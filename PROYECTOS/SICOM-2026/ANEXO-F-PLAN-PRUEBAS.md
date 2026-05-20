# PLAN DE PRUEBAS DE ACEPTACIÓN — Empalme SICOM

**Proyecto:** Empalme SICOM MME  
**Fecha:** 20 de mayo de 2026  
**Responsable:** Jelkin Zair Carrillo Franco  
**Periodo de Pruebas:** 24-30 junio 2026 (7 días)  
**Ambiente:** Pruebas CI2 (replica de producción INTERNEXA)  

---

## 1. OBJETIVOS

1. Validar que todas las funcionalidades del SICOM operan correctamente en ambiente CI2
2. Verificar cumplimiento de ANS (disponibilidad, rendimiento, seguridad)
3. Confirmar integridad de datos post-migración
4. Certificar que el equipo CI2 puede operar sin dependencia de INTERNEXA
5. Obtener acta de aceptación firmada por MME antes del corte

---

## 2. ALCANCE DE PRUEBAS

### 2.1 Sistemas a Probar

| # | Sistema | Tecnología | Crítico |
|---|---------|------------|---------|
| 1 | SICOM Líquidos (Web) | Java | SÍ |
| 2 | SICOM Gas (Web) | Java | SÍ |
| 3 | Nuevo SICOM (BPM) | BPM | SÍ |
| 4 | APP Móvil Líquidos | iOS/Android | SÍ |
| 5 | APP Móvil GAS | iOS/Android | SÍ |
| 6 | Portal Autogestión | Web | SÍ |
| 7 | Web Services / APIs | REST/SOAP | SÍ |
| 8 | Business Intelligence (Cubos) | SSAS | SÍ |
| 9 | Business Intelligence (Dashboards) | Power BI/SSRS | SÍ |
| 10 | Call Center (Software + Telefonía) | CTI | SÍ |
| 11 | Mesa de Servicio (ITSM) | ServiceNow/Jira | SÍ |
| 12 | E-learning | Web | NO |
| 13 | DataMart / ETLs | SSIS | SÍ |

### 2.2 Tipos de Pruebas

| Tipo | Descripción | Cobertura |
|------|-------------|-----------|
| Funcionales | Validar casos de uso según requerimientos | 100% críticos |
| Integración | Validar comunicación entre sistemas | 100% interfaces |
| Rendimiento | Validar tiempos de respuesta bajo carga | 600 trans/min |
| Seguridad | Validar controles, vulnerabilidades | Pentest básico |
| Recuperación | Validar RPO, RTO, DRP | 1 escenario |
| Usabilidad | Validar experiencia usuario final | 5 usuarios clave |
| Operación | Validar procedimientos, monitoreo | 100% SOPs |

---

## 3. CRONOGRAMA DE PRUEBAS

### Fase 1: Preparación (24 junio)

| Hora | Actividad | Responsable | Entregable |
|------|-----------|-------------|------------|
| 08:00-10:00 | Verificación ambiente de pruebas | SysAdmin CI2 | Checklist ambiente |
| 10:00-12:00 | Carga de datos de prueba (subset producción) | DBA CI2 | Datos cargados, validados |
| 12:00-14:00 | Configuración de herramientas de prueba (JMeter, Postman) | QA CI2 | Herramientas listas |
| 14:00-16:00 | Reunión de kickoff de pruebas | Jelkin + QA + Devs | Acta de inicio pruebas |
| 16:00-18:00 | Asignación de casos de prueba a testers | QA CI2 | Matriz de asignación |

### Fase 2: Pruebas Funcionales (25-26 junio)

#### Día 1 (25 junio): SICOM Web y APPs

| Hora | Prueba | Sistema | Tester | Criterio Aceptación |
|------|--------|---------|--------|---------------------|
| 08:00-10:00 | Login, autenticación, roles | Web Líquidos | QA 1 | 100% roles funcionan |
| 10:00-12:00 | Registro de agentes, empresas | Web Líquidos | QA 1 | CRUD completo |
| 12:00-14:00 | Reporte de precios, inventarios | Web Líquidos | QA 2 | Cálculos correctos |
| 14:00-16:00 | Aprobaciones, flujos de trabajo | BPM | QA 3 | Flujos completos |
| 16:00-18:00 | APP móvil: login, reporte, consulta | APP Líquidos | QA 4 | 100% funcionalidades |

#### Día 2 (26 junio): Integraciones y BI

| Hora | Prueba | Sistema | Tester | Criterio Aceptación |
|------|--------|---------|--------|---------------------|
| 08:00-10:00 | Web Services: VIGIA, entidades | APIs | Dev 1 | 100% responden 200 OK |
| 10:00-12:00 | Web Services: SICERCO, RUES, SUI | APIs | Dev 2 | Datos consistentes |
| 12:00-14:00 | ETLs: carga, transformación, destino | SSIS | BI 1 | 0 errores, datos correctos |
| 14:00-16:00 | Cubos: consulta, drill-down, filtros | SSAS | BI 2 | Respuesta <5 segundos |
| 16:00-18:00 | Dashboards: visualización, exportación | Power BI | BI 2 | 100% widgets funcionan |

### Fase 3: Pruebas No Funcionales (27 junio)

#### Día 3 (27 junio): Rendimiento y Seguridad

| Hora | Prueba | Herramienta | Responsable | Criterio Aceptación |
|------|--------|-------------|-------------|---------------------|
| 08:00-10:00 | Carga Web: 100 usuarios concurrentes | JMeter | QA + SysAdmin | Tiempo respuesta <5s |
| 10:00-12:00 | Carga Web: 300 usuarios concurrentes | JMeter | QA + SysAdmin | Sin errores, sin degradación |
| 12:00-14:00 | Carga Web: 600 transacciones/minuto | JMeter | QA + SysAdmin | Meta contrato |
| 14:00-16:00 | Estrés: 1000 usuarios, 10 minutos | JMeter | QA + SysAdmin | Recuperación <2 min |
| 16:00-18:00 | Pentest básico (OWASP Top 10) | Burp Suite / Nikto | Seguridad | 0 vulnerabilidades críticas |

### Fase 4: Pruebas de Recuperación y Operación (28 junio)

#### Día 4 (28 junio): DRP y Operación

| Hora | Prueba | Responsable | Criterio Aceptación |
|------|--------|-------------|---------------------|
| 08:00-10:00 | Backup completo: ejecución, verificación | DBA | Backup exitoso, checksum OK |
| 10:00-12:00 | Restauración backup: tiempo, integridad | DBA | RPO <30 min, datos consistentes |
| 12:00-14:00 | Failover DC: simulación, recuperación | SysAdmin | RTO ≤4h (mayores) |
| 14:00-16:00 | Procedimientos operativos: ejecución SOPs | Operación | 100% SOPs ejecutables |
| 16:00-18:00 | Monitoreo: alertas, dashboards, umbrales | Monitoreo | 100% alertas funcionan |

### Fase 5: Pruebas de Usuario y Aceptación (29 junio)

#### Día 5 (29 junio): UAT con MME

| Hora | Prueba | Usuario MME | Responsable CI2 | Criterio Aceptación |
|------|--------|-------------|-----------------|---------------------|
| 08:00-10:00 | Flujo completo agente: registro, reporte, consulta | Usuario 1 | Analista 1 | Usuario aprueba |
| 10:00-12:00 | Flujo aprobador: revisión, aprobación, rechazo | Usuario 2 | Analista 2 | Usuario aprueba |
| 12:00-14:00 | Consulta BI: precios, inventarios, indicadores | Usuario 3 | BI | Usuario aprueba |
| 14:00-16:00 | APP móvil: reporte desde campo | Usuario 4 | QA | Usuario aprueba |
| 16:00-18:00 | Mesa de servicio: creación ticket, seguimiento | Usuario 5 | Mesa | Usuario aprueba |

### Fase 6: Pruebas Call Center (30 junio - mañana)

#### Día 6 (30 junio): Call Center y Cierre

| Hora | Prueba | Responsable | Criterio Aceptación |
|------|--------|-------------|---------------------|
| 08:00-10:00 | Llamada entrante: IVR, cola, agente | Call Center | Llamada conectada, grabada |
| 10:00-12:00 | Escalamiento: supervisor, transferencia | Call Center | Escalamiento <30 segundos |
| 12:00-14:00 | Reportes: abandono, duración, satisfacción | Call Center | Cálculos correctos |
| 14:00-16:00 | Revisión de hallazgos y bugs | QA + Devs | Listado priorizado |
| 16:00-18:00 | Preparación de informe de pruebas | QA | Informe completo |

---

## 4. CASOS DE PRUEBA DETALLADOS

### 4.1 SICOM Web — Líquidos (30 casos críticos)

| ID | Caso | Precondición | Pasos | Resultado Esperado | Prioridad |
|----|------|--------------|-------|-------------------|-----------|
| WEB-LIQ-01 | Login agente | Usuario registrado | 1. Ingresar URL 2. Usuario/clave 3. Click ingresar | Acceso al módulo agente | Crítico |
| WEB-LIQ-02 | Registro empresa | Usuario logueado | 1. Menú empresas 2. Nuevo 3. Diligenciar 4. Guardar | Empresa creada, consecutivo asignado | Crítico |
| WEB-LIQ-03 | Reporte precios | Empresa activa | 1. Menú precios 2. Seleccionar producto 3. Ingresar precio 4. Guardar | Precio registrado, visible en consulta | Crítico |
| WEB-LIQ-04 | Reporte inventarios | Empresa activa | 1. Menú inventarios 2. Seleccionar depósito 3. Ingresar cantidad 4. Guardar | Inventario registrado, visible en consulta | Crítico |
| WEB-LIQ-05 | Consulta histórico precios | Precios reportados | 1. Menú consultas 2. Filtros fecha, producto 3. Buscar | Lista de precios con gráfico | Alto |
| WEB-LIQ-06 | Aprobación precios (flujo BPM) | Precio reportado | 1. Bandeja aprobador 2. Revisar 3. Aprobar/Rechazar | Estado actualizado, notificación enviada | Crítico |
| WEB-LIQ-07 | Generación reporte estándar | Datos existentes | 1. Menú reportes 2. Seleccionar tipo 3. Parámetros 4. Generar | Reporte descargable (PDF/Excel) | Alto |
| WEB-LIQ-08 | Exportación datos | Datos existentes | 1. Consulta 2. Click exportar 3. Seleccionar formato | Archivo descargado, datos correctos | Alto |
| WEB-LIQ-09 | Cambio contraseña | Usuario logueado | 1. Perfil 2. Cambiar clave 3. Guardar | Clave actualizada, login con nueva clave | Medio |
| WEB-LIQ-10 | Recuperación contraseña | Usuario olvidó clave | 1. Login 2. Olvidé clave 3. Email 4. Link 5. Nueva clave | Acceso recuperado | Medio |

### 4.2 APP Móvil — Líquidos (15 casos críticos)

| ID | Caso | Precondición | Pasos | Resultado Esperado | Prioridad |
|----|------|--------------|-------|-------------------|-----------|
| APP-LIQ-01 | Instalación iOS | Dispositivo compatible | 1. App Store 2. Buscar SICOM 3. Instalar | APP instalada, icono visible | Crítico |
| APP-LIQ-02 | Login | Usuario registrado | 1. Abrir APP 2. Usuario/clave 3. Ingresar | Dashboard visible | Crítico |
| APP-LIQ-03 | Reporte precio desde campo | GPS habilitado | 1. Menú precios 2. Escanear QR estación 3. Ingresar precio 4. Guardar | Precio registrado, geolocalización | Crítico |
| APP-LIQ-04 | Consulta precios cercanos | GPS habilitado | 1. Menú mapa 2. Ver precios estaciones cercanas | Mapa con precios, distancia | Alto |
| APP-LIQ-05 | Sincronización offline | Sin internet | 1. Reportar precio offline 2. Recuperar internet 3. Sincronizar | Datos sincronizados, confirmación | Crítico |

### 4.3 Web Services / APIs (20 casos críticos)

| ID | Caso | Endpoint | Método | Payload | Resultado Esperado | Prioridad |
|----|------|----------|--------|---------|-------------------|-----------|
| API-01 | Consulta precios VIGIA | /api/vigia/precios | GET | fecha, producto | JSON con precios de referencia | Crítico |
| API-02 | Reporte precio agente | /api/agente/precios | POST | empresa, producto, precio, fecha | 201 Created, consecutivo | Crítico |
| API-03 | Consulta empresa RUES | /api/rues/empresas | GET | nit | JSON con datos empresa | Crítico |
| API-04 | Consulta certificado SICERCO | /api/sicerco/certificados | GET | nit, producto | JSON con certificados | Alto |
| API-05 | Consulta servicios SUI | /api/sui/servicios | GET | nit, periodo | JSON con servicios públicos | Alto |
| API-06 | Autenticación token | /api/auth/token | POST | usuario, clave | JWT token válido 24h | Crítico |
| API-07 | Refresco token | /api/auth/refresh | POST | token_refresh | Nuevo JWT token | Crítico |
| API-08 | Health check | /api/health | GET | — | 200 OK, uptime, version | Crítico |

### 4.4 Business Intelligence (15 casos críticos)

| ID | Caso | Cubo/Dashboard | Filtros | Resultado Esperado | Prioridad |
|----|------|----------------|---------|-------------------|-----------|
| BI-01 | Precios promedio nacional | Cubo Precios | Periodo, producto | Valor promedio, variación | Crítico |
| BI-02 | Inventarios por región | Cubo Inventarios | Periodo, región, producto | Cantidades, días cobertura | Crítico |
| BI-03 | Margen comercial | Cubo Margenes | Periodo, agente, producto | Ingreso, costo, margen % | Alto |
| BI-04 | Indicador Observatorio 1 | Dashboard | Periodo | Valor indicador, tendencia | Crítico |
| BI-05 | Comparativo precios internacionales | Dashboard | Periodo, país | Gráfico comparativo | Alto |

### 4.5 Call Center (10 casos críticos)

| ID | Caso | Precondición | Pasos | Resultado Esperado | Prioridad |
|----|------|--------------|-------|-------------------|-----------|
| CC-01 | Llamada entrante agente | Sistema operativo | 1. Usuario llama 2. IVR responde 3. Opción 4. Cola 5. Agente | Llamada conectada, grabada | Crítico |
| CC-02 | Escalamiento supervisor | Agente no resuelve | 1. Agente solicita ayuda 2. Supervisor monitorea 3. Transferencia | Escalamiento <30 segundos | Crítico |
| CC-03 | Registro ticket desde llamada | Llamada atendida | 1. Agente abre ticket 2. Clasifica 3. Describe 4. Guarda | Ticket creado, ID asignado | Crítico |
| CC-04 | Consulta base conocimiento | Agente logueado | 1. Menú conocimiento 2. Buscar 3. Ver artículo | Artículo visible, útil | Alto |
| CC-05 | Reporte abandono | Llamadas del día | 1. Menú reportes 2. Seleccionar fecha 3. Generar | % abandono calculado | Alto |

---

## 5. CRITERIOS DE ACEPTACIÓN POR SISTEMA

### 5.1 SICOM Web

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Funcionalidad crítica | % casos pasados | 100% | 100% |
| Funcionalidad alta | % casos pasados | 95% | 100% |
| Funcionalidad media | % casos pasados | 90% | 95% |
| Tiempo respuesta | Segundos (promedio) | <5 | <3 |
| Disponibilidad | % uptime | 99.90% | 99.95% |
| Errores | # bugs críticos | 0 | 0 |
| Errores | # bugs mayores | ≤2 | 0 |

### 5.2 APP Móvil

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Instalación | % éxito iOS/Android | 100% | 100% |
| Login | % éxito | 100% | 100% |
| Reporte precio | % éxito | 100% | 100% |
| Sincronización offline | % éxito | 100% | 100% |
| Tiempo respuesta | Segundos | <5 | <3 |
| Consumo batería | % por hora uso | <10% | <5% |

### 5.3 Web Services

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Disponibilidad | % uptime | 99.90% | 99.95% |
| Tiempo respuesta | Milisegundos (promedio) | <500 | <300 |
| Tiempo respuesta | Milisegundos (p95) | <1000 | <800 |
| Código HTTP | % 2xx | 99% | 99.9% |
| Autenticación | % éxito | 100% | 100% |
| Payload | Validación schema | 100% | 100% |

### 5.4 Business Intelligence

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Disponibilidad cubos | % uptime | 99.90% | 99.95% |
| Tiempo consulta | Segundos (promedio) | <5 | <3 |
| Tiempo consulta | Segundos (p95) | <10 | <5 |
| Consistencia datos | % coincidencia vs fuente | 100% | 100% |
| ETLs | % ejecución sin errores | 100% | 100% |
| Dashboards | % widgets funcionando | 100% | 100% |

### 5.5 Call Center

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Llamada conectada | % éxito | 100% | 100% |
| Grabación | % grabada | 100% | 100% |
| Escalamiento | Segundos | <60 | <30 |
| Abandono | % | <20% | <15% |
| Satisfacción | % Bueno/Excelente | >80% | >90% |
| Ticket creado | % desde llamada | 100% | 100% |

### 5.6 Seguridad

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| Vulnerabilidades críticas | # | 0 | 0 |
| Vulnerabilidades altas | # | ≤2 | 0 |
| Vulnerabilidades medias | # | ≤5 | ≤2 |
| Autenticación | % éxito | 100% | 100% |
| Autorización | % accesos denegados correctos | 100% | 100% |
| Cifrado | TLS 1.2+ | 100% | 100% |

### 5.7 Recuperación (DRP)

| Criterio | Métrica | Valor Mínimo | Valor Objetivo |
|----------|---------|--------------|----------------|
| RPO | Minutos | ≤30 | ≤15 |
| RTO críticos | Horas | ≤2 | ≤1 |
| RTO mayores | Horas | ≤4 | ≤2 |
| Integridad datos | % consistencia | 100% | 100% |
| Failover DC | Minutos | ≤30 | ≤15 |

---

## 6. GESTIÓN DE DEFECTOS

### 6.1 Clasificación

| Severidad | Descripción | Ejemplo | Tiempo Resolución |
|-----------|-------------|---------|-------------------|
| Crítico | Bloquea operación, no hay workaround | Login falla, BD caída | ≤4 horas |
| Alto | Funcionalidad principal afectada, workaround complejo | Reporte precios no guarda | ≤24 horas |
| Medio | Funcionalidad secundaria afectada, workaround simple | Exportación Excel mal formato | ≤72 horas |
| Bajo | Cosmético, no afecta operación | Typo en mensaje | Próximo release |

### 6.2 Flujo de Gestión

```
Detectado → Registrado en Jira → Asignado → Análisis → Corrección → Prueba → Cerrado
     ↑___________________________________________________________________________|
```

### 6.3 Registro de Defectos

| ID | Descripción | Severidad | Responsable | Fecha Detección | Fecha Corrección | Estado |
|----|-------------|-----------|-------------|----------------|------------------|--------|
| | | | | | | |

---

## 7. ROLES Y RESPONSABILIDADES

| Rol | Responsabilidad | Persona |
|-----|-----------------|---------|
| Líder de Pruebas | Planificar, coordinar, reportar | QA Lead CI2 |
| Tester Funcional | Ejecutar casos de prueba, documentar | QA CI2 (2 personas) |
| Tester Rendimiento | Diseñar, ejecutar pruebas carga | QA + SysAdmin CI2 |
| Tester Seguridad | Ejecutar pentest, validar controles | Seguridad CI2 |
| Tester Integración | Validar APIs, Web Services | Dev CI2 |
| Tester BI | Validar cubos, ETLs, dashboards | BI CI2 |
| Tester Operación | Validar SOPs, monitoreo | Operación CI2 |
| Usuario Final (MME) | Ejecutar UAT, aprobar | 5 usuarios MME |
| Desarrollador | Corregir defectos | Devs CI2 |
| DBA | Validar datos, backups, restauración | DBA CI2 |
| SysAdmin | Preparar ambiente, validar infra | SysAdmin CI2 |
| PM (Jelkin) | Aprobar plan, resolver bloqueos, reportar | Jelkin |

---

## 8. ENTRADAS Y SALIDAS

### 8.1 Entradas (Prerrequisitos)

| # | Entrada | Responsable | Fecha Límite |
|---|---------|-------------|--------------|
| 1 | Ambiente de pruebas CI2 operativo | SysAdmin CI2 | 23 jun |
| 2 | Datos de prueba cargados y validados | DBA CI2 | 24 jun |
| 3 | Casos de prueba diseñados y revisados | QA CI2 | 24 jun |
| 4 | Herramientas de prueba instaladas | QA CI2 | 24 jun |
| 5 | Acceso a ambiente de pruebas para testers | SysAdmin CI2 | 24 jun |
| 6 | Usuarios MME disponibles para UAT | Jelkin → Luis | 28 jun |
| 7 | Documentación de referencia (manuales) | INTERNEXA | 24 jun |

### 8.2 Salidas (Entregables)

| # | Salida | Responsable | Fecha Límite |
|---|--------|-------------|--------------|
| 1 | Informe de pruebas funcionales | QA CI2 | 26 jun |
| 2 | Informe de pruebas de rendimiento | QA + SysAdmin | 27 jun |
| 3 | Informe de pruebas de seguridad | Seguridad CI2 | 27 jun |
| 4 | Informe de pruebas de recuperación | DBA + SysAdmin | 28 jun |
| 5 | Informe de pruebas de usuario (UAT) | QA CI2 | 29 jun |
| 6 | Registro de defectos (Jira) | QA CI2 | 30 jun |
| 7 | Acta de aceptación de pruebas | MME | 30 jun |
| 8 | Informe consolidado de pruebas | Jelkin | 30 jun |

---

## 9. RIESGOS DE PRUEBAS

| ID | Riesgo | Probabilidad | Impacto | Mitigación |
|----|--------|--------------|---------|------------|
| P1 | Ambiente de pruebas no replica producción | Media | Crítico | Validación previa, checklist de configuración |
| P2 | Datos de prueba incompletos o inconsistentes | Media | Crítico | Validación con DBA, subset representativo |
| P3 | Casos de prueba no cubren 100% funcionalidad | Baja | Alto | Revisión por pares, trazabilidad a requerimientos |
| P4 | Defectos críticos detectados post-corte | Baja | Crítico | Pruebas exhaustivas, plan de rollback |
| P5 | Usuarios MME no disponibles para UAT | Media | Alto | Confirmación previa, fechas alternas, proxy |
| P6 | Herramientas de prueba no funcionan | Baja | Medio | Herramientas alternas, instalación previa |
| P7 | Tiempo insuficiente para corrección de defectos | Media | Alto | Priorización por severidad, plan de contingencia |

---

## 10. PRESUPUESTO DE PRUEBAS

| Ítem | Costo Estimado (COP) |
|------|---------------------|
| Herramientas de prueba (licencias JMeter, Burp) | $3.000.000 |
| Infraestructura de pruebas (nube, VMs adicionales) | $5.000.000 |
| Logística usuarios MME (transporte, alimentación) | $2.000.000 |
| Consultor rendimiento (si aplica) | $4.000.000 |
| Contingencia (15%) | $2.100.000 |
| **TOTAL PRUEBAS** | **$16.100.000** |

---

**Documento generado por:** ZEUS — Innovadataco  
**Fecha generación:** 20 de mayo de 2026  
**Versión:** 1.0  
**Próxima actualización:** Post-ejecución de pruebas
