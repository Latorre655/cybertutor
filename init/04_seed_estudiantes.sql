-- =====================================================================
-- CyberTutor | 04_seed_estudiantes.sql
-- Estudiantes SINTÉTICOS (nombres y correos inventados) con perfiles variados.
-- Las notas, asistencias y avances se generan de forma determinista:
-- si lo ejecutas varias veces obtienes siempre los mismos datos.
-- Requiere haber ejecutado antes 02_schema.sql y 03_seed_curso.sql.
-- =====================================================================

TRUNCATE estudiantes RESTART IDENTITY CASCADE;

-- Perfil temporal (NO se guarda en la base):
--   habilidad = nivel base de las notas (0 a 5)
--   faltas    = semanas en las que el estudiante faltó
CREATE TEMP TABLE _perfil (
    id        INT PRIMARY KEY,
    nombre    TEXT NOT NULL,
    habilidad NUMERIC NOT NULL,
    faltas    INT[] NOT NULL DEFAULT '{}'
);

INSERT INTO _perfil (id, nombre, habilidad, faltas) VALUES
 (1,  'Estudiante Demo',          3.5, '{5}'),          -- para las demostraciones y la app
 (2,  'Camila Rojas Prada',       4.7, '{}'),
 (3,  'Andrés Mejía Duarte',      4.3, '{5}'),
 (4,  'Valentina Ortiz León',     4.0, '{2,9}'),
 (5,  'Santiago Pardo Gómez',     3.8, '{7}'),
 (6,  'Laura Sofía Cárdenas',     3.5, '{4}'),
 (7,  'Juan David Ardila',        3.2, '{1,6}'),
 (8,  'Daniela Ríos Becerra',     3.0, '{8}'),
 (9,  'Sebastián Niño Camargo',   2.7, '{2,4,6,9}'),    -- excede el límite de inasistencia
 (10, 'Mariana Villamizar Cruz',  4.5, '{10}'),
 (11, 'Felipe Barrera Suárez',    2.3, '{3,5,7}'),      -- justo en el límite de inasistencia
 (12, 'Karen Jaimes Ortega',      3.4, '{}'),
 (13, 'Nicolás Pinzón Rueda',     2.0, '{1,2,3,5,8}'),  -- notas bajas y excede inasistencia
 (14, 'Isabela Gélvez Prada',     3.9, '{6}'),
 (15, 'Esteban Quintero Mora',    3.1, '{4,7}'),
 (16, 'Paula Andrea Manrique',    4.1, '{}'),
 (17, 'Camilo Acevedo Tarazona',  2.6, '{9,10}'),
 (18, 'Luisa Fernanda Ruiz',      3.3, '{2}');

-- Estudiantes e inscripción en el curso
INSERT INTO estudiantes (id, codigo, nombre, correo)
SELECT id, 'E' || lpad(id::text, 4, '0'), nombre,
       'estudiante' || lpad(id::text, 2, '0') || '@ejemplo.edu.co'
FROM _perfil;

SELECT setval(pg_get_serial_sequence('estudiantes', 'id'), (SELECT max(id) FROM estudiantes));

INSERT INTO inscripciones (estudiante_id, curso_codigo, estado, aprobo_prerrequisito)
SELECT id, '18017', 'activa', TRUE FROM _perfil;

-- Asistencia: semanas 1 hasta (semana_actual - 1)
INSERT INTO asistencia (estudiante_id, semana, asistio)
SELECT p.id, s.n, NOT (s.n = ANY (p.faltas))
FROM _perfil p
CROSS JOIN generate_series(1, (SELECT valor::int FROM config WHERE clave = 'semana_actual') - 1) AS s(n);

-- Notas de las actividades ya finalizadas (semana_fin < semana_actual)
--   * Asistencia: 5.0 x (sesiones asistidas / sesiones del periodo)   [supuesto sintético]
--   * Resto: habilidad del estudiante + variación determinista, entre 0.0 y 5.0
INSERT INTO notas (estudiante_id, actividad_id, nota)
SELECT p.id, a.id,
       CASE WHEN a.categoria = 'asistencia' THEN
                ROUND(5.0 * (SELECT COUNT(*) FROM asistencia s
                             WHERE s.estudiante_id = p.id AND s.asistio
                               AND s.semana BETWEEN a.semana_inicio AND a.semana_fin)
                      / (a.semana_fin - a.semana_inicio + 1), 1)
            ELSE
                ROUND(GREATEST(0, LEAST(5, p.habilidad
                      + ((hashtext(p.id::text || '-' || a.id::text) % 11) / 10.0) * 0.7))::numeric, 1)
       END
FROM _perfil p
CROSS JOIN actividades a
WHERE a.semana_fin < (SELECT valor::int FROM config WHERE clave = 'semana_actual');

-- Progreso en prácticas:
--   semanas ya vistas -> completada o pendiente (según habilidad)
--   semana actual     -> en_progreso
--   semanas futuras   -> pendiente
INSERT INTO progreso_practicas (estudiante_id, practica_id, estado)
SELECT p.id, pr.id,
       CASE WHEN pr.semana < c.sa THEN
                CASE WHEN abs(hashtext(p.id::text || '-' || pr.id::text)::bigint) % 100
                          < (40 + p.habilidad * 12)::int
                     THEN 'completada' ELSE 'pendiente' END
            WHEN pr.semana = c.sa THEN 'en_progreso'
            ELSE 'pendiente' END
FROM _perfil p
CROSS JOIN practicas pr
CROSS JOIN (SELECT valor::int AS sa FROM config WHERE clave = 'semana_actual') c;

DROP TABLE _perfil;
