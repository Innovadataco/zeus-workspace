# CHECKLIST DE DOCUMENTACIÓN REQUERIDA — Empalme SICOM

**Proyecto:** Empalme SICOM MME  
**Fecha:** 20 de mayo de 2026  
**Responsable:** Jelkin Zair Carrillo Franco  
**Operador Saliente:** INTERNEXA S.A.  
**Operador Entrante:** CI2  

---

## INSTRUCCIONES DE USO

1. Marcar con ✅ cuando el documento sea recibido
2. Marcar con ⚠️ cuando esté pendiente o incompleto
3. Marcar con ❌ cuando no aplique o no exista
4. Registrar fecha de recepción y versión
5. Registrar observaciones en la columna correspondiente

---

## 1. DOCUMENTOS CONTRACTUALES Y ADMINISTRATIVOS

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 1.1 | Contrato Interadministrativo GGC-2034-2025 | CRÍTICA | ⚠️ | | | Solicitar a MME |
| 1.2 | Actas de inicio de ejecución contractual | CRÍTICA | ⚠️ | | | Solicitar a MME |
| 1.3 | Actas de reunión de seguimiento (todas) | ALTA | ⚠️ | | | Solicitar a INTERNEXA |
| 1.4 | Informes mensuales de gestión (todos) | ALTA | ⚠️ | | | Solicitar a INTERNEXA |
| 1.5 | Actas de modificación contractual (si aplica) | MEDIA | ⚠️ | | | Solicitar a MME |
| 1.6 | Actas de suspensión o prórroga (si aplica) | MEDIA | ⚠️ | | | Solicitar a MME |
| 1.7 | Certificados de pago y facturación | MEDIA | ⚠️ | | | Solicitar a MME |
| 1.8 | Garantías contractuales (cumplimiento, seriedad) | MEDIA | ⚠️ | | | Solicitar a MME |

---

## 2. ARQUITECTURA E INFRAESTRUCTURA

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 2.1 | Diagrama de arquitectura de solución SICOM (visión general) | CRÍTICA | ⚠️ | | | Debe incluir todos los componentes |
| 2.2 | Diagrama de arquitectura de red (VLANs, VPNs, firewalls) | CRÍTICA | ⚠️ | | | Incluir IPs, puertos, segmentos |
| 2.3 | Diagrama de arquitectura de seguridad (WAF, SIEM, UTM) | CRÍTICA | ⚠️ | | | Incluir flujo de tráfico |
| 2.4 | Diagrama de arquitectura de bases de datos (Oracle, SQL Server) | CRÍTICA | ⚠️ | | | Incluir réplicas, backups |
| 2.5 | Diagrama de arquitectura de aplicaciones (Java, BPM, Web) | CRÍTICA | ⚠️ | | | Incluir dependencias entre apps |
| 2.6 | Diagrama de arquitectura de integraciones (Web Services, VIGIA) | CRÍTICA | ⚠️ | | | Incluir endpoints, protocolos |
| 2.7 | Diagrama de arquitectura de Call Center | ALTA | ⚠️ | | | Incluir colas, IVR, grabación |
| 2.8 | Diagrama de arquitectura de BI (ETLs, cubos, dashboards) | ALTA | ⚠️ | | | Incluir fuentes de datos |
| 2.9 | Catálogo de servidores y VMs (nombre, IP, SO, recursos) | CRÍTICA | ⚠️ | | | Incluir credenciales de acceso |
| 2.10 | Catálogo de servicios en la nube (AWS, Azure, GCP) | CRÍTICA | ⚠️ | | | Incluir cuentas, regiones |
| 2.11 | Configuración de balanceadores y proxies | ALTA | ⚠️ | | | Incluir reglas, certificados |
| 2.12 | Configuración de DNS y dominios | ALTA | ⚠️ | | | Incluir registros, TTL |
| 2.13 | Plan de capacidad y crecimiento | MEDIA | ⚠️ | | | Incluir proyecciones 4% mensual |
| 2.14 | Documentación de DC principal (Bogotá) | ALTA | ⚠️ | | | Incluir certificación Tier III |
| 2.15 | Documentación de DC alterno (ciudad alterna) | ALTA | ⚠️ | | | Incluir certificación ANSI/TIA 942 |

---

## 3. BASES DE DATOS

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 3.1 | Esquema de base de datos Oracle (diagrama ER) | CRÍTICA | ⚠️ | | | Incluir tablas, relaciones, índices |
| 3.2 | Esquema de base de datos SQL Server (si aplica) | CRÍTICA | ⚠️ | | | Incluir tablas, relaciones, índices |
| 3.3 | Diccionario de datos (tablas, campos, tipos, descripciones) | CRÍTICA | ⚠️ | | | Debe estar actualizado |
| 3.4 | Scripts de creación de objetos (tablas, vistas, SPs, triggers) | CRÍTICA | ⚠️ | | | Incluir scripts DDL |
| 3.5 | Scripts de datos iniciales o maestros | CRÍTICA | ⚠️ | | | Incluir datos de referencia |
| 3.6 | Plan de respaldos (políticas, frecuencias, retención) | CRÍTICA | ⚠️ | | | Incluir RPO, RTO |
| 3.7 | Procedimientos de restauración de backups | CRÍTICA | ⚠️ | | | Paso a paso detallado |
| 3.8 | Configuración de RMAN (Oracle) | ALTA | ⚠️ | | | Incluir políticas, catálogo |
| 3.9 | Configuración de AlwaysOn/Clustering (si aplica) | ALTA | ⚠️ | | | Incluir nodos, quorum |
| 3.10 | Tuning y optimización de BD (parámetros, índices) | MEDIA | ⚠️ | | | Incluir recomendaciones |
| 3.11 | Jobs y procesos automatizados (cron, SQL Agent) | ALTA | ⚠️ | | | Incluir horarios, dependencias |
| 3.12 | Documentación de DataMart y ETLs | ALTA | ⚠️ | | | Incluir fuentes, transformaciones |

---

## 4. APLICACIONES Y DESARROLLO

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 4.1 | Código fuente SICOM Líquidos (Java) | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.2 | Código fuente SICOM Gas (Java) | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.3 | Código fuente Nuevo SICOM (BPM) | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.4 | Código fuente Web Services e integraciones | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.5 | Código fuente APPs móviles (iOS, Android) | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.6 | Código fuente BI (ETLs, cubos, reportes) | CRÍTICA | ⚠️ | | | Repositorio Git completo |
| 4.7 | Código fuente Call Center (software, IVR) | ALTA | ⚠️ | | | Repositorio Git completo |
| 4.8 | Scripts de despliegue y automatización (CI/CD) | ALTA | ⚠️ | | | Incluir pipelines |
| 4.9 | Documentación de APIs (Swagger, Postman) | CRÍTICA | ⚠️ | | | Incluir endpoints, payloads |
| 4.10 | Documentación de procesos BPM (modelos, flujos) | CRÍTICA | ⚠️ | | | Incluir diagramas BPMN |
| 4.11 | Manual de instalación y configuración de aplicaciones | CRÍTICA | ⚠️ | | | Paso a paso detallado |
| 4.12 | Manual de administración de aplicaciones | CRÍTICA | ⚠️ | | | Incluir tareas diarias, semanales |
| 4.13 | Manual de troubleshooting (errores comunes, soluciones) | ALTA | ⚠️ | | | Incluir logs, códigos de error |
| 4.14 | Documentación de versiones y releases (changelog) | ALTA | ⚠️ | | | Historial de cambios |
| 4.15 | Documentación de dependencias de librerías y frameworks | ALTA | ⚠️ | | | Incluir versiones, licencias |

---

## 5. SEGURIDAD

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 5.1 | Certificación ISO 27001:2022 vigente | CRÍTICA | ⚠️ | | | Validar vigencia |
| 5.2 | Informe SOC II vigente | CRÍTICA | ⚠️ | | | Validar vigencia |
| 5.3 | Políticas de seguridad de la información | CRÍTICA | ⚠️ | | | Incluir todas las políticas |
| 5.4 | Procedimientos de seguridad (accesos, cambios, incidentes) | CRÍTICA | ⚠️ | | | Incluir flujos de aprobación |
| 5.5 | Matriz de roles y permisos (RBAC) | CRÍTICA | ⚠️ | | | Incluir usuarios, grupos, privilegios |
| 5.6 | Configuración de WAF (reglas, políticas) | ALTA | ⚠️ | | | Incluir reglas personalizadas |
| 5.7 | Configuración de firewalls (reglas, NAT, VPN) | ALTA | ⚠️ | | | Incluir reglas de filtrado |
| 5.8 | Configuración de SIEM (fuentes, correlaciones, alertas) | ALTA | ⚠️ | | | Incluir dashboards |
| 5.9 | Certificados TLS/SSL (wildcards, dominios) | CRÍTICA | ⚠️ | | | Incluir fechas de vencimiento |
| 5.10 | Plan de recuperación ante desastres (DRP) | CRÍTICA | ⚠️ | | | Aprobado por MME |
| 5.11 | Resultados de pentests y auditorías de seguridad | ALTA | ⚠️ | | | Incluir hallazgos, remediaciones |
| 5.12 | Logs de seguridad (últimos 6 meses) | ALTA | ⚠️ | | | Incluir SIEM, firewalls, WAF |
| 5.13 | Inventario de vulnerabilidades y parches | ALTA | ⚠️ | | | Incluir estado de remediación |
| 5.14 | Procedimientos de respuesta a incidentes de seguridad | CRÍTICA | ⚠️ | | | Incluir escalamiento, comunicación |

---

## 6. OPERACIÓN Y MANTENIMIENTO

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 6.1 | Procedimientos operativos estándar (SOPs) | CRÍTICA | ⚠️ | | | Todos los procesos operativos |
| 6.2 | Manual de operación de la plataforma SICOM | CRÍTICA | ⚠️ | | | Incluir tareas diarias, semanales, mensuales |
| 6.3 | Manual de monitoreo (herramientas, umbrales, alertas) | CRÍTICA | ⚠️ | | | Incluir dashboards, KPIs |
| 6.4 | Manual de respaldo y recuperación | CRÍTICA | ⚠️ | | | Incluir RPO, RTO, procedimientos |
| 6.5 | Manual de gestión de cambios | CRÍTICA | ⚠️ | | | Incluir categorías, aprobaciones |
| 6.6 | Manual de gestión de incidentes | CRÍTICA | ⚠️ | | | Incluir clasificación, escalamiento |
| 6.7 | Manual de gestión de problemas | ALTA | ⚠️ | | | Incluir análisis de causa raíz |
| 6.8 | Manual de gestión de configuración (CMDB) | ALTA | ⚠️ | | | Incluir CIs, relaciones |
| 6.9 | Calendario de mantenimiento preventivo | ALTA | ⚠️ | | | Incluir ventanas, impacto |
| 6.10 | Procedimientos de parches y actualizaciones | ALTA | ⚠️ | | | Incluir pruebas, rollback |
| 6.11 | Documentación de herramientas de monitoreo (Nagios, Zabbix, Grafana) | ALTA | ⚠️ | | | Incluir configuración, plugins |
| 6.12 | Runbooks (procedimientos paso a paso para incidentes comunes) | ALTA | ⚠️ | | | Incluir comandos, verificaciones |

---

## 7. CALL CENTER Y MESA DE SERVICIO

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 7.1 | Manual de operación del Call Center | CRÍTICA | ⚠️ | | | Incluir flujos, scripts, escalamiento |
| 7.2 | Configuración de software Call Center (colas, IVR, skill groups) | CRÍTICA | ⚠️ | | | Incluir grabaciones, reportes |
| 7.3 | Base de conocimiento del Call Center (FAQs, procedimientos) | ALTA | ⚠️ | | | Incluir categorías, búsqueda |
| 7.4 | Manual de operación de la mesa de servicio (ITSM) | CRÍTICA | ⚠️ | | | Incluir flujos, SLAs, categorías |
| 7.5 | Configuración de ITSM (ServiceNow/Jira Service Desk) | CRÍTICA | ⚠️ | | | Incluir workflows, campos |
| 7.6 | Catálogo de servicios de la mesa de servicio | ALTA | ⚠️ | | | Incluir descripciones, SLAs |
| 7.7 | Reportes y métricas del Call Center (históricos) | ALTA | ⚠️ | | | Incluir abandono, satisfacción |
| 7.8 | Reportes y métricas de la mesa de servicio (históricos) | ALTA | ⚠️ | | | Incluir tiempos, resolución |
| 7.9 | Plantillas de comunicación al usuario | MEDIA | ⚠️ | | | Incluir notificaciones, boletines |
| 7.10 | Directorio de contactos de escalamiento | ALTA | ⚠️ | | | Incluir roles, disponibilidad |

---

## 8. CAPACITACIÓN Y USUARIOS

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 8.1 | Manual de usuario SICOM Web (agentes, administradores) | CRÍTICA | ⚠️ | | | Incluir todos los roles |
| 8.2 | Manual de usuario APP móvil (iOS, Android) | CRÍTICA | ⚠️ | | | Incluir instalación, uso |
| 8.3 | Manual de usuario Call Center (agentes, supervisores) | ALTA | ⚠️ | | | Incluir funcionalidades |
| 8.4 | Manual de usuario BI (consulta de cubos, dashboards) | ALTA | ⚠️ | | | Incluir filtros, exportación |
| 8.5 | Material de capacitación histórico (presentaciones, videos) | ALTA | ⚠️ | | | Incluir fechas, asistentes |
| 8.6 | Plan de capacitación anual | ALTA | ⚠️ | | | Incluir temas, fechas, responsables |
| 8.7 | Evaluaciones de capacitación (resultados, satisfacción) | MEDIA | ⚠️ | | | Incluir métricas |
| 8.8 | Matriz de usuarios y perfiles (SICOM, Web, APP, BI) | CRÍTICA | ⚠️ | | | Incluir permisos, vigencia |
| 8.9 | Procedimientos de creación y modificación de usuarios | ALTA | ⚠️ | | | Incluir aprobaciones |
| 8.10 | Procedimientos de restablecimiento de contraseñas | ALTA | ⚠️ | | | Incluir verificación de identidad |

---

## 9. BUSINESS INTELLIGENCE Y REPORTES

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 9.1 | Documentación de cubos OLAP (dimensiones, medidas, fuentes) | CRÍTICA | ⚠️ | | | Incluir esquemas, agregaciones |
| 9.2 | Documentación de ETLs (fuentes, transformaciones, destinos) | CRÍTICA | ⚠️ | | | Incluir flujos, dependencias |
| 9.3 | Documentación de dashboards (filtros, indicadores, fuentes) | ALTA | ⚠️ | | | Incluir interacciones |
| 9.4 | Catálogo de reportes estándar (descripción, frecuencia, destinatarios) | ALTA | ⚠️ | | | Incluir formatos, distribución |
| 9.5 | Procedimientos de generación de reportes ad-hoc | ALTA | ⚠️ | | | Incluir herramientas, permisos |
| 9.6 | Matriz de indicadores del Observatorio (definición, fórmula, fuente) | ALTA | ⚠️ | | | Incluir 30 indicadores |
| 9.7 | Procedimientos de validación de datos del BI | ALTA | ⚠️ | | | Incluir reconciliaciones |
| 9.8 | Documentación de herramientas BI (SSAS, SSIS, Power BI) | ALTA | ⚠️ | | | Incluir versiones, configuración |

---

## 10. INTEGRACIONES Y WEB SERVICES

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 10.1 | Catálogo de Web Services (endpoints, métodos, payloads) | CRÍTICA | ⚠️ | | | Incluir WSDL, Swagger |
| 10.2 | Documentación de integración con VIGIA | CRÍTICA | ⚠️ | | | Incluir flujo de datos |
| 10.3 | Documentación de integración con entidades externas (ESP, EDS) | CRÍTICA | ⚠️ | | | Incluir protocolos, frecuencias |
| 10.4 | Documentación de integración con SICERCO | ALTA | ⚠️ | | | Incluir flujo de certificados |
| 10.5 | Documentación de integración con RUES | ALTA | ⚠️ | | | Incluir flujo de empresas |
| 10.6 | Documentación de integración con SUI | ALTA | ⚠️ | | | Incluir flujo de servicios públicos |
| 10.7 | Procedimientos de monitoreo de integraciones | ALTA | ⚠️ | | | Incluir alertas, escalamiento |
| 10.8 | Procedimientos de resolución de fallos en integraciones | ALTA | ⚠️ | | | Incluir diagnóstico, rollback |
| 10.9 | Contratos de datos con entidades externas | MEDIA | ⚠️ | | | Incluir vigencia, responsables |

---

## 11. FORMULACIÓN Y ESTADÍSTICA

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 11.1 | Manual de formulación de combustibles | CRÍTICA | ⚠️ | | | Incluir fórmulas, parámetros |
| 11.2 | Procedimientos de cálculo de precios de referencia | CRÍTICA | ⚠️ | | | Incluir fuentes, frecuencias |
| 11.3 | Procedimientos de validación de precios reportados | CRÍTICA | ⚠️ | | | Incluir umbrales, alertas |
| 11.4 | Metodologías estadísticas del Observatorio | ALTA | ⚠️ | | | Incluir NTC PE 1000 |
| 11.5 | Documentación de indicadores del Observatorio | ALTA | ⚠️ | | | Incluir definición, cálculo |
| 11.6 | Procedimientos de publicación de estadísticas | ALTA | ⚠️ | | | Incluir calendario, formatos |
| 11.7 | Historial de precios de referencia | ALTA | ⚠️ | | | Incluir desde inicio del sistema |
| 11.8 | Historial de indicadores del Observatorio | ALTA | ⚠️ | | | Incluir series temporales |

---

## 12. LEGALES Y CONFIDENCIALIDAD

| # | Documento | Prioridad | Estado | Fecha Recepción | Versión | Observaciones |
|---|-----------|-----------|--------|-----------------|---------|---------------|
| 12.1 | Acuerdo de confidencialidad entre INTERNEXA y CI2 | CRÍTICA | ⚠️ | | | Firmado por ambas partes |
| 12.2 | Acta de entrega y recibo de información | CRÍTICA | ⚠️ | | | Firmada por MME, INTERNEXA, CI2 |
| 12.3 | Inventario de propiedad intelectual (código, documentos, datos) | CRÍTICA | ⚠️ | | | Confirmar propiedad MME |
| 12.4 | Inventario de licencias de software (propiedad, vigencia) | CRÍTICA | ⚠️ | | | Incluir transferibilidad |
| 12.5 | Cláusulas de no competencia (si aplica) | MEDIA | ⚠️ | | | Revisar con legal |
| 12.6 | Compromisos de eliminación de información post-contrato | CRÍTICA | ⚠️ | | | Confirmar procedimientos |

---

## RESUMEN DE ESTADO

| Categoría | Total Docs | Críticos | Recibidos | Pendientes | % Avance |
|-----------|------------|----------|-----------|------------|----------|
| Contractuales | 8 | 2 | 0 | 8 | 0% |
| Arquitectura | 15 | 6 | 0 | 15 | 0% |
| Bases de Datos | 12 | 6 | 0 | 12 | 0% |
| Aplicaciones | 15 | 6 | 0 | 15 | 0% |
| Seguridad | 14 | 5 | 0 | 14 | 0% |
| Operación | 12 | 5 | 0 | 12 | 0% |
| Call Center / Mesa | 10 | 4 | 0 | 10 | 0% |
| Capacitación | 10 | 2 | 0 | 10 | 0% |
| BI y Reportes | 8 | 2 | 0 | 8 | 0% |
| Integraciones | 9 | 3 | 0 | 9 | 0% |
| Formulación | 8 | 3 | 0 | 8 | 0% |
| Legales | 6 | 4 | 0 | 6 | 0% |
| **TOTAL** | **117** | **48** | **0** | **117** | **0%** |

---

## PRÓXIMAS ACCIONES

| # | Acción | Responsable | Fecha Límite |
|---|--------|-------------|--------------|
| 1 | Solicitar checklist a INTERNEXA (carta formal) | Jelkin | 23 mayo |
| 2 | Reunión de revisión de documentación con INTERNEXA | Jelkin + Equipo | 27 mayo |
| 3 | Primera revisión de avance de recepción | Jelkin | 30 mayo |
| 4 | Escalamiento a MME si hay retrasos | Jelkin → Luis | 02 junio |
| 5 | Validación de documentos críticos recibidos | Líder Técnico | 05 junio |

---

**Documento generado por:** ZEUS — Innovadataco  
**Fecha generación:** 20 de mayo de 2026  
**Versión:** 1.0  
**Próxima actualización:** Semanal durante el empalme
