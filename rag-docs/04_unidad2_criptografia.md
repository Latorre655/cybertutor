# Unidad 2: Controles criptográficos, autenticación e identidad digital

> Resumen de apoyo elaborado con ayuda de IA a partir del Syllabus y la Guía de Aprendizaje. Las explicaciones conceptuales son material general de estudio: contrástalas con las diapositivas de clase (CriptografiaDesdeCero). Corresponde a las semanas 2 y 5 a 7 del Corte 1 (RAE 1.2 y 1.3).

## Temas de la unidad (Syllabus)

Principios básicos de criptografía; criptografía simétrica y asimétrica; funciones hash; firmas digitales; certificados y nociones de PKI; control de acceso; métodos de autenticación y MFA; introducción a blockchain y consideraciones de seguridad. La guía añade criptografía clásica, salt, esteganografía, aritmética modular, Diffie-Hellman, RSA y exponenciación rápida.

## Principios básicos de criptografía

La criptografía transforma información legible (texto claro) en información ilegible (texto cifrado) usando un algoritmo y una clave. Busca garantizar confidencialidad, integridad, autenticidad y no repudio. El principio de Kerckhoffs indica que la seguridad debe depender de la clave y no del secreto del algoritmo.

## Criptografía clásica

Cifrados históricos que se implementan en Python en el curso: **César** (desplazamiento del alfabeto), **Atbash** (alfabeto invertido), **transposición columnar** (reordena las letras), **afín** (usa aritmética modular) y **Vernam** (clave aleatoria de la longitud del mensaje, base del cifrado de un solo uso). Son útiles para entender conceptos, pero no son seguros frente a herramientas modernas.

## Criptografía simétrica

Usa **la misma clave** para cifrar y descifrar. Es rápida y adecuada para grandes volúmenes de datos (por ejemplo, AES). Su reto es distribuir la clave de forma segura. En el curso se practica con GPG y OpenSSL y con contenedores cifrados de VeraCrypt.

## Criptografía asimétrica

Usa un **par de claves**: la pública (se comparte) y la privada (se protege). Lo que se cifra con la pública solo se descifra con la privada. Resuelve el problema de distribución de claves, pero es más lenta (por ejemplo, RSA). En la práctica se combina con la simétrica: la asimétrica intercambia una clave de sesión y la simétrica cifra los datos.

## Diffie-Hellman, RSA y aritmética modular

- **Diffie-Hellman:** permite que dos partes acuerden una clave compartida a través de un canal inseguro.
- **RSA:** se basa en la dificultad de factorizar números grandes y usa aritmética modular y exponenciación.
- **Exponenciación rápida:** técnica para calcular potencias modulares de forma eficiente, necesaria en RSA y Diffie-Hellman.

## Funciones hash y salt

Una función hash (por ejemplo SHA-256) convierte cualquier entrada en una huella de tamaño fijo. Es de un solo sentido (no se puede revertir) y un cambio mínimo en la entrada cambia el resultado por completo, por lo que sirve para verificar **integridad**. Para almacenar contraseñas se añade una **salt** (valor aleatorio por usuario) antes del hash, para evitar ataques con tablas precalculadas y que dos contraseñas iguales produzcan hashes distintos. Se practica con sha256sum, Get-FileHash y mkpasswd.

## Firmas digitales, certificados y PKI

- **Firma digital:** se calcula el hash del documento y se cifra con la clave privada del firmante. Quien tenga la clave pública puede verificar autenticidad e integridad, y ofrece no repudio.
- **Certificado digital:** vincula una clave pública con una identidad, firmado por una autoridad certificadora.
- **PKI (infraestructura de clave pública):** conjunto de autoridades, certificados, políticas y procedimientos que permiten confiar en esas identidades. Se practica con OpenSSL.

## Control de acceso, autenticación y MFA

El control de acceso decide qué puede hacer cada identidad. La autenticación verifica quién es, mediante algo que **sabes** (contraseña), algo que **tienes** (token, teléfono) o algo que **eres** (biometría). La **autenticación multifactor (MFA)** combina al menos dos categorías distintas. En el curso hay un taller de MFA con Linux, Python y la placa ESP32.

## Blockchain y su seguridad

Cadena de bloques enlazados mediante hashes: modificar un bloque cambia su hash y rompe la cadena, lo que da integridad y trazabilidad. Se complementa con consenso entre participantes. Sus consideraciones de seguridad incluyen la custodia de claves privadas y los errores en contratos inteligentes.

## Esteganografía

Oculta **la existencia** del mensaje dentro de otro archivo (imagen, audio), mientras que la criptografía oculta su contenido. Se practica con OpenStego, steghide y outguess.

## Prácticas de laboratorio de esta unidad

Auditoría de contraseñas (semana 2), cifrados clásicos en Python, GPG y OpenSSL simétrico y asimétrico, VeraCrypt, hash y salt, demostración de blockchain, taller de PKI, taller de MFA con ESP32 y esteganografía.

## Cómo estudiar esta unidad

1. Implementa los cifrados clásicos en Python para entender el desplazamiento y el módulo.
2. Calcula el hash de un archivo, cambia una letra y compara los resultados.
3. Dibuja el flujo de una firma digital: quién usa qué clave y para qué.
4. Resuelve ejercicios de aritmética modular antes de abordar RSA.

## Preguntas de repaso

- ¿Por qué se combinan criptografía simétrica y asimétrica?
- ¿Qué problema resuelve la salt?
- ¿Qué garantiza una firma digital que un hash solo no garantiza?
- ¿En qué se diferencia la esteganografía de la criptografía?
