-- ============================================================
-- INNOVADATACO — BASE DE DATOS PROYECTOS PM2 v2.0
-- COMPLETA: Toda la metodología PM2
-- Fecha: 15 de mayo de 2026
-- ============================================================

SET search_path TO pm2, public;

-- ============================================================
-- REQUISITOS (Funcionales y No Funcionales)
-- ============================================================

CREATE TABLE requisito (
    id_requisito    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "RF-001", "RNF-005"
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT NOT NULL,
    tipo            VARCHAR(20) CHECK (tipo IN ('funcional','no_funcional')),  -- RF / RNF
    
    -- Categoría RNF
    categoria_rnf   VARCHAR(50),  -- "rendimiento","seguridad","usabilidad","escalabilidad","disponibilidad","mantenibilidad","portabilidad","interoperabilidad"
    
    -- Prioridad y estado
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Trazabilidad
    id_entregable_vinculado UUID REFERENCES entregable(id_entregable),
    
    -- Validación
    criterio_aceptacion TEXT,
    metodo_prueba       TEXT,  -- "prueba_unit","prueba_integr","prueba_sist","inspeccion","demo"
    
    -- Origen
    origen          VARCHAR(100),  -- "TOR","cliente","regulatorio","stakeholder","tecnico"
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- ============================================================
-- TRAZABILIDAD: Requisito ↔ Entregable ↔ QA
-- ============================================================

CREATE TABLE trazabilidad (
    id_trazabilidad UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_requisito    UUID REFERENCES requisito(id_requisito) ON DELETE CASCADE,
    id_entregable   UUID REFERENCES entregable(id_entregable) ON DELETE CASCADE,
    id_tarea        UUID REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_qa           UUID REFERENCES control_calidad(id_qa) ON DELETE CASCADE,
    
    tipo_enlace     VARCHAR(50) CHECK (tipo_enlace IN ('satisface','verifica','prueba','deriva','relacionado')),
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_requisito, id_entregable, tipo_enlace)
);

-- ============================================================
-- DEPENDENCIAS DE TAREAS (CPM - Critical Path Method)
-- ============================================================

CREATE TABLE tarea_dependencia (
    id_dependencia  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_tarea_origen     UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_tarea_destino    UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    
    tipo_relacion   VARCHAR(5) DEFAULT 'FS' CHECK (tipo_relacion IN ('FS','SS','FF','SF')),  -- Finish-Start, Start-Start, Finish-Finish, Start-Finish
    lag_dias        INTEGER DEFAULT 0,  -- Retraso (+) o adelanto (-)
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_tarea_origen, id_tarea_destino, tipo_relacion)
);

-- ============================================================
-- ASIGNACIÓN DE RECURSOS A TAREAS
-- ============================================================

CREATE TABLE tarea_recurso (
    id_tarea_recurso UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto      UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_tarea         UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_persona       UUID REFERENCES persona(id_persona) ON DELETE CASCADE,
    
    -- Horas asignadas
    horas_planificadas  DECIMAL(8,2) DEFAULT 0,
    horas_reales        DECIMAL(8,2) DEFAULT 0,
    
    -- Fechas de asignación
    fecha_inicio_asignacion DATE,
    fecha_fin_asignacion    DATE,
    
    -- Rol en la tarea
    rol_en_tarea     VARCHAR(100),  -- "responsable","ejecutor","revisor","consultor"
    
    observaciones    TEXT,
    created_at       TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- HITOS / MILESTONES (Formalmente separados de tareas)
-- ============================================================

CREATE TABLE hito (
    id_hito         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "M-001"
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Fechas
    fecha_plan      DATE NOT NULL,
    fecha_real      DATE,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Tarea/entregable que genera el hito
    id_tarea_generadora    UUID REFERENCES tarea(id_tarea),
    id_entregable_generador UUID REFERENCES entregable(id_entregable),
    
    -- Indicador
    es_obligatorio  BOOLEAN DEFAULT TRUE,  -- ¿Es hito contractual?
    es_pago_vinculado BOOLEAN DEFAULT FALSE,  -- ¿Desbloquea pago?
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- ============================================================
-- PRESUPUESTO DETALLADO (Por rubro e ítem)
-- ============================================================

CREATE TABLE presupuesto_rubro (
    id_rubro        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(100) NOT NULL,  -- "Mano de obra","Servicios","Materiales","Viajes","Equipos","Software","Administración"
    descripcion     TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE presupuesto_item (
    id_item         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_rubro        UUID NOT NULL REFERENCES presupuesto_rubro(id_rubro) ON DELETE CASCADE,
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Costos
    cantidad        DECIMAL(12,2) DEFAULT 1,
    unidad          VARCHAR(20),  -- "hora","dia","mes","unidad","licencia","viaje","kg","m2"
    costo_unitario  DECIMAL(18,2) NOT NULL,
    costo_total_plan DECIMAL(18,2) GENERATED ALWAYS AS (cantidad * costo_unitario) STORED,
    
    -- Real
    cantidad_real   DECIMAL(12,2) DEFAULT 0,
    costo_unitario_real DECIMAL(18,2) DEFAULT 0,
    costo_total_real DECIMAL(18,2) GENERATED ALWAYS AS (cantidad_real * costo_unitario_real) STORED,
    
    -- Responsable
    responsable_id  UUID REFERENCES persona(id_persona),
    
    -- Fecha
    fecha_estimada  DATE,
    fecha_real      DATE,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- ============================================================
-- RECURSOS NO HUMANOS (Equipos, materiales, herramientas)
-- ============================================================

CREATE TABLE recurso_material (
    id_recurso      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    tipo            VARCHAR(30) CHECK (tipo IN ('equipo','herramienta','software','licencia','vehiculo','instalacion','material_consumible','otro')),
    
    descripcion     TEXT,
    proveedor       VARCHAR(100),
    
    -- Disponibilidad
    cantidad        INTEGER DEFAULT 1,
    disponible_desde DATE,
    disponible_hasta DATE,
    
    -- Costo
    costo_adquisicion DECIMAL(18,2),
    moneda          VARCHAR(3) DEFAULT 'COP',
    
    -- Ubicación
    ubicacion       VARCHAR(100),
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- Vincular recurso material a tarea
CREATE TABLE tarea_recurso_material (
    id_trm          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_tarea        UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_recurso      UUID NOT NULL REFERENCES recurso_material(id_recurso) ON DELETE CASCADE,
    cantidad_usada  DECIMAL(8,2) DEFAULT 1,
    fecha_uso       DATE,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- ISSUES / PROBLEMAS (Ya ocurrieron, distinto de riesgo)
-- ============================================================

CREATE TABLE issue (
    id_issue        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "ISS-001"
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Categoría
    categoria       VARCHAR(30) CHECK (categoria IN ('tecnico','proceso','recurso','comunicacion','calidad','contractual','externo','otro')),
    severidad       VARCHAR(20) CHECK (severidad IN ('critico','alto','medio','bajo')),
    
    -- Origen
    id_riesgo_origen UUID REFERENCES riesgo(id_riesgo),  -- Si viene de un riesgo materializado
    id_tarea_afectada UUID REFERENCES tarea(id_tarea),
    id_entregable_afectado UUID REFERENCES entregable(id_entregable),
    
    -- Resolución
    causa_raiz      TEXT,
    accion_correctiva TEXT,
    accion_preventiva TEXT,
    
    -- Responsable
    reportado_por   UUID REFERENCES persona(id_persona),
    asignado_a      UUID REFERENCES persona(id_persona),
    
    -- Fechas
    fecha_reporte   DATE DEFAULT CURRENT_DATE,
    fecha_resolucion DATE,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Impacto en triple restricción
    impacto_tiempo_dias INTEGER DEFAULT 0,
    impacto_costo   DECIMAL(18,2) DEFAULT 0,
    impacto_alcance TEXT,
    
    url_evidencia   TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- ============================================================
-- ACTA DE CIERRE
-- ============================================================

CREATE TABLE acta_cierre (
    id_cierre       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "CIERRE-2026-001"
    nombre          VARCHAR(200) NOT NULL,
    
    -- Fechas
    fecha_inicio_real DATE,
    fecha_fin_real    DATE,
    duracion_real_dias INTEGER,
    
    -- Resultados
    objetivos_cumplidos   TEXT,
    entregables_entregados TEXT,
    entregables_pendientes TEXT,
    
    -- Triple restricción final
    costo_final         DECIMAL(18,2),
    desviacion_costo    DECIMAL(18,2),
    desviacion_tiempo_dias INTEGER,
    desviacion_alcance  TEXT,
    
    -- Calidad
    satisfaccion_cliente  INTEGER CHECK (satisfaccion_cliente BETWEEN 1 AND 5),
    cumplimiento_requisitos_pct DECIMAL(5,2),
    
    -- Documentos finales
    url_documento_cierre  TEXT,
    url_repositorio_final TEXT,
    
    -- Autoridad
    elaborado_por     UUID REFERENCES persona(id_persona),
    aprobado_por      UUID REFERENCES persona(id_persona),
    
    -- Estado
    id_estado         INTEGER REFERENCES estado(id_estado),
    
    -- Fechas de aprobación
    fecha_elaboracion DATE DEFAULT CURRENT_DATE,
    fecha_aprobacion   DATE,
    
    observaciones     TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW(),
    updated_at        TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- ============================================================
-- CASO DE NEGOCIO / JUSTIFICACIÓN
-- ============================================================

CREATE TABLE caso_negocio (
    id_caso         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    -- Justificación
    problema_negocio    TEXT,
    oportunidad         TEXT,
    analisis_costo_beneficio TEXT,
    
    -- Métricas
    roi_esperado_pct    DECIMAL(5,2),
    roi_real_pct        DECIMAL(5,2),
    payback_meses       INTEGER,
    
    -- Beneficios
    beneficios_cualitativos TEXT,
    beneficios_cuantitativos TEXT,
    
    -- KPIs
    kpis_exito          TEXT,  -- JSON o texto con KPIs medibles
    
    -- Estado
    id_estado           INTEGER REFERENCES estado(id_estado),
    
    -- Responsable
    elaborado_por       UUID REFERENCES persona(id_persona),
    aprobado_por        UUID REFERENCES persona(id_persona),
    
    fecha_elaboracion   DATE,
    fecha_aprobacion    DATE,
    
    observaciones       TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW(),
    updated_at          TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- PLANTILLAS / ESTÁNDARES / CONFIGURACIÓN DE PROCESO
-- ============================================================

CREATE TABLE estandar_proceso (
    id_estandar     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo          VARCHAR(20) NOT NULL UNIQUE,  -- "STD-PM2-001"
    nombre          VARCHAR(200) NOT NULL,
    tipo            VARCHAR(30) CHECK (tipo IN ('plantilla_documento','plantilla_entregable','procedimiento','checklist','formato','politica','norma')),
    
    descripcion     TEXT,
    version         VARCHAR(10) DEFAULT '1.0',
    
    -- Contenido o referencia
    url_plantilla   TEXT,
    contenido       TEXT,  -- Markdown o estructura
    
    -- Aplicabilidad
    aplicable_a     VARCHAR(100),  -- "todos","proyectos_its","proyectos_consultoria","proyectos_tecnologia"
    
    -- Aprobación
    aprobado_por    UUID REFERENCES persona(id_persona),
    fecha_aprobacion DATE,
    
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Vincular estándar a proyecto
CREATE TABLE proyecto_estandar (
    id_pe           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_estandar     UUID NOT NULL REFERENCES estandar_proceso(id_estandar) ON DELETE CASCADE,
    
    es_obligatorio  BOOLEAN DEFAULT TRUE,
    cumplido        BOOLEAN DEFAULT FALSE,
    fecha_cumplimiento DATE,
    observaciones   TEXT,
    
    UNIQUE(id_proyecto, id_estandar)
);

-- ============================================================
-- AUDITORÍA / LOG DE CAMBIOS EN EL SISTEMA
-- ============================================================

CREATE TABLE auditoria (
    id_auditoria    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    tabla_afectada  VARCHAR(50) NOT NULL,
    id_registro     UUID NOT NULL,
    id_proyecto     UUID REFERENCES proyecto(id_proyecto),
    
    tipo_accion     VARCHAR(20) CHECK (tipo_accion IN ('INSERT','UPDATE','DELETE')),
    campo_afectado  VARCHAR(50),
    valor_anterior  TEXT,
    valor_nuevo     TEXT,
    
    ejecutado_por   UUID REFERENCES persona(id_persona),
    fecha_ejecucion TIMESTAMPTZ DEFAULT NOW(),
    
    ip_origen       VARCHAR(45),
    observaciones   TEXT
);

-- ============================================================
-- CATÁLOGOS ADICIONALES
-- ============================================================

-- Tipos de reunión ampliados
INSERT INTO pm2.tipo_reunion (codigo, nombre, descripcion, activo) VALUES
('comite_direccion', 'COMITÉ DE DIRECCIÓN', 'Reunión del comité de dirección del proyecto', TRUE),
('revision_salud', 'REVISIÓN DE SALUD DEL PROYECTO', 'Revisión integral de estado (scope, schedule, cost)', TRUE),
('taller', 'TALLER / WORKSHOP', 'Sesión de trabajo colaborativo', TRUE),
('capacitacion', 'CAPACITACIÓN', 'Sesión de formación o transferencia', TRUE),
('post_mortem', 'POST-MORTEM', 'Análisis tras cierre o incidente', TRUE);

-- Estados adicionales para nuevas tablas
INSERT INTO pm2.estado (codigo, nombre, categoria, color_hex, descripcion, orden) VALUES
-- Estados para requisitos
('borrador_req', 'BORRADOR', 'requisito', '#9E9E9E', 'Requisito en borrador', 1),
('analisis_req', 'EN ANÁLISIS', 'requisito', '#FFC107', 'En análisis de viabilidad', 2),
('aprobado_req', 'APROBADO', 'requisito', '#4CAF50', 'Requisito aprobado', 3),
('implementado_req', 'IMPLEMENTADO', 'requisito', '#2196F3', 'Implementado en entregable', 4),
('rechazado_req', 'RECHAZADO', 'requisito', '#F44336', 'Requisito rechazado', 5),

-- Estados para hitos
('programado', 'PROGRAMADO', 'hito', '#9E9E9E', 'Hito programado', 1),
('alcanzado', 'ALCANZADO', 'hito', '#4CAF50', 'Hito alcanzado', 2),
('no_alcanzado', 'NO ALCANZADO', 'hito', '#F44336', 'Hito no alcanzado', 3),

-- Estados para issues
('abierto', 'ABIERTO', 'issue', '#F44336', 'Issue abierto', 1),
('en_analisis', 'EN ANÁLISIS', 'issue', '#FFC107', 'Analizando causa raíz', 2),
('accion_plan', 'ACCIÓN PLANEADA', 'issue', '#FF9800', 'Acción correctiva planeada', 3),
('resuelto', 'RESUELTO', 'issue', '#4CAF50', 'Issue resuelto', 4),
('cerrado', 'CERRADO', 'issue', '#9E9E9E', 'Cerrado y documentado', 5),

-- Estados para presupuesto
('planificado', 'PLANIFICADO', 'presupuesto', '#9E9E9E', 'Item planificado', 1),
('autorizado', 'AUTORIZADO', 'presupuesto', '#4CAF50', 'Autorizado para ejecución', 2),
('en_ejecucion', 'EN EJECUCIÓN', 'presupuesto', '#2196F3', 'En ejecución', 3),
('ejecutado', 'EJECUTADO', 'presupuesto', '#8BC34A', 'Ejecutado y pagado', 4),
('cancelado_pres', 'CANCELADO', 'presupuesto', '#F44336', 'Cancelado', 5),

-- Estados para acta de cierre
('en_elaboracion', 'EN ELABORACIÓN', 'cierre', '#FFC107', 'Acta en elaboración', 1),
('revision_cierre', 'EN REVISIÓN', 'cierre', '#FF9800', 'En revisión por stakeholders', 2),
('aprobado_cierre', 'APROBADO', 'cierre', '#4CAF50', 'Acta aprobada', 3),
('archivado', 'ARCHIVADO', 'cierre', '#9E9E9E', 'Proyecto archivado', 4);

-- ============================================================
-- ÍNDICES PARA NUEVAS TABLAS
-- ============================================================

CREATE INDEX idx_requisito_proyecto ON pm2.requisito(id_proyecto);
CREATE INDEX idx_requisito_tipo ON pm2.requisito(tipo);
CREATE INDEX idx_requisito_estado ON pm2.requisito(id_estado);

CREATE INDEX idx_trazabilidad_proyecto ON pm2.trazabilidad(id_proyecto);
CREATE INDEX idx_trazabilidad_req ON pm2.trazabilidad(id_requisito);
CREATE INDEX idx_trazabilidad_ent ON pm2.trazabilidad(id_entregable);

CREATE INDEX idx_tarea_dep_origen ON pm2.tarea_dependencia(id_tarea_origen);
CREATE INDEX idx_tarea_dep_destino ON pm2.tarea_dependencia(id_tarea_destino);

CREATE INDEX idx_tarea_recurso_tarea ON pm2.tarea_recurso(id_tarea);
CREATE INDEX idx_tarea_recurso_persona ON pm2.tarea_recurso(id_persona);

CREATE INDEX idx_hito_proyecto ON pm2.hito(id_proyecto);
CREATE INDEX idx_hito_fecha ON pm2.hito(fecha_plan);

CREATE INDEX idx_presupuesto_rubro ON pm2.presupuesto_rubro(id_proyecto);
CREATE INDEX idx_presupuesto_item_rubro ON pm2.presupuesto_item(id_rubro);

CREATE INDEX idx_recurso_mat_proyecto ON pm2.recurso_material(id_proyecto);
CREATE INDEX idx_recurso_mat_tipo ON pm2.recurso_material(tipo);

CREATE INDEX idx_issue_proyecto ON pm2.issue(id_proyecto);
CREATE INDEX idx_issue_severidad ON pm2.issue(severidad);
CREATE INDEX idx_issue_estado ON pm2.issue(id_estado);

CREATE INDEX idx_cierre_proyecto ON pm2.acta_cierre(id_proyecto);

CREATE INDEX idx_auditoria_tabla ON pm2.auditoria(tabla_afectada);
CREATE INDEX idx_auditoria_proyecto ON pm2.auditoria(id_proyecto);
CREATE INDEX idx_auditoria_fecha ON pm2.auditoria(fecha_ejecucion);

-- ============================================================
-- VISTAS ADICIONALES
-- ============================================================

-- Dashboard de requisitos
CREATE VIEW v_requisitos_dashboard AS
SELECT
    r.id_proyecto,
    p.nombre AS proyecto,
    r.tipo,
    COUNT(*) AS total,
    SUM(CASE WHEN r.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'aprobado_req') THEN 1 ELSE 0 END) AS aprobados,
    SUM(CASE WHEN r.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'implementado_req') THEN 1 ELSE 0 END) AS implementados,
    SUM(CASE WHEN r.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'rechazado_req') THEN 1 ELSE 0 END) AS rechazados,
    ROUND(100.0 * SUM(CASE WHEN r.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'implementado_req') THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS tasa_implementacion
FROM pm2.requisito r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
GROUP BY r.id_proyecto, p.nombre, r.tipo;

-- Dashboard de hitos
CREATE VIEW v_hitos_dashboard AS
SELECT
    h.id_proyecto,
    p.nombre AS proyecto,
    COUNT(*) AS total_hitos,
    SUM(CASE WHEN h.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'alcanzado') THEN 1 ELSE 0 END) AS alcanzados,
    SUM(CASE WHEN h.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'programado') THEN 1 ELSE 0 END) AS programados,
    SUM(CASE WHEN h.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'no_alcanzado') THEN 1 ELSE 0 END) AS no_alcanzados,
    SUM(CASE WHEN h.fecha_plan < CURRENT_DATE AND h.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'alcanzado') THEN 1 ELSE 0 END) AS vencidos
FROM pm2.hito h
JOIN pm2.proyecto p ON h.id_proyecto = p.id_proyecto
GROUP BY h.id_proyecto, p.nombre;

-- Dashboard de issues
CREATE VIEW v_issues_dashboard AS
SELECT
    i.id_proyecto,
    p.nombre AS proyecto,
    COUNT(*) AS total_issues,
    SUM(CASE WHEN i.severidad = 'critico' THEN 1 ELSE 0 END) AS criticos,
    SUM(CASE WHEN i.severidad = 'alto' THEN 1 ELSE 0 END) AS altos,
    SUM(CASE WHEN i.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('abierto','en_analisis')) THEN 1 ELSE 0 END) AS abiertos,
    SUM(CASE WHEN i.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'resuelto') THEN 1 ELSE 0 END) AS resueltos
FROM pm2.issue i
JOIN pm2.proyecto p ON i.id_proyecto = p.id_proyecto
GROUP BY i.id_proyecto, p.nombre;

-- Dashboard de presupuesto
CREATE VIEW v_presupuesto_dashboard AS
SELECT
    pr.id_proyecto,
    p.nombre AS proyecto,
    r.nombre AS rubro,
    SUM(i.costo_total_plan) AS plan_total,
    SUM(i.costo_total_real) AS real_total,
    SUM(i.costo_total_plan) - SUM(i.costo_total_real) AS desviacion,
    CASE WHEN SUM(i.costo_total_plan) > 0 
         THEN ROUND(100.0 * SUM(i.costo_total_real) / SUM(i.costo_total_plan), 2) 
         ELSE 0 END AS pct_ejecutado
FROM pm2.presupuesto_rubro r
JOIN pm2.presupuesto_item i ON r.id_rubro = i.id_rubro
JOIN pm2.proyecto pr ON r.id_proyecto = pr.id_proyecto
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
GROUP BY pr.id_proyecto, p.nombre, r.nombre;

-- Dashboard de cierre
CREATE VIEW v_cierre_dashboard AS
SELECT
    c.id_proyecto,
    p.nombre AS proyecto,
    c.codigo,
    c.fecha_fin_real,
    c.costo_final,
    c.desviacion_costo,
    c.desviacion_tiempo_dias,
    c.satisfaccion_cliente,
    c.cumplimiento_requisitos_pct,
    e.nombre AS estado
FROM pm2.acta_cierre c
JOIN pm2.proyecto p ON c.id_proyecto = p.id_proyecto
LEFT JOIN pm2.estado e ON c.id_estado = e.id_estado;

-- Trazabilidad completa
CREATE VIEW v_trazabilidad_completa AS
SELECT
    t.id_trazabilidad,
    p.nombre AS proyecto,
    r.codigo AS requisito,
    r.nombre AS req_nombre,
    e.codigo AS entregable,
    e.nombre AS ent_nombre,
    ta.nombre AS tarea,
    q.resultado AS qa_resultado,
    t.tipo_enlace
FROM pm2.trazabilidad t
JOIN pm2.proyecto p ON t.id_proyecto = p.id_proyecto
LEFT JOIN pm2.requisito r ON t.id_requisito = r.id_requisito
LEFT JOIN pm2.entregable e ON t.id_entregable = e.id_entregable
LEFT JOIN pm2.tarea ta ON t.id_tarea = ta.id_tarea
LEFT JOIN pm2.control_calidad q ON t.id_qa = q.id_qa;

-- ============================================================
-- COMENTARIOS
-- ============================================================

COMMENT ON TABLE pm2.requisito IS 'Requisitos funcionales (RF) y no funcionales (RNF) del proyecto';
COMMENT ON TABLE pm2.trazabilidad IS 'Matriz de trazabilidad: requisito ↔ entregable ↔ tarea ↔ QA';
COMMENT ON TABLE pm2.tarea_dependencia IS 'Dependencias CPM entre tareas (FS, SS, FF, SF)';
COMMENT ON TABLE pm2.tarea_recurso IS 'Asignación de personas a tareas con horas planificadas y reales';
COMMENT ON TABLE pm2.hito IS 'Hitos formales del proyecto, separados de tareas';
COMMENT ON TABLE pm2.presupuesto_rubro IS 'Rubros del presupuesto (mano de obra, servicios, materiales, etc.)';
COMMENT ON TABLE pm2.presupuesto_item IS 'Ítems desglosados del presupuesto con costo plan vs real';
COMMENT ON TABLE pm2.recurso_material IS 'Recursos no humanos: equipos, software, herramientas, vehículos';
COMMENT ON TABLE pm2.issue IS 'Problemas ya ocurridos (distinto de riesgo)';
COMMENT ON TABLE pm2.acta_cierre IS 'Acta formal de cierre del proyecto';
COMMENT ON TABLE pm2.caso_negocio IS 'Justificación del proyecto: ROI, beneficios, KPIs';
COMMENT ON TABLE pm2.estandar_proceso IS 'Plantillas, procedimientos y estándares de la empresa';
COMMENT ON TABLE pm2.auditoria IS 'Log de cambios en el sistema para trazabilidad';

-- ============================================================
-- FIN v2.0 — Base de datos PM2 COMPLETA
-- ============================================================