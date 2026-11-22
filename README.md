# CyberTutor: chatbot de apoyo para el curso de Ciberseguridad

Proyecto final de Ciencia de Datos, Universidad Autónoma de Bucaramanga (UNAB).
Chatbot construido con n8n que apoya al estudiante del curso de Ciberseguridad
(código 18017) en su estado académico, proyección y recomendaciones para el éxito,
con enfoque de autoaprendizaje y educación de precisión.

**Autores:** Johan Andrés Latorre Dulcey y Abigail Vargas Argüello
**Curso:** Ciencia de Datos
**Docente:** Alfredo

## Estado del proyecto
- [x] Infraestructura base (Docker, PostgreSQL + pgvector, n8n)
- [x] Chatbot base con Gemini, memoria persistente y guardrails
- [ ] Base de datos del curso
- [ ] RAG
- [ ] Servidor MCP y webhook
- [ ] Scraper de noticias
- [ ] App Android
- [ ] Despliegue en AWS EC2

## Instalación (versión inicial)
1. Clona el repositorio.
2. Copia `.env.example` a `.env` y cambia las contraseñas.
3. Ejecuta `docker compose up -d`.
4. Abre n8n en http://localhost:5678.
