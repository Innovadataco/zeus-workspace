# PLAN DE GESTIÓN DE LA CALIDAD DEL EMPALME SICOM
## Empalme Operativo SICOM — CI2 ↔ INTERNEXA ↔ MME

---

**Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto CI2:** Luis Felipe Herrera (CI2 / IND TECH)  
**Director de Empalme / PM Ejecutivo:** Jelkin Zair Carrillo Franco (Innovadataco)  
**Versión:** 1.0  
**Fecha:** 20 de Mayo de 2026  
**Aprobador:** Luis Felipe Herrera (CI2)

---

## 1. OBJETIVOS DE CALIDAD DEL EMPALME

### 1.1 Objetivo General
Garantizar que la transferencia del sistema SICOM desde INTERNEXA a CI2 cumpla con los estándares técnicos, funcionales y de seguridad requeridos para una operación continua y sin interrupciones.

### 1.2 Objetivos Específicos
1. Validar que todos los dominios técnicos (D1-D10) cumplan con criterios de aceptación medibles
2. Asegurar la integridad de datos durante todo el proceso de empalme
3. Verificar que la infraestructura destino de CI2 sopere la carga operativa real
4. Confirmar que el equipo CI2 tenga dominio técnico mínimo viable post-corte
5. Documentar evidencia formal de cada validación para auditoría futura

---

## 2. CRITERIOS DE CALIDAD POR DOMINIO TÉCNICO

### D1. INFRAESTRUCTURA

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Inventario completo | 100% de VMs, storage, red documentados | Checklist vs ambiente real | Especialista Infra CI2 |
| Arquitectura aterrizada | Diagramas coinciden con operación | Validación visual + pruebas | Especialista Infra CI2 |
| Certificados vigentes | >90 días de validez restante | Revisión de fechas de vencimiento | Especialista Seguridad CI2 |
| Redundancia de red | Enlaces duplicados confirmados | Prueba de failover | Especialista Infra CI2 |
| Capacidad de storage | >30% de espacio libre post-migración | Medición real | Especialista Infra CI2 |

### D2. CÓDIGO Y DESPLIEGUE

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Repositorios clonados | 100% del código fuente transferido | Git log + diff | Especialista Apps CI2 |
| Pipelines funcionales | Build + deploy exitoso en ambiente CI2 | Ejecución de pipeline | Especialista Apps CI2 |
| Artefactos versionados | Todos los artefactos identificados | Inventario de artefactos | Especialista Apps CI2 |
| Rollback validado | Rollback ejecutado exitosamente en <30 min | Prueba de rollback | Especialista Apps CI2 |
| Variables de entorno | Configuración documentada y transferida | Checklist de variables | Especialista Apps CI2 |

### D3. BASE DE DATOS

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Restore exitoso | 100% de bases restauradas en ambiente CI2 | Ejecución de restore | Especialista BD CI2 |
| Integridad referencial | 0 inconsistencias detectadas | Scripts de validación | Especialista BD CI2 |
| Completitud de objetos | 100% de tablas, índices, procedimientos transferidos | Comparación esquema origen vs destino | Especialista BD CI2 |
| Volumen de datos | <5% de diferencia en conteos de registros | Conteos post-restore | Especialista BD CI2 |
| Jobs programados | Todos los jobs identificados y documentados | Inventario de jobs | Especialista BD CI2 |

### D4. SEGURIDAD

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Escaneo de vulnerabilidades | 0 vulnerabilidades críticas | Informe de escaneo | Especialista Seguridad CI2 |
| RBAC transferido | 100% de roles y permisos replicados | Validación de accesos | Especialista Seguridad CI2 |
| MFA habilitado | Autenticación multifactor funcionando | Prueba de login | Especialista Seguridad CI2 |
| SIEM integrado | Logs operacionales visibles en SIEM de CI2 | Verificación de dashboards | Especialista Seguridad CI2 |
| Hardening aplicado | Checklist de hardening completado | Auditoría de configuración | Especialista Seguridad CI2 |

### D5. INTEGRACIONES

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Conectividad de APIs | 100% de endpoints respondiendo | Pruebas de conectividad | Especialista Apps CI2 |
| Servicios web operativos | Todos los servicios levantados y funcionando | Health checks | Especialista Apps CI2 |
| Colas de mensajes | Sin mensajes pendientes >24h | Monitoreo de colas | Especialista Apps CI2 |
| Notificaciones funcionando | Envío de notificaciones validado | Prueba de notificación | Especialista Apps CI2 |

### D6. OPERACIÓN

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Runbooks completos | 100% de procesos críticos documentados | Revisión de runbooks | Especialista Operación CI2 |
| Turnos 24/7 definidos | Calendario de turnos establecido | Documento de turnos | Especialista Operación CI2 |
| Mesa de ayuda configurada | Sistema de tickets funcionando | Prueba de creación de ticket | Especialista Operación CI2 |
| Escalamiento definido | Matriz de escalamiento documentada | Revisión de matriz | Especialista Operación CI2 |

### D7. CONTINUIDAD DEL NEGOCIO

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| RPO validado | <4 horas de pérdida de datos aceptable | Simulacro de restore | Especialista BD CI2 |
| RTO validado | <8 horas de recuperación del servicio | Simulacro de conmutación | Especialista Infra CI2 |
| Sitio alterno operativo | Replicación funcionando en sitio alterno | Prueba de replicación | Especialista Infra CI2 |
| Simulacro ejecutado | Simulacro de contingencia exitoso | Acta de simulacro | Jelkin Carrillo |

### D8. DOCUMENTACIÓN

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Carpeta maestra consolidada | Toda la documentación en repositorio único | Revisión de estructura de carpetas | Jelkin Carrillo |
| Documentación técnica completa | Arquitectura, diseño, configuraciones documentadas | Checklist de documentos | Especialista Infra CI2 |
| Documentación operativa completa | Procedimientos, runbooks, FAQs documentadas | Revisión de runbooks | Especialista Operación CI2 |
| Documentación de usuario | Manuales de usuario actualizados | Revisión de manuales | Especialista Apps CI2 |

### D9. GOBIERNO Y CALIDAD

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Actas completas | 100% de reuniones con acta firmada | Revisión de actas | Jelkin Carrillo |
| RAID actualizado | Matriz de riesgos, acciones, decisiones, issues actualizada | Revisión semanal | Jelkin Carrillo |
| Comité operativo | Comité directivo funcionando según acta de constitución | Verificación de reuniones | Jelkin Carrillo |

### D10. TRANSFERENCIA DE CONOCIMIENTO

| Criterio | Métrica | Método de Verificación | Responsable |
|----------|---------|------------------------|-------------|
| Sesiones grabadas | 100% de sesiones de transferencia grabadas | Inventario de grabaciones | Jelkin Carrillo |
| Runbooks construidos | 100% de procesos críticos con runbook CI2 propio | Revisión de runbooks | Especialista Operación CI2 |
| Validación funcional | Casos críticos de negocio ejecutados exitosamente | Pruebas funcionales | Especialista Apps CI2 |
| Shadowing completado | 40 horas de shadowing por especialista CI2 | Registro de horas | Jelkin Carrillo |

---

## 3. PROCESO DE ASEGURAMIENTO DE CALIDAD

### 3.1 Fase de Validación por Dominio

```
[ENTREGA INTERNEXA] → [VALIDACIÓN CI2] → [APROBACIÓN] → [REGISTRO]
      ↓                      ↓                ↓            ↓
   Documentos            Checklist        Firma         Acta
   Accesos               Pruebas          Aceptación     Evidencia
   Código                Revisión         Go/No-Go       RAID
```

### 3.2 Roles de Calidad

| Rol | Responsabilidad | Persona |
|-----|-----------------|---------|
| **Aseguramiento de Calidad** | Definir criterios, auditar cumplimiento, reportar desviaciones | Jelkin Carrillo |
| **Control de Calidad Técnico** | Ejecutar validaciones técnicas, documentar hallazgos | Especialistas CI2 |
| **Aceptación Formal** | Firmar actas de recibo, aprobar hitos | Luis Herrera (CI2) + Elizabeth (MME) |

### 3.3 Herramientas de Calidad

| Propósito | Herramienta | Uso |
|-----------|-------------|-----|
| Checklist de validación | Google Sheets / Excel | Validación por dominio |
| Registro de hallazgos | GitHub Issues | Tracking de bugs y observaciones |
| Escaneo de vulnerabilidades | [Por definir según stack] | Seguridad |
| Pruebas de rendimiento | [Por definir según stack] | Estrés y carga |
| Monitoreo de calidad | Dashboard PM2 | Métricas en tiempo real |

---

## 4. GESTIÓN DE NO CONFORMIDADES

### 4.1 Clasificación de Hallazgos

| Severidad | Definición | Ejemplo | Tiempo de Resolución |
|-----------|------------|---------|---------------------|
| **Crítica** | Bloquea el empalme, riesgo de falla total | Backups no restaurables, caída de servicio | 24 horas |
| **Alta** | Afecta dominio técnico, requiere acción antes del corte | Documentación incompleta, credenciales faltantes | 72 horas |
| **Media** | Debe resolverse antes de estabilización | Configuración subóptima, performance degradada | 1 semana |
| **Baja** | Mejora recomendada, no bloqueante | Documentación desactualizada, optimización menor | Post-empalme |

### 4.2 Proceso de Manejo de Hallazgos

1. **Detección:** Especialista CI2 identifica hallazgo durante validación
2. **Registro:** Documentar en GitHub Issues con severidad y evidencia
3. **Notificación:** Alertar a Jelkin Carrillo y Luis Herrera si es Crítica/Alta
4. **Asignación:** Asignar responsable de cierre (INTERNEXA o CI2)
5. **Seguimiento:** Monitorear diariamente hasta cierre
6. **Validación:** Revalidar por especialista CI2 una vez corregido
7. **Cierre:** Documentar resolución y cerrar issue

---

## 5. AUDITORÍAS Y REVISIONES

### 5.1 Auditorías Programadas

| Auditoría | Frecuencia | Responsable | Enfoque |
|-----------|------------|-------------|---------|
| Revisión de dominios técnicos | Semanal | Jelkin Carrillo | % de validación por dominio |
| Revisión de riesgos y hallazgos | Semanal | Jelkin Carrillo | Estado de no conformidades |
| Revisión de documentación | Quincenal | Jelkin Carrillo | Completitud y calidad de actas |
| Auditoría de seguridad | Semana 5 | Especialista Seguridad | Escaneo de vulnerabilidades |
| Auditoría de calidad pre-corte | Semana 6 | Jelkin Carrillo | Checklist final Go/No-Go |

### 5.2 Revisiones por Fase

| Fase | Revisión | Participantes | Entregable |
|------|----------|---------------|------------|
| Fin Semana 2 | Revisión de inventario | CI2 + INTERNEXA + MME | Acta de inventario validado |
| Fin Semana 4 | Revisión de restore | CI2 + INTERNEXA | Acta de restore validado |
| Fin Semana 5 | Revisión de operación en sombra | CI2 + INTERNEXA | Acta de shadowing completado |
| Fin Semana 6 | Revisión pre-corte (Go/No-Go) | CI2 + MME + INTERNEXA | Decisión formal de corte |

---

## 6. INDICADORES DE CALIDAD (KPIs)

| KPI | Meta | Frecuencia de Medición | Responsable |
|-----|------|------------------------|-------------|
| % de dominios técnicos validados | 100% | Semanal | Jelkin Carrillo |
| # de hallazgos críticos abiertos | 0 | Diario | Jelkin Carrillo |
| # de hallazgos altos abiertos | < 3 | Semanal | Jelkin Carrillo |
| % de documentación completa | 100% | Quincenal | Jelkin Carrillo |
| % de casos de prueba exitosos | > 95% | Por fase | Especialistas CI2 |
| Tiempo promedio de resolución de hallazgos | < 48h | Semanal | Jelkin Carrillo |
| Satisfacción de Luis Herrera con calidad | > 90% | Mensual | Jelkin Carrillo |

---

## 7. APROBACIÓN DEL PLAN DE CALIDAD

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| Gerente de Proyecto CI2 | Luis Felipe Herrera | _________________ | 20/05/2026 |
| Director de Empalme / PM Ejecutivo | Jelkin Zair Carrillo Franco | _________________ | 20/05/2026 |
| Supervisora MME | Elizabeth | _________________ | 20/05/2026 |

---

**Luis Felipe Herrera**  
*Gerente de Proyecto CI2 — IND TECH / CI2*

**Jelkin Zair Carrillo Franco**  
*Director de Empalme / PM Ejecutivo — Innovadataco*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*