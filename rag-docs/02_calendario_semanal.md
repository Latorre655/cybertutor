# Calendario semanal del curso de Ciberseguridad (periodo 202660)

> Resumen elaborado con ayuda de IA a partir de la Guía de Aprendizaje. La propia guía aclara que esta distribución está sujeta a cambios sin previo aviso por situaciones imprevistas o por la dinámica de la clase y de la Universidad. Las prácticas se realizan únicamente en entornos de laboratorio autorizados.

Recursos que se repiten en todo el curso: presentaciones de diapositivas del docente (CiberseguridadDesdeCero, CriptografiaDesdeCero, ForenseDesdeCero, RedTeamDesdeCero, OwaspTopTenDesdeCero, OSINTDesdeCero, BlueTeamDesdeCero y SGSIDesdeCero) y el itinerario de aprendizaje en Genially (CyberGuardians). Cada semana combina clase magistral dialogada, análisis de casos reales, talleres guiados y discusión grupal.

# CORTE 1 (semanas 1 a 8)

## Semana 1
- **Contenidos:** fundamentos de ciberseguridad; ciberseguridad, seguridad informática y seguridad de la información.
- **Actividades:** presentación de herramientas, recursos y de la Guía Cátedra; discusión grupal sobre el phishing; video de demostración de un ciberataque; lecturas sobre inseguridad informática.
- **Entorno:** Kali Linux en VirtualBox.
- **Prácticas:** instalación de Kali Linux en un entorno virtualizado; análisis de ataques de interceptación, modificación y suplantación (sniffing con Wireshark y phishing con SET).

## Semana 2
- **Contenidos:** tríada de la seguridad (confidencialidad, integridad y disponibilidad); métodos de autenticación y control de acceso; buenas prácticas de ciberseguridad; uso seguro de medios informáticos.
- **Actividades:** talleres guiados sobre la fortaleza de las contraseñas.
- **Prácticas:** auditoría técnica de la robustez de contraseñas con fuerza bruta y diccionario usando John the Ripper; creación de diccionarios con crunch.

## Semana 3
- **Contenidos:** amenazas, riesgos y vulnerabilidades; superficie de ataque.
- **Actividades:** talleres sobre identificación de riesgos, amenazas y vulnerabilidades; video "Anatomía de un ataque informático".
- **Entorno:** Kali Linux y una máquina Fedora Server en VirtualBox.
- **Prácticas:** diccionarios con Cewl; auditoría de servicios remotos con hydra, medusa y ncrack; medición de la resistencia del hash de archivos comprimidos con hashcat.

## Semana 4
- **Contenidos:** tipos de atacantes; malware y códigos maliciosos.
- **Actividades:** talleres de análisis de vulnerabilidades en escenarios organizacionales.
- **Entorno:** Kali Linux y la máquina Lampiao (VulnHub) en VirtualBox.
- **Prácticas:** reconocimiento, exploración activa y explotación con la máquina Lampiao.

## Semana 5
- **Contenidos:** principios básicos de criptografía; criptografía clásica y moderna; criptografía simétrica y asimétrica.
- **Prácticas:** cifrados César, Vernam, Atbash, transposición columnar simple y afín en Python; criptografía simétrica con GPG y OpenSSL; contenedores cifrados con VeraCrypt; criptografía asimétrica con GPG y OpenSSL.

## Semana 6
- **Contenidos:** funciones hash; salt criptográfica; blockchain; firmas digitales; certificados y nociones de PKI; métodos de autenticación y MFA.
- **Prácticas:** funciones hash con sha256sum y Get-FileHash en PowerShell; salt con mkpasswd; demostración de blockchain en la web; taller de PKI y OpenSSL; taller de MFA con Linux, Python y la placa ESP32.

## Semana 7
- **Contenidos:** esteganografía; aritmética modular; Diffie-Hellman; algoritmo RSA; algoritmo de exponenciación rápida.
- **Prácticas:** esteganografía con Windows (copy, OpenStego) y Linux (cat, outguess, steghide) y herramientas web.

## Semana 8: Evaluación del Corte 1
- Parcial con componentes teórico y práctico (reto CTF, TEMA y Genially).

# CORTE 2 (semanas 9 a 16)

## Semana 9
- **Contenidos:** computación forense; análisis de metadatos.
- **Referencias:** ISO 27037:2016 e ISO 27042:2015.
- **Prácticas:** recuperación de archivos borrados con Foremost y PhotoRec; análisis de metadatos con exiftool; creación de imágenes forenses con FTK Imager; análisis forense con Autopsy.

## Semana 10
- **Contenidos:** Red Team (seguridad ofensiva): ethical hacking y pentesting.
- **Lecturas:** "El estigma del hacker", "Hacker ético vs delincuente informático" y "Understanding a hacker's mind".
- **Entorno:** Kali Linux, una máquina XP en VirtualBox y TryHackMe.
- **Prácticas:** pentesting de caja negra con Metasploit; Nmap para reconocimiento y exploración activa dentro de la anatomía de un ataque; explotación y post-explotación con la máquina Blue de TryHackMe.

## Semana 11
- **Contenidos:** seguridad en redes, bases de datos y sistemas operativos; seguridad web y móvil.
- **Entorno:** Kali Linux, Metasploitable I, II y III, TryHackMe y un punto de acceso Wi-Fi local.
- **Prácticas:** Metasploit con Metasploitable; enumeración y escalamiento de privilegios con la máquina RootMe de TryHackMe; auditoría Wi-Fi; auditoría móvil con Metasploit en Android usando Venom.

## Semana 12
- **Contenidos:** OSINT; OWASP Top Ten.
- **Prácticas:** introducción a la inteligencia en fuentes abiertas; análisis de riesgos críticos en aplicaciones web.

## Semana 13
- **Contenidos:** Blue Team (seguridad defensiva): análisis de vulnerabilidades.
- **Prácticas:** análisis de vulnerabilidades con Nessus y OpenVAS; análisis del protocolo SSL con Wireshark.

## Semana 14
- **Contenidos:** firewalls y sistemas de detección de intrusos (IDS).
- **Prácticas:** instalación de Snort en Kali.

## Semana 15
- **Contenidos:** SGSI; ISO 27001:2022; controles de seguridad de la información; gestión de riesgos; marco regulatorio en ciberseguridad.
- **Prácticas:** análisis de riesgos usando contexto y la máquina Vulniversity de TryHackMe.
- **Evaluación:** Parcial Teórico II.

## Semana 16: Evaluación del Corte 2
- Proyecto final (hackatón) con sustentación, rúbrica y TEMA.

# Resumen de evaluaciones por semana

- **Semanas 1 a 3:** Taller Reto 1 del Corte 1.
- **Semanas 4 a 5:** Taller Reto 2 del Corte 1.
- **Semanas 6 a 7:** Taller Reto 3 del Corte 1 (grupal).
- **Semana 8:** Parcial Teórico I y Parcial Práctico I.
- **Semana 9:** Taller Reto 1 del Corte 2.
- **Semanas 10 a 12:** Taller Reto 2 del Corte 2.
- **Semanas 13 a 14:** Taller Reto 3 del Corte 2 (grupal).
- **Semana 15:** Parcial Teórico II.
- **Semana 16:** Proyecto Final (grupal).
- **Asistencia** se evalúa semanalmente en ambos cortes.
