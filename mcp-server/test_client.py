"""Prueba el servidor MCP: lista herramientas y llama a varias con el estudiante demo.
Uso (desde la carpeta del proyecto):  python mcp-server/test_client.py <TOKEN>
Requiere:  pip install fastmcp
"""
import asyncio
import json
import sys

from fastmcp import Client
from fastmcp.client.auth import BearerAuth

URL = "http://localhost:9000/mcp"


async def main(token: str):
    async with Client(URL, auth=BearerAuth(token)) as c:
        tools = await c.list_tools()
        print("HERRAMIENTAS:", [t.name for t in tools], "\n")
        pruebas = [
            ("consultar_estudiante", {"codigo": "E0001"}),
            ("estado_academico", {"codigo": "E0001"}),
            ("proyectar_nota", {"codigo": "E0001", "objetivo": 4.0}),
            ("actividades_pendientes", {"codigo": "E0001"}),
            ("practicas_pendientes", {"codigo": "E0001"}),
            ("plan_semana", {"numero": 6}),
            ("listar_noticias", {"limite": 3}),
        ]
        for nombre, args in pruebas:
            r = await c.call_tool(nombre, args)
            print(f"== {nombre} {args}")
            print(json.dumps(r.data, indent=2, ensure_ascii=False, default=str), "\n")


asyncio.run(main(sys.argv[1]))
