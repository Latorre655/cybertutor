-- =====================================================================
-- CyberTutor | 02_schema.sql
-- Modelo de datos del curso de Ciberseguridad (código 18017, periodo 202660)
-- Es re-ejecutable: borra y recrea SOLO las tablas del proyecto
-- (no toca las tablas de n8n, como n8n_chat_histories).
-- =====================================================================

DROP VIEW IF EXISTS v_progreso_curso, v_evaluaciones_pendientes, v_practicas_pendientes,
                    v_asistencia, v_resumen_estudiante, v_notas_detalle CASCADE;
DROP TABLE IF EXISTS noticias, progreso_practicas, asistencia, notas, actividades,
                     practicas, semanas, unidades, inscripciones, estudiantes,
                     curso, config CASCADE;

-- ---------------------------------------------------------------------
-- Parámetros configurables (las reglas salen de la Guía de Aprendizaje)
-- ---------------------------------------------------------------------
CREATE TABLE config (
    clave       TEXT PRIMARY KEY,
    valor       TEXT NOT NULL,
    descripcion TEXT
);

-- ---------------------------------------------------------------------
-- Curso
-- ---------------------------------------------------------------------
CREATE TABLE curso (
    codigo                TEXT PRIMARY KEY,
    nombre                TEXT NOT NULL,
    periodo               TEXT NOT NULL,
    creditos              INT  NOT NULL,
    horas_teorico_practicas INT,
    horas_independientes  INT,
    prerrequisito         TEXT,
    docente               TEXT,
    horario_atencion      TEXT,
    modalidad             TEXT
);

-- ---------------------------------------------------------------------
-- Estudiantes e inscripción (equivalente a la "matrícula")
-- Datos 100% sintéticos: no hay personas reales.
-- ---------------------------------------------------------------------
CREATE TABLE estudiantes (
    id      SERIAL PRIMARY KEY,
    codigo  TEXT UNIQUE NOT NULL,
    nombre  TEXT NOT NULL,
    correo  TEXT UNIQUE NOT NULL
);

CREATE TABLE inscripciones (
    estudiante_id        INT  NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    curso_codigo         TEXT NOT NULL REFERENCES curso(codigo),
    estado               TEXT NOT NULL DEFAULT 'activa'
                         CHECK (estado IN ('activa', 'retirada', 'cancelada')),
    aprobo_prerrequisito BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (estudiante_id, curso_codigo)
);

-- ---------------------------------------------------------------------
-- Plan del curso: unidades, semanas y prácticas
-- ---------------------------------------------------------------------
CREATE TABLE unidades (
    id         INT PRIMARY KEY,
    nombre     TEXT NOT NULL,
    contenidos TEXT
);

CREATE TABLE semanas (
    numero        INT PRIMARY KEY CHECK (numero BETWEEN 1 AND 16),
    corte         INT NOT NULL CHECK (corte IN (1, 2)),
    unidad_id     INT REFERENCES unidades(id),
    contenidos    TEXT NOT NULL,
    es_evaluacion BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE practicas (
    id           SERIAL PRIMARY KEY,
    semana       INT  NOT NULL REFERENCES semanas(numero),
    nombre       TEXT NOT NULL,
    herramientas TEXT
);

-- ---------------------------------------------------------------------
-- Evaluación: actividades con peso sobre la nota TOTAL del curso (suman 100)
-- ---------------------------------------------------------------------
CREATE TABLE actividades (
    id            INT PRIMARY KEY,
    nombre        TEXT NOT NULL,
    corte         INT  NOT NULL CHECK (corte IN (1, 2)),
    categoria     TEXT NOT NULL CHECK (categoria IN ('asistencia', 'taller', 'parcial', 'proyecto')),
    peso          NUMERIC(4,1) NOT NULL CHECK (peso > 0),
    tipo          TEXT NOT NULL CHECK (tipo IN ('individual', 'grupal')),
    semana_inicio INT  NOT NULL,
    semana_fin    INT  NOT NULL,
    raes          TEXT
);

CREATE TABLE notas (
    estudiante_id INT NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    actividad_id  INT NOT NULL REFERENCES actividades(id),
    nota          NUMERIC(2,1) NOT NULL CHECK (nota BETWEEN 0 AND 5),
    PRIMARY KEY (estudiante_id, actividad_id)
);

CREATE TABLE asistencia (
    estudiante_id INT NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    semana        INT NOT NULL REFERENCES semanas(numero),
    asistio       BOOLEAN NOT NULL,
    PRIMARY KEY (estudiante_id, semana)
);

CREATE TABLE progreso_practicas (
    estudiante_id INT NOT NULL REFERENCES estudiantes(id) ON DELETE CASCADE,
    practica_id   INT NOT NULL REFERENCES practicas(id),
    estado        TEXT NOT NULL CHECK (estado IN ('completada', 'en_progreso', 'pendiente')),
    PRIMARY KEY (estudiante_id, practica_id)
);

-- ---------------------------------------------------------------------
-- Noticias (la llena el scraper del Workflow 04)
-- ---------------------------------------------------------------------
CREATE TABLE noticias (
    id                SERIAL PRIMARY KEY,
    titulo            TEXT NOT NULL,
    fuente            TEXT NOT NULL,
    url               TEXT UNIQUE NOT NULL,
    fecha_publicacion TIMESTAMPTZ,
    categoria         TEXT,
    resumen           TEXT,
    creado_en         TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- =====================================================================
-- VISTAS ANALÍTICAS (las consumirá el servidor MCP)
-- =====================================================================

-- Detalle de cada nota con su aporte a la nota final
CREATE VIEW v_notas_detalle AS
SELECT e.id AS estudiante_id, e.nombre, a.id AS actividad_id, a.nombre AS actividad,
       a.corte, a.categoria, a.peso, n.nota,
       ROUND(n.nota * a.peso / 100, 3) AS aporte
FROM notas n
JOIN estudiantes e ON e.id = n.estudiante_id
JOIN actividades a ON a.id = n.actividad_id;

-- Resumen y PROYECCIÓN de nota por estudiante
--   acumulado: puntos ya ganados sobre 5.0 (considerando el peso de cada actividad)
--   nota_necesaria_en_pendiente: promedio que necesita en lo que falta para llegar a la nota mínima
CREATE VIEW v_resumen_estudiante AS
WITH cfg AS (
    SELECT valor::numeric AS nota_min FROM config WHERE clave = 'nota_minima'
),
agg AS (
    SELECT e.id AS estudiante_id, e.codigo, e.nombre,
           COALESCE(SUM(n.nota * a.peso / 100), 0) AS acumulado,
           COALESCE(SUM(a.peso), 0)               AS peso_evaluado
    FROM estudiantes e
    LEFT JOIN notas n       ON n.estudiante_id = e.id
    LEFT JOIN actividades a ON a.id = n.actividad_id
    GROUP BY e.id, e.codigo, e.nombre
)
SELECT agg.estudiante_id, agg.codigo, agg.nombre,
       ROUND(agg.acumulado, 2)                    AS acumulado,
       agg.peso_evaluado,
       100 - agg.peso_evaluado                    AS peso_pendiente,
       CASE WHEN agg.peso_evaluado > 0
            THEN ROUND(agg.acumulado / (agg.peso_evaluado / 100), 2) END AS promedio_sobre_evaluado,
       CASE WHEN agg.peso_evaluado < 100
            THEN GREATEST(0, ROUND((cfg.nota_min - agg.acumulado) / ((100 - agg.peso_evaluado) / 100), 2))
       END                                        AS nota_necesaria_en_pendiente,
       CASE WHEN agg.acumulado >= cfg.nota_min THEN 'aprobado_asegurado'
            WHEN agg.acumulado + (100 - agg.peso_evaluado) / 100 * 5 < cfg.nota_min THEN 'no_alcanza'
            ELSE 'en_juego' END                   AS situacion
FROM agg CROSS JOIN cfg;

-- Asistencia frente al límite de inasistencia (20 % de las sesiones del semestre)
-- Supuesto: 1 sesión por semana (16 en total)
CREATE VIEW v_asistencia AS
WITH cfg AS (
    SELECT (SELECT valor::int     FROM config WHERE clave = 'total_semanas')        AS total,
           (SELECT valor::numeric FROM config WHERE clave = 'max_inasistencia_pct') AS maxpct
),
conteo AS (
    SELECT e.id AS estudiante_id, e.nombre,
           COUNT(s.semana)                          AS sesiones_registradas,
           COUNT(s.semana) FILTER (WHERE s.asistio) AS asistencias,
           COUNT(s.semana) FILTER (WHERE NOT s.asistio) AS faltas
    FROM estudiantes e
    LEFT JOIN asistencia s ON s.estudiante_id = e.id
    GROUP BY e.id, e.nombre
)
SELECT c.estudiante_id, c.nombre, c.sesiones_registradas, c.asistencias, c.faltas,
       FLOOR(g.total * g.maxpct / 100)::int AS faltas_permitidas,
       ROUND(c.faltas * 100.0 / g.total, 1) AS pct_inasistencia_sobre_total,
       CASE WHEN c.faltas > FLOOR(g.total * g.maxpct / 100) THEN 'excede_limite'
            WHEN c.faltas = FLOOR(g.total * g.maxpct / 100) THEN 'en_el_limite'
            WHEN c.faltas = FLOOR(g.total * g.maxpct / 100) - 1 THEN 'riesgo'
            ELSE 'ok' END AS alerta
FROM conteo c CROSS JOIN cfg g;

-- Prácticas de laboratorio que el estudiante aún no completa
CREATE VIEW v_practicas_pendientes AS
SELECT e.id AS estudiante_id, e.nombre, p.id AS practica_id, p.semana,
       p.nombre AS practica, p.herramientas, pp.estado
FROM progreso_practicas pp
JOIN estudiantes e ON e.id = pp.estudiante_id
JOIN practicas p   ON p.id = pp.practica_id
WHERE pp.estado <> 'completada';

-- Actividades evaluativas que aún no tienen nota
CREATE VIEW v_evaluaciones_pendientes AS
SELECT e.id AS estudiante_id, e.nombre, a.id AS actividad_id, a.nombre AS actividad,
       a.corte, a.peso, a.semana_inicio, a.semana_fin, a.raes
FROM estudiantes e
CROSS JOIN actividades a
WHERE NOT EXISTS (SELECT 1 FROM notas n
                  WHERE n.estudiante_id = e.id AND n.actividad_id = a.id);

-- Avance general del curso
CREATE VIEW v_progreso_curso AS
SELECT (SELECT valor::int FROM config WHERE clave = 'semana_actual') AS semana_actual,
       (SELECT valor::int FROM config WHERE clave = 'total_semanas') AS total_semanas,
       (SELECT valor::int FROM config WHERE clave = 'total_semanas')
         - (SELECT valor::int FROM config WHERE clave = 'semana_actual') AS semanas_restantes,
       ROUND((SELECT valor::numeric FROM config WHERE clave = 'semana_actual') * 100
             / (SELECT valor::numeric FROM config WHERE clave = 'total_semanas'), 1) AS avance_pct;
