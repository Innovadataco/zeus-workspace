# PLAN DE CORTE Y MIGRACIÓN — Empalme SICOM

**Proyecto:** Empalme SICOM MME  
**Fecha:** 20 de mayo de 2026  
**Responsable:** Jelkin Zair Carrillo Franco  
**Fecha de Corte:** 30 junio 2026  
**Ventana de Corte:** 00:00 — 18:00 (18 horas)  
**Decisión GO/NO-GO:** 18:00 30 junio 2026  

---

## 1. OBJETIVOS DEL CORTE

1. Migrar operación del SICOM de INTERNEXA a CI2 sin pérdida de servicio
2. Garantizar integridad de datos durante y post-migración
3. Minimizar tiempo de indisponibilidad (objetivo: <2h visible para usuarios)
4. Validar que todos los servicios críticos operan en CI2 antes del GO
5. Obtener acta de migración firmada por MME, INTERNEXA y CI2

---

## 2. ESTRATEGIA DE MIGRACIÓN

### 2.1 Enfoque: Migración por Capas

```
Capa 1: Infraestructura base (red, seguridad, monitoreo)
Capa 2: Bases de datos (replicación, sincronización final)
Capa 3: Aplicaciones (despliegue, configuración)
Capa 4: Integraciones (Web Services, APIs)
Capa 5: Servicios al usuario (Web, APPs, Call Center)
Capa 6: Validación y monitoreo
```

### 2.2 Tipo de Migración

- **Bases de datos:** Sincronización inicial + delta final
- **Aplicaciones:** Despliegue en paralelo, switch DNS
- **Integraciones:** Cambio de endpoints en entidades externas
- **Call Center:** Portabilidad numérica o redirección
- **Usuarios:** Migración de perfiles y contraseñas (hash)

---

## 3. CRONOGRAMA DETALLADO DEL CORTE

### Día -3: Preparación (27 junio)

| Hora | Actividad | Responsable | Detalle |
|------|-----------|-------------|---------|
| 08:00 | Congelamiento de cambios en producción INTERNEXA | Jelkin + INTERNEXA | Comunicado formal, bloqueo despliegues |
| 10:00 | Backup completo de todas las bases de datos | DBA INTERNEXA | Full backup, validación checksum |
| 12:00 | Backup de configuraciones de servidores | SysAdmin INTERNEXA | Exportar configs, scripts |
| 14:00 | Backup de repositorios Git (código fuente) | Dev INTERNEXA | Clone completo, verificación |
| 16:00 | Backup de documentación y manuales | Líder Funcional INTERNEXA | Exportar Wiki, Confluence |
| 18:00 | Verificación de integridad de todos los backups | DBA + SysAdmin | Checklist firmado |
| 20:00 | Sincronización inicial de datos a ambiente CI2 | DBA CI2 + INTERNEXA | Replicación bulk, validación |

### Día -2: Preparación (28 junio)

| Hora | Actividad | Responsable | Detalle |
|------|-----------|-------------|---------|
| 08:00 | Verificación de sincronización inicial | DBA CI2 | Validación de registros, consistencia |
| 10:00 | Configuración de servidores CI2 (SO, parches, librerías) | SysAdmin CI2 | Checklist de configuración |
| 12:00 | Despliegue de aplicaciones en ambiente CI2 | Devs CI2 | Compilación, despliegue, smoke test |
| 14:00 | Configuración de seguridad (WAF, firewall, certificados) | Seguridad CI2 | Reglas, políticas, TLS |
| 16:00 | Configuración de monitoreo (dashboards, alertas) | Monitoreo CI2 | Nagios/Zabbix/Grafana |
| 18:00 | Configuración de Call Center (colas, IVR, agentes) | Call Center CI2 | Software, telefonía, pruebas |
| 20:00 | Configuración de mesa de servicio (ITSM, flujos) | Mesa CI2 | ServiceNow/Jira, categorías |
| 22:00 | Pruebas de conectividad interna (CI2) | SysAdmin CI2 | Ping, traza, puertos |

### Día -1: Preparación (29 junio)

| Hora | Actividad | Responsable | Detalle |
|------|-----------|-------------|---------|
| 08:00 | Sincronización delta de datos (últimos 2 días) | DBA CI2 + INTERNEXA | Captura cambios, aplicación |
| 10:00 | Pruebas de integridad post-sincronización | QA CI2 | Validación de registros, balances |
| 12:00 | Pruebas funcionales en ambiente CI2 (smoke tests) | QA CI2 | Casos críticos, 100% paso |
| 14:00 | Validación de Web Services con entidades externas | Devs CI2 | VIGIA, RUES, SICERCO, SUI |
| 16:00 | Validación de APPs móviles (iOS, Android) | QA CI2 | Instalación, login, reporte |
| 18:00 | Validación de BI (cubos, ETLs, dashboards) | BI CI2 | Consultas, datos consistentes |
| 20:00 | Reunión de GO/NO-GO preliminar | Jelkin + Equipo | Revisión de checklist, riesgos |
| 22:00 | Comunicación a usuarios (ventana de corte) | Comunicaciones | Email, SMS, portal |

### Día del Corte: 30 junio 2026

#### Fase 1: Detención Graceful (00:00 — 02:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 00:00 | **INICIO VENTANA DE CORTE** | Jelkin | Comando de inicio, comunicado a equipo | ✅ Iniciado |
| 00:00-00:30 | Notificación a usuarios (corte iniciado) | Mesa CI2 | Banner web, mensaje APP, IVR | ✅ Notificado |
| 00:30-01:00 | Detención de servicios web (graceful shutdown) | SysAdmin INTERNEXA | Stop Apache/Nginx, drain connections | ✅ Detenido |
| 01:00-01:30 | Detención de APPs móviles (backend) | SysAdmin INTERNEXA | Stop servicios API, push notifications | ✅ Detenido |
| 01:30-02:00 | Detención de Call Center (colas, IVR) | Call Center INTERNEXA | Redirección a mensaje, cierre colas | ✅ Detenido |
| 02:00 | **CHECKPOINT: Servicios INTERNEXA detenidos** | Jelkin | Validación de que no hay tráfico | ✅ Checkpoint |

#### Fase 2: Migración Final de Datos (02:00 — 04:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 02:00-02:30 | Backup final delta (últimas 2 horas) | DBA INTERNEXA | Exportar cambios desde sincronización | ✅ Backup |
| 02:30-03:00 | Transferencia de backup delta a CI2 | DBA CI2 + INTERNEXA | SCP/S3, verificación checksum | ✅ Transferido |
| 03:00-03:30 | Aplicación de delta en BD CI2 | DBA CI2 | Import, validación de registros | ✅ Aplicado |
| 03:30-04:00 | Validación de integridad de datos finales | QA CI2 + DBA | Conteos, balances, hashes | ✅ Integridad |
| 04:00 | **CHECKPOINT: Datos migrados y validados** | Jelkin | Acta de validación de datos firmada | ✅ Checkpoint |

#### Fase 3: Activación Servicios CI2 (04:00 — 08:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 04:00-04:30 | Inicio de bases de datos CI2 | DBA CI2 | Start Oracle, validación de instancias | ✅ BD activa |
| 04:30-05:00 | Inicio de servicios de aplicación (Java, BPM) | SysAdmin CI2 | Start servicios, validación de puertos | ✅ Apps activas |
| 05:00-05:30 | Inicio de Web Services y APIs | Devs CI2 | Start endpoints, health check | ✅ APIs activas |
| 05:30-06:00 | Inicio de servicios web (Apache/Nginx) | SysAdmin CI2 | Start web server, validación de virtual hosts | ✅ Web activa |
| 06:00-06:30 | Inicio de APPs móviles (backend) | SysAdmin CI2 | Start servicios móviles, push | ✅ APPs activas |
| 06:30-07:00 | Inicio de Call Center (software, colas, IVR) | Call Center CI2 | Start CTI, validación de agentes | ✅ CC activo |
| 07:00-07:30 | Inicio de mesa de servicio (ITSM) | Mesa CI2 | Start ServiceNow/Jira, validación de flujos | ✅ ITSM activo |
| 07:30-08:00 | Inicio de monitoreo (dashboards, alertas) | Monitoreo CI2 | Validación de métricas, umbrales | ✅ Monitoreo activo |
| 08:00 | **CHECKPOINT: Todos los servicios CI2 activos** | Jelkin | Checklist de servicios firmado | ✅ Checkpoint |

#### Fase 4: Validación Funcional (08:00 — 12:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 08:00-09:00 | Pruebas de login (Web, APP, admin) | QA CI2 | 100% roles, 100% éxito | ✅ Login OK |
| 09:00-10:00 | Pruebas de funcionalidad crítica (reporte precios) | QA CI2 | Casos críticos, 100% paso | ✅ Funcionalidad OK |
| 10:00-11:00 | Pruebas de Web Services (VIGIA, entidades) | Devs CI2 | 100% endpoints responden 200 OK | ✅ APIs OK |
| 11:00-12:00 | Pruebas de BI (cubos, dashboards) | BI CI2 | Consultas <5 segundos, datos consistentes | ✅ BI OK |
| 12:00 | **CHECKPOINT: Validación funcional completa** | Jelkin | Informe de validación firmado | ✅ Checkpoint |

#### Fase 5: Validación de Integración y Usuarios (12:00 — 16:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 12:00-13:00 | Pruebas de integración con entidades externas | Devs CI2 | VIGIA, RUES, SICERCO, SUI | ✅ Integraciones OK |
| 13:00-14:00 | Pruebas de Call Center (llamada, grabación, ticket) | Call Center CI2 | Llamada conectada, grabada, ticket creado | ✅ CC OK |
| 14:00-15:00 | Pruebas de mesa de servicio (ticket, escalamiento) | Mesa CI2 | Ciclo completo <4h (mayores) | ✅ ITSM OK |
| 15:00-16:00 | Validación con usuarios clave MME (5 usuarios) | Usuarios MME | UAT rápido, aprobación verbal | ✅ Usuarios OK |
| 16:00 | **CHECKPOINT: Validación de integración y usuarios** | Jelkin | Acta de validación firmada | ✅ Checkpoint |

#### Fase 6: Monitoreo Intensivo y Ajustes (16:00 — 18:00)

| Hora | Actividad | Responsable | Detalle | Checkpoint |
|------|-----------|-------------|---------|------------|
| 16:00-17:00 | Monitoreo intensivo (métricas, logs, alertas) | Monitoreo CI2 | Dashboards activos, 0 alertas críticas | ✅ Estable |
| 17:00-17:30 | Ajustes de configuración (tuning, parámetros) | SysAdmin + DBA | Si aplica, cambios menores | ✅ Ajustado |
| 17:30-18:00 | Preparación de informe de corte | Jelkin | Resumen de actividades, incidencias | ✅ Informe listo |
| 18:00 | **DECISIÓN GO / NO-GO** | Jelkin + Luis + Elizabeth | Revisión de checklist, riesgos, informe | ✅ Decisión |

#### Fase 7: GO — Activación Completa (18:00 — 20:00)

| Hora | Actividad | Responsable | Detalle |
|------|-----------|-------------|---------|
| 18:00 | **DECISIÓN: GO** | Jelkin + Luis + Elizabeth | Comunicado formal |
| 18:00-18:30 | Cambio de DNS (apuntar a CI2) | SysAdmin CI2 | TTL bajo, propagación rápida |
| 18:30-19:00 | Cambio de endpoints en entidades externas | Devs CI2 | VIGIA, RUES, SICERCO, SUI |
| 19:00-19:30 | Activación de APPs en stores (si aplica) | QA CI2 | Nueva versión con endpoint CI2 |
| 19:30-20:00 | Comunicado a usuarios (servicio restaurado) | Comunicaciones | Email, SMS, portal, IVR |
| 20:00 | **CORTE COMPLETADO — OPERACIÓN CI2 ACTIVA** | Jelkin | Celebración, monitoreo continuo |

#### Fase 8: NO-GO — Rollback (18:00 — 22:00)

| Hora | Actividad | Responsable | Detalle |
|------|-----------|-------------|---------|
| 18:00 | **DECISIÓN: NO-GO** | Jelkin + Luis + Elizabeth | Documentar razones |
| 18:00-18:30 | Comunicado a usuarios (extensión ventana) | Comunicaciones | Nuevo ETA |
| 18:30-19:30 | Reactivación de servicios INTERNEXA | SysAdmin INTERNEXA | Start servicios, validación |
| 19:30-20:30 | Reversión de DNS (apuntar a INTERNEXA) | SysAdmin INTERNEXA | TTL bajo, propagación |
| 20:30-21:30 | Validación de servicios INTERNEXA | QA INTERNEXA | Smoke tests, 100% paso |
| 21:30-22:00 | Informe de NO-GO y plan de recuperación | Jelkin | Razones, acciones, nueva fecha |
| 22:00 | **ROLLBACK COMPLETADO — OPERACIÓN INTERNEXA REACTIVADA** | Jelkin | Plan de contingencia activado |

---

## 4. CHECKLIST DE CORTE

### 4.1 Pre-Corte (Día -3 a Día -1)

| # | Ítem | Responsable | Estado |
|---|------|-------------|--------|
| 1 | Congelamiento de cambios comunicado | Jelkin | ⬜ |
| 2 | Backup completo BD validado | DBA INTERNEXA | ⬜ |
| 3 | Backup configuraciones validado | SysAdmin INTERNEXA | ⬜ |
| 4 | Backup código fuente validado | Dev INTERNEXA | ⬜ |
| 5 | Sincronización inicial de datos validada | DBA CI2 | ⬜ |
| 6 | Ambiente CI2 configurado y operativo | SysAdmin CI2 | ⬜ |
| 7 | Aplicaciones desplegadas en CI2 | Devs CI2 | ⬜ |
| 8 | Seguridad configurada en CI2 | Seguridad CI2 | ⬜ |
| 9 | Monitoreo configurado en CI2 | Monitoreo CI2 | ⬜ |
| 10 | Call Center configurado en CI2 | Call Center CI2 | ⬜ |
| 11 | Mesa de servicio configurada en CI2 | Mesa CI2 | ⬜ |
| 12 | Pruebas smoke en CI2 pasadas | QA CI2 | ⬜ |
| 13 | Sincronización delta validada | DBA CI2 | ⬜ |
| 14 | Comunicación a usuarios enviada | Comunicaciones | ⬜ |
| 15 | Equipo 7×24 asignado y confirmado | Jelkin | ⬜ |

### 4.2 Durante el Corte (Día 0)

| # | Ítem | Responsable | Estado |
|---|------|-------------|--------|
| 16 | Servicios INTERNEXA detenidos graceful | SysAdmin INTERNEXA | ⬜ |
| 17 | Backup delta final validado | DBA INTERNEXA | ⬜ |
| 18 | Delta aplicado en CI2 validado | DBA CI2 | ⬜ |
| 19 | Bases de datos CI2 activas | DBA CI2 | ⬜ |
| 20 | Aplicaciones CI2 activas | SysAdmin CI2 | ⬜ |
| 21 | Web Services CI2 activos | Devs CI2 | ⬜ |
| 22 | Web CI2 activa | SysAdmin CI2 | ⬜ |
| 23 | APPs móviles CI2 activas | SysAdmin CI2 | ⬜ |
| 24 | Call Center CI2 activo | Call Center CI2 | ⬜ |
| 25 | Mesa de servicio CI2 activa | Mesa CI2 | ⬜ |
| 26 | Monitoreo CI2 activo | Monitoreo CI2 | ⬜ |
| 27 | Login 100% roles funciona | QA CI2 | ⬜ |
| 28 | Funcionalidad crítica 100% pasada | QA CI2 | ⬜ |
| 29 | Web Services 100% responden 200 OK | Devs CI2 | ⬜ |
| 30 | BI consultable <5 segundos | BI CI2 | ⬜ |
| 31 | Integraciones externas funcionando | Devs CI2 | ⬜ |
| 32 | Call Center llamada conectada y grabada | Call Center CI2 | ⬜ |
| 33 | Mesa de servicio ticket fluye correctamente | Mesa CI2 | ⬜ |
| 34 | Usuarios MME validan funcionalidad | Usuarios MME | ⬜ |
| 35 | Monitoreo 0 alertas críticas | Monitoreo CI2 | ⬜ |
| 36 | Informe de corte preparado | Jelkin | ⬜ |
| 37 | **DECISIÓN GO / NO-GO tomada** | Jelkin + Luis + Elizabeth | ⬜ |

### 4.3 Post-Corte (GO)

| # | Ítem | Responsable | Estado |
|---|------|-------------|--------|
| 38 | DNS apuntando a CI2 | SysAdmin CI2 | ⬜ |
| 39 | Endpoints externos actualizados | Devs CI2 | ⬜ |
| 40 | Comunicado a usuarios enviado | Comunicaciones | ⬜ |
| 41 | Monitoreo 7×24 activo (72h) | Monitoreo CI2 | ⬜ |
| 42 | Informe diario de estabilidad | Jelkin | ⬜ |
| 43 | Acta de recibo parcial firmada | MME + CI2 | ⬜ |

### 4.4 Post-Corte (NO-GO)

| # | Ítem | Responsable | Estado |
|---|------|-------------|--------|
| 44 | Servicios INTERNEXA reactivados | SysAdmin INTERNEXA | ⬜ |
| 45 | DNS apuntando a INTERNEXA | SysAdmin INTERNEXA | ⬜ |
| 46 | Validación de servicios INTERNEXA | QA INTERNEXA | ⬜ |
| 47 | Informe de NO-GO preparado | Jelkin | ⬜ |
| 48 | Plan de recuperación y nueva fecha | Jelkin + Luis | ⬜ |

---

## 5. COMUNICACIÓN DURANTE EL CORTE

### 5.1 Stakeholders y Frecuencia

| Stakeholder | Rol | Comunicación | Frecuencia | Canal |
|-------------|-----|--------------|------------|-------|
| Luis Herrera | Gerente Proyecto CI2 | Estado del corte | Cada 2h | WhatsApp + Email |
| Elizabeth | Supervisora MME | Estado del corte | Cada 4h | Email formal |
| Equipo CI2 | Ejecutores | Instrucciones, alertas | Continuo | Radio/Teams |
| INTERNEXA | Operador saliente | Coordinación técnica | Según necesidad | WhatsApp/Teams |
| Usuarios finales | Agentes, ESP, EDS | Estado del servicio | Inicio, fin, incidencias | Portal, email, SMS |
| Mesa de servicio | Soporte 1er nivel | Escalamientos | Según incidencia | Teléfono/Teams |

### 5.2 Mensajes Predefinidos

**Inicio de corte:**
> "SICOM en ventana de mantenimiento programado. Servicio no disponible desde [hora] hasta [hora]. Para emergencias: [teléfono Call Center]"

**Actualización cada 4h:**
> "Actualización corte SICOM: [estado]. Avance: [X%]. ETA: [hora]. Sin novedades / Incidencia: [descripción]"

**GO — Servicio restaurado:**
> "SICOM operando normalmente. Todos los servicios activos. Gracias por su paciencia. Soporte: [teléfono / email]"

**NO-GO — Extensión:**
> "Corte SICOM extendido. Nueva ETA: [hora]. Razón: [descripción]. Alternativa: [si aplica]. Disculpe las molestias"

---

## 6. CONTINGENCIAS Y ROLLBACK

### 6.1 Escenarios de NO-GO

| # | Escenario | Indicador | Acción |
|---|-----------|-----------|--------|
| 1 | Datos corruptos post-migración | Validación falla | NO-GO inmediato, rollback a INTERNEXA |
| 2 | Servicios críticos no arrancan en CI2 | Smoke test falla | Diagnóstico 30 min, si no se resuelve: NO-GO |
| 3 | Web Services no responden | Health check falla | Diagnóstico 30 min, si no se resuelve: NO-GO |
| 4 | Integraciones externas fallan | Pruebas fallan | Diagnóstico 1h, si no se resuelve: NO-GO |
| 5 | Usuarios MME no aprueban UAT | UAT falla | Diagnóstico 1h, si no se resuelve: NO-GO |
| 6 | Alertas críticas persistentes | Monitoreo rojo 1h | Diagnóstico 1h, si no se resuelve: NO-GO |
| 7 | Tiempo excede ventana (18h) | Reloj >18:00 | NO-GO automático, rollback planificado |

### 6.2 Procedimiento de Rollback

```
1. Decisión NO-GO por Jelkin + Luis + Elizabeth
2. Comunicado a equipo y usuarios (extensión ventana)
3. Detención de servicios CI2 (si están activos)
4. Reactivación de servicios INTERNEXA
5. Reversión de DNS a INTERNEXA
6. Validación de servicios INTERNEXA (smoke tests)
7. Comunicado a usuarios (servicio restaurado en INTERNEXA)
8. Informe de NO-GO con razones y plan de recuperación
9. Nueva fecha de corte propuesta (mínimo +7 días)
```

### 6.3 Plan de Recuperación Post-NO-GO

| Actividad | Responsable | Duración |
|-----------|-------------|----------|
| Análisis de causa raíz | Jelkin + Equipo | 24h |
| Corrección de problemas | Responsable técnico | 48-72h |
| Pruebas de validación | QA CI2 | 24h |
| Preparación nuevo corte | Jelkin + Equipo | 48h |
| Ejecución nuevo corte | Jelkin + Equipo | 18h |
| **Total recuperación** | | **7-10 días** |

---

## 7. RECURSOS REQUERIDOS

### 7.1 Equipo Durante el Corte

| Rol | Cantidad | Ubicación | Horario |
|-----|----------|-----------|---------|
| PM (Jelkin) | 1 | Centro de comando | 00:00-20:00 |
| Líder Técnico | 1 | Centro de comando | 00:00-20:00 |
| SysAdmin CI2 | 2 | Remoto / Bogotá | 00:00-20:00 |
| DBA CI2 | 2 | Remoto / Bogotá | 00:00-08:00 |
| Devs CI2 | 2 | Remoto / Bogotá | 04:00-20:00 |
| Seguridad CI2 | 1 | Remoto / Bogotá | 04:00-20:00 |
| Monitoreo CI2 | 1 | Remoto / Bogotá | 00:00-20:00 |
| Call Center CI2 | 2 | Bogotá | 06:00-20:00 |
| Mesa CI2 | 2 | Remoto / Bogotá | 06:00-20:00 |
| QA CI2 | 2 | Remoto / Bogotá | 04:00-16:00 |
| SysAdmin INTERNEXA | 1 | Remoto / Bogotá | 00:00-04:00 |
| DBA INTERNEXA | 1 | Remoto / Bogotá | 00:00-04:00 |
| Dev INTERNEXA | 1 | Remoto / Bogotá | 00:00-04:00 |
| **TOTAL** | **19** | | |

### 7.2 Infraestructura

| Recurso | Cantidad | Ubicación | Responsable |
|---------|----------|-----------|-------------|
| Centro de comando (sala crisis) | 1 | Bogotá, oficina CI2 | Jelkin |
| Pantallas de monitoreo (dashboards) | 4 | Centro de comando | Monitoreo |
| Estaciones de trabajo (laptops) | 10 | Centro de comando + remoto | IT CI2 |
| Teléfonos dedicados (conferencia) | 5 | Centro de comando | Logística |
| Internet dedicado (backup) | 2 | Centro de comando | IT CI2 |
| Generador eléctrico (backup) | 1 | Centro de comando | Logística |
| Refrigerios / alimentación | Continuo | Centro de comando | Logística |

---

## 8. PRESUPUESTO DEL CORTE

| Ítem | Costo Estimado (COP) |
|------|---------------------|
| Horas equipo técnico (19 personas × 20h × $150.000/h) | $57.000.000 |
| Infraestructura temporal (nube adicional, licencias) | $10.000.000 |
| Logística (sala, alimentación, transporte) | $5.000.000 |
| Comunicaciones (SMS masivos, llamadas) | $2.000.000 |
| Consultor migración (si aplica) | $8.000.000 |
| Contingencia (15%) | $12.300.000 |
| **TOTAL CORTE** | **$94.300.000** |

---

## 9. ACTAS Y DOCUMENTOS

| Documento | Responsable | Fecha Límite |
|-----------|-------------|--------------|
| Acta de inicio de corte | Jelkin | 30 jun 00:00 |
| Acta de validación de datos | DBA CI2 + INTERNEXA | 30 jun 04:00 |
| Acta de validación funcional | QA CI2 | 30 jun 12:00 |
| Acta de validación de integración | Devs CI2 | 30 jun 16:00 |
| Acta de decisión GO/NO-GO | Jelkin + Luis + Elizabeth | 30 jun 18:00 |
| Acta de corte completado (GO) | Jelkin | 30 jun 20:00 |
| Acta de rollback (NO-GO) | Jelkin | 30 jun 22:00 |
| Informe de incidencias | Jelkin | 01 jul |
| Acta de recibo parcial | MME + CI2 | 07 jul |

---

**Documento generado por:** ZEUS — Innovadataco  
**Fecha generación:** 20 de mayo de 2026  
**Versión:** 1.0  
**Próxima actualización:** Pre-corte (27 junio)
