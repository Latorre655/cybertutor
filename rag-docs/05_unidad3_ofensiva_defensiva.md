# Unidad 3: Seguridad ofensiva y defensiva

> Resumen de apoyo elaborado con ayuda de IA a partir del Syllabus y la Guía de Aprendizaje. Las explicaciones conceptuales son material general de estudio: contrástalas con las diapositivas de clase (RedTeamDesdeCero, OSINTDesdeCero, OwaspTopTenDesdeCero y BlueTeamDesdeCero) y con las fuentes oficiales. Corresponde a las semanas 10 a 14 del Corte 2 (RAE 2.1, 2.2 y 2.3).

**Marco ético y legal:** todas las pruebas ofensivas del curso se realizan solo en entornos autorizados (máquinas virtuales propias, VulnHub, TryHackMe o laboratorios de clase). Probar sistemas sin autorización es un delito (ver Unidad 5, Ley 1273 de 2009). Este documento describe conceptos y no contiene instrucciones para atacar sistemas reales.

## Temas de la unidad (Syllabus)

Anatomía de un ataque informático; OSINT; análisis de vulnerabilidades; fundamentos de pentesting en entornos controlados; red team; blue team (monitoreo y detección); seguridad en redes, sistemas operativos y bases de datos; seguridad web y de aplicaciones; OWASP Top 10; introducción a MITRE ATT&CK.

## Hacker ético frente a delincuente informático

El hacker ético tiene **autorización por escrito, un alcance definido** y reporta lo que encuentra para que se corrija. El delincuente actúa sin permiso y con fines propios. La diferencia no es la técnica, sino la autorización, la intención y el respeto del marco legal.

## Anatomía de un ataque

Un ataque suele avanzar por fases: reconocimiento, escaneo y enumeración, obtención de acceso, mantenimiento del acceso y borrado de huellas. Entender estas fases permite al equipo defensivo detectar y cortar el ataque en cada etapa.

## OSINT (inteligencia de fuentes abiertas)

Consiste en recolectar información pública sobre una organización o persona (sitios web, redes sociales, registros públicos, metadatos). Se usa tanto en pruebas de seguridad como en defensa para saber qué información expone una organización. Debe hacerse respetando la privacidad y la ley.

## Análisis de vulnerabilidades

Identifica debilidades conocidas en sistemas y servicios mediante escáneres como **Nessus y OpenVAS**. Los hallazgos se priorizan con identificadores **CVE** y puntajes **CVSS** (gravedad). Un análisis de vulnerabilidades **detecta**; un pentest además intenta **explotar** para demostrar el impacto real.

## Pentesting

Prueba de seguridad controlada y autorizada. Según el conocimiento previo del auditor se habla de caja negra (sin información), caja blanca (información completa) y caja gris (parcial). Incluye alcance, reglas de participación, ejecución y un informe con hallazgos y recomendaciones. En el curso se estudia con Metasploit y Nmap en laboratorio.

## Red team, blue team y purple team

- **Red team:** simula a un atacante para evaluar la postura de seguridad.
- **Blue team:** defiende: monitoreo, detección, respuesta y hardening.
- **Purple team:** colaboración entre ambos para mejorar las defensas con lo aprendido.

## Seguridad en redes, sistemas operativos y bases de datos

Segmentación de redes, reglas de firewall, cierre de servicios innecesarios, parches, mínimo privilegio, endurecimiento (hardening) de sistemas, cifrado de datos y control de acceso en bases de datos, y protección de redes inalámbricas. Las prácticas se hacen con Metasploitable y máquinas de TryHackMe.

## Seguridad web y OWASP Top 10

El OWASP Top 10 es un documento de concientización sobre los riesgos más críticos en aplicaciones web. La edición **2021** incluye: control de acceso roto, fallas criptográficas, inyección, diseño inseguro, configuración de seguridad incorrecta, componentes vulnerables y desactualizados, fallas de identificación y autenticación, fallas de integridad de software y datos, fallas de registro y monitoreo, y SSRF.

OWASP publicó el **Top 10:2025** (versión final en enero de 2026). Mantiene el control de acceso roto en el primer lugar, sube la configuración de seguridad incorrecta al segundo, y añade las **fallas en la cadena de suministro de software** (ampliación de componentes vulnerables) y el **manejo inadecuado de condiciones excepcionales**. Las fallas de registro pasan a llamarse de registro y alertas, y SSRF se integra en control de acceso roto. Para el listado completo y vigente se consulta owasp.org/Top10, porque la clase puede trabajar con una u otra edición.

## Introducción a MITRE ATT&CK

Base de conocimiento de **tácticas** (el objetivo del atacante en cada etapa) y **técnicas** (cómo lo logra), construida a partir de casos reales. Sirve a los equipos defensivos para mapear detecciones, evaluar cobertura y comunicar amenazas con un lenguaje común.

## Blue team: monitoreo, firewalls e IDS

El monitoreo recopila y analiza registros para detectar actividad anómala. Los **firewalls** filtran el tráfico según reglas. Un **IDS** (sistema de detección de intrusos), como Snort, analiza el tráfico y genera alertas ante patrones sospechosos. Detectar y responder rápido reduce el impacto de un incidente.

## Prácticas de laboratorio de esta unidad

Pentesting de caja negra con Metasploit, Nmap, máquinas Blue y RootMe de TryHackMe, Metasploitable, auditoría Wi-Fi sobre red propia, auditoría móvil en laboratorio, OSINT introductorio, análisis de riesgos web con OWASP, Nessus y OpenVAS, análisis del protocolo SSL con Wireshark e instalación de Snort.

## Cómo estudiar esta unidad

1. Practica en TryHackMe siguiendo las rutas para principiantes y documenta cada sala.
2. Relaciona cada categoría del OWASP Top 10 con un ejemplo y su mitigación.
3. Toma un ataque real y descríbelo con las tácticas de MITRE ATT&CK.
4. Prepara un informe breve de hallazgos con evidencia y recomendaciones: es lo que se espera en un reporte técnico.

## Preguntas de repaso

- ¿En qué se diferencia un análisis de vulnerabilidades de un pentest?
- ¿Qué distingue a un hacker ético de un delincuente informático?
- ¿Para qué sirve CVSS?
- ¿Qué aporta MITRE ATT&CK al blue team?
