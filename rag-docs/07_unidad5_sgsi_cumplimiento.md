# Unidad 5: Gobierno de TI, cumplimiento y SGSI

> Resumen de apoyo elaborado con ayuda de IA a partir del Syllabus y la Guía de Aprendizaje. Las explicaciones son material general de estudio: contrástalas con las diapositivas de clase (SGSIDesdeCero), con la norma ISO/IEC 27001:2022 y con el **texto oficial de las leyes**, porque este documento no es asesoría jurídica. Corresponde a la semana 15 del Corte 2 (RAE 3.2 y 3.3).

## Temas de la unidad (Syllabus)

Introducción a la gestión de la seguridad de la información; ISO/IEC 27001; Sistema de Gestión de Seguridad de la Información (SGSI); gestión de riesgos; respuesta a incidentes; marco regulatorio en ciberseguridad; protección de datos personales en Colombia; delitos informáticos en Colombia.

## Gestión de la seguridad de la información

Gestionar la seguridad no es solo instalar herramientas: es un proceso continuo de la organización que combina **personas, procesos y tecnología**, con respaldo de la alta dirección, objetivos claros y mejora permanente. El gobierno de TI alinea la tecnología con los objetivos del negocio y con las obligaciones legales.

## SGSI e ISO/IEC 27001:2022

- Un **SGSI** es un conjunto de políticas, procesos y controles para gestionar de forma sistemática los riesgos que afectan la información de una organización.
- **ISO/IEC 27001:2022** es la norma que establece los requisitos para implantar, mantener y mejorar un SGSI. Es **certificable**.
- Sigue la lógica de mejora continua (planificar, hacer, verificar y actuar). Sus cláusulas de requisitos cubren el contexto de la organización, el liderazgo, la planificación (incluida la evaluación de riesgos), el apoyo, la operación, la evaluación del desempeño y la mejora.
- Su **Anexo A** reúne **93 controles** agrupados en cuatro temas: organizacionales, de personas, físicos y tecnológicos. La organización elige cuáles aplica según su análisis de riesgos y lo documenta en la **declaración de aplicabilidad**.

## Gestión de riesgos

Proceso para identificar, analizar, evaluar y tratar los riesgos:

1. **Identificar** activos, amenazas y vulnerabilidades.
2. **Analizar** la probabilidad y el impacto.
3. **Evaluar** el riesgo frente a los criterios de aceptación de la organización.
4. **Tratar** el riesgo: mitigar (aplicar controles), transferir (por ejemplo, con un seguro o un tercero), aceptar o evitar.
5. **Monitorear y revisar** de forma continua. El riesgo que queda después de los controles se llama riesgo residual.

En la práctica de la semana 15 se analizan riesgos con la máquina Vulniversity de TryHackMe.

## Respuesta a incidentes

Un incidente de seguridad es un evento que compromete la confidencialidad, integridad o disponibilidad. Un ciclo habitual de respuesta incluye: **preparación**, **detección y análisis**, **contención, erradicación y recuperación**, y **lecciones aprendidas**. Tener un plan, roles definidos y registros evita improvisar bajo presión y reduce el impacto.

## Marco regulatorio en Colombia

**Protección de datos personales: Ley 1581 de 2012.** Establece el régimen general de protección de datos personales y desarrolla el derecho de *habeas data*. Define principios como la finalidad, la libertad (consentimiento previo del titular), la veracidad, la transparencia, la seguridad y la confidencialidad. Reconoce derechos al titular, como conocer, actualizar, rectificar y suprimir sus datos y revocar la autorización. La autoridad de control es la Superintendencia de Industria y Comercio (SIC). Exige a responsables y encargados adoptar medidas de seguridad para los datos que tratan.

**Delitos informáticos: Ley 1273 de 2009.** Modificó el Código Penal y creó el bien jurídico "de la protección de la información y de los datos". Tipifica, entre otras, estas conductas (artículos 269A a 269J):

- Acceso abusivo a un sistema informático.
- Obstaculización ilegítima de un sistema informático o red de telecomunicación.
- Interceptación de datos informáticos.
- Daño informático.
- Uso de software malicioso.
- Violación de datos personales.
- Suplantación de sitios web para capturar datos personales.
- Hurto por medios informáticos y semejantes.
- Transferencia no consentida de activos.

Esto explica por qué las prácticas ofensivas del curso se hacen **solo con autorización y en laboratorios**: acceder o interceptar sin permiso puede constituir delito.

## Prácticas de esta unidad

Análisis de riesgos con contexto usando la máquina Vulniversity de TryHackMe, y revisión de la norma ISO 27001:2022 y de sus controles.

## Cómo estudiar esta unidad

1. Elige una organización pequeña (puede ser ficticia) y lista sus 10 activos más importantes.
2. Para tres de ellos, identifica amenazas, vulnerabilidades y un control del Anexo A.
3. Lee el texto oficial de las leyes 1581 de 2012 y 1273 de 2009 y subraya los artículos que más se relacionen con el curso.
4. Redacta un mini plan de respuesta a incidentes de una página.

## Preguntas de repaso

- ¿Qué diferencia hay entre ISO 27001 y un SGSI?
- ¿Cuáles son las cuatro formas de tratar un riesgo?
- ¿Qué derechos tiene el titular de los datos según la Ley 1581 de 2012?
- ¿Qué conducta tipifica el acceso abusivo a un sistema informático?
