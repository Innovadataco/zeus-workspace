-- ============================================================
-- INNOVADATACO — BASE DE DATOS PROYECTOS PM2
-- Versión: 1.0
-- Motor: PostgreSQL 15+
-- Fecha: 15 de mayo de 2026
-- Autor: ZEUS — Arquitectura de Datos
-- ============================================================

-- --------------------------------------------------------------
-- 1. EXTENSIONES
-- --------------------------------------------------------------
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- --------------------------------------------------------------
-- 2. SCHEMA
-- --------------------------------------------------------------
DROP SCHEMA IF EXISTS pm2 CASCADE;
CREATE SCHEMA pm2;
SET search_path TO pm2, public;

-- ============================================================
-- 3. TABLAS MAESTRAS / CATALÓGOS
-- ============================================================

-- Estado de proyectos, tareas, entregables
CREATE TABLE estado (
    id_estado       SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    categoria       VARCHAR(20) NOT NULL CHECK (categoria IN ('proyecto','tarea','entregable','riesgo','incidente','reunion')),
    color_hex       CHAR(7) DEFAULT '#6C757D',
    descripcion     TEXT,
    orden           INTEGER DEFAULT 0,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Roles del equipo de proyecto
CREATE TABLE rol (
    id_rol          SERIAL PRIMARY KEY,
    codigo          VARCHAR(30) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    nivel           INTEGER DEFAULT 1 CHECK (nivel BETWEEN 1 AND 5),
    descripcion     TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Tipo de documentos / artefactos
CREATE TABLE tipo_documento (
    id_tipo_doc     SERIAL PRIMARY KEY,
    codigo          VARCHAR(30) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    extension_def   VARCHAR(10),
    plantilla_url   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Categorías de riesgos
CREATE TABLE categoria_riesgo (
    id_cat_riesgo   SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    probabilidad_default DECIMAL(3,2) DEFAULT 0.0,
    impacto_default     DECIMAL(3,2) DEFAULT 0.0,
    descripcion     TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Tipo de reuniones / actas
CREATE TABLE tipo_reunion (
    id_tipo_reunion SERIAL PRIMARY KEY,
    codigo          VARCHAR(30) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    requiere_acta   BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Fases de la metodología PM2
CREATE TABLE fase_pm2 (
    id_fase         SERIAL PRIMARY KEY,
    codigo          VARCHAR(10) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    descripcion     TEXT,
    objetivo        TEXT,
    entregables_clave TEXT,
    orden           INTEGER NOT NULL,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Niveles de prioridad
CREATE TABLE prioridad (
    id_prioridad    SERIAL PRIMARY KEY,
    codigo          VARCHAR(10) NOT NULL UNIQUE,
    nombre          VARCHAR(20) NOT NULL,
    valor_numerico  INTEGER NOT NULL,
    color_hex       CHAR(7) DEFAULT '#6C757D',
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- 4. TABLAS PRINCIPALES
-- ============================================================

-- --------------------------------------------------------------
-- 4.1 PERSONAS (Equipo + Stakeholders)
-- --------------------------------------------------------------
CREATE TABLE persona (
    id_persona      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    nombres         VARCHAR(100) NOT NULL,
    apellidos       VARCHAR(100) NOT NULL,
    email           VARCHAR(255) NOT NULL UNIQUE,
    telefono        VARCHAR(20),
    empresa         VARCHAR(100),
    cargo           VARCHAR(100),
    area            VARCHAR(50),
    es_interno      BOOLEAN DEFAULT TRUE,
    es_founder      BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.2 PROYECTOS (Núcleo del PM2)
-- --------------------------------------------------------------
CREATE TABLE proyecto (
    id_proyecto     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    -- Identificación
    codigo_pm2      VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    objetivo        TEXT,
    alcance         TEXT,
    exclusiones     TEXT,
    
    -- Clasificación PM2
    id_fase         INTEGER REFERENCES fase_pm2(id_fase),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Fechas PM2
    fecha_inicio    DATE,
    fecha_fin       DATE,
    fecha_objetivo_cierre DATE,
    fecha_cierre_real     DATE,
    
    -- Datos contractuales
    contrato_numero     VARCHAR(50),
    contrato_fecha      DATE,
    cliente             VARCHAR(100),
    cliente_sector      VARCHAR(50),
    valor_total         DECIMAL(18,2),
    moneda              VARCHAR(3) DEFAULT 'COP',
    vigencia_meses      INTEGER,
    periodicidad_facturacion VARCHAR(20) DEFAULT 'mensual',
    
    -- Datos de contacto / gestión
    director_proyecto_id    UUID REFERENCES persona(id_persona),
    gerente_proyecto_id   UUID REFERENCES persona(id_persona),
    patrocinador_id       UUID REFERENCES persona(id_persona),
    sponsor_cliente_id    UUID REFERENCES persona(id_persona),
    
    -- Métricas de avance
    avance_porcentaje     DECIMAL(5,2) DEFAULT 0.00 CHECK (avance_porcentaje BETWEEN 0 AND 100),
    avance_planificado    DECIMAL(5,2) DEFAULT 0.00 CHECK (avance_planificado BETWEEN 0 AND 100),
    
    -- Documentación
    carpeta_drive_id      VARCHAR(100),
    repo_github_url       TEXT,
    url_documentacion     TEXT,
    
    -- Estado operativo
    es_estrategico        BOOLEAN DEFAULT FALSE,
    activo                BOOLEAN DEFAULT TRUE,
    created_at            TIMESTAMPTZ DEFAULT NOW(),
    updated_at            TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.3 EQUIPO DE PROYECTO (Asignación de roles)
-- --------------------------------------------------------------
CREATE TABLE equipo_proyecto (
    id_equipo       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_persona      UUID NOT NULL REFERENCES persona(id_persona),
    id_rol          INTEGER NOT NULL REFERENCES rol(id_rol),
    fecha_ingreso   DATE DEFAULT CURRENT_DATE,
    fecha_salida    DATE,
    dedicacion_pct  DECIMAL(5,2) DEFAULT 100.00,
    responsabilidades TEXT,
    es_responsable  BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.4 FASES DEL PROYECTO (Instancias de fases PM2)
-- --------------------------------------------------------------
CREATE TABLE proyecto_fase (
    id_proy_fase    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_fase         INTEGER NOT NULL REFERENCES fase_pm2(id_fase),
    
    estado          INTEGER REFERENCES estado(id_estado),
    fecha_inicio    DATE,
    fecha_fin       DATE,
    fecha_fin_real  DATE,
    
    avance_porcentaje DECIMAL(5,2) DEFAULT 0.00,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, id_fase)
);

-- --------------------------------------------------------------
-- 4.5 TAREAS / WBS / ACTIVIDADES
-- --------------------------------------------------------------
CREATE TABLE tarea (
    id_tarea        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_proy_fase    UUID REFERENCES proyecto_fase(id_proy_fase),
    
    -- Jerarquía WBS
    id_tarea_padre  UUID REFERENCES tarea(id_tarea),
    wbs_codigo      VARCHAR(20) NOT NULL,
    nivel           INTEGER DEFAULT 1,
    
    -- Datos
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    tipo            VARCHAR(30) DEFAULT 'tarea' CHECK (tipo IN ('proyecto','fase','entregable','tarea','subtarea','hito')),
    
    -- Planificación
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    fecha_inicio_plan   DATE,
    fecha_fin_plan      DATE,
    duracion_plan_dias  INTEGER DEFAULT 1,
    
    fecha_inicio_real   DATE,
    fecha_fin_real      DATE,
    duracion_real_dias  INTEGER,
    
    -- Asignación
    responsable_id  UUID REFERENCES persona(id_persona),
    
    -- Avance
    avance_pct      DECIMAL(5,2) DEFAULT 0.00 CHECK (avance_pct BETWEEN 0 AND 100),
    es_critica      BOOLEAN DEFAULT FALSE,
    es_milestone    BOOLEAN DEFAULT FALSE,
    
    -- Esfuerzo
    esfuerzo_estimado_horas DECIMAL(8,2),
    esfuerzo_real_horas      DECIMAL(8,2),
    
    -- Ruta crítica
    es_ruta_critica BOOLEAN DEFAULT FALSE,
    float_dias      INTEGER DEFAULT 0,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.6 ENTREGABLES / PRODUCTOS
-- --------------------------------------------------------------
CREATE TABLE entregable (
    id_entregable   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tarea        UUID REFERENCES tarea(id_tarea),
    
    codigo          VARCHAR(30) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    id_tipo_doc     INTEGER REFERENCES tipo_documento(id_tipo_doc),
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    version         VARCHAR(10) DEFAULT '1.0',
    fecha_entrega   DATE,
    fecha_aprobacion DATE,
    
    aprobado_por    UUID REFERENCES persona(id_persona),
    url_archivo     TEXT,
    url_drive       TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.7 RIESGOS (PM2 + gestión de riesgos)
-- --------------------------------------------------------------
CREATE TABLE riesgo (
    id_riesgo       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    causa           TEXT,
    efecto          TEXT,
    
    id_cat_riesgo   INTEGER REFERENCES categoria_riesgo(id_cat_riesgo),
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    -- Matriz probabilidad/impacto
    probabilidad    DECIMAL(3,2) DEFAULT 0.50 CHECK (probabilidad BETWEEN 0 AND 1),
    impacto         DECIMAL(3,2) DEFAULT 0.50 CHECK (impacto BETWEEN 0 AND 1),
    nivel_riesgo    DECIMAL(5,4) GENERATED ALWAYS AS (probabilidad * impacto) STORED,
    
    -- Respuesta al riesgo
    estrategia      VARCHAR(20) CHECK (estrategia IN ('evitar','mitigar','transferir','aceptar')),
    plan_mitigacion TEXT,
    plan_contingencia TEXT,
    responsable_id  UUID REFERENCES persona(id_persona),
    
    fecha_identificacion  DATE DEFAULT CURRENT_DATE,
    fecha_cierre          DATE,
    
    es_residual     BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.8 INCIDENTES / PROBLEMAS / RFCs
-- --------------------------------------------------------------
CREATE TABLE incidente (
    id_incidente    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,
    tipo            VARCHAR(20) NOT NULL CHECK (tipo IN ('incidente','problema','cambio','rfc','defecto')),
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Clasificación
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    severidad       VARCHAR(10) CHECK (severidad IN ('crítica','alta','media','baja')),
    
    -- Afectación
    servicio_afectado VARCHAR(100),
    componente      VARCHAR(100),
    indisponibilidad_min INTEGER DEFAULT 0,
    
    -- Fechas
    fecha_reporte   TIMESTAMPTZ DEFAULT NOW(),
    fecha_inicio    TIMESTAMPTZ,
    fecha_resolucion TIMESTAMPTZ,
    fecha_cierre    TIMESTAMPTZ,
    
    -- Causa y solución
    causa_raiz      TEXT,
    solucion        TEXT,
    requiere_rollback BOOLEAN DEFAULT FALSE,
    
    -- Asignación
    reportado_por   UUID REFERENCES persona(id_persona),
    asignado_a      UUID REFERENCES persona(id_persona),
    resuelto_por    UUID REFERENCES persona(id_persona),
    
    -- Métricas de ANS
    sla_cumplido    BOOLEAN,
    tiempo_respuesta_min INTEGER,
    tiempo_resolucion_min INTEGER,
    
    url_ticket      TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.9 ACTAS / REUNIONES
-- --------------------------------------------------------------
CREATE TABLE reunion (
    id_reunion      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_tipo_reunion INTEGER REFERENCES tipo_reunion(id_tipo_reunion),
    
    nombre          VARCHAR(200) NOT NULL,
    fecha           DATE NOT NULL,
    hora_inicio     TIME,
    hora_fin        TIME,
    lugar           VARCHAR(100),
    url_meet        TEXT,
    
    objetivo        TEXT,
    agenda          TEXT,
    descripcion     TEXT,
    conclusiones    TEXT,
    acuerdos        TEXT,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    elaborada_por   UUID REFERENCES persona(id_persona),
    aprobada_por    UUID REFERENCES persona(id_persona),
    
    url_acta        TEXT,
    url_drive       TEXT,
    
    es_externa      BOOLEAN DEFAULT FALSE,
    es_comite       BOOLEAN DEFAULT FALSE,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Participantes de reunión
CREATE TABLE reunion_participante (
    id_rp           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_reunion      UUID NOT NULL REFERENCES reunion(id_reunion) ON DELETE CASCADE,
    id_persona      UUID NOT NULL REFERENCES persona(id_persona),
    
    asistio         BOOLEAN DEFAULT TRUE,
    rol_en_reunion  VARCHAR(50),
    compromisos     TEXT,
    
    UNIQUE(id_reunion, id_persona)
);

-- Compromisos / seguimientos de reunión
CREATE TABLE reunion_compromiso (
    id_compromiso   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_reunion      UUID NOT NULL REFERENCES reunion(id_reunion) ON DELETE CASCADE,
    
    descripcion     TEXT NOT NULL,
    responsable_id  UUID REFERENCES persona(id_persona),
    fecha_limite    DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.10 DOCUMENTOS / ARCHIVOS
-- --------------------------------------------------------------
CREATE TABLE documento (
    id_documento    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_tipo_doc     INTEGER REFERENCES tipo_documento(id_tipo_doc),
    id_entregable   UUID REFERENCES entregable(id_entregable),
    
    codigo          VARCHAR(30),
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    version         VARCHAR(10) DEFAULT '1.0',
    
    url_archivo     TEXT,
    url_drive       TEXT,
    url_github      TEXT,
    
    tamano_bytes    BIGINT,
    mime_type       VARCHAR(50),
    hash_md5        CHAR(32),
    
    autor_id        UUID REFERENCES persona(id_persona),
    aprobador_id    UUID REFERENCES persona(id_persona),
    
    fecha_creacion  DATE DEFAULT CURRENT_DATE,
    fecha_aprobacion DATE,
    
    es_confidencial BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.11 NOTAS / DIARIO DEL PROYECTO
-- --------------------------------------------------------------
CREATE TABLE nota_proyecto (
    id_nota         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    categoria       VARCHAR(30) DEFAULT 'general' CHECK (categoria IN ('general','decision','aprendizaje','riesgo','issue','idea','recordatorio')),
    titulo          VARCHAR(200),
    contenido       TEXT NOT NULL,
    
    autor_id        UUID REFERENCES persona(id_persona),
    es_privada      BOOLEAN DEFAULT FALSE,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.12 CLIENTES Y STAKEHOLDERS (tabla de relación)
-- --------------------------------------------------------------
CREATE TABLE stakeholder (
    id_stakeholder  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_persona      UUID NOT NULL REFERENCES persona(id_persona),
    
    rol_stakeholder VARCHAR(50),
    influencia      INTEGER DEFAULT 3 CHECK (influencia BETWEEN 1 AND 5),
    interes         INTEGER DEFAULT 3 CHECK (interes BETWEEN 1 AND 5),
    estrategia      TEXT,
    
    es_cliente_directo  BOOLEAN DEFAULT FALSE,
    es_patrocinador     BOOLEAN DEFAULT FALSE,
    es_usuario_final    BOOLEAN DEFAULT FALSE,
    
    observaciones   TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 4.13 KANBAN / SPRINTS (opcional para agile-híbrido)
-- --------------------------------------------------------------
CREATE TABLE sprint (
    id_sprint       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    nombre          VARCHAR(100) NOT NULL,
    objetivo        TEXT,
    
    fecha_inicio    DATE,
    fecha_fin       DATE,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    velocidad_plan  DECIMAL(8,2),
    velocidad_real  DECIMAL(8,2),
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- Relación tareas-sprint
CREATE TABLE tarea_sprint (
    id_ts           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_sprint       UUID NOT NULL REFERENCES sprint(id_sprint) ON DELETE CASCADE,
    id_tarea        UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    
    es_story_point  BOOLEAN DEFAULT FALSE,
    story_points    INTEGER,
    
    UNIQUE(id_sprint, id_tarea)
);

-- ============================================================
-- 5. VISTAS DE REPORTING
-- ============================================================

-- Dashboard de proyectos
CREATE VIEW v_proyecto_dashboard AS
SELECT
    p.id_proyecto,
    p.codigo_pm2,
    p.nombre,
    p.cliente,
    f.nombre AS fase_actual,
    e.nombre AS estado,
    e.color_hex AS estado_color,
    pr.nombre AS prioridad,
    p.avance_porcentaje,
    p.avance_planificado,
    (p.avance_porcentaje - p.avance_planificado) AS desviacion_avance,
    p.fecha_inicio,
    p.fecha_fin,
    p.fecha_objetivo_cierre,
    p.valor_total,
    p.moneda,
    p.es_estrategico,
    p.activo,
    COALESCE(dp.nombres || ' ' || dp.apellidos, 'Sin asignar') AS director_proyecto,
    COALESCE(gp.nombres || ' ' || gp.apellidos, 'Sin asignar') AS gerente_proyecto,
    (SELECT COUNT(*) FROM pm2.tarea t WHERE t.id_proyecto = p.id_proyecto) AS total_tareas,
    (SELECT COUNT(*) FROM pm2.tarea t WHERE t.id_proyecto = p.id_proyecto AND t.avance_pct = 100) AS tareas_completadas,
    (SELECT COUNT(*) FROM pm2.riesgo r WHERE r.id_proyecto = p.id_proyecto AND r.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('cerrado','mitigado')) ) AS riesgos_activos,
    (SELECT COUNT(*) FROM pm2.incidente i WHERE i.id_proyecto = p.id_proyecto AND i.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('cerrado','resuelto')) ) AS incidentes_abiertos
FROM pm2.proyecto p
LEFT JOIN pm2.fase_pm2 f ON p.id_fase = f.id_fase
LEFT JOIN pm2.estado e ON p.id_estado = e.id_estado
LEFT JOIN pm2.prioridad pr ON p.id_prioridad = pr.id_prioridad
LEFT JOIN pm2.persona dp ON p.director_proyecto_id = dp.id_persona
LEFT JOIN pm2.persona gp ON p.gerente_proyecto_id = gp.id_persona;

-- Ruta crítica del proyecto
CREATE VIEW v_ruta_critica AS
SELECT
    t.id_proyecto,
    p.nombre AS proyecto,
    t.wbs_codigo,
    t.nombre AS tarea,
    t.fecha_inicio_plan,
    t.fecha_fin_plan,
    t.duracion_plan_dias,
    t.es_critica,
    t.es_ruta_critica,
    t.float_dias,
    t.avance_pct,
    COALESCE(res.nombres || ' ' || res.apellidos, 'Sin asignar') AS responsable
FROM pm2.tarea t
JOIN pm2.proyecto p ON t.id_proyecto = p.id_proyecto
LEFT JOIN pm2.persona res ON t.responsable_id = res.id_persona
WHERE t.es_ruta_critica = TRUE OR t.float_dias = 0
ORDER BY t.fecha_fin_plan;

-- Matriz de riesgos
CREATE VIEW v_matriz_riesgos AS
SELECT
    r.id_proyecto,
    p.nombre AS proyecto,
    r.codigo,
    r.nombre,
    r.probabilidad,
    r.impacto,
    r.nivel_riesgo,
    CASE
        WHEN r.nivel_riesgo >= 0.20 THEN 'CRÍTICO'
        WHEN r.nivel_riesgo >= 0.10 THEN 'ALTO'
        WHEN r.nivel_riesgo >= 0.05 THEN 'MEDIO'
        ELSE 'BAJO'
    END AS nivel_texto,
    r.estrategia,
    e.nombre AS estado,
    cr.nombre AS categoria,
    COALESCE(resp.nombres || ' ' || resp.apellidos, 'Sin asignar') AS responsable
FROM pm2.riesgo r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
LEFT JOIN pm2.estado e ON r.id_estado = e.id_estado
LEFT JOIN pm2.categoria_riesgo cr ON r.id_cat_riesgo = cr.id_cat_riesgo
LEFT JOIN pm2.persona resp ON r.responsable_id = resp.id_persona
WHERE r.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('cerrado','mitigado'));

-- Tablero de ANS / SLA
CREATE VIEW v_ans_dashboard AS
SELECT
    i.id_proyecto,
    p.nombre AS proyecto,
    i.servicio_afectado,
    i.tipo,
    COUNT(*) AS total_incidentes,
    SUM(i.indisponibilidad_min) AS total_indisponibilidad_min,
    AVG(i.tiempo_respuesta_min) AS avg_tiempo_respuesta,
    AVG(i.tiempo_resolucion_min) AS avg_tiempo_resolucion,
    SUM(CASE WHEN i.sla_cumplido = TRUE THEN 1 ELSE 0 END) AS slas_cumplidos,
    SUM(CASE WHEN i.sla_cumplido = FALSE THEN 1 ELSE 0 END) AS slas_incumplidos,
    ROUND(
        100.0 * SUM(CASE WHEN i.sla_cumplido = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),
        2
    ) AS pct_cumplimiento_sla
FROM pm2.incidente i
JOIN pm2.proyecto p ON i.id_proyecto = p.id_proyecto
WHERE i.fecha_reporte >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY i.id_proyecto, p.nombre, i.servicio_afectado, i.tipo;

-- ============================================================
-- 6. ÍNDICES DE PERFORMANCE
-- ============================================================

CREATE INDEX idx_proyecto_estado ON pm2.proyecto(id_estado);
CREATE INDEX idx_proyecto_fase ON pm2.proyecto(id_fase);
CREATE INDEX idx_proyecto_prioridad ON pm2.proyecto(id_prioridad);
CREATE INDEX idx_proyecto_cliente ON pm2.proyecto(cliente);
CREATE INDEX idx_proyecto_activo ON pm2.proyecto(activo);

CREATE INDEX idx_tarea_proyecto ON pm2.tarea(id_proyecto);
CREATE INDEX idx_tarea_estado ON pm2.tarea(id_estado);
CREATE INDEX idx_tarea_padre ON pm2.tarea(id_tarea_padre);
CREATE INDEX idx_tarea_responsable ON pm2.tarea(responsable_id);
CREATE INDEX idx_tarea_fechas ON pm2.tarea(fecha_inicio_plan, fecha_fin_plan);

CREATE INDEX idx_riesgo_proyecto ON pm2.riesgo(id_proyecto);
CREATE INDEX idx_riesgo_nivel ON pm2.riesgo(nivel_riesgo);
CREATE INDEX idx_riesgo_estado ON pm2.riesgo(id_estado);

CREATE INDEX idx_incidente_proyecto ON pm2.incidente(id_proyecto);
CREATE INDEX idx_incidente_fecha ON pm2.incidente(fecha_reporte);
CREATE INDEX idx_incidente_estado ON pm2.incidente(id_estado);

CREATE INDEX idx_reunion_proyecto ON pm2.reunion(id_proyecto);
CREATE INDEX idx_reunion_fecha ON pm2.reunion(fecha);

CREATE INDEX idx_documento_proyecto ON pm2.documento(id_proyecto);
CREATE INDEX idx_documento_tipo ON pm2.documento(id_tipo_doc);

CREATE INDEX idx_equipo_proyecto ON pm2.equipo_proyecto(id_proyecto);
CREATE INDEX idx_equipo_persona ON pm2.equipo_proyecto(id_persona);

CREATE INDEX idx_stakeholder_proyecto ON pm2.stakeholder(id_proyecto);

CREATE INDEX idx_nota_proyecto ON pm2.nota_proyecto(id_proyecto);
CREATE INDEX idx_nota_categoria ON pm2.nota_proyecto(categoria);

-- ============================================================
-- 7. DATOS MAESTROS INICIALES
-- ============================================================

-- Estados
INSERT INTO pm2.estado (codigo, nombre, categoria, color_hex, descripcion, orden) VALUES
('propuesta', 'PROPUESTA', 'proyecto', '#FFC107', 'Proyecto en fase de propuesta comercial', 1),
('negociacion','EN NEGOCIACIÓN', 'proyecto', '#FF9800', 'Negociando alcance y condiciones', 2),
('ejecucion', 'EN EJECUCIÓN', 'proyecto', '#4CAF50', 'Proyecto en ejecución activa', 3),
('pausa', 'EN PAUSA', 'proyecto', '#9E9E9E', 'Proyecto temporalmente detenido', 4),
('cerrado', 'CERRADO', 'proyecto', '#2196F3', 'Proyecto cerrado exitosamente', 5),
('cancelado', 'CANCELADO', 'proyecto', '#F44336', 'Proyecto cancelado', 6),

('pendiente', 'PENDIENTE', 'tarea', '#FFC107', 'Tarea sin iniciar', 1),
('en_progreso','EN PROGRESO', 'tarea', '#2196F3', 'Tarea en desarrollo', 2),
('completada','COMPLETADA', 'tarea', '#4CAF50', 'Tarea finalizada', 3),
('bloqueada', 'BLOQUEADA', 'tarea', '#F44336', 'Tarea bloqueada por dependencia o impedimento', 4),
('rechazada', 'RECHAZADA', 'tarea', '#9E9E9E', 'Tarea rechazada o descartada', 5),

('borrador', 'BORRADOR', 'entregable', '#9E9E9E', 'Documento en borrador', 1),
('revision', 'EN REVISIÓN', 'entregable', '#FF9800', 'En revisión por stakeholders', 2),
('aprobado', 'APROBADO', 'entregable', '#4CAF50', 'Documento aprobado', 3),
('rechazado','RECHAZADO', 'entregable', '#F44336', 'Documento rechazado', 4),

('abierto', 'ABIERTO', 'riesgo', '#F44336', 'Riesgo activo sin mitigar', 1),
('mitigado','MITIGADO', 'riesgo', '#FF9800', 'Riesgo con plan de mitigación activo', 2),
('cerrado', 'CERRADO', 'riesgo', '#4CAF50', 'Riesgo cerrado o materializado', 3),

('reportado','REPORTADO', 'incidente', '#FFC107', 'Incidente reportado', 1),
('en_analisis','EN ANÁLISIS', 'incidente', '#FF9800', 'En diagnóstico de causa raíz', 2),
('en_resolucion','EN RESOLUCIÓN', 'incidente', '#2196F3', 'Aplicando solución', 3),
('resuelto', 'RESUELTO', 'incidente', '#4CAF50', 'Solución aplicada', 4),
('cerrado', 'CERRADO', 'incidente', '#9E9E9E', 'Incidente cerrado con RCA', 5),

('programada','PROGRAMADA', 'reunion', '#2196F3', 'Reunión programada', 1),
('realizada', 'REALIZADA', 'reunion', '#4CAF50', 'Reunión realizada', 2),
('cancelada', 'CANCELADA', 'reunion', '#F44336', 'Reunión cancelada', 3);

-- Prioridades
INSERT INTO pm2.prioridad (codigo, nombre, valor_numerico, color_hex) VALUES
('critica', 'CRÍTICA', 1, '#F44336'),
('alta', 'ALTA', 2, '#FF5722'),
('media', 'MEDIA', 3, '#FFC107'),
('baja', 'BAJA', 4, '#4CAF50'),
('minima', 'MÍNIMA', 5, '#9E9E9E');

-- Fases PM2
INSERT INTO pm2.fase_pm2 (codigo, nombre, descripcion, objetivo, entregables_clave, orden) VALUES
('I', 'INICIACIÓN', 'Definición del proyecto, análisis de viabilidad y aprobación', 'Validar que el proyecto es viable y estratégico', 'Acta de constitución, Business Case, Identificación de interesados', 1),
('PI', 'PLANIFICACIÓN', 'Desarrollo del plan de proyecto detallado', 'Establecer línea base de alcance, tiempo, costo y calidad', 'Plan de gestión del proyecto, WBS, Cronograma, Presupuesto', 2),
('E', 'EJECUCIÓN', 'Desarrollo de los entregables del proyecto', 'Producir los entregables según especificaciones', 'Entregables aprobados, Informes de avance, Cambios gestionados', 3),
('C', 'CONTROL', 'Monitoreo y control del desempeño del proyecto', 'Detectar desviaciones y aplicar acciones correctivas', 'Informes de desempeño, Registro de cambios, Actualizaciones del plan', 4),
('CIERRE', 'CIERRE', 'Finalización formal del proyecto', 'Liberar recursos, documentar lecciones, entregar al cliente', 'Acta de cierre, Lecciones aprendidas, Liberación de recursos', 5);

-- Roles
INSERT INTO pm2.rol (codigo, nombre, nivel, descripcion) VALUES
('director_proyecto', 'Director de Proyecto', 1, 'Máxima autoridad del proyecto, responsable del éxito'),
('gerente_proyecto', 'Gerente de Proyecto', 2, 'Gestión día a día, recursos, cronograma, stakeholders'),
('lider_tecnico', 'Líder Técnico', 3, 'Arquitectura, decisiones técnicas, calidad del código'),
('arquitecto', 'Arquitecto', 3, 'Diseño de solución, integraciones, infraestructura'),
('dba', 'DBA', 3, 'Base de datos, modelado, optimización, backups'),
('desarrollador', 'Desarrollador', 4, 'Codificación, pruebas unitarias, documentación técnica'),
('analista', 'Analista', 4, 'Requerimientos, casos de uso, pruebas funcionales'),
('qa', 'QA / Tester', 4, 'Pruebas, calidad, automatización'),
('devops', 'DevOps / Infra', 3, 'CI/CD, infraestructura, monitoreo, despliegues'),
('diseñador', 'Diseñador UX/UI', 4, 'Experiencia de usuario, interfaces, prototipos'),
('scrum_master', 'Scrum Master', 3, 'Facilitación, remoción de impedimentos, métricas agile'),
('product_owner','Product Owner', 2, 'Backlog, priorización, valor de negocio'),
('stakeholder', 'Stakeholder', 5, 'Interesado en el proyecto, provee requisitos o recursos'),
('patrocinador', 'Patrocinador', 1, 'Aprueba recursos, resuelve escalaciones estratégicas');

-- Tipos de documento
INSERT INTO pm2.tipo_documento (codigo, nombre, extension_def, plantilla_url) VALUES
('acta_constitucion', 'Acta de Constitución del Proyecto', 'docx', NULL),
('plan_proyecto', 'Plan de Gestión del Proyecto', 'docx', NULL),
('wbs', 'Estructura de Desglose de Trabajo (WBS)', 'xlsx', NULL),
('cronograma', 'Cronograma del Proyecto', 'mpp', NULL),
('presupuesto', 'Presupuesto y S-Curve', 'xlsx', NULL),
('matriz_riesgos', 'Matriz de Riesgos', 'xlsx', NULL),
('acta_reunion', 'Acta de Reunión', 'docx', NULL),
('informe_avance', 'Informe de Avance', 'docx', NULL),
('informe_semanal','Informe Semanal', 'docx', NULL),
('informe_mensual','Informe Mensual', 'docx', NULL),
('informe_ejecutivo','Informe Ejecutivo', 'pdf', NULL),
('especificacion', 'Especificación Técnica / Funcional', 'docx', NULL),
('diagrama', 'Diagrama / Modelo', 'png', NULL),
('codigo', 'Código Fuente / Script', 'sql', NULL),
('checklist', 'Lista de Verificación', 'xlsx', NULL),
('lec_aprendidas', 'Lecciones Aprendidas', 'docx', NULL),
('acta_cierre', 'Acta de Cierre', 'docx', NULL),
('contrato', 'Contrato / Anexo Contractual', 'pdf', NULL),
('propuesta', 'Propuesta Comercial', 'pdf', NULL),
('ppt_presentacion','Presentación', 'pptx', NULL);

-- Categorías de riesgo
INSERT INTO pm2.categoria_riesgo (codigo, nombre, probabilidad_default, impacto_default, descripcion) VALUES
('tecnico', 'Técnico', 0.30, 0.50, 'Riesgos relacionados con tecnología, arquitectura, integraciones'),
('organizacional', 'Organizacional', 0.40, 0.40, 'Cambios en la organización, rotación de personal, capacidad'),
('externo', 'Externo', 0.30, 0.60, 'Dependencias de terceros, regulaciones, proveedores'),
('financiero', 'Financiero', 0.20, 0.70, 'Presupuesto, flujo de caja, pagos, multas'),
('operacional', 'Operacional', 0.50, 0.50, 'Disponibilidad, rendimiento, capacidad de operación'),
('seguridad', 'Seguridad', 0.20, 0.80, 'Breach, vulnerabilidades, cumplimiento normativo'),
('calidad', 'Calidad', 0.30, 0.40, 'Defectos, pruebas insuficientes, deuda técnica');

-- Tipos de reunión
INSERT INTO pm2.tipo_reunion (codigo, nombre, requiere_acta) VALUES
('seguimiento', 'Seguimiento / Standup', FALSE),
('semanal', 'Reunión Semanal', TRUE),
('mensual', 'Reunión Mensual', TRUE),
('comite', 'Comité Directivo', TRUE),
('kickoff', 'Kickoff / Inicio', TRUE),
('cierre', 'Cierre / Lecciones', TRUE),
('tecnica', 'Reunión Técnica', FALSE),
('planificacion', 'Planificación / Sprint Planning', FALSE),
('revision', 'Revisión / Sprint Review', TRUE),
('retrospectiva', 'Retrospectiva', FALSE),
('emergencia', 'Emergencia / War Room', FALSE),
('cliente', 'Con Cliente', TRUE),
('capacitacion', 'Capacitación', FALSE);

-- ============================================================
-- 8. DATOS DE PRUEBA — PROYECTO SICOM COMO EJEMPLO
-- ============================================================

-- Personas clave
INSERT INTO pm2.persona (nombres, apellidos, email, empresa, cargo, es_interno, es_founder) VALUES
('Jelkin Zair', 'Carrillo Franco', 'jelkin@innovadataco.com', 'Innovadataco', 'CEO / Founder', TRUE, TRUE),
('Diana Marcela', 'Cáceres Valderrama', 'diana@innovadataco.com', 'Innovadataco', 'Dirección Jurídica Estratégica', TRUE, TRUE),
('Luis Felipe', 'Herrera', 'lf.herrera@ci2.com', 'CI2', 'Líder Técnico', FALSE, FALSE),
('Luis', 'Marentes', 'l.marentes@ci2.com', 'CI2', 'Director Proyecto', FALSE, FALSE),
('Alejandro', 'Martínez', 'a.martinez@ci2.com', 'CI2', 'Director Proyecto SICOM', FALSE, FALSE),
('Ronald', 'Salinas', 'r.salinas@ci2.com', 'CI2', 'Líder Temático', FALSE, FALSE);

-- Proyecto SICOM
INSERT INTO pm2.proyecto (
    codigo_pm2, nombre, descripcion, objetivo, alcance,
    id_fase, id_estado, id_prioridad,
    fecha_inicio, fecha_fin, fecha_objetivo_cierre,
    contrato_numero, contrato_fecha, cliente, cliente_sector,
    valor_total, moneda, vigencia_meses,
    director_proyecto_id, gerente_proyecto_id,
    es_estrategico, activo
) VALUES (
    'SICOM-2026-001',
    'Operación y Evolución Plataforma SICOM / GNCV — MME',
    'Migración, operación y evolución de la plataforma SICOM (Sistema de Información del Combustible) y GNCV (Gas Natural Vehicular) del Ministerio de Minas y Energía de Colombia. Contrato 2034 de 2025.',
    'Garantizar disponibilidad >99.98% de los portales web, aplicaciones móviles, web services, BI y mesa de ayuda del MME. Desarrollar evolutivos de gestión pública energética.',
    'Operación 24/7, desarrollo evolutivo, BI/ETL, mesa de ayuda, seguridad WAF, aplicaciones móviles, contingencia DRP. Alcance excluye infraestructura de red del MME.',
    3, -- EJECUCIÓN
    3, -- EN EJECUCIÓN
    1, -- CRÍTICA
    '2026-07-01', '2027-06-30', '2027-06-30',
    '2034 de 2025', '2025-12-01', 'Ministerio de Minas y Energía', 'Energía / Gobierno',
    150000000.00, 'COP', 12,
    (SELECT id_persona FROM pm2.persona WHERE email = 'l.marentes@ci2.com'),
    (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'),
    TRUE, TRUE
);

-- Equipo del proyecto
INSERT INTO pm2.equipo_proyecto (id_proyecto, id_persona, id_rol, dedicacion_pct, es_responsable, activo)
SELECT 
    p.id_proyecto,
    per.id_persona,
    r.id_rol,
    CASE per.email 
        WHEN 'jelkin@innovadataco.com' THEN 50.00
        ELSE 100.00 
    END,
    CASE WHEN per.email IN ('jelkin@innovadataco.com', 'lf.herrera@ci2.com', 'l.marentes@ci2.com') THEN TRUE ELSE FALSE END,
    TRUE
FROM pm2.proyecto p
CROSS JOIN pm2.persona per
CROSS JOIN pm2.rol r
WHERE p.codigo_pm2 = 'SICOM-2026-001'
  AND per.email IN ('jelkin@innovadataco.com', 'lf.herrera@ci2.com', 'l.marentes@ci2.com', 'a.martinez@ci2.com', 'r.salinas@ci2.com')
  AND r.codigo IN (
      CASE per.email 
          WHEN 'jelkin@innovadataco.com' THEN 'gerente_proyecto'
          WHEN 'lf.herrera@ci2.com' THEN 'lider_tecnico'
          WHEN 'l.marentes@ci2.com' THEN 'director_proyecto'
          WHEN 'a.martinez@ci2.com' THEN 'director_proyecto'
          WHEN 'r.salinas@ci2.com' THEN 'lider_tecnico'
      END
  );

-- Tareas del proyecto (WBS nivel 1)
INSERT INTO pm2.tarea (id_proyecto, wbs_codigo, nivel, nombre, descripcion, tipo, id_estado, id_prioridad, fecha_inicio_plan, fecha_fin_plan, duracion_plan_dias, avance_pct, es_critica)
SELECT 
    p.id_proyecto,
    t.wbs,
    1,
    t.nombre,
    t.descr,
    'fase',
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'en_progreso'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = 'alta'),
    t.inicio,
    t.fin,
    t.duracion,
    t.avance,
    t.critica
FROM pm2.proyecto p,
LATERAL (VALUES
    ('1.0', 'Gestión de Proyecto', 'Planeación, seguimiento, reportes, reuniones con MME y CI2', '2026-05-01', '2027-06-30', 420, 15, FALSE),
    ('2.0', 'Infraestructura y Operación', 'Nube privada, VMware, Oracle RAC, backups, monitoreo, DRP', '2026-05-01', '2027-06-30', 420, 10, TRUE),
    ('3.0', 'Desarrollo y Evolutivos', 'BPM Bizagi, portales web, apps móviles, web services, BI', '2026-05-01', '2027-06-30', 420, 20, TRUE),
    ('4.0', 'Mesa de Ayuda y Soporte', 'Call center Wolkvox, tickets Aranda, ANS >99.98%', '2026-07-01', '2027-06-30', 365, 0, TRUE),
    ('5.0', 'Seguridad y Cumplimiento', 'WAF FortiWeb, pentesting, auditoría, geobloqueo, certificación', '2026-05-01', '2027-06-30', 420, 5, FALSE),
    ('6.0', 'Migración GNCV a BPM', 'Levantamiento, diseño, desarrollo, pruebas, producción GNCV', '2026-05-01', '2026-12-31', 245, 5, TRUE),
    ('7.0', 'Transición Internexa → Innovadataco', 'Empalme mayo-junio, KT, entrega documentación, validación', '2026-05-01', '2026-06-30', 60, 25, TRUE)
) AS t(wbs, nombre, descr, inicio, fin, duracion, avance, critica)
WHERE p.codigo_pm2 = 'SICOM-2026-001';

-- Riesgos críticos identificados
INSERT INTO pm2.riesgo (id_proyecto, codigo, nombre, descripcion, causa, efecto, id_cat_riesgo, id_estado, id_prioridad, probabilidad, impacto, estrategia, plan_mitigacion, plan_contingencia, fecha_identificacion)
SELECT 
    p.id_proyecto,
    r.codigo,
    r.nombre,
    r.descr,
    r.causa,
    r.efecto,
    (SELECT id_cat_riesgo FROM pm2.categoria_riesgo WHERE codigo = r.cat),
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'abierto' AND categoria = 'riesgo'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = r.prio),
    r.prob,
    r.imp,
    r.estr,
    r.mitig,
    r.cont,
    '2026-05-14'
FROM pm2.proyecto p,
LATERAL (VALUES
    ('RSK-001', 'Saturación Oracle RAC por peticiones GAS', 'La base de datos Oracle RAC presenta saturación crónica por 400,000 peticiones masivas de agentes GNCV con vehículos inexistentes.', 'Agentes GAS envían volúmenes masivos no validados', 'Indisponibilidad de portal SICOM y GNCV, incumplimiento ANS >99.98%', 'tecnico', 'critica', 0.70, 0.90, 'mitigar', 'Implementar validación de datos en capa de aplicación antes de BD. Limitar conexiones a 500. Monitoreo proactivo de archives.', 'Activar contingencia DRP con RPO <30 min. Ejecutar depuración manual de archives. Escalar a DBA Oracle especializado.'),
    ('RSK-002', 'Atraso en entregables Vigencia 7 (CI2)', 'Cronograma Vigencia 7 al 57% real vs 61% planeado. Mayo y junio al 0%.', 'Complejidad de evolutivos + recursos limitados CI2', 'Innovadataco hereda deuda técnica sin claridad de alcance ni compensación', 'organizacional', 'alta', 0.60, 0.80, 'transferir', 'Definir en contrato alcance exacto de Innovadataco vs CI2. Documentar entregables pendientes y responsables.', 'Negociar extensión de plazo o recursos adicionales. Priorizar entregables por criticidad para MME.'),
    ('RSK-003', 'Multas ANS por disponibilidad incumplida', 'En abril 2026 Internexa incumplió 2 ANS: Nuevo SICOM Líquidos 99.88% y Web Service 99.90%.', 'Inestabilidad arquitectura nueva BPM vs legado estable', 'Multa 0.5% facturación mensual por cada 0.1% de falla. Reputación con MME.', 'financiero', 'critica', 0.50, 0.85, 'mitigar', 'Auditar infraestructura antes de corte. Validar capacidad nube privada con carga real. Plan de stabilización primeros 30 días.', 'Reserva financiera para 2-3 meses de multas. Cláusula de transición con CI2 sobre responsabilidad de multas.'),
    ('RSK-004', 'Sin equipo técnico conformado Innovadataco', 'No se ha contratado DBA Oracle, Arquitecto Nube, ni DevOps para operar SICOM.', 'Falta de plan de staffing del Founder', 'No se puede operar 24/7 ni hacer evolutivos. Dependencia total de CI2.', 'organizacional', 'critica', 0.90, 0.80, 'mitigar', 'Publicar vacantes urgentes DBA Oracle y Arquitecto Cloud. Contactar headhunters técnicos. Evaluar outsourcing parcial primeros 3 meses.', 'Contratar consultoría externa de soporte 24/7 transitoria mientras se arma equipo.'),
    ('RSK-005', 'Aplicaciones móviles sin publicar', 'Apps móviles SICOM Líquidos y Gas aún en UAT, no publicadas en tiendas.', 'Pruebas incompletas, aprobación MME pendiente', 'No hay canal móvil para usuarios. Reclamaciones al call center aumentan.', 'operacional', 'alta', 0.60, 0.70, 'mitigar', 'Acelerar cierre de UAT con MME. Preparar paquetes de publicación iOS/Android. Plan de comunicación a usuarios.', 'Publicar versión web responsive como alternativa temporal. Priorizar app más crítica (Líquidos).')
) AS r(codigo, nombre, descr, causa, efecto, cat, prio, prob, imp, estr, mitig, cont)
WHERE p.codigo_pm2 = 'SICOM-2026-001';

-- ============================================================
-- 9. PERMISSIONS Y SEGURIDAD
-- ============================================================

-- Rol de lectura
CREATE ROLE pm2_read;
GRANT USAGE ON SCHEMA pm2 TO pm2_read;
GRANT SELECT ON ALL TABLES IN SCHEMA pm2 TO pm2_read;
ALTER DEFAULT PRIVILEGES IN SCHEMA pm2 GRANT SELECT ON TABLES TO pm2_read;

-- Rol de escritura
CREATE ROLE pm2_write;
GRANT USAGE ON SCHEMA pm2 TO pm2_write;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA pm2 TO pm2_write;
ALTER DEFAULT PRIVILEGES IN SCHEMA pm2 GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO pm2_write;

-- ============================================================
-- 10. COMENTARIOS DE DOCUMENTACIÓN
-- ============================================================

COMMENT ON SCHEMA pm2 IS 'Esquema de gestión de proyectos Innovadataco — Metodología PM2';
COMMENT ON TABLE pm2.proyecto IS 'Proyectos empresariales con metadatos PM2, contractual y operativo';
COMMENT ON TABLE pm2.tarea IS 'WBS — Estructura de desglose de trabajo con ruta crítica';
COMMENT ON TABLE pm2.riesgo IS 'Registro de riesgos con matriz probabilidad x impacto';
COMMENT ON TABLE pm2.incidente IS 'Incidentes, problemas, RFCs — vinculados a ANS/SLA';
COMMENT ON TABLE pm2.reunion IS 'Actas y reuniones con compromisos trazables';
COMMENT ON TABLE pm2.entregable IS 'Productos y documentos entregables del proyecto';

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
-- Ejecutar con: psql -U postgres -d innovadataco -f pm2_database.sql
-- ============================================================