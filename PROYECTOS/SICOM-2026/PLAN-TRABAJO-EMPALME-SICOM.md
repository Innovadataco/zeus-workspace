# PLAN DE TRABAJO EMPALME SICOM — PM2 Innovadataco v1.0

**Gerente de Proyecto:** Jelkin Zair Carrillo Franco (CI2 / Innovadataco)
**Operador Saliente:** INTERNEXA S.A.
**Operador Entrante:** CI2
**Entidad:** Ministerio de Minas y Energía (MME)
**Contrato:** GGC-2034-2025
**Periodo Empalme:** 19 mayo — 30 junio 2026 (6 semanas)
**Inicio Operación CI2:** 01 julio 2026
**Vigencia Contrato:** 01 julio — 30 noviembre 2026 (5 meses)

---

## 1. FASE 0: PREPARACIÓN Y GOBIERNO (Semanas -1 a 1)

### 1.1 Actividades de Instalación del Proyecto

| ID | Actividad | Responsable | Inicio | Fin | Entregable |
|----|-----------|-------------|--------|-----|------------|
| P0.1 | Constitución formal del equipo de empalme | Jelkin | 19 may | 21 may | Acta de Constitución firmada |
| P0.2 | Designación de roles y responsabilidades | Jelkin | 19 may | 22 may | Matriz RACI |
| P0.3 | Apertura de canales de comunicación | Jelkin | 19 may | 22 may | Directorio de contactos, grupos Teams/Slack |
| P0.4 | Reunión de kickoff con INTERNEXA | Jelkin + Luis | 21 may | 21 may | Acta de reunión, acuerdos iniciales |
| P0.5 | Reunión de kickoff con MME (Elizabeth) | Luis | 22 may | 22 may | Acta de reunión, expectativas definidas |
| P0.6 | Definición de sala de crisis y protocolos de escalamiento | Jelkin | 22 may | 23 may | Protocolo de crisis, árbol de escalamiento |
| P0.7 | Configuración de herramientas de gestión (Jira/Monday/Notion) | Equipo CI2 | 22 may | 24 may | Workspace configurado, plantillas cargadas |
| P0.8 | Firma de acuerdos de confidencialidad (CI2 ↔ INTERNEXA) | Legal | 23 may | 25 may | NDAs firmados |
| P0.9 | Solicitud formal de acceso a plataformas (carta a INTERNEXA) | Jelkin | 23 may | 24 may | Carta formal con listado de accesos requeridos |

### 1.2 Entregables de Fase 0

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Acta de Constitución del Empalme | MME + INTERNEXA + CI2 | 21 may |
| 2 | Matriz RACI del equipo | Interno CI2 | 22 may |
| 3 | Directorio de contactos operativos | Todos | 22 may |
| 4 | Protocolo de crisis y escalamiento | Interno CI2 | 23 may |
| 5 | Carta de solicitud de acceso a plataformas | INTERNEXA | 24 may |
| 6 | NDAs firmados entre operadores | MME (copia) | 25 may |

---

## 2. FASE 1: INVENTARIO Y DOCUMENTACIÓN (Semanas 2-3)

### 2.1 Inventario Técnico Completo

| ID | Actividad | Responsable | Inicio | Fin | Entregable |
|----|-----------|-------------|--------|-----|------------|
| I1.1 | Inventario de servidores y VMs (catálogo completo) | DBA + SysAdmin | 26 may | 28 may | Catálogo de infraestructura |
| I1.2 | Inventario de bases de datos (Oracle, SQL Server) | DBA | 26 may | 29 may | Esquema de BD, diagramas ER |
| I1.3 | Inventario de aplicaciones (Java, BPM, Web, APPs) | Líder Técnico | 26 may | 30 may | Listado de apps, versiones, dependencias |
| I1.4 | Inventario de servicios web y APIs | Desarrollador Java | 27 may | 30 may | Catálogo de endpoints, contratos API |
| I1.5 | Inventario de BI (cubos, dashboards, ETLs) | Especialista BI | 27 may | 30 may | Documentación de cubos y flujos |
| I1.6 | Inventario de seguridad (firewalls, WAF, certificados) | Seguridad | 28 may | 31 may | Matriz de controles de seguridad |
| I1.7 | Inventario de redes y telecomunicaciones | Redes | 28 may | 31 may | Diagramas de red, VLANs, VPNs |
| I1.8 | Inventario de licenciamiento | Legal + Técnico | 29 may | 01 jun | Matriz de licencias, propiedad, vigencia |
| I1.9 | Inventario de documentación técnica existente | Líder Funcional | 29 may | 02 jun | Índice de documentos, estado de actualización |
| I1.10 | Inventario de usuarios y perfiles (SICOM, Call Center) | Admin SICOM | 30 may | 02 jun | Matriz de usuarios, roles, permisos |

### 2.2 Documentación Crítica a Obtener

| # | Documento | Fuente | Prioridad | Estado |
|---|-----------|--------|-----------|--------|
| 1 | Arquitectura de solución SICOM (diagramas) | INTERNEXA | CRÍTICA | Pendiente |
| 2 | Manual de instalación y configuración | INTERNEXA | CRÍTICA | Pendiente |
| 3 | Manual de administración (SO, BD, aplicaciones) | INTERNEXA | CRÍTICA | Pendiente |
| 4 | Manual de usuario (Web, APP móvil, Call Center) | INTERNEXA | ALTA | Pendiente |
| 5 | Procedimientos operativos estándar (SOPs) | INTERNEXA | ALTA | Pendiente |
| 6 | Documentación de procesos BPM | INTERNEXA | CRÍTICA | Pendiente |
| 7 | Código fuente (Java, BPM) en repositorio Git | INTERNEXA | CRÍTICA | Pendiente |
| 8 | Scripts de despliegue y automatización | INTERNEXA | ALTA | Pendiente |
| 9 | Plan de respaldos y procedimientos de restauración | INTERNEXA | CRÍTICA | Pendiente |
| 10 | Documentación de integraciones (Web Services, VIGIA) | INTERNEXA | ALTA | Pendiente |
| 11 | Matriz de indicadores y reportes del BI | INTERNEXA | MEDIA | Pendiente |
| 12 | Documentación de seguridad (políticas, procedimientos) | INTERNEXA | ALTA | Pendiente |
| 13 | Actas de reuniones y comités de seguimiento | MME + INTERNEXA | MEDIA | Pendiente |
| 14 | Informes mensuales de gestión históricos | INTERNEXA | MEDIA | Pendiente |

### 2.3 Entregables de Fase 1

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Catálogo de infraestructura completo | Jelkin + Luis | 28 may |
| 2 | Esquema de bases de datos | DBA CI2 | 29 may |
| 3 | Catálogo de aplicaciones y dependencias | Líder Técnico | 30 may |
| 4 | Matriz de licenciamiento | Legal CI2 | 01 jun |
| 5 | Índice de documentación técnica | Líder Funcional | 02 jun |
| 6 | Matriz de usuarios y perfiles | Admin SICOM | 02 jun |

---

## 3. FASE 2: ACCESO Y VALIDACIÓN (Semanas 3-4)

### 3.1 Obtención de Accesos

| ID | Actividad | Responsable | Inicio | Fin | Entregable |
|----|-----------|-------------|--------|-----|------------|
| A2.1 | Acceso a consolas de administración (VMware, AWS, Azure) | SysAdmin | 02 jun | 04 jun | Credenciales validadas |
| A2.2 | Acceso a bases de datos (Oracle, SQL Server) | DBA | 02 jun | 04 jun | Conexiones validadas |
| A2.3 | Acceso a repositorios de código (GitLab/GitHub) | Desarrolladores | 02 jun | 04 jun | Repositorios clonados |
| A2.4 | Acceso a plataforma ITSM (ServiceNow/Jira Service Desk) | Mesa de Servicio | 03 jun | 05 jun | Tickets de prueba creados |
| A2.5 | Acceso a plataforma de monitoreo (Nagios, Zabbix, Grafana) | Monitoreo | 03 jun | 05 jun | Dashboards visualizados |
| A2.6 | Acceso a consolas de seguridad (SIEM, WAF, Firewall) | Seguridad | 03 jun | 05 jun | Logs visualizados |
| A2.7 | Acceso a Call Center (software, grabaciones, reportes) | Call Center | 04 jun | 06 jun | Escucha de llamadas de prueba |
| A2.8 | Acceso a APPs móviles (ambiente de pruebas) | QA | 04 jun | 06 jun | APPs instaladas y funcionando |
| A2.9 | Acceso a portal web (administración) | Admin Web | 04 jun | 06 jun | Funcionalidades de admin validadas |
| A2.10 | Acceso a BI (cubos, dashboards, herramientas ETL) | BI | 05 jun | 07 jun | Cubos consultados |

### 3.2 Validación Técnica

| ID | Actividad | Responsable | Inicio | Fin | Criterio de Aceptación |
|----|-----------|-------------|--------|-----|------------------------|
| V2.1 | Validación de backups (existencia, integridad, restauración) | DBA | 05 jun | 08 jun | Backup restaurado exitosamente en ambiente de pruebas |
| V2.2 | Validación de código fuente (compilación, despliegue) | Desarrolladores | 05 jun | 08 jun | Código compila y despliega en ambiente de pruebas |
| V2.3 | Validación de documentación (completitud, actualidad) | Líder Funcional | 06 jun | 09 jun | 100% de documentos críticos recibidos y validados |
| V2.4 | Validación de plataforma Web (funcionalidad, rendimiento) | QA | 06 jun | 09 jun | 100% funcionalidades críticas operativas |
| V2.5 | Validación de APPs móviles (instalación, funcionalidad) | QA | 07 jun | 10 jun | APPs operativas en iOS y Android |
| V2.6 | Validación de BI (cubos, dashboards, ETLs) | BI | 07 jun | 10 jun | Cubos consultables, ETLs ejecutables |
| V2.7 | Validación de Call Center (llamadas, grabaciones, reportes) | Call Center | 08 jun | 11 jun | Llamada de prueba exitosa, grabación recuperable |
| V2.8 | Validación de seguridad (controles, certificados, logs) | Seguridad | 08 jun | 11 jun | 100% controles operativos, certificados vigentes |
| V2.9 | Validación de integraciones (Web Services, VIGIA) | Desarrolladores | 09 jun | 12 jun | Integraciones respondiendo correctamente |
| V2.10 | Validación de mesa de servicio (creación, escalamiento, cierre) | Mesa Servicio | 09 jun | 12 jun | Ciclo completo de ticket validado |

### 3.3 Entregables de Fase 2

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Matriz de accesos validados | Jelkin | 07 jun |
| 2 | Informe de validación técnica | Jelkin + Luis | 12 jun |
| 3 | Listado de gaps y riesgos identificados | Jelkin | 12 jun |
| 4 | Plan de mitigación de gaps | Jelkin + Equipo | 13 jun |

---

## 4. FASE 3: TRANSFERENCIA DE CONOCIMIENTO (Semanas 4-5)

### 4.1 Capacitaciones Técnicas

| ID | Actividad | Responsable | Inicio | Fin | Audiencia | Duración |
|----|-----------|-------------|--------|-----|-----------|----------|
| T3.1 | Capacitación: Arquitectura SICOM (infraestructura, componentes) | INTERNEXA | 10 jun | 11 jun | Equipo técnico CI2 | 4h |
| T3.2 | Capacitación: Administración Oracle (BD, backups, tuning) | DBA INTERNEXA | 11 jun | 12 jun | DBA CI2 | 8h |
| T3.3 | Capacitación: Desarrollo Java (código, despliegue, debugging) | Dev INTERNEXA | 12 jun | 13 jun | Devs Java CI2 | 8h |
| T3.4 | Capacitación: BPM (modelado, automatización, despliegue) | Dev BPM INTERNEXA | 13 jun | 14 jun | Devs BPM CI2 | 8h |
| T3.5 | Capacitación: Business Intelligence (cubos, ETLs, dashboards) | BI INTERNEXA | 14 jun | 15 jun | BI CI2 | 8h |
| T3.6 | Capacitación: Seguridad (controles, monitoreo, incidentes) | Seguridad INTERNEXA | 15 jun | 16 jun | Seguridad CI2 | 4h |
| T3.7 | Capacitación: Mesa de servicio (ITSM, procedimientos) | Mesa Servicio INTERNEXA | 16 jun | 17 jun | Mesa Servicio CI2 | 4h |
| T3.8 | Capacitación: Call Center (software, procedimientos, escalamiento) | Call Center INTERNEXA | 17 jun | 18 jun | Call Center CI2 | 4h |
| T3.9 | Capacitación: APPs móviles (instalación, soporte, troubleshooting) | QA INTERNEXA | 18 jun | 19 jun | QA + Soporte CI2 | 4h |
| T3.10 | Capacitación: Web Services e integraciones | Dev INTERNEXA | 19 jun | 20 jun | Devs CI2 | 4h |

### 4.2 Shadowing (Acompañamiento Operativo)

| ID | Actividad | Responsable | Inicio | Fin | Modalidad |
|----|-----------|-------------|--------|-----|-----------|
| S3.1 | Shadowing: Operación diaria SICOM (monitoreo, alertas) | Equipo INTERNEXA | 13 jun | 20 jun | Presencial/remoto, 8h/día |
| S3.2 | Shadowing: Mesa de servicio (atención tickets, escalamiento) | Mesa INTERNEXA | 13 jun | 20 jun | Presencial/remoto, 8h/día |
| S3.3 | Shadowing: Call Center (atención llamadas, registro) | Call Center INTERNEXA | 13 jun | 20 jun | Presencial/remoto, 8h/día |
| S3.4 | Shadowing: Administración BD (tareas diarias, backups) | DBA INTERNEXA | 13 jun | 20 jun | Presencial/remoto, 8h/día |
| S3.5 | Shadowing: Despliegues y cambios (procedimientos, ventanas) | Dev INTERNEXA | 15 jun | 22 jun | Presencial/remoto, 4h/día |
| S3.6 | Shadowing: Seguridad (monitoreo, respuesta incidentes) | Seguridad INTERNEXA | 15 jun | 22 jun | Presencial/remoto, 4h/día |
| S3.7 | Shadowing: Reportes y BI (ejecución ETLs, validación) | BI INTERNEXA | 17 jun | 24 jun | Presencial/remoto, 4h/día |

### 4.3 Entregables de Fase 3

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Plan de capacitación ejecutado | Jelkin | 20 jun |
| 2 | Material de capacitación (presentaciones, videos, manuales) | Equipo CI2 | 20 jun |
| 3 | Informe de shadowing (horas, temas cubiertos, evaluación) | Jelkin | 24 jun |
| 4 | Evaluación de competencias del equipo CI2 | Líder Técnico | 25 jun |
| 5 | Plan de refuerzo para competencias gap | Jelkin | 26 jun |

---

## 5. FASE 4: REPLICACIÓN Y PRUEBAS (Semanas 5-6)

### 5.1 Replicación de Ambientes

| ID | Actividad | Responsable | Inicio | Fin | Entregable |
|----|-----------|-------------|--------|-----|------------|
| R4.1 | Despliegue de ambiente de pruebas CI2 (replica de producción) | SysAdmin CI2 | 17 jun | 20 jun | Ambiente de pruebas operativo |
| R4.2 | Migración de datos de prueba (subset de producción) | DBA CI2 | 20 jun | 22 jun | Datos migrados, validados |
| R4.3 | Configuración de monitoreo CI2 (Nagios/Zabbix/Grafana) | Monitoreo CI2 | 20 jun | 22 jun | Dashboards operativos |
| R4.4 | Configuración de seguridad CI2 (WAF, firewall, SIEM) | Seguridad CI2 | 21 jun | 23 jun | Controles operativos |
| R4.5 | Configuración de backups CI2 (políticas, pruebas) | DBA CI2 | 21 jun | 23 jun | Backup exitoso, restauración validada |
| R4.6 | Configuración de Call Center CI2 (software, colas, agentes) | Call Center CI2 | 22 jun | 24 jun | Call Center operativo en pruebas |
| R4.7 | Configuración de mesa de servicio CI2 (ITSM, flujos) | Mesa CI2 | 22 jun | 24 jun | Tickets de prueba fluyen correctamente |

### 5.2 Pruebas de Aceptación

| ID | Actividad | Responsable | Inicio | Fin | Criterio de Aceptación |
|----|-----------|-------------|--------|-----|------------------------|
| P4.1 | Pruebas funcionales SICOM Web (100% casos de uso críticos) | QA CI2 | 24 jun | 26 jun | 100% casos pasan |
| P4.2 | Pruebas funcionales APPs móviles (iOS + Android) | QA CI2 | 24 jun | 26 jun | 100% casos pasan |
| P4.3 | Pruebas de integración (Web Services, VIGIA, entidades) | Devs CI2 | 25 jun | 27 jun | 100% integraciones responden |
| P4.4 | Pruebas de rendimiento (carga, estrés, 600 transacciones/min) | QA + SysAdmin | 25 jun | 27 jun | Respuesta <5 segundos, sin degradación |
| P4.5 | Pruebas de seguridad (pentest, vulnerabilidades) | Seguridad CI2 | 26 jun | 28 jun | 0 vulnerabilidades críticas |
| P4.6 | Pruebas de recuperación (DRP, RPO <30 min, RTO ≤4h) | DBA + SysAdmin | 26 jun | 28 jun | RPO y RTO cumplidos |
| P4.7 | Pruebas de Call Center (llamadas, grabaciones, reportes) | Call Center CI2 | 27 jun | 29 jun | Abandono <20%, satisfacción >80% |
| P4.8 | Pruebas de BI (cubos, ETLs, dashboards) | BI CI2 | 27 jun | 29 jun | Cubos consultables, datos consistentes |
| P4.9 | Pruebas de mesa de servicio (ciclo completo ticket) | Mesa CI2 | 28 jun | 29 jun | Ciclo completo <4h (mayores) |
| P4.10 | Pruebas de usuario final (UAT) con MME | Usuarios MME | 28 jun | 30 jun | 100% usuarios aprueban |

### 5.3 Entregables de Fase 4

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Ambiente de pruebas CI2 operativo | Jelkin | 20 jun |
| 2 | Informe de pruebas funcionales | Jelkin + Luis | 26 jun |
| 3 | Informe de pruebas de rendimiento | Jelkin + Luis | 27 jun |
| 4 | Informe de pruebas de seguridad | Jelkin + Luis | 28 jun |
| 5 | Informe de pruebas de recuperación | Jelkin + Luis | 28 jun |
| 6 | Acta de aceptación de pruebas (firmada por MME) | MME | 30 jun |

---

## 6. FASE 5: CORTE Y MIGRACIÓN (Semana 6 — Última semana empalme)

### 6.1 Preparación del Corte

| ID | Actividad | Responsable | Inicio | Fin | Entregable |
|----|-----------|-------------|--------|-----|------------|
| C5.1 | Congelamiento de cambios en producción INTERNEXA | Jelkin + INTERNEXA | 26 jun | 27 jun | Comunicado de congelamiento |
| C5.2 | Backup final completo de todos los sistemas | DBA INTERNEXA | 27 jun | 28 jun | Backup validado, checksum verificado |
| C5.3 | Sincronización final de datos (delta) | DBA CI2 + INTERNEXA | 28 jun | 29 jun | Delta aplicado, validado |
| C5.4 | Verificación de integridad post-sincronización | QA CI2 | 29 jun | 29 jun | Checklist de integridad firmado |
| C5.5 | Comunicación a usuarios (corte programado, ventana) | Comunicaciones | 27 jun | 28 jun | Comunicado enviado a todos los usuarios |
| C5.6 | Activación de equipo CI2 7×24 durante corte | Jelkin | 29 jun | 30 jun | Equipo en sitio/remoto 24h |

### 6.2 Día del Corte (30 junio 2026)

| Hora | Actividad | Responsable | Duración |
|------|-----------|-------------|----------|
| 00:00 | Inicio de ventana de corte | Jelkin + INTERNEXA + CI2 | — |
| 00:00-02:00 | Detención graceful de servicios en INTERNEXA | SysAdmin INTERNEXA | 2h |
| 02:00-04:00 | Migración final de datos (si aplica) | DBA CI2 + INTERNEXA | 2h |
| 04:00-06:00 | Activación de servicios en infraestructura CI2 | SysAdmin CI2 | 2h |
| 06:00-08:00 | Validación de servicios críticos (Web, APPs, BI) | QA CI2 | 2h |
| 08:00-10:00 | Pruebas de integración y conectividad | Devs CI2 | 2h |
| 10:00-12:00 | Pruebas de Call Center y mesa de servicio | Call Center + Mesa CI2 | 2h |
| 12:00-14:00 | Monitoreo intensivo y ajustes | Monitoreo CI2 | 2h |
| 14:00-16:00 | Validación con usuarios clave MME | Usuarios MME | 2h |
| 16:00-18:00 | Documentación de incidencias y resoluciones | Jelkin | 2h |
| 18:00 | **Decisión: GO / NO-GO** | Jelkin + Luis + Elizabeth | — |
| 18:00-20:00 | Si GO: Activación completa y comunicado | Jelkin | 2h |
| 18:00-20:00 | Si NO-GO: Rollback y plan de recuperación | Jelkin + INTERNEXA | 2h |
| 20:00-00:00 | Monitoreo post-corte (4h) | Equipo CI2 | 4h |

### 6.3 Post-Corte (1-7 julio 2026)

| ID | Actividad | Responsable | Inicio | Fin |
|----|-----------|-------------|--------|-----|
| PC1 | Monitoreo 7×24 intensivo (primeras 72h) | Equipo CI2 | 01 jul | 04 jul |
| PC2 | Validación de ANS (disponibilidad, tiempos respuesta) | Monitoreo CI2 | 01 jul | 07 jul |
| PC3 | Atención de incidencias post-migración | Mesa CI2 | 01 jul | 07 jul |
| PC4 | Ajustes de configuración y tuning | SysAdmin + DBA | 01 jul | 07 jul |
| PC5 | Informe diario de estabilidad a MME | Jelkin → Luis → Elizabeth | 01 jul | 07 jul |
| PC6 | Acta de recibo parcial (infraestructura y servicios) | MME + CI2 | 05 jul | 07 jul |

### 6.4 Entregables de Fase 5

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Acta de corte y migración | MME + INTERNEXA + CI2 | 30 jun |
| 2 | Informe de incidencias y resoluciones | Jelkin + Luis | 01 jul |
| 3 | Acta de recibo parcial | MME + CI2 | 07 jul |
| 4 | Informe de estabilidad post-migración (7 días) | Jelkin + Luis | 08 jul |

---

## 7. FASE 6: OPERACIÓN Y ESTABILIZACIÓN (Julio — Noviembre 2026)

### 7.1 Operación Normal (01 julio — 30 noviembre 2026)

| ID | Actividad | Responsable | Frecuencia |
|----|-----------|-------------|------------|
| O6.1 | Monitoreo de ANS (disponibilidad, rendimiento, seguridad) | Monitoreo | Continuo 7×24 |
| O6.2 | Atención mesa de servicio (tickets, requerimientos) | Mesa CI2 | 7×24 |
| O6.3 | Atención Call Center (llamadas, soporte) | Call Center | 7×24 |
| O6.4 | Administración de BD (backups, tuning, mantenimiento) | DBA | Diario |
| O6.5 | Administración de infraestructura (patches, capacidad) | SysAdmin | Semanal |
| O6.6 | Desarrollo evolutivo (nuevas funcionalidades, mejoras) | Devs | Según backlog |
| O6.7 | Business Intelligence (ETLs, reportes, dashboards) | BI | Según solicitud |
| O6.8 | Seguridad (monitoreo, patches, respuesta incidentes) | Seguridad | Continuo |
| O6.9 | Formación a usuarios (nuevos, actualizaciones) | Formadores | Mensual |
| O6.10 | Informe mensual de gestión (17 secciones) | Jelkin | Mensual (5 días hábiles) |
| O6.11 | Informe mensual ejecutivo (máx 8 páginas) | Jelkin | Mensual |
| O6.12 | Reunión de seguimiento con MME | Jelkin + Luis + Elizabeth | Mensual |

### 7.2 Hitos de Operación

| Hito | Fecha | Descripción |
|------|-------|-------------|
| H1 | 15 jul | Primer informe mensual de gestión |
| H2 | 31 jul | Primer mes de operación completado |
| H3 | 15 ago | Segundo informe mensual |
| H4 | 31 ago | Validación de ANS acumulados (2 meses) |
| H5 | 15 sep | Tercer informe mensual |
| H6 | 30 sep | Revisión contractual trimestral |
| H7 | 15 oct | Cuarto informe mensual |
| H8 | 31 oct | Preparación de transferencia al nuevo operador |
| H9 | 15 nov | Quinto informe mensual |
| H10 | 30 nov | Cierre de contrato y transferencia |

### 7.3 Entregables de Fase 6

| # | Entregable | Destinatario | Frecuencia |
|---|------------|--------------|------------|
| 1 | Informe mensual de gestión (17 secciones) | MME | Mensual |
| 2 | Informe mensual ejecutivo | MME | Mensual |
| 3 | Informe de ANS (cumplimiento, multas) | MME | Mensual |
| 4 | Actas de reuniones de seguimiento | MME + CI2 | Mensual |
| 5 | Informe de seguridad | MME | Mensual |
| 6 | Informe de capacitación | MME | Mensual |

---

## 8. FASE 7: TRANSFERENCIA FINAL (Noviembre 2026)

### 8.1 Preparación de Transferencia

| ID | Actividad | Responsable | Inicio | Fin |
|----|-----------|-------------|--------|-----|
| TF1 | Notificación a MME de inicio de transferencia | Luis | 01 nov | 01 nov |
| TF2 | Inventario final de infraestructura, aplicaciones, datos | Jelkin | 01 nov | 05 nov |
| TF3 | Actualización de documentación técnica y de usuario | Equipo CI2 | 01 nov | 10 nov |
| TF4 | Preparación de código fuente final (GitLab/GitHub) | Devs | 05 nov | 10 nov |
| TF5 | Preparación de backups finales completos | DBA | 10 nov | 15 nov |
| TF6 | Plan de capacitación al nuevo operador | Jelkin | 05 nov | 10 nov |

### 8.2 Ejecución de Transferencia

| ID | Actividad | Responsable | Inicio | Fin |
|----|-----------|-------------|--------|-----|
| TF7 | Capacitación al nuevo operador (arquitectura, operación) | Equipo CI2 | 15 nov | 20 nov |
| TF8 | Shadowing del nuevo operador (acompañamiento) | Equipo CI2 | 20 nov | 25 nov |
| TF9 | Entrega de documentación completa | Jelkin | 20 nov | 25 nov |
| TF10 | Entrega de código fuente y repositorios | Devs | 20 nov | 25 nov |
| TF11 | Entrega de backups y logs | DBA | 22 nov | 25 nov |
| TF12 | Acta de entrega y recibo firmada | MME + CI2 + Nuevo Operador | 25 nov | 27 nov |
| TF13 | Eliminación de información de CI2 (según contrato) | SysAdmin CI2 | 27 nov | 30 nov |
| TF14 | Acta de cierre de contrato | MME + CI2 | 30 nov | 30 nov |

### 8.3 Entregables de Fase 7

| # | Entregable | Destinatario | Fecha Límite |
|---|------------|--------------|--------------|
| 1 | Informe final de cierre (todas las secciones) | MME | 30 nov |
| 2 | Acta de entrega y recibo | MME + Nuevo Operador | 27 nov |
| 3 | Acta de cierre de contrato | MME + CI2 | 30 nov |
| 4 | Documentación completa actualizada | Nuevo Operador | 25 nov |
| 5 | Código fuente en repositorio | Nuevo Operador | 25 nov |
| 6 | Backups y logs | Nuevo Operador | 25 nov |

---

## 9. CRONOGRAMA RESUMIDO (Gantt Simplificado)

```
FASE          | Mayo        | Junio                     | Julio      | Ago | Sep | Oct | Nov
              | 19 26       | 02 09 16 23 30            | 01 15 31   |     |     |     |
--------------|-------------|---------------------------|------------|-----|-----|-----|-----
F0 Gobierno   | ████████    |                           |            |     |     |     |
F1 Inventario |             | ██████████                |            |     |     |     |
F2 Acceso     |             |      ██████████           |            |     |     |     |
F3 Transferencia|           |           ██████████      |            |     |     |     |
F4 Replicación|             |                ██████████ |            |     |     |     |
F5 Corte      |             |                     ██████|██          |     |     |     |
F6 Operación  |             |                           | ████████████████████████████
F7 Transferencia|           |                           |            |     |     |  ████
```

---

## 10. RIESGOS DEL EMPALME (Matriz Actualizada)

| ID | Riesgo | Probabilidad | Impacto | Estrategia | Mitigación | Responsable | Fecha Límite |
|----|--------|--------------|---------|------------|------------|-------------|--------------|
| R1 | INTERNEXA no entrega documentación completa | ALTA | CRÍTICO | Mitigar | Solicitud formal con plazos, escalamiento a MME, cláusulas contractuales | Jelkin | 02 jun |
| R2 | INTERNEXA no facilita acceso a plataformas | ALTA | CRÍTICO | Mitigar | Carta formal, NDAs firmados, escalamiento a Elizabeth | Jelkin | 04 jun |
| R3 | Código fuente incompleto o sin documentación | MEDIA | CRÍTICO | Mitigar | Validación temprana, checklist de entregables, pruebas de compilación | Líder Técnico | 08 jun |
| R4 | Backups corruptos o irreversibles | MEDIA | CRÍTICO | Mitigar | Validación inmediata, prueba de restauración, backup alterno | DBA | 08 jun |
| R5 | Equipo CI2 no alcanza competencias requeridas | MEDIA | ALTO | Mitigar | Shadowing intensivo, capacitación adicional, refuerzo con consultores | Jelkin | 20 jun |
| R6 | Fallo en corte de migración | BAJA | CRÍTICO | Mitigar | Plan de rollback, ventana extendida, equipo 7×24, pruebas exhaustivas | Jelkin | 30 jun |
| R7 | Incumplimiento de ANS en primer mes | MEDIA | ALTO | Transferir | Monitoreo intensivo, planes de choque, comunicación proactiva con MME | Monitoreo | 31 jul |
| R8 | Pérdida de conocimiento por rotación de personal | MEDIA | ALTO | Mitigar | Documentación continua, shadowing cruzado, capacitación grabada | Jelkin | Continuo |
| R9 | Cambios de alcance no documentados | MEDIA | ALTO | Mitigar | Gestión de cambios formal, actas de reunión, trazabilidad | Jelkin | Continuo |
| R10 | Problemas de licenciamiento | BAJA | ALTO | Mitigar | Inventario temprano, verificación de propiedad, negociación con proveedores | Legal | 01 jun |
| R11 | Brecha de seguridad durante transición | BAJA | CRÍTICO | Mitigar | Controles duales, monitoreo de ambos lados, NDAs, auditoría | Seguridad | Continuo |
| R12 | Retraso en cronograma por dependencias externas | ALTA | ALTO | Mitigar | Seguimiento diario, buffer en cronograma, escalamiento temprano | Jelkin | Continuo |

---

## 11. RECURSOS HUMANOS REQUERIDOS

### 11.1 Equipo Mínimo del Contrato (31 personas)

| Rol | Cantidad | Dedicación | Perfil | Experiencia |
|-----|----------|------------|--------|-------------|
| Director de Proyecto | 1 | 100% | Ingeniero, PMP | 36 meses dirección |
| Líder Técnico | 1 | 100% | Ingeniero, Scrum Master | 36 meses BPM/Java |
| Líder Funcional | 1 | 100% | Ingeniero | 36 meses proyectos |
| DBA Oracle | 2 | 100% | Ingeniero + OCA | 24 meses Oracle |
| Ingeniero QA | 2 | 100% | Ingeniero | 36 meses pruebas |
| Desarrollador Java | 2 | 100% | Ingeniero | 36 meses Java |
| Desarrollador BPM | 3 | 100% | Ingeniero | 36 meses BPM |
| Especialista BI | 2 | 100% | Posgrado analítica | 24 meses BI |
| Analista de Información | 7 | 100% | Profesional | 12 meses análisis |
| Profesional Operación Estadística | 1 | 100% | Profesional + NTC PE 1000 | 24 meses |
| Profesional Calidad | 1 | 100% | Profesional + ISO 9001 | 24 meses |
| Formador | 2 | 100% | Profesional | 12 meses capacitación |
| Coordinador Call Center | 1 | 100% | Profesional | 24 meses CC |
| Agente Call Center | 6 | 100% | Técnico | No requiere |

### 11.2 Equipo de Empalme Adicional (Innovadataco)

| Rol | Cantidad | Dedicación | Responsabilidad |
|-----|----------|------------|-----------------|
| PM Ejecutivo (Jelkin) | 1 | 100% | Dirección empalme, reporte a Luis |
| Analista de Procesos | 1 | 50% | Mapeo de procesos, documentación |
| Especialista en Migración | 1 | 50% | Plan de corte, rollback, validación |
| Documentador Técnico | 1 | 50% | Actualización de manuales, SOPs |
| Abogado (externo) | 1 | 25% | NDAs, actas, revisión contractual |

---

## 12. PRESUPUESTO ESTIMADO DEL EMPALME

### 12.1 Costos Directos (6 semanas)

| Ítem | Costo Estimado (COP) |
|------|---------------------|
| Equipo técnico CI2 (31 personas × 1.5 meses) | $450.000.000 |
| Equipo empalme Innovadataco (4 personas × 1.5 meses) | $75.000.000 |
| Infraestructura temporal (nube, licencias) | $50.000.000 |
| Capacitaciones y material | $20.000.000 |
| Viajes y logística (Bogotá) | $15.000.000 |
| Herramientas de gestión (Jira, monitoreo) | $10.000.000 |
| Contingencia (15%) | $93.000.000 |
| **TOTAL EMPALME** | **$713.000.000** |

### 12.2 Costos de Operación (5 meses)

| Ítem | Costo Estimado (COP) |
|------|---------------------|
| Equipo técnico CI2 (31 personas × 5 meses) | $1.500.000.000 |
| Infraestructura (DC, nube, licencias) | $800.000.000 |
| Seguridad (WAF, SIEM, pentests) | $100.000.000 |
| Formación y soporte | $50.000.000 |
| Monitoreo y herramientas | $30.000.000 |
| Contingencia (10%) | $248.000.000 |
| **TOTAL OPERACIÓN** | **$2.728.000.000** |

---

## 13. GOBIERNO Y COMUNICACIÓN

### 13.1 Estructura de Reporte

```
Jelkin (Director Empalme)
    ↓
Luis Felipe Herrera (Gerente Proyecto CI2 / IND TECH)
    ↓
Elizabeth (Supervisora MME)
    ↓
Ministerio de Minas y Energía
```

### 13.2 Ritmos de Reunión

| Reunión | Frecuencia | Participantes | Duración |
|---------|------------|---------------|----------|
| Daily standup empalme | Diario | Equipo CI2 | 15 min |
| Reunión de seguimiento INTERNEXA | 2× semana | Jelkin + INTERNEXA | 30 min |
| Reunión de riesgos | Semanal | Jelkin + equipo | 1h |
| Reunión con Luis | Semanal | Jelkin + Luis | 1h |
| Reunión con Elizabeth | Quincenal | Luis + Elizabeth | 1h |
| Reunión de gobierno | Mensual | Todos | 2h |

### 13.3 Canales de Comunicación

| Canal | Uso | Respuesta Esperada |
|-------|-----|-------------------|
| WhatsApp/Telegram (grupo crisis) | Alertas críticas, incidencias | <15 min |
| Email formal | Reportes, actas, solicitudes | <4h |
| Jira/Monday | Seguimiento tareas, tickets | <24h |
| Teams/Meet | Reuniones, capacitaciones | Programado |
| Llamada directa | Emergencias | Inmediata |

---

## 14. INDICADORES CLAVE (KPIs)

### 14.1 KPIs del Empalme

| KPI | Meta | Frecuencia | Responsable |
|-----|------|------------|-------------|
| Documentación recibida | 100% crítica | Semanal | Jelkin |
| Accesos validados | 100% | Semanal | Líder Técnico |
| Capacitaciones ejecutadas | 100% plan | Semanal | Jelkin |
| Pruebas pasadas | >95% | Por fase | QA |
| Incidencias críticas | 0 | Diario | Monitoreo |
| Cumplimiento cronograma | >90% | Semanal | Jelkin |

### 14.2 KPIs de Operación (ANS)

| KPI | ANS | Meta | Frecuencia |
|-----|-----|------|------------|
| Disponibilidad plataforma | >99.90% | 99.90% | Mensual |
| RPO | <30 min | 30 min | Por incidente |
| RTO críticos | ≤2h | 2h | Por incidente |
| RTO mayores | ≤4h | 4h | Por incidente |
| MTTD | ≤15 min | 15 min | Por incidente |
| MTTR | ≤4h | 4h | Por incidente |
| Abandono Call Center | <20% | 20% | Mensual |
| Satisfacción capacitación | >80% | 80% | Por evento |
| Satisfacción atención | >80% | 80% | Mensual |
| Incidentes resueltos | >95% | 95% | Mensual |
| Requerimientos solucionados | >90% | 90% | Mensual |

---

## 15. PLAN DE CALIDAD

### 15.1 Criterios de Aceptación por Fase

| Fase | Criterio | Métrica | Responsable Validación |
|------|----------|---------|------------------------|
| F0 | Acta firmada, equipo constituido | 100% roles asignados | Jelkin |
| F1 | 100% documentos críticos recibidos | Checklist completo | Jelkin |
| F2 | 100% accesos validados | Matriz de accesos | Líder Técnico |
| F3 | >90% competencias alcanzadas | Evaluación shadowing | Líder Técnico |
| F4 | 100% pruebas pasadas | Informe de pruebas | QA |
| F5 | Corte exitoso, servicios activos | Acta de corte | Jelkin + MME |
| F6 | ANS cumplidos >99.90% | Informe mensual | Monitoreo |
| F7 | 100% entregables transferidos | Acta de entrega | MME |

### 15.2 Auditorías y Revisiones

| Tipo | Frecuencia | Responsable |
|------|------------|-------------|
| Revisión de documentación | Semanal | Líder Funcional |
| Revisión de avance técnico | Semanal | Líder Técnico |
| Revisión de riesgos | Semanal | Jelkin |
| Auditoría de seguridad | Mensual | Seguridad |
| Auditoría de ANS | Mensual | Monitoreo |
| Revisión contractual | Trimestral | Legal + Jelkin |

---

## 16. ANEXOS

### Anexo A: Matriz de Stakeholders
(Ver documento: `04-MATRIZ-STAKEHOLDERS-EMPALME.md`)

### Anexo B: Registro de Riesgos Detallado
(Ver documento: `03-REGISTRO-RIESGOS-EMPALME.md`)

### Anexo C: Plan de Comunicaciones
(Ver documento: `05-PLAN-COMUNICACIONES-EMPALME.md`)

### Anexo D: Checklist de Documentación Requerida
(Ver documento: `CHECKLIST-DOCUMENTACION-EMPALME.md` — pendiente generar)

### Anexo E: Plan de Capacitación Detallado
(Ver documento: `PLAN-CAPACITACION-EMPALME.md` — pendiente generar)

### Anexo F: Plan de Pruebas de Aceptación
(Ver documento: `PLAN-PRUEBAS-EMPALME.md` — pendiente generar)

### Anexo G: Plan de Corte y Migración
(Ver documento: `PLAN-CORTE-MIGRACION.md` — pendiente generar)

---

**Documento generado por:** ZEUS — Innovadataco
**Fecha generación:** 20 de mayo de 2026
**Versión:** 1.0
**Próxima revisión:** Post-reunión con Luis (21 mayo 2026)

---

## HISTORIAL DE CAMBIOS

| Versión | Fecha | Autor | Cambios |
|---------|-------|-------|---------|
| 1.0 | 20 mayo 2026 | ZEUS | Creación inicial del plan de trabajo completo |
