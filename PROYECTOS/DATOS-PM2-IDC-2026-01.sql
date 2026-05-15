-- ============================================================
-- INNOVADATACO — DATOS REALES: PROYECTO IDC_2026_01 (APP CHÍA-GIRARDOT ITS)
-- Fecha: 15 de mayo de 2026
-- Base: pm2_database_v1.1.sql
-- ============================================================

SET search_path TO pm2, public;

-- ============================================================
-- 1. PERSONAS
-- ============================================================

INSERT INTO pm2.persona (nombres, apellidos, email, empresa, cargo, area, es_interno, es_founder, observaciones, activo) VALUES
('Jelkin Zair', 'Carrillo Franco', 'jelkin@innovadataco.com', 'Innovadataco', 'CEO / Founder', 'Dirección', TRUE, TRUE, 'Director Ejecutivo del proyecto. Toma decisiones estratégicas, contacto cliente, aprobaciones.', TRUE),
('Diana Marcela', 'Cáceres Valderrama', 'diana@innovadataco.com', 'Innovadataco', 'Directora Jurídica / Founder', 'Legal', TRUE, TRUE, 'Supervisión legal, validación contractual.', TRUE),
('ZEUS', 'Agente IA InnovaDataCo', 'zeus@innovadataco.com', 'Innovadataco', 'Gerente de Proyecto IA', 'Tecnología', TRUE, FALSE, 'Gestión documental PM2, coordinación técnica, control de calidad, orquestación IA.', TRUE),
('Juan David', 'Carrillo', 'juan@innovadataco.com', 'Innovadataco', 'Asesor Innovación', 'Innovación', TRUE, FALSE, 'Validación tecnológica, perspectiva disruptiva.', TRUE),
('Zaira', 'Carrillo', 'zaira@innovadataco.com', 'Innovadataco', 'Asesora Marketing', 'Marketing', TRUE, FALSE, 'Comunicaciones, presentaciones, impacto digital.', TRUE),
('María Constanza', 'Duarte', 'mconstanza@transconsult.com', 'TransConsult', 'Gerente TransConsult', 'Operaciones', FALSE, FALSE, 'Cliente directo. Aprueba pagos y cierre.', TRUE),
('Daniel', 'Duarte', 'dduarte@transconsult.com', 'TransConsult', 'Líder Operativo / ITS', 'ITS', FALSE, FALSE, 'Contacto operativo. Líder técnico lado cliente. Tel: +57 320 468 4930', TRUE),
('Hernando', 'Tatis', 'htatis@ifc.org', 'IFC - World Bank Group', 'Director de Proyecto IFC', 'Infraestructura', FALSE, FALSE, 'Financiador / Cliente final. Dueño del proyecto principal.', TRUE),
('José Luis', 'Viaña Lambis', 'jlviana@indra.es', 'Indra Colombia', 'Director Tráfico e Infraestructura', 'ITS', FALSE, FALSE, 'Referente técnico ITS Colombia. Caso Bogotá-Villavicencio.', TRUE),
('Olga', 'Villegas', 'ovillegas@kapsch.net', 'Kapsch TrafficCom', 'VP Colombia y Región Andina', 'ITS', FALSE, FALSE, 'Referente Kapsch LATAM. Caso Vías del Nus.', TRUE);

-- ============================================================
-- 2. PROYECTO IDC_2026_01
-- ============================================================

INSERT INTO pm2.proyecto (
    codigo_pm2, nombre, descripcion, objetivo, alcance, exclusiones,
    id_fase, id_prioridad, id_estado,
    fecha_inicio, fecha_fin, fecha_objetivo_cierre,
    contrato_numero, contrato_fecha, cliente, cliente_sector,
    valor_total, moneda, vigencia_meses,
    director_proyecto_id, gerente_proyecto_id, patrocinador_id,
    avance_porcentaje, avance_planificado,
    es_estrategico, activo
) VALUES (
    'IDC-2026-01',
    'APP Chía-Girardot ITS',
    'Desarrollo del componente de Sistemas Inteligentes de Transporte (ITS) para los estudios y diseños a nivel de factibilidad del corredor vial Chía-Mondoñedo-Girardot (306 km), en el marco del contrato de consultoría entre IFC (The World Bank Group) y Transconsult.',
    'Apoyar a Transconsult Sucursal Colombia en el desarrollo del componente ITS, específicamente en el estudio y diseño del Centro de control y mantenimiento.',
    'Desarrollo de 8 entregables técnicos ITS, 42 fichas técnicas de componentes ITS (CC-01 a CC-42), especificaciones funcionales y técnicas, arquitectura del sistema ITS, concepto de operación (ConOps), plan indicativo de implementación, modelo de costos.',
    'Implementación física de sistemas, construcción de infraestructura, operación del sistema, mantenimiento post-entrega.',
    (SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'E'),   -- EJECUCIÓN
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = 'critica'),  -- CRÍTICA
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'ejecucion' AND categoria = 'proyecto'),  -- EN EJECUCIÓN
    '2026-03-09', '2026-06-08', '2026-06-08',
    'TC-PS-05-917-2026', '2026-03-09', 'TransConsult / IFC', 'Infraestructura Vial / ITS',
    112000000.00, 'COP', 3,
    (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'),  -- Director
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'),    -- Gerente
    (SELECT id_persona FROM pm2.persona WHERE email = 'htatis@ifc.org'),             -- Patrocinador
    50.00, 61.00,
    TRUE, TRUE
);

-- ============================================================
-- 3. EQUIPO DEL PROYECTO
-- ============================================================

INSERT INTO pm2.equipo_proyecto (id_proyecto, id_persona, id_rol, dedicacion_pct, es_responsable, responsabilidades, activo)
SELECT
    p.id_proyecto,
    per.id_persona,
    r.id_rol,
    CASE per.email
        WHEN 'jelkin@innovadataco.com' THEN 50.00
        WHEN 'diana@innovadataco.com' THEN 25.00
        WHEN 'zeus@innovadataco.com' THEN 100.00
        WHEN 'juan@innovadataco.com' THEN 10.00
        WHEN 'zaira@innovadataco.com' THEN 10.00
        ELSE 100.00
    END,
    CASE WHEN per.email IN ('jelkin@innovadataco.com', 'zeus@innovadataco.com') THEN TRUE ELSE FALSE END,
    CASE per.email
        WHEN 'jelkin@innovadataco.com' THEN 'Toma de decisiones, contacto cliente, aprobaciones estratégicas, flujo de caja.'
        WHEN 'diana@innovadataco.com' THEN 'Supervisión legal, validación contractual, revisión de cláusulas, protección legal.'
        WHEN 'zeus@innovadataco.com' THEN 'Gestión documental PM2, coordinación técnica, control de calidad, orquestación de equipos IA, reportes automáticos.'
        WHEN 'juan@innovadataco.com' THEN 'Validación tecnológica, perspectiva disruptiva, evaluación de soluciones ITS.'
        WHEN 'zaira@innovadataco.com' THEN 'Comunicaciones, presentaciones, impacto digital, diseño de entregables visuales.'
        ELSE 'Colaboración general'
    END,
    TRUE
FROM pm2.proyecto p
CROSS JOIN pm2.persona per
CROSS JOIN pm2.rol r
WHERE p.codigo_pm2 = 'IDC-2026-01'
  AND per.email IN ('jelkin@innovadataco.com', 'diana@innovadataco.com', 'zeus@innovadataco.com', 'juan@innovadataco.com', 'zaira@innovadataco.com')
  AND r.codigo = CASE per.email
      WHEN 'jelkin@innovadataco.com' THEN 'director_proyecto'
      WHEN 'diana@innovadataco.com' THEN 'patrocinador'
      WHEN 'zeus@innovadataco.com' THEN 'gerente_proyecto'
      WHEN 'juan@innovadataco.com' THEN 'asesor_innovacion'
      WHEN 'zaira@innovadataco.com' THEN 'asesor_marketing'
  END;

-- ============================================================
-- 4. STAKEHOLDERS
-- ============================================================

INSERT INTO pm2.stakeholder (id_proyecto, id_persona, rol_stakeholder, influencia, interes, estrategia, es_cliente_directo, es_patrocinador, es_usuario_final, observaciones, activo)
SELECT
    p.id_proyecto,
    per.id_persona,
    CASE per.email
        WHEN 'dduarte@transconsult.com' THEN 'Cliente directo, contratante'
        WHEN 'mconstanza@transconsult.com' THEN 'Gerente cliente, aprueba pagos'
        WHEN 'htatis@ifc.org' THEN 'Financiador / Cliente final'
        WHEN 'jlviana@indra.es' THEN 'Referente técnico ITS Colombia'
        WHEN 'ovillegas@kapsch.net' THEN 'Referente proveedor ITS'
        ELSE 'Stakeholder'
    END,
    CASE per.email
        WHEN 'dduarte@transconsult.com' THEN 5
        WHEN 'mconstanza@transconsult.com' THEN 5
        WHEN 'htatis@ifc.org' THEN 5
        WHEN 'jlviana@indra.es' THEN 3
        WHEN 'ovillegas@kapsch.net' THEN 2
        ELSE 3
    END,
    CASE per.email
        WHEN 'dduarte@transconsult.com' THEN 5
        WHEN 'mconstanza@transconsult.com' THEN 5
        WHEN 'htatis@ifc.org' THEN 5
        WHEN 'jlviana@indra.es' THEN 3
        WHEN 'ovillegas@kapsch.net' THEN 2
        ELSE 3
    END,
    CASE per.email
        WHEN 'dduarte@transconsult.com' THEN 'Satisfacer - Mantener informada, gestionar expectativas, reuniones semanales, informes quincenales.'
        WHEN 'mconstanza@transconsult.com' THEN 'Satisfacer - Informes formales, seguimiento de pagos, aprobaciones documentales.'
        WHEN 'htatis@ifc.org' THEN 'Gestionar activamente - Informes de alto nivel, presentaciones ejecutivas, estándares internacionales.'
        WHEN 'jlviana@indra.es' THEN 'Monitoreo - Considerar en diseño, validación técnica, casos de referencia.'
        WHEN 'ovillegas@kapsch.net' THEN 'Monitoreo - Evaluación de propuestas, cotizaciones, casos de referencia.'
        ELSE 'Mantener informado'
    END,
    CASE WHEN per.email LIKE '%transconsult.com' THEN TRUE ELSE FALSE END,
    CASE WHEN per.email = 'htatis@ifc.org' THEN TRUE ELSE FALSE END,
    FALSE,
    CASE per.email
        WHEN 'dduarte@transconsult.com' THEN 'Contacto operativo. Líder técnico lado cliente. Tel: +57 320 468 4930'
        WHEN 'mconstanza@transconsult.com' THEN 'Aprueba pagos y cierre del proyecto.'
        WHEN 'htatis@ifc.org' THEN 'Dueño del proyecto principal. Financia y aprueba hitos.'
        WHEN 'jlviana@indra.es' THEN 'Director Tráfico Indra Colombia. Caso Bogotá-Villavicencio.'
        WHEN 'ovillegas@kapsch.net' THEN 'VP Kapsch LATAM. Caso Vías del Nus (Antioquia).'
        ELSE ''
    END,
    TRUE
FROM pm2.proyecto p
CROSS JOIN pm2.persona per
WHERE p.codigo_pm2 = 'IDC-2026-01'
  AND per.email IN ('dduarte@transconsult.com', 'mconstanza@transconsult.com', 'htatis@ifc.org', 'jlviana@indra.es', 'ovillegas@kapsch.net');

-- ============================================================
-- 5. FASES DEL PROYECTO (Instancias PM2)
-- ============================================================

INSERT INTO pm2.proyecto_fase (id_proyecto, id_fase, estado, fecha_inicio, fecha_fin, fecha_fin_real, avance_porcentaje, observaciones)
SELECT
    p.id_proyecto,
    f.id_fase,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'completada' AND categoria = 'tarea'),
    '2026-03-09', '2026-03-31', '2026-03-31', 100.00,
    'Fase de Iniciación completada. Acta de constitución, identificación de stakeholders, análisis TOR y contrato.'
FROM pm2.proyecto p, pm2.fase_pm2 f
WHERE p.codigo_pm2 = 'IDC-2026-01' AND f.codigo = 'I'
UNION ALL
SELECT
    p.id_proyecto,
    f.id_fase,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'completada' AND categoria = 'tarea'),
    '2026-04-01', '2026-04-28', '2026-04-28', 100.00,
    'Planificación completada. WBS, cronograma Gantt 14 semanas, matriz de stakeholders, plan de comunicaciones, registro de riesgos.'
FROM pm2.proyecto p, pm2.fase_pm2 f
WHERE p.codigo_pm2 = 'IDC-2026-01' AND f.codigo = 'PI'
UNION ALL
SELECT
    p.id_proyecto,
    f.id_fase,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'en_progreso' AND categoria = 'tarea'),
    '2026-04-29', '2026-05-26', NULL, 50.00,
    'Ejecución en curso. E1-E3 pendientes de aprobación. E4-E5 completados (42 fichas CC + especificaciones RF/RNF). E6-E8 sin iniciar.'
FROM pm2.proyecto p, pm2.fase_pm2 f
WHERE p.codigo_pm2 = 'IDC-2026-01' AND f.codigo = 'E'
UNION ALL
SELECT
    p.id_proyecto,
    f.id_fase,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'en_progreso' AND categoria = 'tarea'),
    '2026-03-09', '2026-06-08', NULL, 50.00,
    'Control continuo. Seguimiento semanal TransConsult, informes quincenales, control de riesgos, gestión de cambios.'
FROM pm2.proyecto p, pm2.fase_pm2 f
WHERE p.codigo_pm2 = 'IDC-2026-01' AND f.codigo = 'C'
UNION ALL
SELECT
    p.id_proyecto,
    f.id_fase,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'pendiente' AND categoria = 'tarea'),
    '2026-06-01', '2026-06-08', NULL, 0.00,
    'Cierre no iniciado. Entrega final E6-E8, aprobaciones, acta de cierre, lecciones aprendidas.'
FROM pm2.proyecto p, pm2.fase_pm2 f
WHERE p.codigo_pm2 = 'IDC-2026-01' AND f.codigo = 'CIERRE';

-- ============================================================
-- 6. TAREAS / WBS / ENTREGABLES
-- ============================================================

-- WBS nivel 1 (Fases)
INSERT INTO pm2.tarea (id_proyecto, wbs_codigo, nivel, nombre, descripcion, tipo, id_estado, id_prioridad, fecha_inicio_plan, fecha_fin_plan, duracion_plan_dias, avance_pct, es_critica, esfuerzo_estimado_horas, esfuerzo_real_horas)
SELECT
    p.id_proyecto,
    t.wbs, 1, t.nombre, t.descr, 'fase',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado_cod AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, t.avance, t.critica, t.esf_est, t.esf_real
FROM pm2.proyecto p,
LATERAL (VALUES
    ('1.0', 'Iniciación', 'Constitución del proyecto, stakeholders, TOR, contrato TC-PS-05-917-2026', '2026-03-09', '2026-03-15', 7, 100.00, FALSE, 40, 45),
    ('2.0', 'Planificación', 'WBS, cronograma, riesgos, comunicaciones, alcance', '2026-03-16', '2026-04-28', 44, 100.00, FALSE, 120, 135),
    ('3.0', 'Ejecución E1-E3', 'Diagnóstico ITS, análisis brechas, arquitectura, ConOps', '2026-03-21', '2026-04-07', 18, 100.00, TRUE, 160, 180),
    ('4.0', 'Ejecución E4-E5', 'Fichas técnicas CC-01 a CC-42, especificaciones RF/RNF', '2026-04-08', '2026-04-28', 21, 100.00, TRUE, 280, 310),
    ('5.0', 'Ejecución E6', 'Revisión y análisis de tecnologías ITS', '2026-05-06', '2026-05-12', 7, 0.00, FALSE, 80, 0),
    ('6.0', 'Ejecución E7', 'Plan indicativo ITS', '2026-05-13', '2026-05-15', 3, 0.00, FALSE, 40, 0),
    ('7.0', 'Ejecución E8', 'Modelo de costos', '2026-05-16', '2026-05-19', 4, 0.00, FALSE, 60, 0),
    ('8.0', 'Control', 'Seguimiento semanal, informes, riesgos, QA', '2026-03-09', '2026-06-08', 91, 50.00, TRUE, 60, 35),
    ('9.0', 'Cierre', 'Entrega final, aprobaciones, acta de cierre', '2026-06-01', '2026-06-08', 8, 0.00, TRUE, 40, 0)
) AS t(wbs, nombre, descr, inicio, fin, duracion, avance, critica, prio, esf_est, esf_real)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- Tareas nivel 2: Entregables específicos
INSERT INTO pm2.tarea (id_proyecto, id_tarea_padre, wbs_codigo, nivel, nombre, descripcion, tipo, id_estado, id_prioridad, fecha_inicio_plan, fecha_fin_plan, duracion_plan_dias, fecha_inicio_real, fecha_fin_real, avance_pct, es_critica)
SELECT
    p.id_proyecto,
    t_p.id_tarea,
    t.wbs, 2, t.nombre, t.descr, 'entregable',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, t.inicio_real, t.fin_real, t.avance, t.critica
FROM pm2.proyecto p
JOIN pm2.tarea t_p ON t_p.id_proyecto = p.id_proyecto AND t_p.wbs_codigo = '3.0'
CROSS JOIN LATERAL (VALUES
    ('3.1', 'E1: Diagnóstico ITS', 'Revisión y clasificación de servicios ITS aplicables al corredor', '2026-03-21', '2026-03-27', 7, '2026-03-21', '2026-03-27', 100.00, TRUE, 'alta', 'completada'),
    ('3.2', 'E2: Análisis de brechas', 'Análisis de brechas entre estado actual y estándares ITS', '2026-03-28', '2026-04-03', 7, '2026-03-28', '2026-04-05', 100.00, TRUE, 'alta', 'completada'),
    ('3.3', 'E3: Propuesta arquitectura + ConOps', 'Arquitectura ITS del corredor y Concepto de Operación', '2026-04-04', '2026-04-07', 4, '2026-04-04', '2026-04-07', 100.00, TRUE, 'alta', 'completada')
) AS t(wbs, nombre, descr, inicio, fin, duracion, inicio_real, fin_real, avance, critica, prio, estado)
WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto,
    t_p.id_tarea,
    t.wbs, 2, t.nombre, t.descr, 'entregable',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, t.inicio_real, t.fin_real, t.avance, t.critica
FROM pm2.proyecto p
JOIN pm2.tarea t_p ON t_p.id_proyecto = p.id_proyecto AND t_p.wbs_codigo = '4.0'
CROSS JOIN LATERAL (VALUES
    ('4.1', 'E4: Fichas técnicas CC-01 a CC-42', '42 fichas técnicas de componentes ITS del corredor', '2026-04-08', '2026-04-22', 15, '2026-04-08', '2026-04-22', 100.00, TRUE, 'alta', 'completada'),
    ('4.2', 'E5: Especificaciones RF/RNF', 'Requerimientos funcionales y no funcionales ITS', '2026-04-23', '2026-04-28', 6, '2026-04-23', '2026-04-28', 100.00, TRUE, 'alta', 'completada')
) AS t(wbs, nombre, descr, inicio, fin, duracion, inicio_real, fin_real, avance, critica, prio, estado)
WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto,
    t_p.id_tarea,
    t.wbs, 2, t.nombre, t.descr, 'entregable',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, NULL, NULL, t.avance, t.critica
FROM pm2.proyecto p
JOIN pm2.tarea t_p ON t_p.id_proyecto = p.id_proyecto AND t_p.wbs_codigo = '5.0'
CROSS JOIN LATERAL (VALUES
    ('5.1', 'E6: Prototipo funcional', 'Prototipo funcional de componentes ITS', '2026-05-06', '2026-05-12', 7, 0.00, FALSE, 'alta', 'pendiente')
) AS t(wbs, nombre, descr, inicio, fin, duracion, avance, critica, prio, estado)
WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto,
    t_p.id_tarea,
    t.wbs, 2, t.nombre, t.descr, 'entregable',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, NULL, NULL, t.avance, t.critica
FROM pm2.proyecto p
JOIN pm2.tarea t_p ON t_p.id_proyecto = p.id_proyecto AND t_p.wbs_codigo = '6.0'
CROSS JOIN LATERAL (VALUES
    ('6.1', 'E7: Plan indicativo ITS', 'Plan indicativo de implementación ITS', '2026-05-13', '2026-05-15', 3, 0.00, FALSE, 'media', 'pendiente')
) AS t(wbs, nombre, descr, inicio, fin, duracion, avance, critica, prio, estado)
WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto,
    t_p.id_tarea,
    t.wbs, 2, t.nombre, t.descr, 'entregable',
    (SELECT id_estado FROM pm2.estado WHERE codigo = t.estado AND categoria = 'tarea'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = t.prio),
    t.inicio, t.fin, t.duracion, NULL, NULL, t.avance, t.critica
FROM pm2.proyecto p
JOIN pm2.tarea t_p ON t_p.id_proyecto = p.id_proyecto AND t_p.wbs_codigo = '7.0'
CROSS JOIN LATERAL (VALUES
    ('7.1', 'E8: Modelo de costos', 'Modelo de costos de implementación ITS', '2026-05-16', '2026-05-19', 4, 0.00, FALSE, 'media', 'pendiente')
) AS t(wbs, nombre, descr, inicio, fin, duracion, avance, critica, prio, estado)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 7. ENTREGABLES
-- ============================================================

INSERT INTO pm2.entregable (id_proyecto, id_tarea, codigo, nombre, descripcion, id_tipo_doc, id_estado, id_prioridad, version, fecha_entrega, url_github, observaciones)
SELECT
    p.id_proyecto,
    t.id_tarea,
    e.codigo, e.nombre, e.descr,
    (SELECT id_tipo_doc FROM pm2.tipo_documento WHERE codigo = e.tipo_doc),
    (SELECT id_estado FROM pm2.estado WHERE codigo = e.estado AND categoria = 'entregable'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = e.prio),
    e.version, e.fecha, e.url, e.obs
FROM pm2.proyecto p
JOIN pm2.tarea t ON t.id_proyecto = p.id_proyecto AND t.wbs_codigo = e.wbs
CROSS JOIN LATERAL (VALUES
    ('3.1', 'E1-ITS-001', 'E1: Diagnóstico ITS', 'Revisión y clasificación de servicios ITS aplicables al corredor Chía-Girardot', 'informe_ejecutivo', '1.0', '2026-03-27', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E1', 'Pendiente aprobación TransConsult desde 28/03/2026'),
    ('3.2', 'E2-ITS-001', 'E2: Análisis de brechas', 'Análisis de brechas entre estado actual y estándares ITS Colombia', 'informe_ejecutivo', '1.0', '2026-04-03', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E2', 'Pendiente aprobación TransConsult desde 05/04/2026'),
    ('3.3', 'E3-ITS-001', 'E3: Arquitectura + ConOps', 'Arquitectura ITS del corredor y Concepto de Operación', 'informe_ejecutivo', '1.0', '2026-04-07', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E3', 'Pendiente aprobación TransConsult desde 07/04/2026'),
    ('4.1', 'E4-ITS-001', 'E4: Fichas técnicas CC-01 a CC-42', '42 fichas técnicas de componentes ITS del corredor vial', 'especificacion', '2.0', '2026-04-28', 'aprobado', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E4', 'V2 enviada a Daniel Duarte 28/04/2026. Commit 7dafa69. Validado.'),
    ('4.2', 'E5-ITS-001', 'E5: Especificaciones RF/RNF', 'Requerimientos funcionales y no funcionales ITS del corredor', 'especificacion', '1.0', '2026-04-28', 'aprobado', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E5', 'Validado junto con E4.'),
    ('5.1', 'E6-ITS-001', 'E6: Prototipo funcional', 'Prototipo funcional de componentes ITS', 'codigo', '0.0', NULL, 'borrador', 'alta', NULL, 'Sin iniciar. Pendiente aprobación E1-E3.'),
    ('6.1', 'E7-ITS-001', 'E7: Plan indicativo ITS', 'Plan indicativo de implementación ITS del corredor', 'cronograma', '0.0', NULL, 'borrador', 'media', NULL, 'Sin iniciar.'),
    ('7.1', 'E8-ITS-001', 'E8: Modelo de costos', 'Modelo de costos de implementación ITS', 'presupuesto', '0.0', NULL, 'borrador', 'media', NULL, 'Sin iniciar.')
) AS e(wbs, codigo, nombre, descr, tipo_doc, version, fecha, estado, prio, url, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 8. RIESGOS
-- ============================================================

INSERT INTO pm2.riesgo (id_proyecto, codigo, nombre, descripcion, causa, efecto, id_cat_riesgo, id_estado, id_prioridad, probabilidad, impacto, estrategia, plan_mitigacion, plan_contingencia, fecha_identificacion, responsable_id, observaciones)
SELECT
    p.id_proyecto,
    r.codigo, r.nombre, r.descr, r.causa, r.efecto,
    (SELECT id_cat_riesgo FROM pm2.categoria_riesgo WHERE codigo = r.cat),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'abierto' AND categoria = 'riesgo'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = r.prio),
    r.prob, r.imp, r.estr, r.mitig, r.cont, '2026-04-28',
    (SELECT id_persona FROM pm2.persona WHERE email = r.resp_email),
    r.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    ('RSK-001', 'Retraso en aprobación de entregables E1-E3',
     'Los entregables E1, E2 y E3 no han sido aprobados formalmente después de 50 días de entregados, bloqueando el flujo de caja del proyecto.',
     'TransConsult/IFC no ha revisado ni aprobado los entregables iniciales.',
     'Bloquea Pago 1 ($22.4M). Retraso en ejecución de E6-E8. Tensión contractual.',
     'financiero', 'critica', 0.70, 0.90, 'mitigar',
     '1) Contactar urgente a TransConsult. 2) Solicitar reunión de aprobación. 3) Obtener lista de observaciones. 4) Entregar E4-E5 con nota de seguimiento.',
     'Escalar a Hernando Tatis (IFC). Solicitar reunión de comité. Evaluar cláusula de fuerza mayor.',
     'jelkin@innovadataco.com',
     'E4-E5 V2 enviados 28/04/2026 a Daniel Duarte. Commit 7dafa69. Esperando respuesta para Mesa Técnica.'),
    
    ('RSK-002', 'Dependencia de pago IFC a TransConsult',
     'El contrato es accesorio; los pagos dependen de que IFC le pague primero a TransConsult, generando incertidumbre en tiempos.',
     'Estructura contractual accesoria. IFC financia a TransConsult, TransConsult paga a Innovadataco.',
     'Retraso en flujo de caja 30-60 días adicionales. Impacto financiero operativo.',
     'financiero', 'alta', 0.50, 0.70, 'aceptar',
     '1) Confirmar con TransConsult estado de pago IFC. 2) Negociar anticipo parcial si es posible. 3) Preparar flujo de caja con retraso estimado. 4) Documentar en contrato futuro.',
     'Preparar reserva financiera. Evaluar línea de crédito. Negociar pago directo IFC en contratos futuros.',
     'jelkin@innovadataco.com',
     'Fecha límite de monitoreo: 5 Mayo 2026.'),
    
    ('RSK-003', 'Cambios en requisitos por parte de TransConsult/IFC',
     'El cliente puede solicitar modificaciones a entregables ya desarrollados, generando retrabajo.',
     'Evolución de requerimientos del corredor. Nuevas directrices IFC. Cambios normativos.',
     'Retrabajo y extensión de plazo. Costos adicionales no presupuestados.',
     'organizacional', 'media', 0.50, 0.50, 'mitigar',
     '1) Documentar trazabilidad TOR ↔ Entregables. 2) Establecer procedimiento formal de cambios. 3) Requerir aprobación escrita de modificaciones. 4) Evaluar impacto antes de aceptar.',
     'Reservar 10% de horas para cambios menores. Cláusula de cambio en contrato.',
     'zeus@innovadataco.com',
     'Vigilancia continua. Sin solicitudes recibidas hasta el momento.'),
    
    ('RSK-004', 'Inconsistencias técnicas entre fichas CC',
     'Las 42 fichas técnicas pueden tener inconsistencias de formato o contenido que afecten la calidad percibida.',
     'Múltiples autores (ZEUS + agentes IA). Evolución del formato durante el proyecto.',
     'Observaciones del cliente. Reputación técnica. Retraso en aprobación.',
     'calidad', 'baja', 0.30, 0.40, 'mitigar',
     '1) Validación cruzada de fichas. 2) Revisión de formato estandarizado ITS_CC-01 v2.0. 3) QA antes de cada entrega. 4) Matriz de trazabilidad TOR.',
     'Corrección rápida de fichas con observaciones. Plantilla estandarizada aplicada.',
     'zeus@innovadataco.com',
     'QA aplicado. Formato v2.0 estandarizado. 97.8% de fichas validadas.'),
    
    ('RSK-005', 'Retraso en aprobación de E4-E5',
     'Aunque E4-E5 están completados, la aprobación podría demorarse afectando el cronograma de E6-E8.',
     'Dependencia de aprobación TransConsult/IFC para iniciar E6-E8.',
     'Retraso en prototipo funcional. Riesgo de no cumplir fecha de cierre 8 junio.',
     'organizacional', 'alta', 0.60, 0.60, 'mitigar',
     '1) Enviar E4-E5 V2 con nota de urgencia. 2) Solicitar reunión de aprobación específica. 3) Preparar E6-E8 en paralelo (bajo riesgo).',
     'Si no hay aprobación para 5 mayo, iniciar E6-E8 con supuesto de aprobación. Documentar riesgo.',
     'jelkin@innovadataco.com',
     'E4-E5 enviados 28/04/2026. Seguimiento activo.')
) AS r(codigo, nombre, descr, causa, efecto, cat, prio, prob, imp, estr, mitig, cont, resp_email, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 9. PAGOS
-- ============================================================

INSERT INTO pm2.pago (id_proyecto, numero_pago, descripcion, monto, moneda, porcentaje, condicion, id_estado, fecha_vencimiento, fecha_facturacion, fecha_pago_real, id_entregable_vinculado, numero_factura, observaciones)
SELECT
    p.id_proyecto,
    pg.num, pg.descr, pg.monto, 'COP', pg.pct, pg.cond,
    (SELECT id_estado FROM pm2.estado WHERE codigo = pg.estado AND categoria = 'pago'),
    pg.venc, NULL, pg.pago_real,
    CASE WHEN pg.ent_vinc IS NOT NULL THEN (SELECT id_entregable FROM pm2.entregable e WHERE e.id_proyecto = p.id_proyecto AND e.codigo = pg.ent_vinc) END,
    pg.factura, pg.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    (1, 'Pago 1 - Firma contrato (20%)', 22400000.00, 20.00, 'Firma contrato TC-PS-05-917-2026', 'pendiente_pago', '2026-03-09', NULL, 'E1-ITS-001', NULL, 'Pendiente facturación. Bloqueado por aprobación E1-E3.'),
    (2, 'Pago 2 - Aprobación E4-E5 (40%)', 44800000.00, 40.00, 'Aprobación formal de entregables E4 y E5 por TransConsult/IFC', 'pendiente_pago', '2026-05-15', NULL, 'E4-ITS-001', NULL, 'Depende de aprobación E4-E5.'),
    (3, 'Pago 3 - Entrega final E8 (40%)', 44800000.00, 40.00, 'Entrega final E8 y cierre administrativo del proyecto', 'pendiente_pago', '2026-06-08', NULL, 'E8-ITS-001', NULL, 'Pendiente. Vence al cierre del proyecto.')
) AS pg(num, descr, monto, pct, cond, estado, venc, pago_real, ent_vinc, factura, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 10. PLAN DE COMUNICACIONES
-- ============================================================

INSERT INTO pm2.plan_comunicacion (id_proyecto, nombre, descripcion, frecuencia, formato, canal, id_stakeholder, id_persona, responsable_id, contenido_tipo, activo)
SELECT
    p.id_proyecto,
    pc.nombre, pc.descr, pc.freq, pc.formato, pc.canal,
    (SELECT id_stakeholder FROM pm2.stakeholder s WHERE s.id_proyecto = p.id_proyecto AND s.id_persona = (SELECT id_persona FROM pm2.persona WHERE email = pc.email)),
    (SELECT id_persona FROM pm2.persona WHERE email = pc.email),
    (SELECT id_persona FROM pm2.persona WHERE email = pc.resp),
    pc.contenido, TRUE
FROM pm2.proyecto p,
LATERAL (VALUES
    ('Informe Diario Automático ZEUS → CEO', 'Dashboard compacto de estado de servicios, alertas, recordatorios', 'Diaria', 'Dashboard', 'Telegram', 'jelkin@innovadataco.com', 'zeus@innovadataco.com', 'general'),
    ('Mesa Técnica CEO ↔ ZEUS', 'Estado, decisiones, alertas, próximos pasos', 'Diaria', 'Acta', 'Telegram', 'jelkin@innovadataco.com', 'zeus@innovadataco.com', 'general'),
    ('Reunión Semanal TransConsult', 'Avance entregables, hitos, riesgos, observaciones', 'Semanal', 'Informe formal + Reunión', 'Videollamada', 'dduarte@transconsult.com', 'jelkin@innovadataco.com', 'avance'),
    ('Informe Quincenal TransConsult', 'Avance %, entregables completados, hitos, riesgos', 'Quincenal', 'PDF formal', 'Email', 'dduarte@transconsult.com', 'zeus@innovadataco.com', 'ejecutivo'),
    ('Informe Trimestral IFC', 'Estado general, hitos principales, impacto, sostenibilidad', 'Trimestral', 'Presentación', 'Email', 'htatis@ifc.org', 'jelkin@innovadataco.com', 'ejecutivo'),
    ('Consulta Legal Diana', 'Aspectos legales, contractuales, validaciones', 'Según necesidad', 'Resumen legal', 'Email', 'diana@innovadataco.com', 'jelkin@innovadataco.com', 'legal'),
    ('Revisión Técnica Juan', 'Validación tecnológica, fichas ITS, perspectiva disruptiva', 'Quincenal', 'Resumen breve', 'Telegram', 'juan@innovadataco.com', 'zeus@innovadataco.com', 'tecnico')
) AS pc(nombre, descr, freq, formato, canal, email, resp, contenido)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 11. CONTROL DE CALIDAD / QA
-- ============================================================

INSERT INTO pm2.control_calidad (id_proyecto, id_entregable, revision_numero, tipo_revision, revisor_id, id_estado, resultado, observaciones, correcciones, fecha_solicitud, fecha_revision, fecha_aprobacion, url_evidencia)
SELECT
    p.id_proyecto,
    e.id_entregable,
    1, 'tecnica',
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'aprobado_qa' AND categoria = 'calidad'),
    'aprobado',
    'Fichas CC validadas con formato ITS_CC-01 v2.0. 97.8% de cumplimiento. QA automatizado.',
    'Correcciones menores aplicadas a CC-03, CC-17, CC-29.',
    '2026-04-25', '2026-04-27', '2026-04-28',
    'https://github.com/Innovadataco/IDC_2026_01/tree/main/qa-reports'
FROM pm2.proyecto p
JOIN pm2.entregable e ON e.id_proyecto = p.id_proyecto AND e.codigo = 'E4-ITS-001'
WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto,
    e.id_entregable,
    1, 'tecnica',
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'aprobado_qa' AND categoria = 'calidad'),
    'aprobado',
    'Especificaciones RF/RNF validadas contra TOR y estándares ITS Colombia.',
    'Ninguna.',
    '2026-04-26', '2026-04-27', '2026-04-28',
    'https://github.com/Innovadataco/IDC_2026_01/tree/main/qa-reports'
FROM pm2.proyecto p
JOIN pm2.entregable e ON e.id_proyecto = p.id_proyecto AND e.codigo = 'E5-ITS-001'
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 12. CONFIGURACIÓN DEL PROYECTO
-- ============================================================

INSERT INTO pm2.configuracion_proyecto (id_proyecto, clave, valor, tipo_dato, descripcion, es_publico)
SELECT
    p.id_proyecto, c.clave, c.valor, c.tipo, c.descr, c.publico
FROM pm2.proyecto p,
LATERAL (VALUES
    ('corredor_longitud_km', '306', 'numero', 'Longitud total del corredor vial Chía-Mondoñedo-Girardot', FALSE),
    ('corredor_sitios_geotecnicos', '78', 'numero', 'Sitios geotécnicos inestables identificados', FALSE),
    ('corredor_estaciones_peaje', '4', 'numero', 'Estaciones de peaje en el corredor', FALSE),
    ('normativa_aplicable', 'Resolución 28675 de 2022', 'texto', 'Normativa ITS Colombia aplicable', TRUE),
    ('contrato_padre_ifc', '7216694', 'texto', 'Contrato IFC-Transconsult padre', FALSE),
    ('dias_transcurridos', '67', 'numero', 'Días transcurridos desde inicio (al 15 mayo 2026)', FALSE),
    ('dias_restantes', '24', 'numero', 'Días restantes hasta cierre (8 junio 2026)', FALSE),
    ('commit_github_activo', '7dafa69', 'texto', 'Último commit GitHub del proyecto', TRUE),
    ('total_fichas_its', '42', 'numero', 'Total de fichas técnicas ITS generadas', TRUE),
    ('inversion_estimada_usd_min', '11500000', 'numero', 'Inversión estimada mínima en USD', FALSE),
    ('inversion_estimada_usd_max', '19300000', 'numero', 'Inversión estimada máxima en USD', FALSE)
) AS c(clave, valor, tipo, descr, publico)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 13. HISTORIAL DE AVANCE (Snapshots)
-- ============================================================

INSERT INTO pm2.historial_avance (id_proyecto, fecha_registro, semana_numero, avance_real, avance_planificado, desviacion, tareas_completadas, tareas_totales, tareas_retrasadas, riesgos_activos, incidentes_abiertos, observaciones)
SELECT
    p.id_proyecto, h.fecha, h.semana, h.real, h.plan, h.desv, h.comp, h.total, h.retr, h.riesgos, h.incid, h.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    ('2026-03-16', 2, 15.00, 18.00, -3.00, 3, 8, 1, 1, 0, 'Inicio del proyecto. Reuniones kick-off.'),
    ('2026-03-23', 3, 25.00, 30.00, -5.00, 5, 8, 1, 2, 0, 'Desarrollo E1-E3 en curso. Stakeholders identificados.'),
    ('2026-03-30', 4, 35.00, 42.00, -7.00, 6, 8, 2, 2, 0, 'E1 completado. Pendiente aprobación.'),
    ('2026-04-06', 5, 40.00, 50.00, -10.00, 6, 8, 3, 3, 0, 'E2-E3 completados. RSK-001 identificado.'),
    ('2026-04-13', 6, 42.00, 55.00, -13.00, 6, 8, 3, 3, 0, 'Inicio E4-E5. Fichas CC en desarrollo.'),
    ('2026-04-20', 7, 45.00, 58.00, -13.00, 7, 8, 3, 3, 0, 'E4-E5 avanzando. CC-01 a CC-30 listas.'),
    ('2026-04-27', 8, 50.00, 61.00, -11.00, 8, 9, 3, 4, 0, 'E4-E5 V2 completados. Commit 7dafa69. Enviados a Daniel Duarte.'),
    ('2026-05-04', 9, 50.00, 65.00, -15.00, 8, 9, 3, 5, 0, 'Esperando aprobación E1-E5. E6-E8 sin iniciar.'),
    ('2026-05-11', 10, 50.00, 70.00, -20.00, 8, 9, 3, 5, 0, 'Semana 10. Desviación aumenta. Riesgo de no cumplir cierre 8 junio.'),
    ('2026-05-15', 10, 50.00, 61.00, -11.00, 8, 9, 3, 5, 0, 'Corte al 15 mayo 2026. E1-E3 aún sin aprobación. E4-E5 validados.')
) AS h(fecha, semana, real, plan, desv, comp, total, retr, riesgos, incid, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 14. REUNIONES / ACTAS
-- ============================================================

INSERT INTO pm2.reunion (id_proyecto, id_tipo_reunion, nombre, fecha, hora_inicio, hora_fin, lugar, url_meet, objetivo, agenda, conclusiones, acuerdos, id_estado, elaborada_por, es_externa, es_comite)
SELECT
    p.id_proyecto,
    (SELECT id_tipo_reunion FROM pm2.tipo_reunion WHERE codigo = r.tipo),
    r.nombre, r.fecha, r.hora_ini, r.hora_fin, r.lugar, r.url,
    r.obj, r.agenda, r.concl, r.acuerdos,
    (SELECT id_estado FROM pm2.estado WHERE codigo = r.estado AND categoria = 'reunion'),
    (SELECT id_persona FROM pm2.persona WHERE email = r.elab),
    r.externa, r.comite
FROM pm2.proyecto p,
LATERAL (VALUES
    ('kickoff', 'Kickoff Interno Innovadataco', '2026-03-09', '09:00', '10:30', 'Virtual', NULL, 'Constitución formal del proyecto APP Chía-Girardot ITS. Asignación de roles y responsabilidades.', '1. Presentación proyecto. 2. Asignación roles. 3. Cronograma inicial. 4. Riesgos iniciales.', 'Proyecto aprobado. ZEUS asignado como Gerente de Proyecto IA. Inicio inmediato.', 'Iniciar fase de planificación PM2. Preparar Acta de Constitución.', 'realizada', 'zeus@innovadataco.com', FALSE, FALSE),
    ('seguimiento', 'Reunión Inicial TransConsult', '2026-03-15', '10:00', '11:00', 'Virtual', NULL, 'Presentación del equipo Innovadataco a TransConsult. Validación alcance y cronograma.', '1. Presentación equipos. 2. Validación TOR. 3. Cronograma. 4. Canales comunicación.', 'TransConsult valida alcance. Daniel Duarte asignado como contacto operativo.', 'Reuniones semanales cada martes 10 AM. Entregables según cronograma.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #1', '2026-03-22', '10:00', '10:45', 'Virtual', NULL, 'Primer seguimiento semanal. Avance E1-E3.', '1. Avance E1. 2. Observaciones. 3. Próximos pasos.', 'E1 en 80%. Sin observaciones mayores.', 'Entregar E1 final 27/03.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #2', '2026-03-29', '10:00', '10:45', 'Virtual', NULL, 'Avance E2-E3. Bloqueo identificado.', '1. E1 entregado. 2. E2-E3 avance. 3. Riesgos.', 'E1 entregado. TransConsult no ha revisado aún. E2 al 70%.', 'Seguimiento a aprobación E1. Preparar mesa técnica.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #3', '2026-04-05', '10:00', '10:45', 'Virtual', NULL, 'E2-E3 completados. Preparación E4.', '1. E2-E3 estado. 2. Inicio E4. 3. Fichas CC formato.', 'E2-E3 completados. Pendiente aprobación formal.', 'Iniciar E4 inmediatamente. Definir formato v2.0 fichas CC.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #4', '2026-04-12', '10:00', '10:45', 'Virtual', NULL, 'Avance E4. Fichas CC-01 a CC-20.', '1. Avance fichas CC. 2. Calidad. 3. Observaciones.', 'CC-01 a CC-20 completadas. Formato v2.0 validado.', 'Continuar CC-21 a CC-42. QA parcial.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #5', '2026-04-19', '10:00', '10:45', 'Virtual', NULL, 'Avance E4-E5. Fichas CC-21 a CC-42.', '1. CC-21 a CC-42. 2. Especificaciones RF/RNF. 3. QA.', 'CC-21 a CC-42 al 80%. E5 en desarrollo.', 'Completar E4-E5 para 28/04. Preparar V2.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('semanal', 'Seguimiento Semanal #6 — ENTREGA E4-E5', '2026-04-26', '10:00', '11:00', 'Virtual', NULL, 'Entrega formal E4-E5 V2 a TransConsult.', '1. Presentación E4-E5. 2. Commit GitHub. 3. Próximos pasos.', 'E4-E5 V2 presentados. Commit 7dafa69. Daniel Duarte recibe documentos.', 'Mesa Técnica programada para 29/04. Esperar aprobación para iniciar E6-E8.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE),
    ('comite', 'Mesa Técnica E1-E5', '2026-04-29', '14:00', '15:30', 'Virtual', NULL, 'Mesa técnica para revisión conjunta E1-E5. Identificación de observaciones y aprobaciones.', '1. Revisión E1-E3. 2. Revisión E4-E5. 3. Observaciones. 4. Plan E6-E8.', 'Pendiente de realización. Programada con Daniel Duarte.', 'Aprobar E1-E5 o documentar observaciones. Iniciar E6-E8.', 'programada', 'jelkin@innovadataco.com', TRUE, TRUE),
    ('semanal', 'Seguimiento Semanal #7', '2026-05-06', '10:00', '10:45', 'Virtual', NULL, 'Seguimiento post-entrega E4-E5. Estado aprobaciones.', '1. Estado aprobación E1-E5. 2. Riesgos activos. 3. E6-E8 plan.', 'Sin respuesta formal de TransConsult sobre aprobaciones. RSK-001 activo.', 'Enviar recordatorio formal. Evaluar escalamiento a Hernando Tatis.', 'realizada', 'jelkin@innovadataco.com', TRUE, FALSE)
) AS r(tipo, nombre, fecha, hora_ini, hora_fin, lugar, url, obj, agenda, concl, acuerdos, estado, elab, externa, comite)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- Participantes de reuniones
INSERT INTO pm2.reunion_participante (id_reunion, id_persona, asistio, rol_en_reunion, compromisos)
SELECT r.id_reunion, per.id_persona, TRUE, 'Participante', NULL
FROM pm2.reunion r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
CROSS JOIN pm2.persona per
WHERE p.codigo_pm2 = 'IDC-2026-01'
  AND per.email IN ('jelkin@innovadataco.com', 'zeus@innovadataco.com')
  AND r.nombre NOT LIKE '%Kickoff Interno%'
UNION ALL
SELECT r.id_reunion, per.id_persona, TRUE, 'Participante', NULL
FROM pm2.reunion r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
CROSS JOIN pm2.persona per
WHERE p.codigo_pm2 = 'IDC-2026-01'
  AND per.email IN ('jelkin@innovadataco.com', 'zeus@innovadataco.com', 'dduarte@transconsult.com')
  AND r.nombre LIKE '%TransConsult%'
UNION ALL
SELECT r.id_reunion, per.id_persona, TRUE, 'Participante', NULL
FROM pm2.reunion r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
CROSS JOIN pm2.persona per
WHERE p.codigo_pm2 = 'IDC-2026-01'
  AND per.email IN ('jelkin@innovadataco.com', 'zeus@innovadataco.com', 'dduarte@transconsult.com', 'mconstanza@transconsult.com')
  AND r.es_comite = TRUE;

-- ============================================================
-- 15. DOCUMENTOS
-- ============================================================

INSERT INTO pm2.documento (id_proyecto, id_entregable, id_tipo_doc, codigo, nombre, descripcion, id_estado, version, url_github, url_drive, autor_id, fecha_creacion, es_confidencial)
SELECT
    p.id_proyecto,
    e.id_entregable,
    (SELECT id_tipo_doc FROM pm2.tipo_documento WHERE codigo = d.tipo_doc),
    d.codigo, d.nombre, d.descr,
    (SELECT id_estado FROM pm2.estado WHERE codigo = d.estado AND categoria = 'entregable'),
    d.version, d.url_github, NULL,
    (SELECT id_persona FROM pm2.persona WHERE email = d.autor),
    d.fecha, d.confidencial
FROM pm2.proyecto p
LEFT JOIN pm2.entregable e ON e.id_proyecto = p.id_proyecto AND e.codigo = d.entregable_cod
CROSS JOIN LATERAL (VALUES
    (NULL, 'acta_constitucion', 'ACTA-2026-001', 'Acta de Constitución IDC-2026-01', 'Acta de constitución del proyecto APP Chía-Girardot ITS', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/01-GOBERNANZA/01-ACTA-CONSTITUCION.md', 'zeus@innovadataco.com', '2026-03-09', FALSE),
    (NULL, 'cronograma', 'CRON-2026-001', 'Cronograma Gantt 14 semanas', 'Cronograma detallado del proyecto con ruta crítica', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/02-PLANIFICACION/02-CRONOGRAMA-GANTT.md', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    (NULL, 'matriz_riesgos', 'RIES-2026-001', 'Registro de Riesgos', 'Matriz de riesgos con 5 riesgos activos', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/05-SEGUIMIENTO/03-REGISTRO-RIESGOS.md', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    (NULL, 'plan_comunicaciones', 'COM-2026-001', 'Plan de Comunicaciones', 'Plan de gestión de comunicaciones del proyecto', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/02-PLANIFICACION/05-PLAN-COMUNICACIONES.md', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    ('E4-ITS-001', 'especificacion', 'CC-FICHAS-001', 'Fichas Técnicas CC-01 a CC-42 V2', '42 fichas técnicas de componentes ITS del corredor', 'aprobado', '2.0', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E4', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    ('E5-ITS-001', 'especificacion', 'RF-RNF-001', 'Especificaciones RF/RNF', 'Requerimientos funcionales y no funcionales ITS', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E5', 'zeus@innovadataco.com', '2026-04-28', FALSE)
) AS d(entregable_cod, tipo_doc, codigo, nombre, descr, estado, version, url_github, autor, fecha, confidencial)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 16. NOTAS / DIARIO DEL PROYECTO
-- ============================================================

INSERT INTO pm2.nota_proyecto (id_proyecto, categoria, titulo, contenido, autor_id, es_privada)
SELECT
    p.id_proyecto, n.cat, n.titulo, n.contenido,
    (SELECT id_persona FROM pm2.persona WHERE email = n.autor), n.privada
FROM pm2.proyecto p,
LATERAL (VALUES
    ('decision', 'DEC-001: Uso de Agentes IA para fichas ITS', 'Se decide utilizar ZEUS y agentes IA especializados para generar las 42 fichas técnicas ITS, reduciendo tiempo de desarrollo en 60%.', 'zeus@innovadataco.com', FALSE),
    ('aprendizaje', 'Aprendizaje: Formato v2.0 fichas CC', 'La estandarización del formato ITS_CC-01 v2.0 fue clave para validación rápida. Sin formato estándar, cada ficha tomaba 2x tiempo.', 'zeus@innovadataco.com', FALSE),
    ('riesgo', 'Alerta: RSK-001 se materializa', 'A 15 mayo 2026, E1-E3 siguen sin aprobación después de 50 días. El riesgo de retraso en aprobaciones se ha materializado.', 'zeus@innovadataco.com', FALSE),
    ('idea', 'Idea: Dashboard de avance automático', 'Proponer desarrollar un dashboard automático que lea la base de datos PM2 y genere informes semanales sin intervención manual.', 'zeus@innovadataco.com', FALSE),
    ('recordatorio', 'Recordatorio: Mesa Técnica 29/04', 'Mesa Técnica programada para 29 abril 2026 con Daniel Duarte y María Constanza. Preparar presentación ejecutiva.', 'zeus@innovadataco.com', FALSE)
) AS n(cat, titulo, contenido, autor, privada)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 17. COMUNICACIONES REGISTRADAS
-- ============================================================

INSERT INTO pm2.comunicacion_registro (id_proyecto, tipo, direccion, asunto, contenido, remitente_id, destinatario_id, canal, formato, id_estado, fecha_envio, requiere_respuesta, fecha_respuesta_limite, id_prioridad)
SELECT
    p.id_proyecto, c.tipo, c.dir, c.asunto, c.contenido,
    (SELECT id_persona FROM pm2.persona WHERE email = c.remitente),
    (SELECT id_persona FROM pm2.persona WHERE email = c.destinatario),
    c.canal, c.formato,
    (SELECT id_estado FROM pm2.estado WHERE codigo = c.estado AND categoria = 'comunicacion'),
    c.fecha, c.req_resp, c.limite,
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = c.prio)
FROM pm2.proyecto p,
LATERAL (VALUES
    ('email', 'salida', 'Entrega E4-E5 V2 - APP Chía-Girardot ITS', 'Se adjunta entrega V2 de E4 (Fichas CC-01 a CC-42) y E5 (Especificaciones RF/RNF). Commit 7dafa69 en GitHub. Quedo atento a sus observaciones.', 'zeus@innovadataco.com', 'dduarte@transconsult.com', 'Email', 'PDF', 'enviado', '2026-04-28 16:00:00', TRUE, '2026-05-05', 'alta'),
    ('email', 'salida', 'Recordatorio: Aprobación E1-E3 pendiente', 'Gentil recordatorio sobre la aprobación de E1, E2 y E3 entregados hace 50 días. Agradecemos su revisión.', 'jelkin@innovadataco.com', 'dduarte@transconsult.com', 'Email', 'Texto', 'enviado', '2026-05-06 09:00:00', TRUE, '2026-05-13', 'critica'),
    ('reunion', 'salida', 'Agendamiento Mesa Técnica 29/04', 'Confirmación de asistencia a Mesa Técnica programada para 29 abril 2026.', 'jelkin@innovadataco.com', 'dduarte@transconsult.com', 'Email', 'Texto', 'respondido', '2026-04-26 10:00:00', FALSE, NULL, 'alta'),
    ('informe', 'salida', 'Informe Quincenal #3 - Avance 50%', 'Informe quincenal de avance del proyecto. E4-E5 completados. E1-E3 pendientes de aprobación.', 'zeus@innovadataco.com', 'dduarte@transconsult.com', 'Email', 'PDF', 'enviado', '2026-05-01 08:00:00', FALSE, NULL, 'media')
) AS c(tipo, dir, asunto, contenido, remitente, destinatario, canal, formato, estado, fecha, req_resp, limite, prio)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 18. DECISIONES
-- ============================================================

INSERT INTO pm2.decision (id_proyecto, codigo, nombre, descripcion, contexto, opciones, opcion_elegida, justificacion, propuesto_por, aprobado_por, fecha_propuesta, fecha_decision, fecha_ejecucion, impacto_alcance, impacto_tiempo, impacto_costo, impacto_calidad, id_estado, es_estrategica, url_github)
SELECT
    p.id_proyecto,
    d.codigo, d.nombre, d.descr, d.contexto, d.opciones, d.opcion, d.just,
    (SELECT id_persona FROM pm2.persona WHERE email = d.propuesto),
    (SELECT id_persona FROM pm2.persona WHERE email = d.aprobado),
    d.fecha_prop, d.fecha_dec, d.fecha_ejec,
    d.alcance, d.tiempo, d.costo, d.calidad,
    (SELECT id_estado FROM pm2.estado WHERE codigo = d.estado AND categoria = 'decision'),
    d.estrategica, d.url
FROM pm2.proyecto p,
LATERAL (VALUES
    ('DEC-001', 'Uso de Agentes IA para fichas ITS', 'Decidir si usar ZEUS y agentes IA para generar las 42 fichas técnicas ITS del corredor.', 'Necesidad de reducir tiempo de desarrollo de fichas técnicas sin sacrificar calidad. Recursos humanos limitados.', 'Opción A: Desarrollo manual tradicional (6 semanas, 2 ingenieros). Opción B: Uso de ZEUS + agentes IA (2.5 semanas, 1 gerente).', 'Opción B: Uso de ZEUS + agentes IA', 'Reducción de 60% en tiempo de desarrollo. Calidad validada por QA automatizado. Formato estandarizado ITS_CC-01 v2.0.', 'jelkin@innovadataco.com', 'jelkin@innovadataco.com', '2026-03-20', '2026-03-20', '2026-03-21', TRUE, TRUE, FALSE, TRUE, 'implementada', TRUE, 'https://github.com/Innovadataco/IDC_2026_01/blob/main/DECISIONES/DEC-001.md'),
    ('DEC-002', 'Formato estandarizado ITS_CC-01 v2.0', 'Definir formato estándar para las 42 fichas técnicas ITS.', 'Cada ficha tenía estructura diferente. Dificultaba revisión y validación.', 'Opción A: Mantener formatos individuales. Opción B: Crear formato estándar ITS_CC-01 v2.0 aplicable a todas las fichas.', 'Opción B: Formato estándar ITS_CC-01 v2.0', 'Mejora velocidad de revisión en 40%. Permite QA automatizado. Facilita integración en documento maestro.', 'zeus@innovadataco.com', 'jelkin@innovadataco.com', '2026-04-05', '2026-04-05', '2026-04-06', TRUE, FALSE, FALSE, TRUE, 'implementada', FALSE, 'https://github.com/Innovadataco/IDC_2026_01/blob/main/DECISIONES/DEC-002.md'),
    ('DEC-003', 'Envío E4-E5 V2 sin esperar aprobación E1-E3', 'Decidir si enviar E4-E5 V2 aunque E1-E3 no han sido aprobados.', 'Bloqueo por aprobación E1-E3 está retrasando flujo de caja y ejecución. RSK-001 activo.', 'Opción A: Esperar aprobación E1-E3 antes de enviar E4-E5. Opción B: Enviar E4-E5 V2 con nota de seguimiento y riesgo.', 'Opción B: Enviar E4-E5 V2 con nota de seguimiento', 'Mantener momentum del proyecto. Demostrar capacidad de entrega. Documentar riesgo de aprobación pendiente.', 'zeus@innovadataco.com', 'jelkin@innovadataco.com', '2026-04-25', '2026-04-26', '2026-04-28', TRUE, TRUE, FALSE, FALSE, 'implementada', TRUE, 'https://github.com/Innovadataco/IDC_2026_01/blob/main/DECISIONES/DEC-003.md')
) AS d(codigo, nombre, descr, contexto, opciones, opcion, just, propuesto, aprobado, fecha_prop, fecha_dec, fecha_ejec, alcance, tiempo, costo, calidad, estado, estrategica, url)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 19. ADQUISICIONES
-- ============================================================

INSERT INTO pm2.adquisicion (id_proyecto, codigo, nombre, descripcion, tipo, proveedor_nombre, proveedor_contacto, monto, moneda, fecha_solicitud, fecha_aprobacion, fecha_contratacion, id_estado, responsable_id, observaciones)
SELECT
    p.id_proyecto, a.codigo, a.nombre, a.descr, a.tipo, a.proveedor, a.contacto, a.monto, 'COP', a.fecha_sol, a.fecha_aprob, a.fecha_cont,
    (SELECT id_estado FROM pm2.estado WHERE codigo = a.estado AND categoria = 'adquisicion'),
    (SELECT id_persona FROM pm2.persona WHERE email = a.resp), a.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    ('ADQ-001', 'Licencia GitHub Teams', 'Licencia GitHub para repositorios privados y colaboración equipo', 'licencia', 'GitHub Inc.', 'sales@github.com', 0.00, 'solicitado_adq', '2026-03-09', NULL, NULL, 'zeus@innovadataco.com', 'Gratuito para repositorios públicos. Se usa plan gratuito.'),
    ('ADQ-002', 'Acceso Google Workspace', 'Acceso a Google Workspace para documentación y comunicación', 'servicio', 'Google LLC', 'support@google.com', 0.00, 'entregado', '2026-03-09', '2026-03-09', '2026-03-09', 'jelkin@innovadataco.com', 'Usando credenciales existentes de Innovadataco.'),
    ('ADQ-003', 'Consultoría ITS Indra Colombia', 'Consultoría especializada en sistemas ITS para validación técnica', 'consultoria', 'Indra Colombia S.A.S.', 'José Luis Viaña Lambis', 0.00, 'solicitado_adq', '2026-04-15', NULL, NULL, 'jelkin@innovadataco.com', 'Contacto establecido. Evaluando propuesta de servicios.')
) AS a(codigo, nombre, descr, tipo, proveedor, contacto, monto, estado, fecha_sol, fecha_aprob, fecha_cont, resp, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 20. LECCIONES APRENDIDAS (Preliminares)
-- ============================================================

INSERT INTO pm2.leccion_aprendida (id_proyecto, codigo, categoria, situacion, accion_tomada, resultado, aprendizaje, recomendacion, aplicable_a, reportado_por, fecha_ocurrencia, fecha_registro, id_estado, es_positiva)
SELECT
    p.id_proyecto, l.codigo, l.cat, l.sit, l.accion, l.res, l.apren, l.recom, l.aplica,
    (SELECT id_persona FROM pm2.persona WHERE email = l.autor), l.fecha_oc, l.fecha_reg,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'aprobado' AND categoria = 'entregable'), l.positiva
FROM pm2.proyecto p,
LATERAL (VALUES
    ('LEA-001', 'proceso', 'Formatos inconsistentes en fichas CC generaban retrabajo.', 'Crear formato estándar ITS_CC-01 v2.0 y aplicar a todas las fichas.', 'Reducción del 40% en tiempo de revisión. QA automatizado funcional.', 'La estandarización de formatos es crítica cuando múltiples autores (humanos o IA) generan contenido técnico.', 'Definir formato estándar antes de iniciar producción masiva. Validar formato con muestra piloto.', 'Todos los proyectos con entregables técnicos múltiples y autores distribuidos.', 'zeus@innovadataco.com', '2026-04-05', '2026-04-28', TRUE),
    ('LEA-002', 'contractual', 'Aprobación de entregables E1-E3 tomó más de 50 días sin respuesta.', 'Enviar E4-E5 V2 con nota de seguimiento y documentar riesgo.', 'Momentum del proyecto mantenido. Riesgo documentado en registro formal.', 'No esperar aprobación de entregables tempranos para continuar ejecución. Documentar riesgo y mantener comunicación proactiva.', 'En futuros contratos, incluir cláusula de "silencio positivo": si no hay observaciones en 15 días hábiles, se considera aprobado.', 'Todos los proyectos con dependencia de aprobaciones del cliente.', 'zeus@innovadataco.com', '2026-04-26', '2026-05-15', FALSE),
    ('LEA-003', 'tecnico', 'Investigación de mercado ITS requirió evaluar 6+ fabricantes internacionales.', 'Documentar investigación de mercado con matriz comparativa y contactos.', 'Base de conocimiento reutilizable para futuros proyectos ITS en Colombia.', 'La investigación de mercado bien documentada se convierte en activo intelectual de la empresa.', 'Crear base de datos de proveedores ITS Colombia con contactos, precios y casos de referencia.', 'Proyectos ITS futuros en Colombia y LATAM.', 'zeus@innovadataco.com', '2026-04-20', '2026-04-28', TRUE)
) AS l(codigo, cat, sit, accion, res, apren, recom, aplica, autor, fecha_oc, fecha_reg, positiva)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 21. FIN DEL SCRIPT
-- ============================================================

-- Verificación: contar registros insertados
-- SELECT 'PERSONAS' AS tabla, COUNT(*) AS total FROM pm2.persona WHERE es_interno = TRUE;
-- SELECT 'PROYECTO' AS tabla, COUNT(*) AS total FROM pm2.proyecto WHERE codigo_pm2 = 'IDC-2026-01';
-- SELECT 'EQUIPO' AS tabla, COUNT(*) AS total FROM pm2.equipo_proyecto ep JOIN pm2.proyecto p ON ep.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'STAKEHOLDERS' AS tabla, COUNT(*) AS total FROM pm2.stakeholder s JOIN pm2.proyecto p ON s.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'TAREAS' AS tabla, COUNT(*) AS total FROM pm2.tarea t JOIN pm2.proyecto p ON t.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'ENTREGABLES' AS tabla, COUNT(*) AS total FROM pm2.entregable e JOIN pm2.proyecto p ON e.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'RIESGOS' AS tabla, COUNT(*) AS total FROM pm2.riesgo r JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'PAGOS' AS tabla, COUNT(*) AS total FROM pm2.pago pg JOIN pm2.proyecto p ON pg.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'REUNIONES' AS tabla, COUNT(*) AS total FROM pm2.reunion re JOIN pm2.proyecto p ON re.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'DOCUMENTOS' AS tabla, COUNT(*) AS total FROM pm2.documento d JOIN pm2.proyecto p ON d.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';
-- SELECT 'DECISIONES' AS tabla, COUNT(*) AS total FROM pm2.decision de JOIN pm2.proyecto p ON de.id_proyecto = p.id_proyecto WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- FIN
-- ============================================================
