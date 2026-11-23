# Unidad 4: Tecnologías emergentes, inteligencia y análisis digital

> Resumen de apoyo elaborado con ayuda de IA a partir del Syllabus y la Guía de Aprendizaje. Las explicaciones conceptuales son material general de estudio: contrástalas con las diapositivas de clase (ForenseDesdeCero) y con las normas citadas. Corresponde principalmente a la semana 9 del Corte 2 (RAE 3.1 y 3.3). La guía asigna a esta unidad la computación forense y los metadatos como contenido central.

## Temas de la unidad (Syllabus)

Metadatos; computación forense; seguridad en dispositivos móviles; IA aplicada a ciberseguridad; ciberseguridad en IoT; seguridad en la nube.

## Computación forense

Es la aplicación de métodos científicos para **identificar, recolectar, preservar, analizar y presentar evidencia digital** de forma que sea confiable y admisible. Principios básicos:

- **Preservar la evidencia original:** se trabaja sobre copias (imágenes forenses), no sobre el dispositivo original.
- **Cadena de custodia:** registro de quién tuvo la evidencia, cuándo y qué hizo con ella.
- **Integridad:** se calcula el hash de la evidencia para demostrar que no fue alterada.
- **Documentación:** cada paso queda registrado en un informe estructurado y reproducible.

El curso toma como referencia dos normas: **ISO/IEC 27037:2016** (identificación, recolección, adquisición y preservación de evidencia digital) e **ISO/IEC 27042:2015** (análisis e interpretación de evidencia digital).

## Análisis de metadatos

Los metadatos son datos sobre los datos: autor, fechas de creación y modificación, software usado, dispositivo, y en las fotos puede haber ubicación GPS. Son valiosos en una investigación forense y en OSINT, y también un riesgo de privacidad si se publican archivos sin limpiarlos.

## Prácticas de laboratorio forense

- Recuperación de archivos borrados con Foremost y PhotoRec.
- Análisis de metadatos con exiftool.
- Creación de imágenes forenses con FTK Imager.
- Análisis forense con Autopsy.

Se trabaja con evidencia de práctica del curso, nunca con equipos o datos de terceros.

## Seguridad en dispositivos móviles

Riesgos: aplicaciones maliciosas o con permisos excesivos, redes Wi-Fi inseguras, pérdida o robo del dispositivo, y falta de actualizaciones. Controles: instalar solo desde tiendas oficiales, revisar permisos, cifrado del dispositivo, bloqueo de pantalla, MFA y gestión de dispositivos en organizaciones.

## IA aplicada a la ciberseguridad

- **Para defender:** detección de anomalías y de malware, análisis de grandes volúmenes de registros, priorización de alertas y automatización de respuesta.
- **Riesgos:** atacantes que usan IA para campañas de phishing más convincentes o para deepfakes, y ataques a los propios sistemas de IA, como la inyección de instrucciones (prompt injection) o el envenenamiento de datos.
- **Uso responsable:** validar siempre los resultados, considerar los sesgos y proteger los datos que se entregan a un modelo. OWASP mantiene una lista aparte de riesgos para aplicaciones con modelos de lenguaje.

## Ciberseguridad en IoT

Los dispositivos IoT suelen tener poca capacidad de cómputo, contraseñas por defecto, y rara vez se actualizan, lo que amplía la superficie de ataque. Buenas prácticas: cambiar credenciales por defecto, segmentar la red, actualizar el firmware y deshabilitar servicios innecesarios. La placa ESP32 que se usa en el taller de MFA es un ejemplo de dispositivo IoT.

## Seguridad en la nube

Se basa en el **modelo de responsabilidad compartida**: el proveedor protege la infraestructura y el cliente protege sus datos, accesos y configuraciones. Los errores más comunes son configuraciones incorrectas (por ejemplo, almacenamiento público) y gestión débil de identidades. Controles clave: mínimo privilegio, MFA, cifrado, registro y monitoreo. Esto se conecta con el despliegue en AWS de este proyecto (grupos de seguridad y puertos mínimos).

## Cómo estudiar esta unidad

1. Descarga una foto tuya y revisa sus metadatos con exiftool: ¿qué información revela?
2. Practica el flujo completo: imagen forense, cálculo de hash y análisis con Autopsy, documentando cada paso.
3. Lee los resúmenes de ISO 27037 e ISO 27042 y relaciona cada fase con tu práctica.
4. Busca un caso real de brecha en la nube o en IoT y analiza qué control faltó.

## Preguntas de repaso

- ¿Por qué se trabaja sobre una imagen forense y no sobre el disco original?
- ¿Qué es la cadena de custodia?
- ¿Qué información puede revelar una fotografía a través de sus metadatos?
- ¿Qué parte de la seguridad en la nube es responsabilidad del cliente?
