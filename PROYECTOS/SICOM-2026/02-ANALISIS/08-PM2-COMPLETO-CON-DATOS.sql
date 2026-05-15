-- ============================================================
-- INNOVADATACO — MANUAL COMPLETO DE IMPLEMENTACIÓN PM2 v2.0
-- Base de Datos + Datos del Proyecto IDC_2026_01
-- Fecha: 15 de mayo de 2026
-- Autor: ZEUS
-- Versión: 2.0 FINAL
-- ============================================================

/*
╔══════════════════════════════════════════════════════════════════════════════╗
║                           GUÍA DE EJECUCIÓN                                  ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  1. Conectarse a PostgreSQL:  psql -U tu_usuario -d tu_base_de_datos        ║
║  2. Ejecutar este archivo:    \i 08-PM2-COMPLETO-CON-DATOS.sql              ║
║                                                                              ║
║  ORDEN INTERNO DEL SCRIPT:                                                   ║
║    A. Esquema y extensiones                                                  ║
║    B. Tablas base (sin dependencias externas)                                ║
║    C. Tablas con dependencias                                                ║
║    D. Índices                                                                ║
║    E. Vistas                                                                 ║
║    F. Datos de catálogo (estados, prioridades, etc.)                         ║
║    G. Datos del Proyecto IDC_2026_01                                         ║
╚══════════════════════════════════════════════════════════════════════════════╝
*/

-- ============================================================
-- A. ESQUEMA Y EXTENSIONES
-- ============================================================

-- Crear esquema si no existe
CREATE SCHEMA IF NOT EXISTS pm2;

-- Extensión para UUIDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Establecer search_path
SET search_path TO pm2, public;

-- ============================================================
-- B. TABLAS BASE (Sin dependencias entre sí)
-- ============================================================

-- ------------------------------------------------------------
-- B.1. ESTADO — Catálogo maestro de estados
-- ------------------------------------------------------------
CREATE TABLE estado (
    id_estado       SERIAL PRIMARY KEY,
    codigo          VARCHAR(50) NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    categoria       VARCHAR(50) NOT NULL,
    color_hex       VARCHAR(7),
    descripcion     TEXT,
    orden           INTEGER DEFAULT 0,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE estado IS 'Catálogo maestro de estados para todas las entidades del sistema';

-- ------------------------------------------------------------
-- B.2. PRIORIDAD — Catálogo maestro de prioridades
-- ------------------------------------------------------------
CREATE TABLE prioridad (
    id_prioridad    SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(50) NOT NULL,
    color_hex       VARCHAR(7),
    valor_numerico  INTEGER,  -- 1=crítico, 5=bajo
    descripcion     TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE prioridad IS 'Catálogo de prioridades: crítico, alto, medio, bajo';

-- ------------------------------------------------------------
-- B.3. FASE PM2 — Catálogo de fases
-- ------------------------------------------------------------
CREATE TABLE fase_pm2 (
    id_fase         SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    orden           INTEGER NOT NULL,
    color_hex       VARCHAR(7),
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE fase_pm2 IS 'Catálogo de fases PM2: Iniciación, Planificación, Ejecución, Control, Cierre';

-- ------------------------------------------------------------
-- B.4. TIPO DOCUMENTO — Catálogo de tipos de documento
-- ------------------------------------------------------------
CREATE TABLE tipo_documento (
    id_tipo_doc     SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    extension_defecto VARCHAR(10),  -- .md, .pdf, .xlsx
    plantilla_url   TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE tipo_documento IS 'Catálogo de tipos de documento del proyecto';

-- ------------------------------------------------------------
-- B.5. CATEGORÍA RIESGO — Catálogo de categorías de riesgo
-- ------------------------------------------------------------
CREATE TABLE categoria_riesgo (
    id_categoria_riesgo SERIAL PRIMARY KEY,
    codigo              VARCHAR(20) NOT NULL UNIQUE,
    nombre              VARCHAR(100) NOT NULL,
    descripcion         TEXT,
    color_hex           VARCHAR(7),
    activo              BOOLEAN DEFAULT TRUE,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE categoria_riesgo IS 'Catálogo de categorías de riesgo';

-- ------------------------------------------------------------
-- B.6. ROL — Catálogo de roles
-- ------------------------------------------------------------
CREATE TABLE rol (
    id_rol          SERIAL PRIMARY KEY,
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    nivel_jerarquico INTEGER,  -- 1=director, 2=gerente, 3=analista
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE rol IS 'Catálogo de roles del proyecto: director, gerente, analista, etc.';

-- ------------------------------------------------------------
-- B.7. TIPO REUNIÓN — Catálogo de tipos de reunión
-- ------------------------------------------------------------
CREATE TABLE tipo_reunion (
    id_tipo_reunion SERIAL PRIMARY KEY,
    codigo          VARCHAR(50) NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE tipo_reunion IS 'Catálogo de tipos de reunión';

-- ============================================================
-- C. TABLAS CON DEPENDENCIAS
-- ============================================================

-- ------------------------------------------------------------
-- C.1. PERSONA — Todas las personas del sistema
-- ------------------------------------------------------------
CREATE TABLE persona (
    id_persona      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    nombres         VARCHAR(100) NOT NULL,
    apellidos       VARCHAR(100),
    email           VARCHAR(255) UNIQUE,
    telefono        VARCHAR(20),
    organizacion    VARCHAR(100),
    cargo           VARCHAR(100),
    
    tipo            VARCHAR(20) CHECK (tipo IN ('interno','externo','proveedor','cliente','consultor')),
    
    url_foto        TEXT,
    url_linkedin    TEXT,
    notas           TEXT,
    
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE persona IS 'Todas las personas: internos, clientes, proveedores, consultores';

-- ------------------------------------------------------------
-- C.2. PROYECTO — Proyecto principal
-- ------------------------------------------------------------
CREATE TABLE proyecto (
    id_proyecto     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    alcance         TEXT,
    exclusiones     TEXT,
    
    -- Triple restricción
    valor_total     DECIMAL(18,2),
    moneda          VARCHAR(3) DEFAULT 'COP',
    
    -- Fechas
    fecha_inicio    DATE,
    fecha_fin       DATE,
    fecha_objetivo_cierre DATE,
    
    -- Patrocinador
    patrocinador_id UUID REFERENCES persona(id_persona),
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    -- URLs
    url_repositorio TEXT,
    url_drive       TEXT,
    url_jira        TEXT,
    
    -- Metadatos
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE proyecto IS 'Proyecto maestro con triple restricción';

-- ------------------------------------------------------------
-- C.3. PROYECTO FASE — Instancias de fase en el proyecto
-- ------------------------------------------------------------
CREATE TABLE proyecto_fase (
    id_proyecto_fase UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto      UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_fase          INTEGER NOT NULL REFERENCES fase_pm2(id_fase),
    
    fecha_inicio_plan DATE,
    fecha_fin_plan    DATE,
    fecha_inicio_real DATE,
    fecha_fin_real    DATE,
    
    avance_pct        DECIMAL(5,2) DEFAULT 0.00,
    
    id_estado         INTEGER REFERENCES estado(id_estado),
    observaciones     TEXT,
    
    created_at        TIMESTAMPTZ DEFAULT NOW(),
    updated_at        TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, id_fase)
);

COMMENT ON TABLE proyecto_fase IS 'Fases PM2 instanciadas en cada proyecto con fechas reales';

-- ------------------------------------------------------------
-- C.4. TAREA — WBS completa
-- ------------------------------------------------------------
CREATE TABLE tarea (
    id_tarea        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_proyecto_fase UUID REFERENCES proyecto_fase(id_proyecto_fase),
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Jerarquía WBS
    id_tarea_padre  UUID REFERENCES tarea(id_tarea),
    nivel_wbs       INTEGER DEFAULT 1,
    es_entregable   BOOLEAN DEFAULT FALSE,
    es_hito         BOOLEAN DEFAULT FALSE,
    
    -- Plan
    fecha_inicio_plan DATE,
    fecha_fin_plan  DATE,
    duracion_dias_plan INTEGER,
    esfuerzo_horas_plan DECIMAL(8,2),
    
    -- Real
    fecha_inicio_real DATE,
    fecha_fin_real  DATE,
    duracion_dias_real INTEGER,
    esfuerzo_horas_real DECIMAL(8,2),
    
    -- Avance
    avance_pct      DECIMAL(5,2) DEFAULT 0.00,
    es_critica      BOOLEAN DEFAULT FALSE,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    observaciones   TEXT,
    url_github      TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

COMMENT ON TABLE tarea IS 'Work Breakdown Structure: fases, entregables, actividades, tareas';

-- ------------------------------------------------------------
-- C.5. ENTREGABLE — Productos finales
-- ------------------------------------------------------------
CREATE TABLE entregable (
    id_entregable   UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tarea        UUID REFERENCES tarea(id_tarea),
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    version         VARCHAR(10) DEFAULT '1.0',
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    fecha_entrega   DATE,
    fecha_aprobacion DATE,
    aprobado_por    UUID REFERENCES persona(id_persona),
    
    url_github      TEXT,
    url_drive       TEXT,
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

COMMENT ON TABLE entregable IS 'Productos finales del proyecto con versiones y aprobaciones';

-- ------------------------------------------------------------
-- C.6. EQUIPO PROYECTO — Personas asignadas al proyecto
-- ------------------------------------------------------------
CREATE TABLE equipo_proyecto (
    id_equipo       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_persona      UUID NOT NULL REFERENCES persona(id_persona) ON DELETE CASCADE,
    id_rol          INTEGER REFERENCES rol(id_rol),
    
    dedicacion_pct  INTEGER DEFAULT 100,
    fecha_inicio    DATE,
    fecha_fin       DATE,
    
    es_responsable  BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, id_persona, id_rol)
);

COMMENT ON TABLE equipo_proyecto IS 'Matriz de asignación de personas a proyectos';

-- ------------------------------------------------------------
-- C.7. STAKEHOLDER — Matriz de interesados
-- ------------------------------------------------------------
CREATE TABLE stakeholder (
    id_stakeholder  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_persona      UUID REFERENCES persona(id_persona),
    
    nombre          VARCHAR(100) NOT NULL,
    tipo            VARCHAR(50) CHECK (tipo IN ('interno','externo','cliente','regulador','financiador','usuario','comunidad')),
    
    influencia      INTEGER CHECK (influencia BETWEEN 1 AND 5),
    interes         INTEGER CHECK (interes BETWEEN 1 AND 5),
    estrategia      TEXT,  -- "Gestionar de cerca","Mantener satisfecho","Monitorear mínimo","Mantener informado"
    
    comunicacion_preferida VARCHAR(50),
    frecuencia_comunicacion VARCHAR(50),
    
    expectativas    TEXT,
    preocupaciones  TEXT,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE stakeholder IS 'Matriz de stakeholders con influencia/interés';

-- ------------------------------------------------------------
-- C.8. RIESGO — Matriz de riesgos
-- ------------------------------------------------------------
CREATE TABLE riesgo (
    id_riesgo       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_categoria_riesgo INTEGER REFERENCES categoria_riesgo(id_categoria_riesgo),
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    causa           TEXT,
    efecto          TEXT,
    
    probabilidad    INTEGER CHECK (probabilidad BETWEEN 1 AND 5),
    impacto         INTEGER CHECK (impacto BETWEEN 1 AND 5),
    nivel_riesgo    INTEGER GENERATED ALWAYS AS (probabilidad * impacto) STORED,
    
    estrategia      VARCHAR(20) CHECK (estrategia IN ('evitar','mitigar','transferir','aceptar')),
    accion_mitigacion TEXT,
    accion_contingencia TEXT,
    
    responsable_id  UUID REFERENCES persona(id_persona),
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    fecha_identificacion DATE,
    fecha_revision    DATE,
    
    url_evidencia   TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

COMMENT ON TABLE riesgo IS 'Matriz de riesgos con probabilidad, impacto y estrategia';

-- ------------------------------------------------------------
-- C.9. DOCUMENTO — Gestión documental
-- ------------------------------------------------------------
CREATE TABLE documento (
    id_documento    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tipo_doc     INTEGER REFERENCES tipo_documento(id_tipo_doc),
    id_entregable   UUID REFERENCES entregable(id_entregable),
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    version         VARCHAR(10) DEFAULT '1.0',
    
    autor_id        UUID REFERENCES persona(id_persona),
    revisor_id      UUID REFERENCES persona(id_persona),
    aprobador_id    UUID REFERENCES persona(id_persona),
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    url_archivo     TEXT,
    url_drive       TEXT,
    url_github      TEXT,
    
    fecha_creacion  DATE,
    fecha_revision  DATE,
    fecha_aprobacion DATE,
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

COMMENT ON TABLE documento IS 'Gestión documental con versiones y aprobaciones';

-- ------------------------------------------------------------
-- C.10. REUNIÓN — Actas de reunión
-- ------------------------------------------------------------
CREATE TABLE reunion (
    id_reunion      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tipo_reunion INTEGER REFERENCES tipo_reunion(id_tipo_reunion),
    
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    objetivo        TEXT,
    
    fecha           DATE,
    hora_inicio     TIME,
    hora_fin        TIME,
    lugar           VARCHAR(200),
    url_meet        TEXT,
    
    agenda          TEXT,
    conclusiones    TEXT,
    acuerdos        TEXT,
    compromisos     TEXT,
    
    moderador_id    UUID REFERENCES persona(id_persona),
    secretario_id   UUID REFERENCES persona(id_persona),
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    url_acta        TEXT,
    url_github      TEXT,
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

COMMENT ON TABLE reunion IS 'Actas de reunión con agenda, conclusiones y acuerdos';

-- ------------------------------------------------------------
-- C.11. REUNIÓN PARTICIPANTE
-- ------------------------------------------------------------
CREATE TABLE reunion_participante (
    id_rp           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_reunion      UUID NOT NULL REFERENCES reunion(id_reunion) ON DELETE CASCADE,
    id_persona      UUID NOT NULL REFERENCES persona(id_persona) ON DELETE CASCADE,
    
    asistio         BOOLEAN DEFAULT FALSE,
    compromiso      TEXT,
    fecha_compromiso DATE,
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE reunion_participante IS 'Asistencia y compromisos por participante';

-- ------------------------------------------------------------
-- C.12. NOTA PROYECTO
-- ------------------------------------------------------------
CREATE TABLE nota_proyecto (
    id_nota         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    tipo            VARCHAR(30) CHECK (tipo IN ('decision','aprendizaje','idea','recordatorio','alerta','otro')),
    titulo          VARCHAR(200) NOT NULL,
    contenido       TEXT,
    
    autor_id        UUID REFERENCES persona(id_persona),
    
    es_destacada    BOOLEAN DEFAULT FALSE,
    es_publica      BOOLEAN DEFAULT TRUE,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

COMMENT ON TABLE nota_proyecto IS 'Notas rápidas: decisiones, aprendizajes, ideas, recordatorios';

-- ------------------------------------------------------------
-- C.13. SPRINT (para proyectos ágiles)
-- ------------------------------------------------------------
CREATE TABLE sprint (
    id_sprint       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_proyecto_fase UUID REFERENCES proyecto_fase(id_proyecto_fase),
    
    numero          INTEGER NOT NULL,
    nombre          VARCHAR(100),
    objetivo        TEXT,
    
    fecha_inicio    DATE,
    fecha_fin       DATE,
    
    puntos_plan     INTEGER,
    puntos_real     INTEGER,
    
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, numero)
);

COMMENT ON TABLE sprint IS 'Sprints para metodologías ágiles vinculadas a fases PM2';

-- ============================================================
-- C.14. TABLAS ADICIONALES v1.1
-- ============================================================

CREATE TABLE plan_comunicacion (
    id_plan_com     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    frecuencia      VARCHAR(50),
    formato         VARCHAR(50),
    canal           VARCHAR(50),
    id_stakeholder  UUID REFERENCES stakeholder(id_stakeholder),
    id_persona      UUID REFERENCES persona(id_persona),
    responsable_id  UUID REFERENCES persona(id_persona),
    contenido_tipo  VARCHAR(50),
    plantilla_url   TEXT,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE comunicacion_registro (
    id_comunicacion UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    tipo            VARCHAR(30) NOT NULL,
    direccion       VARCHAR(10),
    asunto          VARCHAR(200) NOT NULL,
    contenido       TEXT,
    remitente_id    UUID REFERENCES persona(id_persona),
    destinatario_id UUID REFERENCES persona(id_persona),
    canal           VARCHAR(50),
    formato         VARCHAR(50),
    url_archivo     TEXT,
    url_drive       TEXT,
    id_estado       INTEGER REFERENCES estado(id_estado),
    fecha_envio     TIMESTAMPTZ,
    fecha_recepcion TIMESTAMPTZ,
    fecha_lectura   TIMESTAMPTZ,
    es_respuesta_a  UUID REFERENCES comunicacion_registro(id_comunicacion),
    requiere_respuesta BOOLEAN DEFAULT FALSE,
    fecha_respuesta_limite DATE,
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    ticket_externo  VARCHAR(50),
    hash_contenido  VARCHAR(64),
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE decision (
    id_decision     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    contexto        TEXT,
    opciones        TEXT,
    opcion_elegida  TEXT,
    justificacion   TEXT,
    propuesto_por   UUID REFERENCES persona(id_persona),
    aprobado_por    UUID REFERENCES persona(id_persona),
    fecha_propuesta DATE,
    fecha_decision  DATE,
    fecha_ejecucion DATE,
    impacto_alcance BOOLEAN DEFAULT FALSE,
    impacto_tiempo  BOOLEAN DEFAULT FALSE,
    impacto_costo   BOOLEAN DEFAULT FALSE,
    impacto_calidad BOOLEAN DEFAULT FALSE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    url_acta        TEXT,
    url_github      TEXT,
    es_estrategica  BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE cambio (
    id_cambio       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    tipo_origen     VARCHAR(30),
    solicitado_por  UUID REFERENCES persona(id_persona),
    impacto_alcance TEXT,
    impacto_tiempo_dias INTEGER DEFAULT 0,
    impacto_costo   DECIMAL(18,2) DEFAULT 0,
    impacto_calidad TEXT,
    id_estado       INTEGER REFERENCES estado(id_estado),
    aprobado_por    UUID REFERENCES persona(id_persona),
    fecha_aprobacion DATE,
    responsable_id  UUID REFERENCES persona(id_persona),
    fecha_implementacion DATE,
    id_entregable_afectado UUID REFERENCES entregable(id_entregable),
    url_documento   TEXT,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE control_calidad (
    id_qa           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_entregable   UUID REFERENCES entregable(id_entregable),
    id_tarea        UUID REFERENCES tarea(id_tarea),
    id_documento    UUID REFERENCES documento(id_documento),
    revision_numero INTEGER DEFAULT 1,
    tipo_revision   VARCHAR(30),
    revisor_id      UUID REFERENCES persona(id_persona),
    aprobador_id    UUID REFERENCES persona(id_persona),
    id_estado       INTEGER REFERENCES estado(id_estado),
    resultado       VARCHAR(20),
    observaciones   TEXT,
    correcciones    TEXT,
    fecha_solicitud DATE,
    fecha_revision  DATE,
    fecha_correccion DATE,
    fecha_aprobacion DATE,
    url_evidencia   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE pago (
    id_pago         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    numero_pago     INTEGER NOT NULL,
    descripcion     VARCHAR(200),
    monto           DECIMAL(18,2) NOT NULL,
    moneda          VARCHAR(3) DEFAULT 'COP',
    porcentaje      DECIMAL(5,2),
    condicion       TEXT,
    id_estado       INTEGER REFERENCES estado(id_estado),
    fecha_vencimiento DATE,
    fecha_facturacion DATE,
    fecha_pago_real   DATE,
    id_entregable_vinculado UUID REFERENCES entregable(id_entregable),
    numero_factura  VARCHAR(50),
    url_factura     TEXT,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE leccion_aprendida (
    id_leccion      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20),
    categoria       VARCHAR(30),
    situacion       TEXT NOT NULL,
    accion_tomada   TEXT,
    resultado       TEXT,
    aprendizaje     TEXT NOT NULL,
    recomendacion   TEXT,
    aplicable_a     TEXT,
    reportado_por   UUID REFERENCES persona(id_persona),
    fecha_ocurrencia DATE,
    fecha_registro   DATE DEFAULT CURRENT_DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    es_positiva     BOOLEAN DEFAULT FALSE,
    url_evidencia   TEXT,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE adquisicion (
    id_adquisicion  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20),
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    tipo            VARCHAR(30),
    proveedor_nombre VARCHAR(100),
    proveedor_contacto VARCHAR(100),
    proveedor_email  VARCHAR(255),
    proveedor_telefono VARCHAR(20),
    monto           DECIMAL(18,2),
    moneda          VARCHAR(3) DEFAULT 'COP',
    fecha_solicitud DATE,
    fecha_aprobacion DATE,
    fecha_contratacion DATE,
    fecha_entrega   DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    responsable_id  UUID REFERENCES persona(id_persona),
    url_contrato    TEXT,
    url_orden_compra TEXT,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE configuracion_proyecto (
    id_config       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    clave           VARCHAR(50) NOT NULL,
    valor           TEXT,
    tipo_dato       VARCHAR(20),
    descripcion     TEXT,
    es_publico      BOOLEAN DEFAULT FALSE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, clave)
);

CREATE TABLE historial_avance (
    id_historial    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    fecha_registro  DATE NOT NULL DEFAULT CURRENT_DATE,
    semana_numero   INTEGER,
    avance_real     DECIMAL(5,2) DEFAULT 0.00,
    avance_planificado DECIMAL(5,2) DEFAULT 0.00,
    desviacion      DECIMAL(5,2) DEFAULT 0.00,
    tareas_completadas INTEGER DEFAULT 0,
    tareas_totales     INTEGER DEFAULT 0,
    tareas_retrasadas  INTEGER DEFAULT 0,
    riesgos_activos    INTEGER DEFAULT 0,
    incidentes_abiertos INTEGER DEFAULT 0,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- C.15. TABLAS v2.0 (Completitud PM2)
-- ============================================================

CREATE TABLE requisito (
    id_requisito    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT NOT NULL,
    tipo            VARCHAR(20),
    categoria_rnf   VARCHAR(50),
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_entregable_vinculado UUID REFERENCES entregable(id_entregable),
    criterio_aceptacion TEXT,
    metodo_prueba       TEXT,
    origen          VARCHAR(100),
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE trazabilidad (
    id_trazabilidad UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_requisito    UUID REFERENCES requisito(id_requisito) ON DELETE CASCADE,
    id_entregable   UUID REFERENCES entregable(id_entregable) ON DELETE CASCADE,
    id_tarea        UUID REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_qa           UUID REFERENCES control_calidad(id_qa) ON DELETE CASCADE,
    tipo_enlace     VARCHAR(50),
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_requisito, id_entregable, tipo_enlace)
);

CREATE TABLE tarea_dependencia (
    id_dependencia  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tarea_origen UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_tarea_destino UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    tipo_relacion   VARCHAR(5) DEFAULT 'FS',
    lag_dias        INTEGER DEFAULT 0,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_tarea_origen, id_tarea_destino, tipo_relacion)
);

CREATE TABLE tarea_recurso (
    id_tarea_recurso UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto      UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    id_tarea         UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_persona       UUID REFERENCES persona(id_persona) ON DELETE CASCADE,
    horas_planificadas  DECIMAL(8,2) DEFAULT 0,
    horas_reales        DECIMAL(8,2) DEFAULT 0,
    fecha_inicio_asignacion DATE,
    fecha_fin_asignacion    DATE,
    rol_en_tarea     VARCHAR(100),
    observaciones    TEXT,
    created_at       TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE hito (
    id_hito         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    fecha_plan      DATE NOT NULL,
    fecha_real      DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    id_tarea_generadora UUID REFERENCES tarea(id_tarea),
    id_entregable_generador UUID REFERENCES entregable(id_entregable),
    es_obligatorio  BOOLEAN DEFAULT TRUE,
    es_pago_vinculado BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE presupuesto_rubro (
    id_rubro        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(100) NOT NULL,
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
    cantidad        DECIMAL(12,2) DEFAULT 1,
    unidad          VARCHAR(20),
    costo_unitario  DECIMAL(18,2) NOT NULL,
    costo_total_plan DECIMAL(18,2) GENERATED ALWAYS AS (cantidad * costo_unitario) STORED,
    cantidad_real   DECIMAL(12,2) DEFAULT 0,
    costo_unitario_real DECIMAL(18,2) DEFAULT 0,
    costo_total_real DECIMAL(18,2) GENERATED ALWAYS AS (cantidad_real * costo_unitario_real) STORED,
    responsable_id  UUID REFERENCES persona(id_persona),
    fecha_estimada  DATE,
    fecha_real      DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE recurso_material (
    id_recurso      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    tipo            VARCHAR(30),
    descripcion     TEXT,
    proveedor       VARCHAR(100),
    cantidad        INTEGER DEFAULT 1,
    disponible_desde DATE,
    disponible_hasta DATE,
    costo_adquisicion DECIMAL(18,2),
    moneda          VARCHAR(3) DEFAULT 'COP',
    ubicacion       VARCHAR(100),
    id_estado       INTEGER REFERENCES estado(id_estado),
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE tarea_recurso_material (
    id_trm          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_tarea        UUID NOT NULL REFERENCES tarea(id_tarea) ON DELETE CASCADE,
    id_recurso      UUID NOT NULL REFERENCES recurso_material(id_recurso) ON DELETE CASCADE,
    cantidad_usada  DECIMAL(8,2) DEFAULT 1,
    fecha_uso       DATE,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE issue (
    id_issue        UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    categoria       VARCHAR(30),
    severidad       VARCHAR(20),
    id_riesgo_origen UUID REFERENCES riesgo(id_riesgo),
    id_tarea_afectada UUID REFERENCES tarea(id_tarea),
    id_entregable_afectado UUID REFERENCES entregable(id_entregable),
    causa_raiz      TEXT,
    accion_correctiva TEXT,
    accion_preventiva TEXT,
    reportado_por   UUID REFERENCES persona(id_persona),
    asignado_a      UUID REFERENCES persona(id_persona),
    fecha_reporte   DATE DEFAULT CURRENT_DATE,
    fecha_resolucion DATE,
    id_estado       INTEGER REFERENCES estado(id_estado),
    impacto_tiempo_dias INTEGER DEFAULT 0,
    impacto_costo   DECIMAL(18,2) DEFAULT 0,
    impacto_alcance TEXT,
    url_evidencia   TEXT,
    observaciones   TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE acta_cierre (
    id_cierre       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    codigo          VARCHAR(20) NOT NULL,
    nombre          VARCHAR(200) NOT NULL,
    fecha_inicio_real DATE,
    fecha_fin_real    DATE,
    duracion_real_dias INTEGER,
    objetivos_cumplidos   TEXT,
    entregables_entregados TEXT,
    entregables_pendientes TEXT,
    costo_final         DECIMAL(18,2),
    desviacion_costo    DECIMAL(18,2),
    desviacion_tiempo_dias INTEGER,
    desviacion_alcance  TEXT,
    satisfaccion_cliente  INTEGER CHECK (satisfaccion_cliente BETWEEN 1 AND 5),
    cumplimiento_requisitos_pct DECIMAL(5,2),
    url_documento_cierre  TEXT,
    url_repositorio_final TEXT,
    elaborado_por     UUID REFERENCES persona(id_persona),
    aprobado_por      UUID REFERENCES persona(id_persona),
    id_estado         INTEGER REFERENCES estado(id_estado),
    fecha_elaboracion DATE DEFAULT CURRENT_DATE,
    fecha_aprobacion   DATE,
    observaciones     TEXT,
    created_at        TIMESTAMPTZ DEFAULT NOW(),
    updated_at        TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(id_proyecto, codigo)
);

CREATE TABLE caso_negocio (
    id_caso         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    problema_negocio    TEXT,
    oportunidad         TEXT,
    analisis_costo_beneficio TEXT,
    roi_esperado_pct    DECIMAL(5,2),
    roi_real_pct        DECIMAL(5,2),
    payback_meses       INTEGER,
    beneficios_cualitativos TEXT,
    beneficios_cuantitativos TEXT,
    kpis_exito          TEXT,
    id_estado           INTEGER REFERENCES estado(id_estado),
    elaborado_por       UUID REFERENCES persona(id_persona),
    aprobado_por        UUID REFERENCES persona(id_persona),
    fecha_elaboracion   DATE,
    fecha_aprobacion    DATE,
    observaciones       TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW(),
    updated_at          TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE estandar_proceso (
    id_estandar     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    codigo          VARCHAR(20) NOT NULL UNIQUE,
    nombre          VARCHAR(200) NOT NULL,
    tipo            VARCHAR(30),
    descripcion     TEXT,
    version         VARCHAR(10) DEFAULT '1.0',
    url_plantilla   TEXT,
    contenido       TEXT,
    aplicable_a     VARCHAR(100),
    aprobado_por    UUID REFERENCES persona(id_persona),
    fecha_aprobacion DATE,
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

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

CREATE TABLE auditoria (
    id_auditoria    UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tabla_afectada  VARCHAR(50) NOT NULL,
    id_registro     UUID NOT NULL,
    id_proyecto     UUID REFERENCES proyecto(id_proyecto),
    tipo_accion     VARCHAR(20),
    campo_afectado  VARCHAR(50),
    valor_anterior  TEXT,
    valor_nuevo     TEXT,
    ejecutado_por   UUID REFERENCES persona(id_persona),
    fecha_ejecucion TIMESTAMPTZ DEFAULT NOW(),
    ip_origen       VARCHAR(45),
    observaciones   TEXT
);

-- ============================================================
-- D. ÍNDICES
-- ============================================================

CREATE INDEX idx_estado_categoria ON pm2.estado(categoria);
CREATE INDEX idx_persona_tipo ON pm2.persona(tipo);
CREATE INDEX idx_persona_activo ON pm2.persona(activo);
CREATE INDEX idx_proyecto_estado ON pm2.proyecto(id_estado);
CREATE INDEX idx_proyecto_codigo ON pm2.proyecto(codigo);
CREATE INDEX idx_tarea_proyecto ON pm2.tarea(id_proyecto);
CREATE INDEX idx_tarea_padre ON pm2.tarea(id_tarea_padre);
CREATE INDEX idx_tarea_estado ON pm2.tarea(id_estado);
CREATE INDEX idx_tarea_fase ON pm2.tarea(id_proyecto_fase);
CREATE INDEX idx_entregable_proyecto ON pm2.entregable(id_proyecto);
CREATE INDEX idx_entregable_tarea ON pm2.entregable(id_tarea);
CREATE INDEX idx_entregable_estado ON pm2.entregable(id_estado);
CREATE INDEX idx_equipo_proyecto ON pm2.equipo_proyecto(id_proyecto);
CREATE INDEX idx_equipo_persona ON pm2.equipo_proyecto(id_persona);
CREATE INDEX idx_stakeholder_proyecto ON pm2.stakeholder(id_proyecto);
CREATE INDEX idx_riesgo_proyecto ON pm2.riesgo(id_proyecto);
CREATE INDEX idx_riesgo_nivel ON pm2.riesgo(nivel_riesgo);
CREATE INDEX idx_documento_proyecto ON pm2.documento(id_proyecto);
CREATE INDEX idx_reunion_proyecto ON pm2.reunion(id_proyecto);
CREATE INDEX idx_reunion_fecha ON pm2.reunion(fecha);
CREATE INDEX idx_nota_proyecto ON pm2.nota_proyecto(id_proyecto);
CREATE INDEX idx_sprint_proyecto ON pm2.sprint(id_proyecto);

CREATE INDEX idx_plan_com_proyecto ON pm2.plan_comunicacion(id_proyecto);
CREATE INDEX idx_comunicacion_proyecto ON pm2.comunicacion_registro(id_proyecto);
CREATE INDEX idx_comunicacion_tipo ON pm2.comunicacion_registro(tipo);
CREATE INDEX idx_decision_proyecto ON pm2.decision(id_proyecto);
CREATE INDEX idx_cambio_proyecto ON pm2.cambio(id_proyecto);
CREATE INDEX idx_qa_proyecto ON pm2.control_calidad(id_proyecto);
CREATE INDEX idx_pago_proyecto ON pm2.pago(id_proyecto);
CREATE INDEX idx_leccion_proyecto ON pm2.leccion_aprendida(id_proyecto);
CREATE INDEX idx_adquisicion_proyecto ON pm2.adquisicion(id_proyecto);
CREATE INDEX idx_config_proyecto ON pm2.configuracion_proyecto(id_proyecto);
CREATE INDEX idx_historial_proyecto ON pm2.historial_avance(id_proyecto);

CREATE INDEX idx_requisito_proyecto ON pm2.requisito(id_proyecto);
CREATE INDEX idx_requisito_tipo ON pm2.requisito(tipo);
CREATE INDEX idx_trazabilidad_proyecto ON pm2.trazabilidad(id_proyecto);
CREATE INDEX idx_tarea_dep_origen ON pm2.tarea_dependencia(id_tarea_origen);
CREATE INDEX idx_tarea_dep_destino ON pm2.tarea_dependencia(id_tarea_destino);
CREATE INDEX idx_tarea_recurso_tarea ON pm2.tarea_recurso(id_tarea);
CREATE INDEX idx_hito_proyecto ON pm2.hito(id_proyecto);
CREATE INDEX idx_presupuesto_rubro ON pm2.presupuesto_rubro(id_proyecto);
CREATE INDEX idx_presupuesto_item_rubro ON pm2.presupuesto_item(id_rubro);
CREATE INDEX idx_recurso_mat_proyecto ON pm2.recurso_material(id_proyecto);
CREATE INDEX idx_issue_proyecto ON pm2.issue(id_proyecto);
CREATE INDEX idx_cierre_proyecto ON pm2.acta_cierre(id_proyecto);
CREATE INDEX idx_auditoria_tabla ON pm2.auditoria(tabla_afectada);
CREATE INDEX idx_auditoria_proyecto ON pm2.auditoria(id_proyecto);

-- ============================================================
-- E. VISTAS
-- ============================================================

CREATE VIEW v_proyecto_resumen AS
SELECT
    p.id_proyecto,
    p.codigo,
    p.nombre,
    p.valor_total,
    p.moneda,
    p.fecha_inicio,
    p.fecha_fin,
    CASE WHEN p.fecha_inicio IS NOT NULL AND p.fecha_fin IS NOT NULL
         THEN (CURRENT_DATE - p.fecha_inicio)::INTEGER
         ELSE NULL END AS dias_transcurridos,
    e.nombre AS estado,
    pr.nombre AS prioridad,
    per.nombres || ' ' || per.apellidos AS patrocinador
FROM pm2.proyecto p
LEFT JOIN pm2.estado e ON p.id_estado = e.id_estado
LEFT JOIN pm2.prioridad pr ON p.id_prioridad = pr.id_prioridad
LEFT JOIN pm2.persona per ON p.patrocinador_id = per.id_persona;

CREATE VIEW v_tareas_por_estado AS
SELECT
    p.id_proyecto,
    p.nombre AS proyecto,
    e.nombre AS estado,
    COUNT(*) AS cantidad,
    SUM(CASE WHEN t.es_critica THEN 1 ELSE 0 END) AS criticas
FROM pm2.tarea t
JOIN pm2.proyecto p ON t.id_proyecto = p.id_proyecto
LEFT JOIN pm2.estado e ON t.id_estado = e.id_estado
GROUP BY p.id_proyecto, p.nombre, e.nombre;

CREATE VIEW v_riesgos_activos AS
SELECT
    p.id_proyecto,
    p.nombre AS proyecto,
    r.codigo,
    r.nombre,
    r.probabilidad,
    r.impacto,
    r.nivel_riesgo,
    r.estrategia,
    e.nombre AS estado,
    per.nombres || ' ' || per.apellidos AS responsable
FROM pm2.riesgo r
JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto
LEFT JOIN pm2.estado e ON r.id_estado = e.id_estado
LEFT JOIN pm2.persona per ON r.responsable_id = per.id_persona
WHERE r.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('cerrado','mitigado','aceptado'));

CREATE VIEW v_equipo_asignado AS
SELECT
    p.codigo AS proyecto_codigo,
    p.nombre AS proyecto,
    per.nombres || ' ' || per.apellidos AS persona,
    per.email,
    r.nombre AS rol,
    ep.dedicacion_pct,
    ep.fecha_inicio,
    ep.fecha_fin,
    CASE WHEN ep.es_responsable THEN 'SÍ' ELSE 'NO' END AS es_responsable
FROM pm2.equipo_proyecto ep
JOIN pm2.proyecto p ON ep.id_proyecto = p.id_proyecto
JOIN pm2.persona per ON ep.id_persona = per.id_persona
LEFT JOIN pm2.rol r ON ep.id_rol = r.id_rol
WHERE per.activo = TRUE;

CREATE VIEW v_proyecto_avance AS
SELECT
    p.id_proyecto,
    p.nombre AS proyecto,
    f.nombre AS fase,
    pf.fecha_inicio_real,
    pf.fecha_fin_real,
    pf.avance_pct,
    e.nombre AS estado
FROM pm2.proyecto_fase pf
JOIN pm2.proyecto p ON pf.id_proyecto = p.id_proyecto
JOIN pm2.fase_pm2 f ON pf.id_fase = f.id_fase
LEFT JOIN pm2.estado e ON pf.id_estado = e.id_estado;

CREATE VIEW v_comunicaciones_dashboard AS
SELECT
    c.id_proyecto,
    p.nombre AS proyecto,
    c.tipo,
    c.direccion,
    COUNT(*) AS total,
    SUM(CASE WHEN c.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'completada') THEN 1 ELSE 0 END) AS respondidas,
    SUM(CASE WHEN c.requiere_respuesta = TRUE AND c.fecha_respuesta_limite < CURRENT_DATE THEN 1 ELSE 0 END) AS vencidas
FROM pm2.comunicacion_registro c
JOIN pm2.proyecto p ON c.id_proyecto = p.id_proyecto
GROUP BY c.id_proyecto, p.nombre, c.tipo, c.direccion;

CREATE VIEW v_pagos_dashboard AS
SELECT
    p.id_proyecto,
    pr.nombre AS proyecto,
    COUNT(*) AS total_pagos,
    SUM(p.monto) AS monto_total,
    SUM(CASE WHEN p.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'pagado') THEN p.monto ELSE 0 END) AS monto_pagado,
    SUM(CASE WHEN p.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'pendiente') THEN p.monto ELSE 0 END) AS monto_pendiente,
    SUM(CASE WHEN p.id_estado IN (SELECT id_estado FROM pm2.estado WHERE codigo = 'vencido') THEN p.monto ELSE 0 END) AS monto_vencido
FROM pm2.pago p
JOIN pm2.proyecto pr ON p.id_proyecto = pr.id_proyecto
GROUP BY p.id_proyecto, pr.nombre;

CREATE VIEW v_calidad_dashboard AS
SELECT
    q.id_proyecto,
    p.nombre AS proyecto,
    COUNT(*) AS total_revisiones,
    SUM(CASE WHEN q.resultado = 'aprobado' THEN 1 ELSE 0 END) AS aprobados,
    SUM(CASE WHEN q.resultado = 'rechazado' THEN 1 ELSE 0 END) AS rechazados,
    SUM(CASE WHEN q.resultado = 'aprobado_con_obs' THEN 1 ELSE 0 END) AS aprobados_con_obs,
    SUM(CASE WHEN q.resultado = 'pendiente' THEN 1 ELSE 0 END) AS pendientes,
    ROUND(100.0 * SUM(CASE WHEN q.resultado = 'aprobado' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS tasa_aprobacion
FROM pm2.control_calidad q
JOIN pm2.proyecto p ON q.id_proyecto = p.id_proyecto
GROUP BY q.id_proyecto, p.nombre;

CREATE VIEW v_decisiones_pendientes AS
SELECT
    d.id_proyecto,
    p.nombre AS proyecto,
    d.codigo,
    d.nombre,
    d.descripcion,
    d.fecha_propuesta,
    d.fecha_decision,
    e.nombre AS estado,
    COALESCE(prop.nombres || ' ' || prop.apellidos, 'Sin asignar') AS propuesto_por,
    COALESCE(apro.nombres || ' ' || apro.apellidos, 'Sin asignar') AS aprobado_por,
    d.es_estrategica
FROM pm2.decision d
JOIN pm2.proyecto p ON d.id_proyecto = p.id_proyecto
LEFT JOIN pm2.estado e ON d.id_estado = e.id_estado
LEFT JOIN pm2.persona prop ON d.propuesto_por = prop.id_persona
LEFT JOIN pm2.persona apro ON d.aprobado_por = apro.id_persona
WHERE d.id_estado NOT IN (SELECT id_estado FROM pm2.estado WHERE codigo IN ('aprobado','rechazado','cerrado','implementado'));

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
-- F. DATOS DE CATÁLOGO (Estados, Prioridades, Fases, etc.)
-- ============================================================

-- F.1. ESTADOS
INSERT INTO pm2.estado (codigo, nombre, categoria, color_hex, descripcion, orden) VALUES
('borrador', 'BORRADOR', 'general', '#9E9E9E', 'Documento o tarea en borrador', 1),
('pendiente', 'PENDIENTE', 'general', '#FFC107', 'Pendiente de acción', 2),
('en_progreso', 'EN PROGRESO', 'general', '#2196F3', 'En ejecución activa', 3),
('en_revision', 'EN REVISIÓN', 'general', '#FF9800', 'En proceso de revisión', 4),
('aprobado', 'APROBADO', 'general', '#4CAF50', 'Aprobado y validado', 5),
('completado', 'COMPLETADO', 'general', '#8BC34A', 'Trabajo finalizado', 6),
('cerrado', 'CERRADO', 'general', '#9E9E9E', 'Caso cerrado', 7),
('cancelado', 'CANCELADO', 'general', '#F44336', 'Cancelado o descartado', 8),
('rechazado', 'RECHAZADO', 'general', '#F44336', 'Rechazado', 9),
('activo', 'ACTIVO', 'general', '#4CAF50', 'Entidad activa', 10),
('inactivo', 'INACTIVO', 'general', '#9E9E9E', 'Entidad inactiva', 11),
('alto', 'ALTO', 'riesgo', '#F44336', 'Riesgo alto', 12),
('medio', 'MEDIO', 'riesgo', '#FF9800', 'Riesgo medio', 13),
('bajo', 'BAJO', 'riesgo', '#4CAF50', 'Riesgo bajo', 14),
('planificado', 'PLANIFICADO', 'tarea', '#9E9E9E', 'Tarea planificada', 15),
('en_desarrollo', 'EN DESARROLLO', 'tarea', '#2196F3', 'Tarea en desarrollo', 16),
('finalizado', 'FINALIZADO', 'tarea', '#8BC34A', 'Tarea finalizada', 17),
('validado', 'VALIDADO', 'tarea', '#4CAF50', 'Tarea validada por QA', 18),
('no_alcanzado', 'NO ALCANZADO', 'hito', '#F44336', 'Hito no alcanzado', 19),
('programado', 'PROGRAMADO', 'hito', '#9E9E9E', 'Hito programado', 20),
('alcanzado', 'ALCANZADO', 'hito', '#4CAF50', 'Hito alcanzado', 21),
('abierto', 'ABIERTO', 'issue', '#F44336', 'Issue abierto', 22),
('en_analisis', 'EN ANÁLISIS', 'issue', '#FFC107', 'Analizando causa raíz', 23),
('accion_plan', 'ACCIÓN PLANEADA', 'issue', '#FF9800', 'Acción correctiva planeada', 24),
('resuelto', 'RESUELTO', 'issue', '#4CAF50', 'Issue resuelto', 25),
('solicitado', 'SOLICITADO', 'adquisicion', '#FFC107', 'Solicitud creada', 26),
('cotizacion', 'EN COTIZACIÓN', 'adquisicion', '#FF9800', 'Esperando cotizaciones', 27),
('contratado', 'CONTRATADO', 'adquisicion', '#2196F3', 'Contrato firmado', 28),
('entregado', 'ENTREGADO', 'adquisicion', '#8BC34A', 'Producto/Servicio entregado', 29),
('pendiente_pago', 'PENDIENTE', 'pago', '#FFC107', 'Pago pendiente de facturación', 30),
('facturado', 'FACTURADO', 'pago', '#FF9800', 'Factura emitida', 31),
('pagado', 'PAGADO', 'pago', '#4CAF50', 'Pago recibido', 32),
('vencido_pago', 'VENCIDO', 'pago', '#F44336', 'Pago vencido', 33),
('borrador_req', 'BORRADOR', 'requisito', '#9E9E9E', 'Requisito en borrador', 34),
('analisis_req', 'EN ANÁLISIS', 'requisito', '#FFC107', 'En análisis de viabilidad', 35),
('aprobado_req', 'APROBADO', 'requisito', '#4CAF50', 'Requisito aprobado', 36),
('implementado_req', 'IMPLEMENTADO', 'requisito', '#2196F3', 'Implementado en entregable', 37),
('propuesta', 'PROPUESTA', 'decision', '#FFC107', 'Decisión propuesta', 38),
('aprobada', 'APROBADA', 'decision', '#4CAF50', 'Decisión aprobada', 39),
('implementada', 'IMPLEMENTADA', 'decision', '#2196F3', 'Decisión implementada', 40),
('solicitado_cambio', 'SOLICITADO', 'cambio', '#FFC107', 'Cambio solicitado', 41),
('evaluacion', 'EN EVALUACIÓN', 'cambio', '#FF9800', 'Evaluando impacto', 42),
('aprobado_cambio', 'APROBADO', 'cambio', '#4CAF50', 'Cambio aprobado', 43),
('implementado_cambio', 'IMPLEMENTADO', 'cambio', '#2196F3', 'Cambio implementado', 44),
('enviado', 'ENVIADO', 'comunicacion', '#2196F3', 'Enviado, esperando respuesta', 45),
('respondido', 'RESPONDIDO', 'comunicacion', '#4CAF50', 'Respuesta recibida', 46),
('vencido', 'VENCIDO', 'comunicacion', '#F44336', 'Sin respuesta dentro del plazo', 47);

-- F.2. PRIORIDADES
INSERT INTO pm2.prioridad (codigo, nombre, color_hex, valor_numerico, descripcion) VALUES
('critico', 'CRÍTICO', '#F44336', 1, 'Requiere atención inmediata'),
('alto', 'ALTO', '#FF9800', 2, 'Alta prioridad de resolución'),
('medio', 'MEDIO', '#FFC107', 3, 'Prioridad media'),
('bajo', 'BAJO', '#4CAF50', 4, 'Baja prioridad'),
('minimo', 'MÍNIMO', '#9E9E9E', 5, 'Prioridad mínima o informativo');

-- F.3. FASES PM2
INSERT INTO pm2.fase_pm2 (codigo, nombre, descripcion, orden, color_hex) VALUES
('iniciacion', 'INICIACIÓN', 'Definir el proyecto, obtener autorización y establecer bases', 1, '#4CAF50'),
('planificacion', 'PLANIFICACIÓN', 'Desarrollar plan detallado de alcance, tiempo, costos, calidad, recursos, comunicaciones, riesgos y adquisiciones', 2, '#2196F3'),
('ejecucion', 'EJECUCIÓN', 'Coordinar personas y recursos, gestionar expectativas, producir entregables', 3, '#FF9800'),
('control', 'CONTROL', 'Monitorear y controlar trabajo, medir desviaciones, aplicar acciones correctivas', 4, '#9C27B0'),
('cierre', 'CIERRE', 'Finalizar actividades, entregar producto, documentar lecciones aprendidas', 5, '#607D8B');

-- F.4. TIPOS DE DOCUMENTO
INSERT INTO pm2.tipo_documento (codigo, nombre, descripcion, extension_defecto) VALUES
('acta', 'ACTA', 'Acta de reunión, constitución o cierre', '.md'),
('especificacion', 'ESPECIFICACIÓN', 'Especificación técnica o funcional', '.md'),
('informe', 'INFORME', 'Informe de avance, estado o análisis', '.md'),
('cronograma', 'CRONOGRAMA', 'Cronograma o plan de trabajo', '.md'),
('presupuesto', 'PRESUPUESTO', 'Documento de presupuesto o costos', '.xlsx'),
('riesgo', 'RIESGO', 'Matriz o registro de riesgos', '.md'),
('calidad', 'CALIDAD', 'Plan o registro de calidad', '.md'),
('comunicacion', 'COMUNICACIÓN', 'Plan de comunicaciones', '.md'),
('adquisicion', 'ADQUISICIÓN', 'Documento de adquisición o contrato', '.md'),
('leccion', 'LECCIÓN APRENDIDA', 'Registro de lección aprendida', '.md');

-- F.5. CATEGORÍAS DE RIESGO
INSERT INTO pm2.categoria_riesgo (codigo, nombre, descripcion, color_hex) VALUES
('tecnico', 'TÉCNICO', 'Riesgos relacionados con tecnología, arquitectura, implementación', '#2196F3'),
('organizacional', 'ORGANIZACIONAL', 'Riesgos de recursos, equipo, habilidades, estructura', '#FF9800'),
('financiero', 'FINANCIERO', 'Riesgos de costos, presupuesto, flujo de caja', '#4CAF50'),
('calidad', 'CALIDAD', 'Riesgos de calidad del producto o proceso', '#9C27B0'),
('externo', 'EXTERNO', 'Riesgos del entorno: regulación, mercado, climático', '#F44336'),
('legal', 'LEGAL', 'Riesgos contractuales, normativos, litigios', '#607D8B');

-- F.6. ROLES
INSERT INTO pm2.rol (codigo, nombre, descripcion, nivel_jerarquico) VALUES
('director', 'DIRECTOR EJECUTIVO', 'Responsable último del proyecto, toma decisiones estratégicas', 1),
('patrocinador', 'PATROCINADOR', 'Financia o aprueba el proyecto desde la alta dirección o cliente', 1),
('gerente', 'GERENTE DE PROYECTO', 'Gestiona día a día el proyecto, coordina recursos y entregables', 2),
('analista', 'ANALISTA', 'Analiza requisitos, procesos y documentación', 3),
('desarrollador', 'DESARROLLADOR', 'Construye soluciones técnicas y software', 3),
('qa', 'ASESOR DE CALIDAD', 'Revisa calidad, documentación y cumplimiento', 3),
('legal', 'ASESOR LEGAL', 'Revisa aspectos contractuales y normativos', 3),
('comunicaciones', 'RESPONSABLE DE COMUNICACIONES', 'Gestiona comunicaciones con stakeholders', 3),
('stakeholder', 'STAKEHOLDER', 'Interesado externo con influencia en el proyecto', 2),
('consultor', 'CONSULTOR EXTERNO', 'Provee servicios especializados por contrato', 3);

-- F.7. TIPOS DE REUNIÓN
INSERT INTO pm2.tipo_reunion (codigo, nombre, descripcion) VALUES
('constitucion', 'CONSTITUCIÓN', 'Reunión de constitución del proyecto'),
('seguimiento', 'SEGUIMIENTO', 'Reunión periódica de seguimiento de avance'),
('revision', 'REVISIÓN TÉCNICA', 'Revisión de entregables o documentos técnicos'),
('planificacion', 'PLANIFICACIÓN', 'Sesión de planificación de fase o sprint'),
('emergencia', 'EMERGENCIA', 'Reunión convocada por problema crítico'),
('cierre', 'CIERRE', 'Reunión de cierre de fase o proyecto'),
('comite_direccion', 'COMITÉ DE DIRECCIÓN', 'Reunión del comité de dirección'),
('revision_salud', 'REVISIÓN DE SALUD', 'Revisión integral de estado del proyecto'),
('taller', 'TALLER / WORKSHOP', 'Sesión de trabajo colaborativo'),
('capacitacion', 'CAPACITACIÓN', 'Sesión de formación'),
('post_mortem', 'POST-MORTEM', 'Análisis tras cierre o incidente');

-- ============================================================
-- G. DATOS DEL PROYECTO IDC_2026_01
-- ============================================================

-- G.1. PERSONAS (8 confirmadas)
INSERT INTO pm2.persona (nombres, apellidos, email, telefono, organizacion, cargo, tipo, activo) VALUES
('Jelkin Zair', 'Carrillo Franco', 'jelkin@innovadataco.com', NULL, 'INNOVADATACO', 'CEO / Director Ejecutivo', 'interno', TRUE),
('Diana Marcela', 'Cáceres Valderrama', 'diana@innovadataco.com', NULL, 'INNOVADATACO', 'Dirección Jurídica Estratégica', 'interno', TRUE),
('ZEUS', NULL, 'zeus@innovadataco.com', NULL, 'INNOVADATACO', 'Gerente de Proyecto IA', 'interno', TRUE),
('Juan David', 'Carrillo', 'juan@innovadataco.com', NULL, 'INNOVADATACO', 'Agente IA Innovación', 'interno', TRUE),
('Zaira', 'Carrillo', 'zaira@innovadataco.com', NULL, 'INNOVADATACO', 'Agente IA Marketing', 'interno', TRUE),
('Daniel', 'Duarte', 'dduarte@transconsult.com', '+57 320 468 4930', 'TransConsult (IFC)', 'Líder Operativo', 'externo', TRUE),
('María Constanza', NULL, 'mconstanza@transconsult.com', NULL, 'TransConsult Colombia', 'Gerente', 'externo', TRUE),
('Otto', 'Fernández', 'ofernandez@proveedor.com', NULL, 'Proveedor Externo', 'Consultor Financiero', 'consultor', TRUE);

-- G.2. PROYECTO
INSERT INTO pm2.proyecto (codigo, nombre, descripcion, alcance, exclusiones, valor_total, moneda, fecha_inicio, fecha_fin, fecha_objetivo_cierre, patrocinador_id, id_estado, id_prioridad, url_repositorio)
SELECT
    'IDC-2026-01',
    'APP Chía-Girardot ITS',
    'Diseño conceptual y especificaciones técnicas del corredor Chía-Mondoñedo-Girardot (306 km) bajo Resolución 28675 de 2022. Contrato TC-PS-05-917-2026 con TransConsult Colombia.',
    '8 entregables técnicos ITS, 42 fichas técnicas (CC-01 a CC-42), especificaciones funcionales/no funcionales, arquitectura ITS + ConOps, plan indicativo + modelo de costos.',
    'Implementación física de sistemas, construcción de infraestructura, operación del sistema, mantenimiento post-entrega.',
    112000000.00,
    'COP',
    '2026-03-09',
    '2026-06-08',
    '2026-06-08',
    NULL,
    (SELECT id_estado FROM pm2.estado WHERE codigo = 'en_progreso'),
    (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = 'critico'),
    'https://github.com/Innovadataco/zeus-workspace'
WHERE NOT EXISTS (SELECT 1 FROM pm2.proyecto WHERE codigo = 'IDC-2026-01');

-- G.3. EQUIPO PROYECTO (5 internos + 2 externos asignados)
INSERT INTO pm2.equipo_proyecto (id_proyecto, id_persona, id_rol, dedicacion_pct, fecha_inicio, es_responsable)
SELECT p.id_proyecto, per.id_persona, r.id_rol, ep.dedicacion_pct, ep.fecha_inicio, ep.es_responsable
FROM pm2.proyecto p
CROSS JOIN (VALUES
    ((SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'director'), 100, '2026-03-09', TRUE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'diana@innovadataco.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'legal'), 50, '2026-03-09', FALSE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'gerente'), 100, '2026-03-09', FALSE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'juan@innovadataco.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'consultor'), 30, '2026-03-09', FALSE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'zaira@innovadataco.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'comunicaciones'), 30, '2026-03-09', FALSE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'dduarte@transconsult.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'stakeholder'), 100, '2026-03-09', FALSE),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'mconstanza@transconsult.com'), (SELECT id_rol FROM pm2.rol WHERE codigo = 'stakeholder'), 100, '2026-03-09', FALSE)
) AS ep(id_persona, id_rol, dedicacion_pct, fecha_inicio, es_responsable)
WHERE p.codigo = 'IDC-2026-01';

-- G.4. STAKEHOLDERS (8 total: 3 con persona + 5 institucionales)
INSERT INTO pm2.stakeholder (id_proyecto, id_persona, nombre, tipo, influencia, interes, estrategia, comunicacion_preferida, frecuencia_comunicacion, expectativas, id_estado)
SELECT p.id_proyecto, s.id_persona, s.nombre, s.tipo, s.influencia, s.interes, s.estrategia, s.comunicacion_preferida, s.frecuencia_comunicacion, s.expectativas, (SELECT id_estado FROM pm2.estado WHERE codigo = 'activo')
FROM pm2.proyecto p
CROSS JOIN (VALUES
    ((SELECT id_persona FROM pm2.persona WHERE email = 'dduarte@transconsult.com'), 'Daniel Duarte (TransConsult)', 'cliente', 5, 5, 'Gestionar de cerca', 'Email + Llamada', 'Semanal', 'Entregables a tiempo y calidad'),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'mconstanza@transconsult.com'), 'María Constanza (TransConsult)', 'cliente', 5, 5, 'Gestionar de cerca', 'Email', 'Quincenal', 'Supervisión gerencial y reportes'),
    (NULL, 'IFC (The World Bank Group)', 'financiador', 5, 3, 'Mantener informado', 'Reporte formal', 'Trimestral', 'Cumplimiento de contrato padre 7216694'),
    (NULL, 'Ministerio de Transporte Colombia', 'regulador', 4, 3, 'Mantener informado', 'Oficial', 'A demanda', 'Cumplimiento normativo Res. 28675/2022'),
    (NULL, 'ANI - Agencia Nacional de Infraestructura', 'regulador', 4, 4, 'Mantener satisfecho', 'Oficial', 'A demanda', 'Alineación con corredores viales'),
    (NULL, 'Usuarios del corredor vial (306 km)', 'usuario', 2, 5, 'Monitorear mínimo', 'App/Portal', 'Mensual', 'Mejora en movilidad y seguridad'),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'), 'Jelkin Carrillo (Innovadataco)', 'interno', 5, 5, 'Gestionar de cerca', 'Directo', 'Diaria', 'Éxito del proyecto y posicionamiento'),
    ((SELECT id_persona FROM pm2.persona WHERE email = 'diana@innovadataco.com'), 'Diana Cáceres (Innovadataco)', 'interno', 4, 4, 'Gestionar de cerca', 'Directo', 'Semanal', 'Protección legal y contractual')
) AS s(id_persona, nombre, tipo, influencia, interes, estrategia, comunicacion_preferida, frecuencia_comunicacion, expectativas)
WHERE p.codigo = 'IDC-2026-01';

-- G.5. PROYECTO FASE (5 fases PM2)
INSERT INTO pm2.proyecto_fase (id_proyecto, id_fase, fecha_inicio_plan, fecha_fin_plan, fecha_inicio_real, fecha_fin_real, avance_pct, id_estado)
SELECT p.id_proyecto, f.id_fase, pf.fecha_inicio_plan, pf.fecha_fin_plan, pf.fecha_inicio_real, pf.fecha_fin_real, pf.avance_pct, (SELECT id_estado FROM pm2.estado WHERE codigo = pf.estado_codigo)
FROM pm2.proyecto p
CROSS JOIN pm2.fase_pm2 f
CROSS JOIN (VALUES
    ((SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'iniciacion'), '2026-03-09', '2026-03-16', '2026-03-09', '2026-03-16', 100.00, 'completado'),
    ((SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'planificacion'), '2026-03-17', '2026-04-06', '2026-03-17', '2026-04-06', 100.00, 'completado'),
    ((SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'ejecucion'), '2026-04-07', '2026-05-31', '2026-04-07', NULL, 62.50, 'en_progreso'),
    ((SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'control'), '2026-04-07', '2026-06-07', '2026-04-07', NULL, 50.00, 'en_progreso'),
    ((SELECT id_fase FROM pm2.fase_pm2 WHERE codigo = 'cierre'), '2026-06-01', '2026-06-08', NULL, NULL, 0.00, 'pendiente')
) AS pf(id_fase, fecha_inicio_plan, fecha_fin_plan, fecha_inicio_real, fecha_fin_real, avance_pct, estado_codigo)
WHERE f.id_fase = pf.id_fase AND p.codigo = 'IDC-2026-01';

-- G.6. RIESGOS (3 confirmados en README)
INSERT INTO pm2.riesgo (id_proyecto, id_categoria_riesgo, codigo, nombre, descripcion, causa, efecto, probabilidad, impacto, estrategia, accion_mitigacion, accion_contingencia, responsable_id, id_estado, id_prioridad, fecha_identificacion)
SELECT p.id_proyecto, cr.id_categoria_riesgo, r.codigo, r.nombre, r.descripcion, r.causa, r.efecto, r.probabilidad, r.impacto, r.estrategia, r.accion_mitigacion, r.accion_contingencia, r.responsable_id, (SELECT id_estado FROM pm2.estado WHERE codigo = 'pendiente'), (SELECT id_prioridad FROM pm2.prioridad WHERE codigo = 'alto'), '2026-03-15'
FROM pm2.proyecto p
CROSS JOIN (VALUES
    ((SELECT id_categoria_riesgo FROM pm2.categoria_riesgo WHERE codigo = 'financiero'), 'R001', 'Aprobación E1-E3 bloquea Pago 1', 'Los entregables E1-E3 llevan semanas sin aprobación formal, lo que bloquea el desembolso del primer pago ($22.4M COP).', 'Retraso en revisión por parte de TransConsult/IFC', 'Congelamiento de flujo de caja de Innovadataco', 4, 5, 'mitigar', 'Escalar semanalmente a Daniel Duarte y María Constanza. Documentar estado de revisión.', 'Solicitar anticipo parcial o negociar pago condicional a entrega sin aprobación formal', (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com')),
    ((SELECT id_categoria_riesgo FROM pm2.categoria_riesgo WHERE codigo = 'externo'), 'R003', 'Dependencia INVIAS para validación', 'La validación técnica requiere alineación con INVIAS para el corredor de 306 km.', 'Procesos burocráticos de entidades estatales', 'Retraso en aprobación final y entrega del proyecto', 3, 3, 'mitigar', 'Iniciar contactos tempranos con INVIAS. Documentar requisitos normativos.', 'Ajustar cronograma con margen de 15 días para trámites estatales', (SELECT id_persona FROM pm2.persona WHERE email = 'diana@innovadataco.com')),
    ((SELECT id_categoria_riesgo FROM pm2.categoria_riesgo WHERE codigo = 'organizacional'), 'R005', 'Alcance no definido claramente en TOR', 'El Término de Referencia tiene ambigüedades que pueden generar interpretaciones divergentes.', 'Redacción imprecisa del TOR original', 'Solicitudes de cambio no previstas, costos adicionales, descontento del cliente', 3, 3, 'mitigar', 'Documentar supuestos y exclusiones formalmente. Obtener confirmación por escrito.', 'Activar comité de cambios formal con representantes de TransConsult e IFC', (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'))
) AS r(id_categoria_riesgo, codigo, nombre, descripcion, causa, efecto, probabilidad, impacto, estrategia, accion_mitigacion, accion_contingencia, responsable_id)
WHERE p.codigo = 'IDC-2026-01';

-- G.7. PAGOS (3 confirmados)
INSERT INTO pm2.pago (id_proyecto, numero_pago, descripcion, monto, moneda, porcentaje, condicion, id_estado, fecha_vencimiento)
SELECT p.id_proyecto, pg.numero, pg.descripcion, pg.monto, 'COP', pg.porcentaje, pg.condicion, (SELECT id_estado FROM pm2.estado WHERE codigo = pg.estado), pg.fecha_vencimiento
FROM pm2.proyecto p
CROSS JOIN (VALUES
    (1, 'Pago 1 - Desembolso inicial post-firma', 22400000.00, 20.00, 'pendiente_pago', '2026-03-20'),
    (2, 'Pago 2 - Aprobación E4-E5 (Fichas + Especificaciones)', 44800000.00, 40.00, 'pendiente_pago', '2026-05-15'),
    (3, 'Pago 3 - Entrega final E8 (Capacitación)', 44800000.00, 40.00, 'pendiente_pago', '2026-06-08')
) AS pg(numero, descripcion, monto, porcentaje, estado, fecha_vencimiento)
WHERE p.codigo = 'IDC-2026-01';

-- G.8. ADQUISICIÓN (1 confirmada: Otto Fernández)
INSERT INTO pm2.adquisicion (id_proyecto, codigo, nombre, descripcion, tipo, proveedor_nombre, proveedor_contacto, proveedor_email, monto, moneda, fecha_solicitud, fecha_aprobacion, fecha_contratacion, fecha_entrega, id_estado, responsable_id)
SELECT p.id_proyecto, 'ADQ-001', 'Modelo financiero + Estudio de mercado', 'Contratación de consultor externo para desarrollar modelo financiero del sistema ITS y estudio de mercado de tecnologías disponibles.', 'consultoria', 'Otto Fernández', 'Consultor Financiero', 'ofernandez@proveedor.com', 13000000.00, 'COP', '2026-05-01', '2026-05-05', '2026-05-05', '2026-05-25', (SELECT id_estado FROM pm2.estado WHERE codigo = 'contratado'), (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com')
FROM pm2.proyecto p
WHERE p.codigo = 'IDC-2026-01';

-- G.9. CONFIGURACIÓN PROYECTO
INSERT INTO pm2.configuracion_proyecto (id_proyecto, clave, valor, tipo_dato, descripcion, es_publico)
SELECT p.id_proyecto, c.clave, c.valor, c.tipo_dato, c.descripcion, c.es_publico
FROM pm2.proyecto p
CROSS JOIN (VALUES
    ('corredor_longitud_km', '306', 'numero', 'Longitud del corredor vial Chía-Girardot', TRUE),
    ('normativa_aplicable', 'Resolución 28675 de 2022', 'texto', 'Normativa ITS aplicable al proyecto', TRUE),
    ('contrato_padre_ifc', '7216694', 'texto', 'Contrato padre entre IFC y TransConsult', TRUE),
    ('sin_iva', 'true', 'booleano', 'El valor del contrato no incluye IVA', TRUE),
    ('commit_github_activo', '7dafa69', 'texto', 'Commit de referencia en repositorio GitHub', TRUE),
    ('total_fichas_its', '42', 'numero', 'Total de fichas técnicas a desarrollar (CC-01 a CC-42)', TRUE),
    ('fecha_actual_corte', '2026-05-14', 'fecha', 'Fecha de corte de la información confirmada', TRUE),
    ('pm2_es_primer_proyecto', 'true', 'booleano', 'Este es el primer proyecto de Innovadataco con metodología PM2 formal', TRUE)
) AS c(clave, valor, tipo_dato, descripcion, es_publico)
WHERE p.codigo = 'IDC-2026-01';

-- G.10. NOTAS IMPORTANTES
INSERT INTO pm2.nota_proyecto (id_proyecto, tipo, titulo, contenido, autor_id, es_destacada, es_publica)
SELECT p.id_proyecto, n.tipo, n.titulo, n.contenido, n.autor_id, n.es_destacada, n.es_publica
FROM pm2.proyecto p
CROSS JOIN (VALUES
    ('alerta', 'PAGO 1 BLOQUEADO', 'E1-E3 entregados el 27 marzo, 3 abril y 7 abril. Sin aprobación formal a 14 mayo 2026. Bloquea $22.4M COP.', (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'), TRUE, FALSE),
    ('decision', 'Contacto IFC indirecto', 'No existe contacto directo con IFC. Toda comunicación pasa por TransConsult (Daniel Duarte / María Constanza).', (SELECT id_persona FROM pm2.persona WHERE email = 'jelkin@innovadataco.com'), TRUE, FALSE),
    ('aprendizaje', 'Primera aplicación PM2', 'Este es el primer proyecto de Innovadataco con metodología PM2 completa. La base de datos y procesos se están construyendo junto con el proyecto.', (SELECT id_persona FROM pm2.persona WHERE email = 'zeus@innovadataco.com'), FALSE, TRUE)
) AS n(tipo, titulo, contenido, autor_id, es_destacada, es_publica)
WHERE p.codigo = 'IDC-2026-01';

-- ============================================================
-- H. VERIFICACIÓN FINAL
-- ============================================================

SELECT 'PROYECTO CREADO' AS verificacion, codigo, nombre, valor_total, fecha_inicio, fecha_fin
FROM pm2.proyecto WHERE codigo = 'IDC-2026-01';

SELECT 'PERSONAS' AS verificacion, COUNT(*) AS total FROM pm2.persona;
SELECT 'EQUIPO' AS verificacion, COUNT(*) AS total FROM pm2.equipo_proyecto ep JOIN pm2.proyecto p ON ep.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'STAKEHOLDERS' AS verificacion, COUNT(*) AS total FROM pm2.stakeholder s JOIN pm2.proyecto p ON s.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'FASES' AS verificacion, COUNT(*) AS total FROM pm2.proyecto_fase pf JOIN pm2.proyecto p ON pf.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'RIESGOS' AS verificacion, COUNT(*) AS total FROM pm2.riesgo r JOIN pm2.proyecto p ON r.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'PAGOS' AS verificacion, COUNT(*) AS total FROM pm2.pago pg JOIN pm2.proyecto p ON pg.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'ADQUISICIONES' AS verificacion, COUNT(*) AS total FROM pm2.adquisicion a JOIN pm2.proyecto p ON a.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'CONFIGURACIÓN' AS verificacion, COUNT(*) AS total FROM pm2.configuracion_proyecto c JOIN pm2.proyecto p ON c.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';
SELECT 'NOTAS' AS verificacion, COUNT(*) AS total FROM pm2.nota_proyecto n JOIN pm2.proyecto p ON n.id_proyecto = p.id_proyecto WHERE p.codigo = 'IDC-2026-01';

-- ============================================================
-- FIN DEL SCRIPT
-- Total: 42 tablas, 14 vistas, 8 catálogos, datos reales IDC_2026_01
-- ============================================================