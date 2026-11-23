-- =====================================================================
-- CyberTutor | 03_seed_curso.sql
-- Datos del curso tomados del Syllabus y la Guía de Aprendizaje (periodo 202660)
-- =====================================================================

TRUNCATE config, curso, unidades, semanas, practicas, actividades RESTART IDENTITY CASCADE;

-- ---------------------------------------------------------------------
-- Parámetros
-- ---------------------------------------------------------------------
INSERT INTO config (clave, valor, descripcion) VALUES
 ('periodo',                  '202660', 'Periodo académico'),
 ('total_semanas',            '16',     'Semanas del semestre (2 cortes de 8)'),
 ('semana_actual',            '11',     'SEMANA SIMULADA para probar el bot; cámbiala para simular otro momento'),
 ('nota_minima',              '3.0',    'Nota mínima aprobatoria (CONFIRMAR con el reglamento o el docente)'),
 ('max_inasistencia_pct',     '20',     'Límite de inasistencia en pregrado según la Guía de Aprendizaje'),
 ('penalizacion_tardia_pct',  '10',     'Descuento sobre la nota de la actividad por entrega tardía (Guía, regla e)');

-- ---------------------------------------------------------------------
-- Curso
-- ---------------------------------------------------------------------
INSERT INTO curso VALUES
 ('18017', 'Ciberseguridad', '202660', 3, 4, 5, 'Infraestructura Tecnológica',
  'Yamid Gabriel Gamba González', 'Lunes de 4 a 6 pm', 'Presencial y Virtual');

-- ---------------------------------------------------------------------
-- Unidades (Syllabus, sección 4)
-- ---------------------------------------------------------------------
INSERT INTO unidades (id, nombre, contenidos) VALUES
 (1, 'Fundamentos de ciberseguridad y gestión del riesgo',
     'Ciberseguridad, seguridad informática y de la información; confidencialidad, integridad y disponibilidad; amenazas, vulnerabilidades, riesgos y controles; superficie de ataque; tipos de actores y códigos maliciosos; buenas prácticas; uso seguro de medios informáticos; introducción a NIST CSF 2.0'),
 (2, 'Controles criptográficos, autenticación e identidad digital',
     'Principios de criptografía; criptografía simétrica y asimétrica; funciones hash; firmas digitales; certificados y PKI; control de acceso; autenticación y MFA; blockchain y su seguridad'),
 (3, 'Seguridad ofensiva y defensiva',
     'Anatomía de un ataque; OSINT; análisis de vulnerabilidades; pentesting en entornos controlados; red team; blue team (monitoreo y detección); seguridad en redes, sistemas operativos y bases de datos; seguridad web y de aplicaciones; OWASP Top 10; MITRE ATT&CK'),
 (4, 'Tecnologías emergentes, inteligencia y análisis digital',
     'Metadatos; computación forense; seguridad en dispositivos móviles; IA aplicada a ciberseguridad; ciberseguridad en IoT; seguridad en la nube'),
 (5, 'Gobierno de TI, cumplimiento y SGSI',
     'Gestión de la seguridad de la información; ISO/IEC 27001; SGSI; gestión de riesgos; respuesta a incidentes; marco regulatorio; protección de datos personales y delitos informáticos en Colombia');

-- ---------------------------------------------------------------------
-- Semanas (Guía de Aprendizaje, sección 5)
-- ---------------------------------------------------------------------
INSERT INTO semanas (numero, corte, unidad_id, contenidos, es_evaluacion) VALUES
 (1,  1, 1,    'Fundamentos de ciberseguridad; ciberseguridad, seguridad informática y seguridad de la información', FALSE),
 (2,  1, 1,    'Tríada CIA (confidencialidad, integridad, disponibilidad); métodos de autenticación y control de acceso; buenas prácticas; uso seguro de medios informáticos', FALSE),
 (3,  1, 1,    'Amenazas, riesgos y vulnerabilidades; superficie de ataque', FALSE),
 (4,  1, 1,    'Tipos de atacantes; malware y códigos maliciosos', FALSE),
 (5,  1, 2,    'Principios básicos de criptografía; criptografía clásica y moderna; criptografía simétrica y asimétrica', FALSE),
 (6,  1, 2,    'Funciones hash; salt criptográfica; blockchain; firmas digitales; certificados y PKI; autenticación y MFA', FALSE),
 (7,  1, 2,    'Esteganografía; aritmética modular; Diffie-Hellman; algoritmo RSA; exponenciación rápida', FALSE),
 (8,  1, NULL, 'Evaluación Corte 1: parcial con componente teórico y práctico (reto CTF + TEMA + Genially)', TRUE),
 (9,  2, 4,    'Computación forense; análisis de metadatos', FALSE),
 (10, 2, 3,    'Red Team (seguridad ofensiva): ethical hacking y pentesting', FALSE),
 (11, 2, 3,    'Seguridad en redes, bases de datos y sistemas operativos; seguridad web y móvil', FALSE),
 (12, 2, 3,    'OSINT; OWASP Top Ten', FALSE),
 (13, 2, 3,    'Blue Team (seguridad defensiva): análisis de vulnerabilidades', FALSE),
 (14, 2, 3,    'Firewalls y sistemas de detección de intrusos (IDS)', FALSE),
 (15, 2, 5,    'SGSI; ISO 27001:2022; controles de seguridad de la información; gestión de riesgos; marco regulatorio en ciberseguridad', FALSE),
 (16, 2, NULL, 'Evaluación Corte 2: proyecto final (hackatón) + sustentación y parcial teórico', TRUE);

-- ---------------------------------------------------------------------
-- Prácticas de laboratorio (se ejecutan SOLO en entornos autorizados:
-- máquinas virtuales propias, VulnHub, TryHackMe)
-- ---------------------------------------------------------------------
INSERT INTO practicas (semana, nombre, herramientas) VALUES
 (1,  'Instalación de Kali Linux en un entorno virtualizado',                         'Kali Linux, VirtualBox'),
 (1,  'Ataques de interceptación y suplantación: sniffing y phishing',                'Wireshark, SET'),
 (2,  'Auditoría de robustez de contraseñas (fuerza bruta y diccionario)',            'John the Ripper'),
 (2,  'Creación de diccionarios',                                                     'crunch'),
 (3,  'Creación de diccionarios con Cewl',                                            'Cewl'),
 (3,  'Auditoría de servicios remotos (fuerza bruta y diccionario)',                  'hydra, medusa, ncrack'),
 (3,  'Resistencia del hash de archivos comprimidos',                                 'hashcat'),
 (4,  'Reconocimiento, exploración activa y explotación con la máquina Lampiao',      'Kali Linux, VulnHub (Lampiao)'),
 (5,  'Cifrados clásicos en Python (César, Vernam, Atbash, transposición, afín)',     'Python'),
 (5,  'Criptografía simétrica',                                                       'GPG, OpenSSL'),
 (5,  'Contenedores cifrados',                                                        'VeraCrypt'),
 (5,  'Criptografía asimétrica',                                                      'GPG, OpenSSL'),
 (6,  'Funciones hash en Linux y PowerShell',                                         'sha256sum, Get-FileHash'),
 (6,  'Salt criptográfica',                                                           'mkpasswd'),
 (6,  'Funcionamiento de una blockchain (demo web)',                                  'Navegador'),
 (6,  'Taller de PKI',                                                                'OpenSSL'),
 (6,  'Taller de autenticación multifactor (MFA)',                                    'Linux, Python, ESP32'),
 (7,  'Esteganografía en Windows y Linux',                                            'copy, OpenStego, steghide, outguess'),
 (9,  'Recuperación de archivos borrados',                                            'Foremost, PhotoRec'),
 (9,  'Análisis de metadatos de archivos digitales',                                  'exiftool'),
 (9,  'Creación de imágenes forenses',                                                'FTK Imager'),
 (9,  'Análisis forense de evidencias',                                               'Autopsy'),
 (10, 'Pentesting de caja negra',                                                     'Metasploit'),
 (10, 'Reconocimiento y exploración activa dentro de la anatomía de un ataque',       'Nmap'),
 (10, 'Explotación y post-explotación con la máquina Blue',                           'TryHackMe (Blue)'),
 (11, 'Entendiendo Metasploit con Metasploitable',                                    'Metasploit, Metasploitable'),
 (11, 'Enumeración y escalamiento de privilegios con la máquina RootMe',              'TryHackMe (RootMe)'),
 (11, 'Auditoría Wi-Fi en red local propia',                                          'Kali Linux'),
 (11, 'Auditoría móvil en entorno de laboratorio',                                    'Metasploit, Venom'),
 (12, 'Introducción a la inteligencia en fuentes abiertas (OSINT)',                   'Kali Linux'),
 (12, 'Análisis de riesgos críticos en aplicaciones web (OWASP Top 10)',              'TryHackMe, OWASP'),
 (13, 'Análisis de vulnerabilidades',                                                 'Nessus, OpenVAS'),
 (13, 'Análisis del protocolo SSL',                                                   'Wireshark'),
 (14, 'Instalación y configuración de un IDS',                                        'Snort, Kali Linux'),
 (15, 'Análisis de riesgos con la máquina Vulniversity',                              'TryHackMe (Vulniversity)');

-- ---------------------------------------------------------------------
-- Actividades de evaluación (Guía de Aprendizaje, sección 6)
-- Los pesos son sobre la nota TOTAL: Corte 1 = 50 y Corte 2 = 50
-- ---------------------------------------------------------------------
INSERT INTO actividades (id, nombre, corte, categoria, peso, tipo, semana_inicio, semana_fin, raes) VALUES
 (1,  'Asistencia I',                              1, 'asistencia',  5, 'individual', 1,  8,  'Todos'),
 (2,  'Taller Reto 1 (Corte 1)',                   1, 'taller',      5, 'individual', 1,  3,  '1.1, 1.2'),
 (3,  'Taller Reto 2 (Corte 1)',                   1, 'taller',      5, 'individual', 4,  5,  '1.3'),
 (4,  'Taller Reto 3 (Corte 1)',                   1, 'taller',     10, 'grupal',     6,  7,  '2.1'),
 (5,  'Parcial Teórico I',                         1, 'parcial',    10, 'individual', 8,  8,  '1.1, 1.2, 1.3, 2.1'),
 (6,  'Parcial Práctico I',                        1, 'parcial',    15, 'individual', 8,  8,  '1.1, 1.2, 1.3, 2.1'),
 (7,  'Asistencia II',                             2, 'asistencia',  5, 'individual', 9,  16, 'Todos'),
 (8,  'Taller Reto 1 (Corte 2)',                   2, 'taller',      5, 'individual', 9,  9,  '3.1, 3.2, 3.3'),
 (9,  'Taller Reto 2 (Corte 2)',                   2, 'taller',      5, 'individual', 10, 12, '3.1, 3.2, 3.3'),
 (10, 'Taller Reto 3 (Corte 2)',                   2, 'taller',      5, 'grupal',     13, 14, '3.1, 3.2, 3.3'),
 (11, 'Parcial Teórico II',                        2, 'parcial',    10, 'individual', 15, 15, 'Todos'),
 (12, 'Proyecto Final (hackatón + sustentación)',  2, 'proyecto',   20, 'grupal',     16, 16, 'Todos');
