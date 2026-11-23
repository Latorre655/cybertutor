# Unidad 1: Fundamentos de ciberseguridad y gestión del riesgo

> Resumen de apoyo elaborado con ayuda de IA a partir del Syllabus y la Guía de Aprendizaje. Las explicaciones conceptuales son material general de estudio: contrástalas con las diapositivas de clase y con las fuentes oficiales citadas. Corresponde a las semanas 1 a 4 del Corte 1 (RAE 1.1 y 1.3).

## Temas de la unidad (Syllabus)

Ciberseguridad, seguridad informática y seguridad de la información; confidencialidad, integridad y disponibilidad; amenazas, vulnerabilidades, riesgos y controles; superficie de ataque; tipos de actores y códigos maliciosos; buenas prácticas de ciberseguridad; uso seguro de medios informáticos; introducción a NIST CSF 2.0.

## Ciberseguridad, seguridad informática y seguridad de la información

- **Seguridad de la información:** protege la información en cualquier formato (digital, papel o conversada) a lo largo de todo su ciclo de vida. Es el concepto más amplio.
- **Seguridad informática:** se centra en proteger los sistemas, equipos, redes y datos digitales de una organización.
- **Ciberseguridad:** protege los activos de información en el ciberespacio, es decir, en sistemas, redes y servicios conectados, frente a amenazas que provienen de ese entorno.

Los tres conceptos se solapan y a menudo se usan como sinónimos, pero conviene distinguir su alcance.

## Tríada CIA

- **Confidencialidad:** solo accede a la información quien está autorizado. Ejemplos de controles: cifrado, control de acceso, autenticación.
- **Integridad:** la información no se altera de forma no autorizada y se mantiene exacta. Ejemplos: funciones hash, firmas digitales, control de versiones.
- **Disponibilidad:** la información y los servicios están accesibles cuando se necesitan. Ejemplos: copias de respaldo, redundancia, planes de continuidad.

Un ataque de interceptación afecta la confidencialidad, uno de modificación afecta la integridad y uno que deja un servicio inaccesible afecta la disponibilidad.

## Amenaza, vulnerabilidad, riesgo y control

- **Activo:** lo que tiene valor para la organización (datos, sistemas, personas, reputación).
- **Amenaza:** causa potencial de un incidente que puede dañar un activo.
- **Vulnerabilidad:** debilidad de un activo o de un control que una amenaza puede aprovechar.
- **Riesgo:** posibilidad de que una amenaza aproveche una vulnerabilidad y cause un impacto. De forma sencilla, riesgo = probabilidad × impacto.
- **Control:** medida que reduce el riesgo (técnica, organizacional o física).

## Superficie de ataque

Es el conjunto de puntos por donde un atacante podría intentar entrar o extraer datos: servicios expuestos, aplicaciones, cuentas, dispositivos, correo y las propias personas. Reducirla (cerrar servicios innecesarios, aplicar mínimo privilegio, actualizar) es una de las medidas más efectivas.

## Tipos de actores de amenaza

Ciberdelincuentes con motivación económica, hacktivistas, atacantes patrocinados por estados, personas internas (maliciosas o negligentes) y aficionados con herramientas ya hechas. El curso distingue claramente al **hacker ético**, que actúa con autorización y dentro de un marco legal, del delincuente informático.

## Malware y códigos maliciosos

Virus, gusanos, troyanos, ransomware (cifra datos para exigir un pago), spyware, rootkits, botnets y adware. Se estudian su funcionamiento general, cómo se propagan y cómo prevenirlos y detectarlos, siempre desde el enfoque defensivo.

## Buenas prácticas y uso seguro de medios informáticos

Contraseñas largas y únicas con gestor de contraseñas, autenticación multifactor, actualizaciones al día, copias de respaldo, desconfiar de enlaces y adjuntos no esperados (phishing), cuidado con medios extraíbles y redes públicas, y principio de mínimo privilegio.

## Introducción a NIST CSF 2.0

El Marco de Ciberseguridad del NIST organiza la gestión de la ciberseguridad en seis funciones: **Gobernar (Govern), Identificar, Proteger, Detectar, Responder y Recuperar**. Sirve como lenguaje común para evaluar y mejorar la postura de seguridad de una organización.

## Prácticas de laboratorio de esta unidad (entornos autorizados)

- Instalación de Kali Linux en VirtualBox.
- Análisis de ataques de interceptación, modificación y suplantación: sniffing con Wireshark y phishing con SET, en laboratorio.
- Auditoría de robustez de contraseñas con John the Ripper, crunch, Cewl, hydra, medusa, ncrack y hashcat, **sobre máquinas propias del laboratorio**.
- Reconocimiento, exploración y explotación con la máquina Lampiao de VulnHub.

Estas herramientas solo se usan en las máquinas virtuales del curso o en plataformas autorizadas. Usarlas contra sistemas de terceros es ilegal.

## Cómo estudiar esta unidad

1. Arma un glosario propio con amenaza, vulnerabilidad, riesgo y control, con un ejemplo de cada uno.
2. Para cada noticia de ataque que leas, identifica qué pilar de la tríada CIA se vio afectado.
3. Revisa las lecturas de la guía y el video de anatomía de un ataque.
4. Practica en la máquina virtual con los talleres guiados y documenta lo que haces.

## Preguntas de repaso

- ¿Cuál es la diferencia entre amenaza y vulnerabilidad?
- ¿Qué pilar de la tríada CIA protege una función hash?
- ¿Por qué reducir la superficie de ataque disminuye el riesgo?
- ¿Cuáles son las seis funciones del NIST CSF 2.0?
