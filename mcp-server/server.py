"""
CyberTutor | Servidor MCP (FastMCP)
Expone herramientas de SOLO LECTURA sobre la base de datos académica sintética.
- Transporte: HTTP (streamable) en el puerto 9000, endpoint /mcp
- Autenticación: token Bearer (variable MCP_TOKEN)
- Consultas parametrizadas (sin concatenar texto del usuario en el SQL)
"""
import hmac
import os
from datetime import date, datetime
from decimal import Decimal

import psycopg
from fastmcp import FastMCP
from psycopg.rows import dict_row
from starlette.middleware import Middleware
from starlette.responses import JSONResponse, PlainTextResponse

MCP_TOKEN = os.environ.get("MCP_TOKEN", "")
if not MCP_TOKEN:
    raise SystemExit("MCP_TOKEN no está definido: el servidor no arranca sin autenticación.")

DB = dict(
    host=os.environ.get("POSTGRES_HOST", "postgres"),
    port=int(os.environ.get("POSTGRES_PORT", "5432")),
    dbname=os.environ["POSTGRES_DB"],
    user=os.environ["POSTGRES_USER"],
    password=os.environ["POSTGRES_PASSWORD"],
)

mcp = FastMCP("CyberTutor MCP")


# ----------------------------------------------------------------- utilidades
def _clean(v):
    if isinstance(v, Decimal):
        return float(v)
    if isinstance(v, (datetime, date)):
        return v.isoformat()
    return v


def query(sql: str, params: tuple = ()) -> list[dict]:
    with psycopg.connect(**DB, row_factory=dict_row) as conn:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            rows = cur.fetchall()
    return [{k: _clean(v) for k, v in r.items()} for r in rows]


def _cod(codigo: str) -> str:
    return codigo.strip().upper()


SUBQ = "(SELECT id FROM estudiantes WHERE codigo = %s)"


# ------------------------------------------------------------------ herramientas
@mcp.tool
def consultar_estudiante(codigo: str) -> dict:
    """Datos de matrícula de un estudiante (código tipo 'E0001'): nombre, correo,
    curso inscrito, estado de la inscripción, prerrequisito y docente."""
    rows = query(
        """SELECT e.codigo, e.nombre, e.correo, c.codigo AS curso_codigo, c.nombre AS curso,
                  c.periodo, c.creditos, c.prerrequisito, i.aprobo_prerrequisito,
                  i.estado AS estado_inscripcion, c.docente
           FROM estudiantes e
           JOIN inscripciones i ON i.estudiante_id = e.id
           JOIN curso c ON c.codigo = i.curso_codigo
           WHERE e.codigo = %s""",
        (_cod(codigo),),
    )
    return rows[0] if rows else {"error": f"No existe el estudiante {codigo}"}


@mcp.tool
def consultar_notas(codigo: str) -> dict:
    """Notas del estudiante por actividad, con corte, peso y aporte a la nota final."""
    rows = query(
        """SELECT actividad, corte, categoria, peso, nota, aporte
           FROM v_notas_detalle
           WHERE estudiante_id = """ + SUBQ + """
           ORDER BY corte, actividad_id""",
        (_cod(codigo),),
    )
    return {"codigo": _cod(codigo), "notas": rows}


@mcp.tool
def estado_academico(codigo: str) -> dict:
    """Estado académico: nota acumulada, porcentaje evaluado y pendiente, situación
    (aprobado_asegurado / en_juego / no_alcanza), asistencia y avance del semestre."""
    resumen = query(
        """SELECT codigo, nombre, acumulado, peso_evaluado, peso_pendiente,
                  promedio_sobre_evaluado, nota_necesaria_en_pendiente, situacion
           FROM v_resumen_estudiante WHERE codigo = %s""",
        (_cod(codigo),),
    )
    if not resumen:
        return {"error": f"No existe el estudiante {codigo}"}
    asistencia = query(
        """SELECT sesiones_registradas, asistencias, faltas, faltas_permitidas, alerta
           FROM v_asistencia WHERE estudiante_id = """ + SUBQ,
        (_cod(codigo),),
    )
    nota_min = query("SELECT valor::numeric AS v FROM config WHERE clave = 'nota_minima'")
    return {
        "resumen": resumen[0],
        "asistencia": asistencia[0] if asistencia else None,
        "avance_curso": query("SELECT * FROM v_progreso_curso")[0],
        "nota_minima_usada": nota_min[0]["v"] if nota_min else None,
        "aviso": "La nota mínima aprobatoria es un supuesto sintético: no figura en la guía de aprendizaje.",
    }


@mcp.tool
def proyectar_nota(codigo: str, objetivo: float = 0) -> dict:
    """Proyección: qué promedio necesita el estudiante en lo que falta por evaluar
    para alcanzar una nota final objetivo entre 0 y 5. Si objetivo es 0, usa la nota mínima configurada."""
    r = query(
        "SELECT acumulado, peso_evaluado, peso_pendiente FROM v_resumen_estudiante WHERE codigo = %s",
        (_cod(codigo),),
    )
    if not r:
        return {"error": f"No existe el estudiante {codigo}"}
    if not objetivo:
        objetivo = query("SELECT valor::numeric AS v FROM config WHERE clave = 'nota_minima'")[0]["v"]
    r = r[0]
    pend = r["peso_pendiente"]
    if pend <= 0:
        return {"mensaje": "No queda peso por evaluar.", "nota_final": r["acumulado"]}
    necesaria = max(0.0, round((objetivo - r["acumulado"]) / (pend / 100), 2))
    return {
        "objetivo": objetivo,
        "acumulado": r["acumulado"],
        "peso_pendiente_pct": pend,
        "promedio_necesario_en_pendiente": necesaria,
        "alcanzable": necesaria <= 5.0,
    }


@mcp.tool
def actividades_pendientes(codigo: str) -> dict:
    """Actividades evaluativas sin nota todavía (talleres, parciales, proyecto), con semanas y peso."""
    return {
        "semana_actual": query("SELECT semana_actual FROM v_progreso_curso")[0]["semana_actual"],
        "pendientes": query(
            """SELECT actividad, corte, peso, semana_inicio, semana_fin
               FROM v_evaluaciones_pendientes
               WHERE estudiante_id = """ + SUBQ + """
               ORDER BY semana_inicio""",
            (_cod(codigo),),
        ),
    }


@mcp.tool
def practicas_pendientes(codigo: str) -> dict:
    """Prácticas de laboratorio que el estudiante no ha completado (pendientes o en progreso)."""
    return {
        "practicas": query(
            """SELECT semana, practica, herramientas, estado
               FROM v_practicas_pendientes
               WHERE estudiante_id = """ + SUBQ + """
               ORDER BY semana""",
            (_cod(codigo),),
        )
    }


@mcp.tool
def plan_semana(numero: int) -> dict:
    """Contenidos y prácticas planeadas de una semana del curso (1 a 16)."""
    s = query("SELECT numero, corte, contenidos, es_evaluacion FROM semanas WHERE numero = %s", (numero,))
    if not s:
        return {"error": "La semana debe estar entre 1 y 16"}
    return {
        "semana": s[0],
        "practicas": query("SELECT nombre, herramientas FROM practicas WHERE semana = %s ORDER BY id", (numero,)),
    }


@mcp.tool
def listar_noticias(limite: int = 5) -> dict:
    """Últimas noticias de ciberseguridad guardadas por el scraper (título, fuente, fecha, enlace)."""
    limite = max(1, min(limite, 20))
    return {
        "noticias": query(
            """SELECT titulo, fuente, fecha_publicacion, categoria, resumen, url
               FROM noticias ORDER BY COALESCE(fecha_publicacion, creado_en) DESC LIMIT %s""",
            (limite,),
        )
    }


@mcp.custom_route("/health", methods=["GET"])
async def health(request):
    return PlainTextResponse("ok")


# ---------------------------------------------------------- autenticación Bearer
class TokenAuth:
    """Middleware ASGI: exige 'Authorization: Bearer <MCP_TOKEN>' salvo en /health."""

    def __init__(self, app):
        self.app = app

    async def __call__(self, scope, receive, send):
        if scope["type"] == "http" and scope["path"] != "/health":
            headers = dict(scope["headers"])
            recibido = headers.get(b"authorization", b"").decode()
            if not hmac.compare_digest(recibido, f"Bearer {MCP_TOKEN}"):
                resp = JSONResponse({"error": "unauthorized"}, status_code=401)
                await resp(scope, receive, send)
                return
        await self.app(scope, receive, send)


app = mcp.http_app(middleware=[Middleware(TokenAuth)])

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=9000)
