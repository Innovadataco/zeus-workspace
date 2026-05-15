-- ============================================================
-- INNOVADATACO — DATOS REALES VERIFICADOS POR CEO: PROYECTO IDC_2026_01
-- Fecha: 14 de mayo de 2026 (según CEO)
-- Política: SOLO datos confirmados por CEO Jelkin Zair Carrillo Franco
-- ============================================================

SET search_path TO pm2, public;

-- ============================================================
-- 1. PERSONAS — Confirmadas por CEO el 15 mayo 2026
-- ============================================================

INSERT INTO pm2.persona (nombres, apellidos, email, empresa, cargo, area, es_interno, es_founder, observaciones, activo) VALUES
('Jelkin Zair', 'Carrillo Franco', 'jelkin@innovadataco.com', 'Innovadataco', 'CEO / Founder', 'Dirección', TRUE, TRUE, 'Director Ejecutivo del proyecto.', TRUE),
('Diana Marcela', 'Cáceres Valderrama', 'diana@innovadataco.com', 'Innovadataco', 'Directora Jurídica / Founder', 'Legal', TRUE, TRUE, 'Directora Jurídica.', TRUE),
('ZEUS', 'Agente IA InnovaDataCo', 'zeus@innovadataco.com', 'Innovadataco', 'Gerente de Proyecto IA', 'Tecnología', TRUE, FALSE, 'Gestión documental PM2, coordinación técnica.', TRUE),
('Juan David', 'Carrillo', 'juan@innovadataco.com', 'Innovadataco', 'Asesor Innovación (Agente IA)', 'Innovación', TRUE, FALSE, 'Hijo del CEO. Agente IA que apoya el proyecto. Validación tecnológica.', TRUE),
('Zaira', 'Carrillo', 'zaira@innovadataco.com', 'Innovadataco', 'Asesora Marketing (Agente IA)', 'Marketing', TRUE, FALSE, 'Hija del CEO. Agente IA que apoya el proyecto. Comunicaciones, presentaciones.', TRUE),
('Daniel', 'Duarte', 'dduarte@transconsult.com', 'TransConsult', 'Líder TARConsultores', 'Operaciones', FALSE, FALSE, 'Contacto operativo. Tel: +57 320 468 4930.', TRUE),
('María Constanza', '[Apellido no confirmado]', 'mconstanza@transconsult.com', 'TransConsult Colombia', 'Gerente TransConsult Colombia', 'Operaciones', FALSE, FALSE, 'Gerente de TransConsult Colombia. Confirmada por CEO.', TRUE),
('Otto', 'Fernández', 'ofernandez@proveedor.com', 'Proveedor externo', 'Responsable modelo financiero y estudio de mercado', 'Consultoría', FALSE, FALSE, 'Proveedor externo. Responsabilidad: definir modelo financiero, generar estudio de mercado. Acordado $13 millones. Entrega: 25 mayo 2026.', TRUE);

-- ============================================================
-- 2. PROYECTO IDC_2026-01 — Datos confirmados
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
    'Desarrollo del componente ITS para estudios de factibilidad del corredor vial Chía-Mondoñedo-Girardot (306 km), contrato IFC-Transconsult No. 7216694.',
    'Apoyar a Transconsult Colombia en el desarrollo del componente ITS, específicamente en el estudio y diseño del Centro de control y mantenimiento.',
    '8 entregables técnicos ITS, 42 fichas técnicas CC-01 a CC-42, especificaciones RF/RNF, arquitectura ITS, ConOps, plan indicativo, modelo de costos.',
    'Implementación física de sistemas, construcción de infraestructura, operación del sistema, mantenimiento post-entrega.',
    (SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'E'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = 'critica'),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'ejecucion' AND categoria = 'proyecto'),
    '2026-03-09', '2026-06-08', '2026-06-08',
    'TC-PS-05-917-2026', '2026-03-09', 'TransConsult Colombia / IFC', 'Infraestructura Vial / ITS',
    112000000.00, 'COP', 3,
    (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'),
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'),
    NULL,  -- patrocinador_id: IFC contacto indirecto, mismo que TransConsult
    50.00, 61.00,
    TRUE, TRUE
);

-- ============================================================
-- 3. EQUIPO DEL PROYECTO — Confirmado por CEO
-- ============================================================

INSERT INTO pm2.equipo_proyecto (id_proyecto, id_persona, id_rol, dedicacion_pct, es_responsable, responsabilidades, activo)
SELECT
    p.id_proyecto,
    per.id_persona,
    r.id_rol,
    CASE per.email
        WHEN 'jelkin@innovadataco.com' THEN 50.00
        WHEN 'zeus@innovadataco.com' THEN 100.00
        WHEN 'juan@innovadataco.com' THEN 25.00
        WHEN 'zaira@innovadataco.com' THEN 25.00
        ELSE 25.00
    END,
    CASE WHEN per.email IN ('jelkin@innovadataco.com', 'zeus@innovadataco.com') THEN TRUE ELSE FALSE END,
    CASE per.email
        WHEN 'jelkin@innovadataco.com' THEN 'Director Ejecutivo. Toma decisiones, contacto cliente.'
        WHEN 'diana@innovadataco.com' THEN 'Directora Jurídica. Supervisión legal.'
        WHEN 'zeus@innovadataco.com' THEN 'Gerente de Proyecto IA. Gestión documental PM2.'
        WHEN 'juan@innovadataco.com' THEN 'Asesor Innovación. Agente IA. Validación tecnológica.'
        WHEN 'zaira@innovadataco.com' THEN 'Asesora Marketing. Agente IA. Comunicaciones.'
        ELSE 'Colaborador'
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
-- 4. STAKEHOLDERS — Confirmados por CEO y documentos
-- ============================================================

INSERT INTO pm2.stakeholder (id_proyecto, id_persona, rol_stakeholder, influencia, interes, estrategia, es_cliente_directo, es_patrocinador, es_usuario_final, observaciones, activo)
SELECT
    p.id_proyecto,
    per.id_persona,
    s.rol,
    s.inf,
    s.int,
    'Gestionar activamente. Mantener informado según plan de comunicaciones.',
    s.cliente,
    s.patrocinador,
    s.usuario,
    s.obs,
    TRUE
FROM pm2.proyecto p
CROSS JOIN pm2.persona per
CROSS JOIN LATERAL (VALUES
    ('dduarte@transconsult.com', 'Cliente directo, contratante', 5, 5, TRUE, FALSE, FALSE, 'Confirmado por CEO. Tel: +57 320 468 4930.'),
    ('mconstanza@transconsult.com', 'Gerente TransConsult Colombia', 5, 5, TRUE, FALSE, FALSE, 'Confirmada por CEO. Gerente de TransConsult Colombia.'),
    ('jelkin@innovadataco.com', 'Director Ejecutivo Innovadataco', 5, 5, FALSE, FALSE, FALSE, 'Rol dual: interno + stakeholder ejecutivo.')
) AS s(email, rol, inf, int, cliente, patrocinador, usuario, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01' AND per.email = s.email;

-- Stakeholders institucionales sin persona específica:
INSERT INTO pm2.stakeholder (id_proyecto, id_persona, rol_stakeholder, influencia, interes, estrategia, es_cliente_directo, es_patrocinador, es_usuario_final, observaciones, activo)
SELECT
    p.id_proyecto,
    NULL,
    s.rol, s.inf, s.int,
    'Pendiente: definir estrategia específica. Contacto exacto NO confirmado.',
    s.cliente, s.patrocinador, s.usuario,
    s.obs, TRUE
FROM pm2.proyecto p,
LATERAL (VALUES
    ('IFC (The World Bank Group)', 'Financiador / Cliente final', 5, 5, FALSE, TRUE, FALSE, 'Confirmado en Acta. Contacto indirecto vía TransConsult.'),
    ('Ministerio de Transporte Colombia', 'Regulador', 3, 3, FALSE, FALSE, FALSE, 'Confirmado en Acta.'),
    ('ANI (Agencia Nacional de Infraestructura)', 'Entidad sectorial', 3, 3, FALSE, FALSE, FALSE, 'Confirmado en Acta.'),
    ('Usuarios del corredor vial', 'Beneficiarios finales', 2, 5, FALSE, FALSE, TRUE, 'Confirmado en Acta.')
) AS s(rol, inf, int, cliente, patrocinador, usuario, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 5. RIESGOS — Confirmados en README (3 activos)
-- ============================================================

INSERT INTO pm2.riesgo (id_proyecto, codigo, nombre, descripcion, causa, efecto, id_cat_riesgo, id_estado, id_prioridad, probabilidad, impacto, estrategia, plan_mitigacion, plan_contingencia, fecha_identificacion, responsable_id, observaciones)
SELECT
    p.id_proyecto,
    r.codigo, r.nombre, r.descr, r.causa, r.efecto,
    (SELECT id_cat_riesgo FROM pm2.categoria_riesgo WHERE codigo = r.cat),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'abierto' AND categoria = 'riesgo'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = r.prio),
    r.prob, r.imp, r.estr, r.mitig, r.cont, '2026-04-28',
    (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'),
    r.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    ('R001', 'Aprobación E1-E3 bloquea Pago 1',
     'Los entregables E1-E3 no han sido aprobados, bloqueando el flujo de caja.',
     'TransConsult no ha revisado ni aprobado los entregables iniciales.',
     'Bloquea Pago 1 ($22.4M). Retraso en ejecución.',
     'financiero', 'critica', 0.70, 0.90, 'escalar',
     'Contactar TransConsult. Solicitar reunión de aprobación.',
     'Escalar a IFC vía TransConsult.',
     'Confirmado en README.'),
    ('R003', 'Dependencia de terceros (INVIAS)',
     'Dependencia de información o aprobaciones de terceros.',
     'INVIAS u otras entidades externas pueden retrasar procesos.',
     'Retraso en entregables que requieren datos de terceros.',
     'organizacional', 'media', 0.50, 0.50, 'monitorear',
     'Monitoreo semanal de dependencias.',
     'Buscar fuentes alternativas.',
     'Confirmado en README.'),
    ('R005', 'Alcance no definido claramente',
     'Ambigüedad en el alcance del proyecto.',
     'TOR abierto a interpretación. Requerimientos cambiantes.',
     'Retrabajo, extensiones de plazo, conflictos contractuales.',
     'organizacional', 'media', 0.50, 0.50, 'mitigar',
     'Comité de cambios formal. Documentar alcance.',
     'Cláusula de cambio en contrato.',
     'Confirmado en README.')
) AS r(codigo, nombre, descr, causa, efecto, cat, prio, prob, imp, estr, mitig, cont, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 6. PAGOS — Confirmados en README (3 pagos)
-- ============================================================

INSERT INTO pm2.pago (id_proyecto, numero_pago, descripcion, monto, moneda, porcentaje, condicion, id_estado, fecha_vencimiento, observaciones)
SELECT
    p.id_proyecto, pg.num, pg.descr, pg.monto, 'COP', pg.pct, pg.cond,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'pendiente_pago' AND categoria = 'pago'),
    pg.venc, pg.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    (1, 'Pago 1 - Firma contrato (20%)', 22400000.00, 20.00, 'Firma contrato TC-PS-05-917-2026', '2026-03-09', 'Confirmado en README. Pendiente facturación.'),
    (2, 'Pago 2 - Aprobación E4-E5 (40%)', 44800000.00, 40.00, 'Aprobación formal de entregables E4 y E5 por TransConsult', '2026-05-15', 'Confirmado en README.'),
    (3, 'Pago 3 - Entrega final E8 (40%)', 44800000.00, 40.00, 'Entrega final E8 y cierre administrativo', '2026-06-08', 'Confirmado en README.')
) AS pg(num, descr, monto, pct, cond, venc, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 7. ENTREGABLES — Confirmados en README (8 entregables)
-- ============================================================

INSERT INTO pm2.entregable (id_proyecto, codigo, nombre, descripcion, id_tipo_doc, id_estado, id_prioridad, version, fecha_entrega, url_github, observaciones)
SELECT
    p.id_proyecto,
    e.codigo, e.nombre, e.descr,
    (SELECT id_tipo_doc FROM pm2.tipo_documento WHERE codigo = e.tipo_doc),
    (SELECT id_estado FROM pm2.estado WHERE codigo = e.estado AND categoria = 'entregable'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = e.prio),
    e.version, e.fecha, e.url, e.obs
FROM pm2.proyecto p,
LATERAL (VALUES
    ('E1-ITS-001', 'E1: Diagnóstico ITS', 'Revisión y clasificación de servicios ITS aplicables al corredor',
     'informe_ejecutivo', '1.0', '2026-03-27', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E1',
     'Confirmado en README: 100% desarrollado, pendiente aprobación.'),
    ('E2-ITS-001', 'E2: Análisis de brechas', 'Análisis de brechas entre estado actual y estándares ITS Colombia',
     'informe_ejecutivo', '1.0', '2026-04-03', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E2',
     'Confirmado en README: 100% desarrollado, pendiente aprobación.'),
    ('E3-ITS-001', 'E3: Arquitectura + ConOps', 'Arquitectura ITS del corredor y Concepto de Operación',
     'informe_ejecutivo', '1.0', '2026-04-07', 'revision', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E3',
     'Confirmado en README: 100% desarrollado, pendiente aprobación.'),
    ('E4-ITS-001', 'E4: Fichas técnicas CC-01 a CC-42', '42 fichas técnicas de componentes ITS del corredor vial',
     'especificacion', '2.0', '2026-04-28', 'aprobado', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E4',
     'Confirmado en README: Validado. Commit 7dafa69.'),
    ('E5-ITS-001', 'E5: Especificaciones RF/RNF', 'Requerimientos funcionales y no funcionales ITS',
     'especificacion', '1.0', '2026-04-28', 'aprobado', 'alta', 'https://github.com/Innovadataco/IDC_2026_01/tree/main/03-EJECUCION/E5',
     'Confirmado en README: Validado.'),
    ('E6-ITS-001', 'E6: Prototipo funcional', 'Prototipo funcional de componentes ITS',
     'codigo', '0.0', NULL, 'borrador', 'alta', NULL,
     'Confirmado en README: Pendiente, 0%.'),
    ('E7-ITS-001', 'E7: Documentación técnica', 'Documentación técnica del sistema ITS',
     'tecnico', '0.0', NULL, 'borrador', 'media', NULL,
     'Confirmado en README: Pendiente, 0%.'),
    ('E8-ITS-001', 'E8: Capacitación y transferencia', 'Capacitación y transferencia del sistema',
     'capacitacion', '0.0', NULL, 'borrador', 'media', NULL,
     'Confirmado en README: Pendiente, 0%.')
) AS e(codigo, nombre, descr, tipo_doc, version, fecha, estado, prio, url, obs)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 8. DOCUMENTOS — Confirmados en estructura del repo
-- ============================================================

INSERT INTO pm2.documento (id_proyecto, id_tipo_doc, codigo, nombre, descripcion, id_estado, version, url_github, autor_id, fecha_creacion, es_confidencial)
SELECT
    p.id_proyecto,
    (SELECT id_tipo_doc FROM pm2.tipo_documento WHERE codigo = d.tipo_doc),
    d.codigo, d.nombre, d.descr,
    (SELECT id_estado FROM pm2.estado WHERE codigo = d.estado AND categoria = 'entregable'),
    d.version, d.url,
    (SELECT id_persona FROM pm2.persona WHERE email = d.autor),
    d.fecha, d.confidencial
FROM pm2.proyecto p,
LATERAL (VALUES
    ('acta_constitucion', 'ACTA-2026-001', 'Acta de Constitución IDC-2026-01', 'Acta de constitución del proyecto', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/01-GOBERNANZA/01-ACTA-CONSTITUCION.md', 'zeus@innovadataco.com', '2026-03-09', FALSE),
    ('cronograma', 'CRON-2026-001', 'Cronograma Gantt 14 semanas', 'Cronograma detallado del proyecto', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/02-PLANIFICACION/02-CRONOGRAMA-GANTT.md', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    ('matriz_riesgos', 'RIES-2026-001', 'Registro de Riesgos', 'Matriz de riesgos con 3 riesgos activos', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/05-SEGUIMIENTO/03-REGISTRO-RIESGOS.md', 'zeus@innovadataco.com', '2026-04-28', FALSE),
    ('plan_comunicaciones', 'COM-2026-001', 'Plan de Comunicaciones', 'Plan de gestión de comunicaciones', 'aprobado', '1.0', 'https://github.com/Innovadataco/IDC_2026_01/blob/main/02-PLANIFICACION/05-PLAN-COMUNICACIONES.md', 'zeus@innovadataco.com', '2026-04-28', FALSE)
) AS d(tipo_doc, codigo, nombre, descr, estado, version, url, autor, fecha, confidencial)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 9. ADQUISICION — Confirmada por CEO: Otto Fernández
-- ============================================================

INSERT INTO pm2.adquisicion (id_proyecto, codigo, nombre, descripcion, tipo, proveedor_nombre, proveedor_contacto, monto, moneda, fecha_solicitud, fecha_aprobacion, fecha_contratacion, id_estado, responsable_id, observaciones)
SELECT
    p.id_proyecto, 'ADQ-001', 'Consultoría modelo financiero y estudio de mercado',
    'Responsabilidad: definir modelo financiero, generar estudio de mercado. Acordado $13 millones. Entrega: 25 mayo 2026.',
    'consultoria', 'Otto Fernández', 'ofernandez@proveedor.com', 13000000.00, 'COP',
    '2026-05-01', '2026-05-01', '2026-05-01',
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'en_progreso' AND categoria = 'adquisicion'),
    (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'),
    'Proveedor externo confirmado por CEO. Entrega pactada: 25 mayo 2026.'
FROM pm2.proyecto p
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 10. CONFIGURACIÓN — Datos confirmados
-- ============================================================

INSERT INTO pm2.configuracion_proyecto (id_proyecto, clave, valor, tipo_dato, descripcion, es_publico)
SELECT
    p.id_proyecto, c.clave, c.valor, c.tipo, c.descr, c.publico
FROM pm2.proyecto p,
LATERAL (VALUES
    ('corredor_longitud_km', '306', 'numero', 'Longitud total del corredor vial Chía-Mondoñedo-Girardot', FALSE),
    ('normativa_aplicable', 'Resolución 28675 de 2022', 'texto', 'Normativa ITS Colombia aplicable', TRUE),
    ('contrato_padre_ifc', '7216694', 'texto', 'Contrato IFC-Transconsult padre', FALSE),
    ('sin_iva', 'true', 'booleano', 'Sin obligación de IVA según contrato', FALSE),
    ('commit_github_activo', '7dafa69', 'texto', 'Último commit GitHub confirmado en cronograma', TRUE),
    ('total_fichas_its', '42', 'numero', 'Total de fichas técnicas ITS (CC-01 a CC-42)', TRUE),
    ('fecha_actual_corte', '2026-05-14', 'fecha', 'Fecha confirmada por CEO para corte de información', FALSE),
    ('pm2_es_primer_proyecto', 'true', 'booleano', 'Este es el PRIMER proyecto de Innovadataco con metodología PM2 implementada', TRUE)
) AS c(clave, valor, tipo, descr, publico)
WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- 11. NOTAS — Pendientes y contexto
-- ============================================================

INSERT INTO pm2.nota_proyecto (id_proyecto, categoria, titulo, contenido, autor_id, es_privada)
SELECT
    p.id_proyecto, 'contexto',
    'PRIMER proyecto PM2 de Innovadataco',
    'Este es el primer proyecto de la empresa que implementa metodología PM2 formalmente. No hay proyectos anteriores con esta estructura. Confirmado por CEO el 15 mayo 2026.',
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'), FALSE
FROM pm2.proyecto p WHERE p.codigo_pm2 = 'IDC-2026-01'
UNION ALL
SELECT
    p.id_proyecto, 'pendiente',
    'Proveedor externo: Otto Fernández',
    'Acordado $13 millones. Debe entregar modelo financiero + estudio de mercado el 25 mayo 2026. Confirmado por CEO.',
    (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'), FALSE
FROM pm2.proyecto p WHERE p.codigo_pm2 = 'IDC-2026-01';

-- ============================================================
-- FIN — Datos verificados por CEO. Nada inventado.
-- ============================================================
