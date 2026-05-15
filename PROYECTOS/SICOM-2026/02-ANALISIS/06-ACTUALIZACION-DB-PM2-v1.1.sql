-- ============================================================
-- INNOVADATACO — BASE DE DATOS PROYECTOS PM2 v1.1
-- Actualización: Tablas faltantes para metodología PM2 completa
-- Fecha: 15 de mayo de 2026
-- ============================================================

SET search_path TO pm2, public;

-- ============================================================
-- TABLAS ADICIONALES PARA PM2 COMPLETO
-- ============================================================

-- --------------------------------------------------------------
-- 1. PLAN DE COMUNICACIONES
-- --------------------------------------------------------------
CREATE TABLE plan_comunicacion (
    id_plan_com     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    
    -- Frecuencia y formato
    frecuencia      VARCHAR(50),  -- "Diaria", "Semanal", "Quincenal", "Mensual", "Trimestral", "A demanda"
    formato         VARCHAR(50),  -- "Email", "PDF", "Reunión", "Dashboard", "Telegram", "Videollamada"
    canal           VARCHAR(50),  -- "Email", "Teams", "Meet", "Telegram", "Llamada", "Presencial"
    
    -- Destinatarios
    id_stakeholder  UUID REFERENCES stakeholder(id_stakeholder),
    id_persona      UUID REFERENCES persona(id_persona),
    
    -- Responsable de generar/enviar
    responsable_id  UUID REFERENCES persona(id_persona),
    
    -- Contenido esperado
    contenido_tipo  VARCHAR(50),  -- "Avance", "Ejecutivo", "Riesgos", "Alerta", "Formal", "Informe"
    plantilla_url   TEXT,
    
    activo          BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 2. REGISTRO DE COMUNICACIONES (Emails, informes, llamadas)
-- --------------------------------------------------------------
CREATE TABLE comunicacion_registro (
    id_comunicacion UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    tipo            VARCHAR(30) NOT NULL CHECK (tipo IN ('email','reunion','llamada','informe','alerta','decision','cambio','otro')),
    direccion       VARCHAR(10) CHECK (direccion IN ('entrada','salida','interna')),
    
    asunto          VARCHAR(200) NOT NULL,
    contenido       TEXT,
    
    remitente_id    UUID REFERENCES persona(id_persona),
    destinatario_id UUID REFERENCES persona(id_persona),
    
    -- Medio y formato
    canal           VARCHAR(50),  -- "Email", "Telegram", "Teams", "Meet", "Llamada"
    formato         VARCHAR(50),  -- "Texto", "PDF", "Word", "PowerPoint", "Excel"
    
    -- Archivos adjuntos
    url_archivo     TEXT,
    url_drive       TEXT,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    fecha_envio     TIMESTAMPTZ,
    fecha_recepcion TIMESTAMPTZ,
    fecha_lectura   TIMESTAMPTZ,
    
    -- Respuesta / seguimiento
    es_respuesta_a  UUID REFERENCES comunicacion_registro(id_comunicacion),
    requiere_respuesta BOOLEAN DEFAULT FALSE,
    fecha_respuesta_limite DATE,
    
    -- Prioridad
    id_prioridad    INTEGER REFERENCES prioridad(id_prioridad),
    
    -- Metadatos
    ticket_externo  VARCHAR(50),  -- ID en sistema externo (Gmail, etc.)
    hash_contenido  VARCHAR(64),
    
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 3. DECISIONES FORMALES (DEC-XXX)
-- --------------------------------------------------------------
CREATE TABLE decision (
    id_decision     UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "DEC-001", "DEC-002"
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Contexto
    contexto        TEXT,
    opciones        TEXT,  -- Opciones evaluadas (JSON o texto)
    opcion_elegida  TEXT,
    justificacion   TEXT,
    
    -- Autoridad
    propuesto_por   UUID REFERENCES persona(id_persona),
    aprobado_por    UUID REFERENCES persona(id_persona),
    
    -- Fechas
    fecha_propuesta DATE,
    fecha_decision  DATE,
    fecha_ejecucion DATE,
    
    -- Impacto
    impacto_alcance BOOLEAN DEFAULT FALSE,
    impacto_tiempo  BOOLEAN DEFAULT FALSE,
    impacto_costo   BOOLEAN DEFAULT FALSE,
    impacto_calidad BOOLEAN DEFAULT FALSE,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Documento asociado
    url_acta        TEXT,
    url_github      TEXT,
    
    es_estrategica  BOOLEAN DEFAULT FALSE,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- --------------------------------------------------------------
-- 4. SOLICITUDES DE CAMBIO
-- --------------------------------------------------------------
CREATE TABLE cambio (
    id_cambio       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20) NOT NULL,  -- "CHG-001"
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Origen
    tipo_origen     VARCHAR(30) CHECK (tipo_origen IN ('cliente','interno','regulatorio','tecnico','otro')),
    solicitado_por  UUID REFERENCES persona(id_persona),
    
    -- Análisis de impacto
    impacto_alcance TEXT,
    impacto_tiempo_dias INTEGER DEFAULT 0,
    impacto_costo   DECIMAL(18,2) DEFAULT 0,
    impacto_calidad TEXT,
    
    -- Estado del cambio
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Aprobación
    aprobado_por    UUID REFERENCES persona(id_persona),
    fecha_aprobacion DATE,
    
    -- Implementación
    responsable_id  UUID REFERENCES persona(id_persona),
    fecha_implementacion DATE,
    
    -- Relación con entregables
    id_entregable_afectado UUID REFERENCES entregable(id_entregable),
    
    url_documento   TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, codigo)
);

-- --------------------------------------------------------------
-- 5. CONTROL DE CALIDAD / QA
-- --------------------------------------------------------------
CREATE TABLE control_calidad (
    id_qa           UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    id_entregable   UUID REFERENCES entregable(id_entregable),
    id_tarea        UUID REFERENCES tarea(id_tarea),
    id_documento    UUID REFERENCES documento(id_documento),
    
    -- Revisión
    revision_numero INTEGER DEFAULT 1,
    tipo_revision   VARCHAR(30) CHECK (tipo_revision IN ('tecnica','legal','funcional','normativa','editorial','final')),
    
    -- Revisores
    revisor_id      UUID REFERENCES persona(id_persona),
    aprobador_id    UUID REFERENCES persona(id_persona),
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Resultado
    resultado       VARCHAR(20) CHECK (resultado IN ('aprobado','rechazado','aprobado_con_obs','pendiente')),
    observaciones   TEXT,
    correcciones    TEXT,
    
    -- Fechas
    fecha_solicitud DATE,
    fecha_revision  DATE,
    fecha_correccion DATE,
    fecha_aprobacion DATE,
    
    url_evidencia   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 6. PAGOS Y FACTURACIÓN
-- --------------------------------------------------------------
CREATE TABLE pago (
    id_pago         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    numero_pago     INTEGER NOT NULL,
    descripcion     VARCHAR(200),
    
    -- Montos
    monto           DECIMAL(18,2) NOT NULL,
    moneda          VARCHAR(3) DEFAULT 'COP',
    porcentaje      DECIMAL(5,2),  -- % del valor total
    
    -- Condiciones
    condicion       TEXT,  -- "Firma contrato", "Aprobación E4-E5", "Entrega final"
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Fechas
    fecha_vencimiento DATE,
    fecha_facturacion DATE,
    fecha_pago_real   DATE,
    
    -- Relación con entregables
    id_entregable_vinculado UUID REFERENCES entregable(id_entregable),
    
    -- Documentos
    numero_factura  VARCHAR(50),
    url_factura     TEXT,
    
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 7. LECCIONES APRENDIDAS
-- --------------------------------------------------------------
CREATE TABLE leccion_aprendida (
    id_leccion      UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20),
    categoria       VARCHAR(30) CHECK (categoria IN ('tecnico','proceso','comunicacion','gestion','calidad','contractual','otro')),
    
    situacion       TEXT NOT NULL,  -- ¿Qué pasó?
    accion_tomada   TEXT,            -- ¿Qué hicimos?
    resultado       TEXT,            -- ¿Qué resultado tuvo?
    aprendizaje     TEXT NOT NULL,   -- ¿Qué aprendimos?
    
    -- Recomendación
    recomendacion   TEXT,
    aplicable_a     TEXT,  -- Proyectos futuros donde aplica
    
    -- Autoría
    reportado_por   UUID REFERENCES persona(id_persona),
    
    -- Fecha
    fecha_ocurrencia DATE,
    fecha_registro   DATE DEFAULT CURRENT_DATE,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    es_positiva     BOOLEAN DEFAULT FALSE,  -- ¿Fue un éxito o un problema?
    
    url_evidencia   TEXT,
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 8. ADQUISICIONES / CONTRATOS / PROVEEDORES
-- --------------------------------------------------------------
CREATE TABLE adquisicion (
    id_adquisicion  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    codigo          VARCHAR(20),
    nombre          VARCHAR(200) NOT NULL,
    descripcion     TEXT,
    
    -- Tipo
    tipo            VARCHAR(30) CHECK (tipo IN ('servicio','producto','licencia','consultoria','infraestructura','otro')),
    
    -- Proveedor
    proveedor_nombre VARCHAR(100),
    proveedor_contacto VARCHAR(100),
    proveedor_email  VARCHAR(255),
    proveedor_telefono VARCHAR(20),
    
    -- Monto
    monto           DECIMAL(18,2),
    moneda          VARCHAR(3) DEFAULT 'COP',
    
    -- Fechas
    fecha_solicitud DATE,
    fecha_aprobacion DATE,
    fecha_contratacion DATE,
    fecha_entrega   DATE,
    
    -- Estado
    id_estado       INTEGER REFERENCES estado(id_estado),
    
    -- Responsable
    responsable_id  UUID REFERENCES persona(id_persona),
    
    -- Documentos
    url_contrato    TEXT,
    url_orden_compra TEXT,
    
    observaciones   TEXT,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- --------------------------------------------------------------
-- 9. CONFIGURACIÓN / PARAMETROS DEL PROYECTO
-- --------------------------------------------------------------
CREATE TABLE configuracion_proyecto (
    id_config       UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    id_proyecto     UUID NOT NULL REFERENCES proyecto(id_proyecto) ON DELETE CASCADE,
    
    clave           VARCHAR(50) NOT NULL,
    valor           TEXT,
    tipo_dato       VARCHAR(20) CHECK (tipo_dato IN ('texto','numero','fecha','booleano','json','url')),
    descripcion     TEXT,
    
    es_publico      BOOLEAN DEFAULT FALSE,
    
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    
    UNIQUE(id_proyecto, clave)
);

-- --------------------------------------------------------------
-- 10. HISTORIAL DE AVANCE (snapshot semanal)
-- --------------------------------------------------------------
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
-- ÍNDICES ADICIONALES
-- ============================================================

CREATE INDEX idx_plan_com_proyecto ON pm2.plan_comunicacion(id_proyecto);
CREATE INDEX idx_plan_com_stakeholder ON pm2.plan_comunicacion(id_stakeholder);

CREATE INDEX idx_comunicacion_proyecto ON pm2.comunicacion_registro(id_proyecto);
CREATE INDEX idx_comunicacion_tipo ON pm2.comunicacion_registro(tipo);
CREATE INDEX idx_comunicacion_fecha ON pm2.comunicacion_registro(fecha_envio);
CREATE INDEX idx_comunicacion_estado ON pm2.comunicacion_registro(id_estado);

CREATE INDEX idx_decision_proyecto ON pm2.decision(id_proyecto);
CREATE INDEX idx_decision_codigo ON pm2.decision(codigo);
CREATE INDEX idx_decision_estado ON pm2.decision(id_estado);

CREATE INDEX idx_cambio_proyecto ON pm2.cambio(id_proyecto);
CREATE INDEX idx_cambio_estado ON pm2.cambio(id_estado);
CREATE INDEX idx_cambio_entregable ON pm2.cambio(id_entregable_afectado);

CREATE INDEX idx_qa_proyecto ON pm2.control_calidad(id_proyecto);
CREATE INDEX idx_qa_entregable ON pm2.control_calidad(id_entregable);
CREATE INDEX idx_qa_estado ON pm2.control_calidad(id_estado);

CREATE INDEX idx_pago_proyecto ON pm2.pago(id_proyecto);
CREATE INDEX idx_pago_estado ON pm2.pago(id_estado);
CREATE INDEX idx_pago_numero ON pm2.pago(numero_pago);

CREATE INDEX idx_leccion_proyecto ON pm2.leccion_aprendida(id_proyecto);
CREATE INDEX idx_leccion_categoria ON pm2.leccion_aprendida(categoria);

CREATE INDEX idx_adquisicion_proyecto ON pm2.adquisicion(id_proyecto);
CREATE INDEX idx_adquisicion_estado ON pm2.adquisicion(id_estado);

CREATE INDEX idx_config_proyecto ON pm2.configuracion_proyecto(id_proyecto);
CREATE INDEX idx_config_clave ON pm2.configuracion_proyecto(clave);

CREATE INDEX idx_historial_proyecto ON pm2.historial_avance(id_proyecto);
CREATE INDEX idx_historial_fecha ON pm2.historial_avance(fecha_registro);

-- ============================================================
-- VISTAS ADICIONALES
-- ============================================================

-- Dashboard de comunicaciones
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

-- Dashboard de pagos
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

-- Dashboard de calidad
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

-- Matriz de decisiones
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

-- ============================================================
-- ESTADOS ADICIONALES PARA NUEVAS TABLAS
-- ============================================================

INSERT INTO pm2.estado (codigo, nombre, categoria, color_hex, descripcion, orden) VALUES
-- Estados para comunicaciones
('borrador', 'BORRADOR', 'comunicacion', '#9E9E9E', 'Comunicación en borrador', 1),
('enviado', 'ENVIADO', 'comunicacion', '#2196F3', 'Enviado, esperando respuesta', 2),
('respondido', 'RESPONDIDO', 'comunicacion', '#4CAF50', 'Respuesta recibida', 3),
('vencido', 'VENCIDO', 'comunicacion', '#F44336', 'Sin respuesta dentro del plazo', 4),

-- Estados para decisiones
('propuesta', 'PROPUESTA', 'decision', '#FFC107', 'Decisión propuesta, esperando aprobación', 1),
('aprobada', 'APROBADA', 'decision', '#4CAF50', 'Decisión aprobada', 2),
('rechazada', 'RECHAZADA', 'decision', '#F44336', 'Decisión rechazada', 3),
('implementada', 'IMPLEMENTADA', 'decision', '#2196F3', 'Decisión implementada', 4),

-- Estados para cambios
('solicitado', 'SOLICITADO', 'cambio', '#FFC107', 'Cambio solicitado', 1),
('evaluacion', 'EN EVALUACIÓN', 'cambio', '#FF9800', 'Evaluando impacto', 2),
('aprobado', 'APROBADO', 'cambio', '#4CAF50', 'Cambio aprobado', 3),
('implementado_cambio', 'IMPLEMENTADO', 'cambio', '#2196F3', 'Cambio implementado', 4),
('rechazado_cambio', 'RECHAZADO', 'cambio', '#F44336', 'Cambio rechazado', 5),

-- Estados para QA/Calidad
('pendiente_rev', 'PENDIENTE REVISIÓN', 'calidad', '#FFC107', 'Pendiente de revisión', 1),
('en_revision', 'EN REVISIÓN', 'calidad', '#FF9800', 'En proceso de revisión', 2),
('aprobado_qa', 'APROBADO QA', 'calidad', '#4CAF50', 'Aprobado por calidad', 3),
('rechazado_qa', 'RECHAZADO QA', 'calidad', '#F44336', 'Rechazado, requiere correcciones', 4),
('corregido', 'CORREGIDO', 'calidad', '#2196F3', 'Correcciones aplicadas', 5),

-- Estados para pagos
('pendiente_pago', 'PENDIENTE', 'pago', '#FFC107', 'Pago pendiente de facturación', 1),
('facturado', 'FACTURADO', 'pago', '#FF9800', 'Factura emitida', 2),
('pagado', 'PAGADO', 'pago', '#4CAF50', 'Pago recibido', 3),
('vencido_pago', 'VENCIDO', 'pago', '#F44336', 'Pago vencido', 4),
('cancelado_pago', 'CANCELADO', 'pago', '#9E9E9E', 'Pago cancelado', 5),

-- Estados para adquisiciones
('solicitado_adq', 'SOLICITADO', 'adquisicion', '#FFC107', 'Solicitud creada', 1),
('cotizacion', 'EN COTIZACIÓN', 'adquisicion', '#FF9800', 'Esperando cotizaciones', 2),
('aprobado_adq', 'APROBADO', 'adquisicion', '#4CAF50', 'Adquisición aprobada', 3),
('contratado', 'CONTRATADO', 'adquisicion', '#2196F3', 'Contrato firmado', 4),
('entregado', 'ENTREGADO', 'adquisicion', '#8BC34A', 'Producto/Servicio entregado', 5),
('cancelado_adq', 'CANCELADO', 'adquisicion', '#F44336', 'Cancelado', 6);

-- ============================================================
-- COMENTARIOS
-- ============================================================

COMMENT ON TABLE pm2.plan_comunicacion IS 'Plan de gestión de comunicaciones por proyecto y stakeholder';
COMMENT ON TABLE pm2.comunicacion_registro IS 'Registro de todas las comunicaciones formales (emails, informes, llamadas)';
COMMENT ON TABLE pm2.decision IS 'Decisiones formales del proyecto con trazabilidad DEC-XXX';
COMMENT ON TABLE pm2.cambio IS 'Solicitudes de cambio con análisis de impacto y aprobación';
COMMENT ON TABLE pm2.control_calidad IS 'Revisiones de calidad QA de entregables y documentos';
COMMENT ON TABLE pm2.pago IS 'Condiciones de pago, facturación y seguimiento de cobros';
COMMENT ON TABLE pm2.leccion_aprendida IS 'Lecciones aprendidas del proyecto para reutilización';
COMMENT ON TABLE pm2.adquisicion IS 'Adquisiciones, contratos y proveedores del proyecto';
COMMENT ON TABLE pm2.configuracion_proyecto IS 'Parámetros y configuración específica del proyecto';
COMMENT ON TABLE pm2.historial_avance IS 'Snapshot semanal del avance del proyecto';

-- ============================================================
-- FIN ACTUALIZACIÓN v1.1
-- ============================================================
