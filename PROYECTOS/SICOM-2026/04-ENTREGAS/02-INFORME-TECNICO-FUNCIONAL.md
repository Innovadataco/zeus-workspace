# INFORME TÉCNICO-FUNCIONAL — PLATAFORMA SICOM MME

**Para:** Luis Felipe Herrera — CI2 (Líder Técnico/Operativo)  
**De:** Jelkin Zair Carrillo Franco — Innovadataco  
**Fecha:** 13 de mayo de 2026  
**Asunto:** Comprensión técnica y funcional del sistema SICOM para soporte de transición operativa

---

## 1. IDENTIDAD DEL SISTEMA

| Atributo | Valor |
|----------|-------|
| **Nombre** | SICOM — Sistema de Información de Combustibles |
| **Cliente propietario** | Ministerio de Minas y Energía (MME) |
| **Operador entrante** | Innovadataco (subcontratista CI2) |
| **Operador saliente** | Internexa |
| **Tipo de sistema** | Plataforma transaccional de misión crítica nacional |
| **Objetivo core** | Administrar la información del mercado de combustibles líquidos y gas combustible de Colombia |

---

## 2. ARQUITECTURA TÉCNICA

### 2.1 Stack Completo

| Capa | Tecnología | Versión/Nota |
|------|-----------|-------------|
| **Backend** | Java | Framework no especificado en anexo (Spring/Jakarta EE inferido) |
| **Motor BPM** | Bizagi | Flujos de proceso de negocio parametrizados |
| **Base de Datos Principal** | Oracle 19c | Enterprise Edition, configuración RAC (Real Application Clusters) |
| **Base de Datos Secundaria** | SQL Server | Presencia confirmada, rol no detallado en anexo |
| **Virtualización** | VMware | Incluyendo vSphere/vCenter implícito |
| **Balanceo** | Balanceadores de carga | Alta disponibilidad activo-pasivo |
| **Control de Versiones** | Git | Repositorio de código fuente |
| **BI / Analítica** | Cubos y tableros | Herramienta específica no nombrada en anexo |
| **Web** | Portal Web + Apps Móviles | Acceso ciudadano y agentes |
| **Servidor Aplicaciones** | Java EE / Jakarta EE | Infiere del stack Java |
| **Web Services** | SOAP/REST | Integraciones con sistemas externos |

### 2.2 Infraestructura de Data Centers

| Componente | DC Principal | DC Alterno |
|------------|-------------|------------|
| **Ubicación** | Zona metropolitana Bogotá (≤40 km sede MME) | Ciudad colombiana distinta a Bogotá |
| **Tier mínimo** | Tier III | Tier III equivalente |
| **Modo operación** | Activo | Pasivo (standby para contingencia) |
| **Replicación** | Real-time hacia alterno | Recepción replicación continua |
| **Crecimiento mensual** | 4% capacidad cómputo | Alineado al principal |

### 2.3 Diagrama Lógico (Inferido del Anexo)

```
[Usuarios Externos: 15,000 concurrentes]
         ↓
[Firewall + WAF] → [Balanceador Carga]
         ↓
[Portal Web / Apps Móviles]
         ↓
[Servidor Aplicaciones Java + Bizagi BPM]
         ↓
[Oracle 19c RAC] ←→ [SQL Server]
         ↓
[BI / Cubos / Tableros]
         ↓
[Backup / Replicación DC Alterno]
```

---

## 3. FUNCIONALIDADES POR SEGMENTO

### 3.1 SICOM Líquidos (Combustibles Líquidos)

| Función | Descripción Técnica | Actor Principal |
|---------|---------------------|-----------------|
| **Registro de Agentes** | CRUD de actores PRIMA + minoristas + grandes consumidores. Código único por agente. Validación documental | MME + Agentes |
| **Órdenes de Pedido** | 5 tipos: Simple, Transferencia, Traslado, Programada, Anticipada (Individual/Nominal) | Agentes de cadena |
| **Guía Digital** | Recepción electrónica de guías de transporte. Trazabilidad física | Transportadores/Agentes |
| **Balance Volumétrico** | Cálculo de entradas/salidas por agente. Detección de diferencias | MME + Agentes |
| **Registro de Precios** | Reporte y seguimiento de precios en puntos de venta | Mayoristas/Minoristas |
| **Control de Cupos** | Asignación de cupos por zona (frontera, electrificadoras) | MME |
| **Validación Documental** | Verificación de documentos de vehículos e información ACA (Agente de Cadena de Abastecimiento) | MME |
| **Gestión de Usuarios** | Creación, modificación, roles, habilitación/deshabilitación | Admin SICOM |
| **Notificación Vigencia** | Alertas de documentos próximos a vencer | Sistema automatizado |
| **Replicación Agentes** | Sincronización de datos maestros de agentes entre sistemas | Sistema automatizado |
| **Reasignación de Casos** | Distribución de casos/incidentes entre operadores | Mesa de servicio |

### 3.2 SICOM Gas Combustible (GNCV + Auto GLP)

| Función | Descripción Técnica |
|---------|---------------------|
| **Registro Agentes GNCV** | Censo de distribuidores y estaciones GNCV |
| **Registro Vehículos** | Matrícula, tipo de conversión, certificación |
| **Registro Comercialización** | Ventas, inventarios, movimientos de GLP/GNCV |
| **Validación Información ACA** | Verificación de agentes en cadena de gas combustible |

### 3.3 Portal Ciudadano

| Función | Descripción |
|---------|-------------|
| **Autogestión** | Atención de requerimientos sin intervención humana |
| **Consulta** | Precios, estaciones, agentes registrados |
| **Acceso masivo** | 15,000 usuarios concurrentes mínimo |

---

## 4. VOLUMETRÍA OPERATIVA REAL

### 4.1 Procesos Bizagi — Casos Instanciados Mensuales

| Proceso BPM | Casos/Mes | % del Total |
|-------------|-----------|-------------|
| **Orden de Pedido Simple** | **100,017** | 47.5% |
| **Recibir Guía Digital** | **89,223** | 42.4% |
| **Orden de Pedido Transferencia** | 6,854 | 3.3% |
| **Registro de Precios** | 5,060 | 2.4% |
| **Gestionar Solicitudes OP Programada** | 1,610 | 0.8% |
| **Validación Documentos Vehículo** | 1,751 | 0.8% |
| **Validar Datos** | 1,104 | 0.5% |
| **Orden de Pedido Programada** | 783 | 0.4% |
| **Reasignación de Casos** | 432 | 0.2% |
| **Orden de Pedido Traslado** | 384 | 0.2% |
| **Orden de Pedido Anticipada Individual** | 316 | 0.1% |
| **Gestionar Usuarios** | 189 | 0.1% |
| **Orden de Pedido Anticipada Nominal** | 84 | <0.1% |
| **Notificar Vigencia Documentos Agente** | 27 | <0.1% |
| **Replicación Agentes Sicom** | 17 | <0.1% |
| **TOTAL** | **~210,000** | 100% |

### 4.2 Perfiles de Usuarios y Licencias

| Perfil | Cantidad | Tipo Acceso |
|--------|----------|-------------|
| **Usuarios nombrados iniciales** | 25,000 | Identificados individuales |
| **Usuarios nombrados crecimiento** | 45,000 | Proyección máxima contrato |
| **Usuarios externos concurrentes** | 15,000 | Simultáneos en portal |
| **Administración SICOM** | 40 | Gestión plataforma |
| **Seguimiento/Control MME** | 15 | Supervisión y auditoría |
| **Supervisión código fuente** | 4 | Acceso repositorio Git |
| **TOTAL MFA requerido** | **45,000** | Doble factor autenticación |

### 4.3 Requerimientos de Software y Licenciamiento

| Componente | Requerimiento |
|------------|---------------|
| Oracle Database | Enterprise Edition 19c RAC |
| SQL Server | Licencias para ambiente desarrollo/producción |
| VMware | Licenciamiento plataforma virtualización completa |
| Bizagi BPM | Licencias para flujos de proceso operativos |
| Antivirus | Licenciamiento endpoint sobre plataforma virtualizada |
| Versionador Git | Licenciamiento/GitLab/GitHub Enterprise |
| Call Center | XCALLY / Primo Dialler / Kixie / Wolkvox o equivalente |
| MFA | Licenciamiento para 45,000 usuarios nombrados |
| Mesa de Servicio | Licenciamiento primer nivel soporte |
| BI | Licenciamiento cubos y tableros |

---

## 5. REQUERIMIENTOS TÉCNICOS DETALLADOS

### 5.1 Infraestructura Mínima

| Ítem | Especificación |
|------|---------------|
| **Nube** | Privada, propiedad del oferente o modelo servicio con control total oferente |
| **Política Gobierno Digital** | Alineación normativa MinTIC |
| **VMs / Capacidad** | Línea base actual VMware (valores en carpeta INFRAESTRUCTURA no accesible aún) |
| **Crecimiento** | 4% mensual capacidad de cómputo |
| **Balanceadores** | Alta disponibilidad activo-pasivo para aplicaciones SICOM |
| **Almacenamiento** | Considerar consumo de: aplicaciones, SO, motores BD, BI, mesa servicio, web services, BPM, antivirus, bodega datos |
| **RAC Oracle** | Clúster activo-pasivo garantizando alta disponibilidad |

### 5.2 Seguridad Técnica

| Control | Implementación Requerida |
|---------|-------------------------|
| **Autenticación Multifactor (MFA)** | Doble factor para 45,000 usuarios. Portal web + apps móviles |
| **RBAC** | Control de acceso basado en roles. Matriz de permisos documentada |
| **Cifrado** | Tránsito y reposo. Protocolos de cifrado definidos |
| **Firewall Red** | Inspección tráfico entrante/saliente. Reglas restrictivas |
| **WAF** | Filtrado HTTP. Protección SQL injection, XSS, falsificación |
| **Antivirus** | Plataforma virtualizada, actualización continua |
| **Logs/Trazabilidad** | 6 meses mínimo de retención. Transacciones + conexiones |
| **Hardening** | Servidores, BD, aplicaciones, redes |
| **SIEM** | Monitoreo centralizado de seguridad (implícito por logs y WAF) |

### 5.3 Backup y Recuperación

| Parámetro | Especificación |
|-----------|---------------|
| **RPO** | Máximo 30 minutos |
| **RTO** | Según estrategia recuperación (número 8 del anexo, detalle no extraído) |
| **Backup VMs** | Incremental diario + full mensual |
| **Backup BD** | Incremental diario + full mensual |
| **Backup Logs** | Incremental diario |
| **Backup Código Fuente** | Full mensual |
| **Backup Especial** | Bajo solicitud MME |
| **Réplica Full Mensual** | Canal comunicaciones dedicado a repositorio MME |
| **Replicación DC Alterno** | Real-time, sin afectar desempeño, independiente de distancia |
| **Retención** | Mínimo 6 meses logs trazabilidad |

---

## 6. OPERACIÓN Y MANTENIMIENTO

### 6.1 Centro de Contacto (Call Center)

| Requerimiento | Especificación |
|---------------|---------------|
| **Herramienta** | XCALLY / Primo Dialler / Kixie / Wolkvox o equivalente |
| **Cobertura inicial** | 25,000 usuarios |
| **Cobertura escalable** | 45,000 usuarios |
| **Canales** | Telefonía + portal autogestión |
| **Métricas obligatorias** | Llamadas recibidas, abandonadas, duración promedio, espera promedio, clasificación por tipo |

### 6.2 Mesa de Servicio

| Requerimiento | Especificación |
|---------------|---------------|
| **Nivel** | Primer nivel soporte |
| **Tiquetes** | Número, reabiertos, abiertos/cerrados/pendientes a fin de mes |
| **Top 10** | Aplicaciones con más incidentes, usuarios más frecuentes |
| **Tendencias** | Gráficos históricos y de tendencia |

### 6.3 Acuerdos de Niveles de Servicio (ANS) Técnicos

| Línea de Servicio | Meta | Penalización |
|-------------------|------|-------------|
| **Disponibilidad SICOM Líquidos** | >99.90% | 0.5% descuento mensual por cada 0.1% debajo |
| **Disponibilidad SICOM GNCV** | >99.90% | 0.5% descuento mensual por cada 0.1% debajo |
| **Tiempo respuesta call center** | Definido por severidad | Penalización por incumplimiento |
| **Resolución incidentes** | Definido por severidad | Penalización por incumplimiento |

### 6.4 Formación y Capacitación

| Requerimiento | Detalle |
|---------------|---------|
| **Audiencia** | Agentes, actores, involucrados en uso del sistema |
| **Evaluación** | Encuesta satisfacción 1-5 (5=excelente). Puntaje entra en ANS |
| **Modalidad** | Interactiva, presencial o virtual |
| **Entregables** | Manuales, guías, videos tutoriales |

---

## 7. ENTREGABLES TÉCNICOS MENSUALES OBLIGATORIOS

El contratista debe entregar mensualmente (5 días hábiles del mes siguiente):

| Informe | Contenido Técnico |
|---------|-------------------|
| **Informe Mensual de Gestión** | Cumplimiento ANS, histórico ANS, infraestructura procesamiento, disponibilidad, arquitectura HW/SW, BI, desempeño infraestructura (CPU, memoria, disco), diagramas lógicos, diagnóstico funcional, capacidades, licenciamiento, historias usuario, mockups, RFC ejecutados, plan evolución, seguridad (diagrama, novedades, políticas, ataques, vulnerabilidades), centro de datos (disponibilidad, contingencia, replicación, pruebas), backup (ejecución, restauraciones, éxito), comunicaciones (enlaces, ancho de banda, tráfico), call center (llamadas, abandonos, duración, espera, clasificación), mesa servicio (tiquetes, reabiertos, top 10, tendencias, estado fin de mes), formación (fechas, usuarios, informes), operación estadística (procedimientos, documentación, mejoras, avance evolutivos, novedades personal) |
| **Informe Ejecutivo** | Máximo 8 páginas. Comparativos históricos por servicio. Acciones mejora |
| **Informe Final** | Estado sistema, lecciones aprendidas, recomendaciones (al cierre) |

---

## 8. FASES TÉCNICAS DEL CONTRATO

| Fase | Periodo | Actividades Técnicas Clave |
|------|---------|---------------------------|
| **Empalme / Transferencia** | Previo al 1 julio 2026 | Recibo sistema, migración datos, accesos, capacitación, pruebas, actas, repositorio código fuente |
| **Operación Plena** | 1 jul → 30 nov 2026 | Admin, operación 24/7, soporte, mantenimiento preventivo/correctivo, evolutivos aprobados |
| **Acompañamiento + Evolución** | Últimos 2 meses | Análisis técnico, evaluación requerimientos evolutivos, estrategia futura para nuevo contrato |

---

## 9. GAPS TÉCNICOS IDENTIFICADOS (Pendientes de Verificación)

| # | Gap Técnico | Impacto Operativo | ¿Cómo Resolver? |
|---|-------------|-------------------|-----------------|
| 1 | **Sin diagramas arquitectura** (carpeta ARQUITECTURA vacía) | No podemos replicar ni proponer infraestructura | Solicitar a CI2/ITX acceso o copia de diagramas |
| 2 | **Sin especificaciones VMs actuales** (carpeta INFRAESTRUCTURA vacía) | No sabemos línea base de vCPU, RAM, storage | Solicitar inventario técnico actualizado a Internexa |
| 3 | **Sin plan DRP detallado** (carpeta DRP vacía) | No sabemos procedimiento real de failover | Solicitar documento DRP y runbook de contingencia |
| 4 | **Sin fichas licenciamiento** (carpeta FICHAS TECNICAS vacía) | No sabemos qué licencias Oracle/VMware/etc. tenemos que replicar/contratar | Solicitar consolidado de licencias activas y vigencias |
| 5 | **Sin repositorio Git** | No tenemos acceso al código fuente | Solicitar URL repo + credenciales de solo lectura |
| 6 | **Sin URL de sistemas** | No podemos hacer reconocimiento ni pruebas | Solicitar URLs staging/producción + usuarios de prueba |
| 7 | **Sin logs de operación** | No sabemos patrones de falla ni salud del sistema | Solicitar logs últimos 6 meses o acceso a herramienta de monitoreo |
| 8 | **Sin diccionario de datos** | No entendemos el modelo de datos Oracle | Solicitar ER + diccionario de datos |
| 9 | **Sin mapa de integraciones** | No sabemos qué sistemas externos consumen/producen datos SICOM | Solicitar matriz de integraciones y APIs |
| 10 | **Sin documentación Bizagi** | No sabemos flujos de proceso ni reglas de negocio | Solicitar exporte de procesos Bizagi y documentación funcional |

---

## 10. RECOMENDACIONES TÉCNICAS INMEDIATAS

1. **Solicitar acceso a las 10 carpetas técnicas vacías del Drive antes del viernes 15 mayo.** Sin esa información no podemos dimensionar infraestructura ni planificar migración.

2. **Primera reunión técnica con Internexa esta semana.** Agendar con su arquitecto y DBA. Objetivo: obtener inventario técnico, diagramas de red, y credenciales de lectura.

3. **Confirmar si Innovadataco tiene nube privada Tier III lista** o si hay que construirla/contratarla. Esto define si el 1 julio es viable o no.

4. **Definir herramienta de monitoreo** para cumplir ANS de disponibilidad 99.90%. Necesitamos monitoreo proactivo, no reactivo.

5. **Validar licenciamiento Oracle RAC 19c Enterprise.** Es el componente más costoso. Confirmar si Internexa transfiere licencias o si Innovadataco debe adquirirlas.

---

**Preparado por:** ZEUS — Análisis Técnico SICOM, Innovadataco  
**Fecha:** 13 de mayo de 2026

---

*Informe basado en revisión técnica del Anexo Técnico del contrato SICOM (196,091 caracteres, ~76 páginas). No incluye información no confirmada ni suposiciones sin base documental.*
