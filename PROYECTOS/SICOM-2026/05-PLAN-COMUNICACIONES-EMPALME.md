# PLAN DE GESTIÓN DE COMUNICACIONES DEL EMPALME SICOM
## Empalme Operativo SICOM — CI2 ↔ INTERNEXA ↔ MME

---

**Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto:** Jelkin Zair Carrillo Franco (CI2)  
**Versión:** 1.0  
**Fecha:** 20 de Mayo de 2026  
**Aprobador:** Jelkin Zair Carrillo Franco (CI2)

---

## 1. OBJETIVOS DEL PLAN DE COMUNICACIONES

1. Asegurar que toda la información del empalme fluya de manera oportuna y efectiva
2. Mantener a los stakeholders informados según sus necesidades e intereses
3. Documentar TODAS las comunicaciones formales del empalme
4. Establecer canales claros para consultas, decisiones y alertas
5. Facilitar la gestión de expectativas del MME (Elizabeth) y de INTERNEXA
6. Garantizar trazabilidad de decisiones, entregas y acuerdos

---

## 2. STAKEHOLDERS Y REQUERIMIENTOS DE INFORMACIÓN

| Stakeholder | Información Requerida | Frecuencia | Formato | Canal |
|-------------|----------------------|------------|---------|-----|
| **Elizabeth (MME)** | Avance empalme, hitos, riesgos, decisiones | Semanal + Eventos | Informe formal + Reuniones | Email + Videollamada |
| **INTERNEXA (Saliente)** | Solicitudes de entrega, actas, validaciones | Diaria + Eventos | Matriz de entregables + Actas | Email + Reuniones técnicas |
| **Equipo CI2 (Técnicos)** | Tareas, prioridades, hallazgos, dependencias | Diaria | Mesa técnica + Grupo de trabajo | Presencial / Teams |
| **Jelkin Carrillo (PM)** | Todo: operativo, estratégico, contractual | Diario + A demanda | Dashboard + Mensajes | Telegram + Llamada |
| **Diana Cáceres (Legal)** | Aspectos legales, actas, contratos | Según necesidad | Resumen legal | Email + Telegram |
| **Proveedores Telecom** | Avance instalación, incidencias | Diaria (durante instalación) | Reporte de avance | Email + Llamada |

---

## 3. ESTRUCTURA DE COMUNICACIONES

### 3.1 Comunicaciones Internas (CI2)

#### Mesa Técnica CI2 (Diaria)

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | Diaria (Lunes a Viernes) |
| **Horario** | 8:00 AM (Hora Colombia) |
| **Duración** | 15-30 minutos |
| **Formato** | Presencial / Google Meet / Teams |
| **Agenda** | Estado del día anterior, tareas del día, bloqueos, dependencias |
| **Registro** | Acta diaria breve (formato estándar) |
| **Responsable** | Jelkin Carrillo (PM) |
| **Participantes** | Especialistas CI2 (Seguridad, Infra, BD, Apps, Operación) |

#### Mesa Técnica con INTERNEXA (Diaria)

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | Diaria (Lunes a Viernes) |
| **Horario** | 10:00 AM (Hora Colombia) |
| **Duración** | 30-45 minutos |
| **Formato** | Videollamada / Presencial si aplica |
| **Agenda** | Entregas del día, validaciones, hallazgos, plan siguiente día |
| **Registro** | Acta formal con formato estándar |
| **Responsable** | Jelkin Carrillo (PM) |
| **Participantes** | CI2 + Representantes INTERNEXA |

#### Informe Diario a Jelkin (Automático)

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | 7:00 PM (Hora Colombia) |
| **Canal** | Telegram |
| **Contenido** | Estado del día, % avance, alertas, decisiones pendientes |
| **Formato** | Dashboard compacto (texto) |
| **Ejecución** | ZEUS genera automáticamente |

### 3.2 Comunicaciones Externas (MME / INTERNEXA)

#### Reuniones de Seguimiento con Elizabeth (MME)

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | Semanal (cada martes 2:00 PM) |
| **Participantes** | Jelkin Carrillo (PM) + Elizabeth (MME) |
| **Duración** | 30-45 minutos |
| **Formato** | Videollamada (Meet/Teams) |
| **Agenda** | Avance %, hitos, riesgos, decisiones requeridas, próximos pasos |
| **Registro** | Acta enviada en 24h |
| **Responsable** | Jelkin Carrillo (genera contenido, ZEUS documenta) |

#### Informes Quincenales al MME

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | Cada 15 días (15 y 30 de cada mes) |
| **Contenido** | Avance %, entregables completados, hitos, riesgos, próximas actividades |
| **Formato** | PDF formal (1-2 páginas) |
| **Canal** | Email a Elizabeth |
| **Preparación** | ZEUS genera borrador, Jelkin revisa y envía |

#### Entregas Formales a INTERNEXA

| Aspecto | Descripción |
|---------|-------------|
| **Frecuencia** | Según cronograma de empalme |
| **Contenido** | Matriz de requerimientos, solicitudes de entrega, actas de validación |
| **Formato** | Documentos formales con formato PM2 |
| **Canal** | Email formal + Drive compartido |
| **Responsable** | Jelkin Carrillo envía, ZEUS prepara contenido |
| **Registro** | Fecha de envío, fecha de respuesta, trazabilidad |

---

## 4. PROTOCOLOS DE COMUNICACIÓN

### 4.1 Protocolo para Alertas y Urgencias

**Nivel CRÍTICO (🔴):**
- **Situación:** Riesgo de no cumplir hito, problema legal, bloqueo total del empalme, caída de SICOM
- **Tiempo respuesta:** Inmediato (menos de 1 hora)
- **Canal:** Llamada telefónica + Telegram + Email
- **Destinatario:** Jelkin + Elizabeth + Diana (si es legal)
- **Ejemplo:** "Alerta: INTERNEXA no entrega backups, bloquea Semana 4"

**Nivel ALTO (🟡):**
- **Situación:** Riesgo de retraso, observaciones importantes, consulta urgente del MME
- **Tiempo respuesta:** Mismo día (menos de 4 horas)
- **Canal:** Telegram prioritario + Email
- **Destinatario:** Jelkin + Stakeholder relevante
- **Ejemplo:** "Urgente: Elizabeth solicita reunión mañana para revisar riesgos"

**Nivel MEDIO (🟢):**
- **Situación:** Información importante, actualización de estado, avance normal
- **Tiempo respuesta:** 24 horas
- **Canal:** Email o Telegram normal
- **Destinatario:** Según matriz de stakeholders

### 4.2 Protocolo para Decisiones

1. **Identificación:** ZEUS o Jelkin detecta necesidad de decisión
2. **Análisis:** ZEUS presenta opciones + recomendación
3. **Consulta:** Jelkin evalúa (con Diana si es legal/contractual)
4. **Decisión:** Jelkin decide o escala a Elizabeth si afecta MME
5. **Ejecución:** ZEUS documenta y ejecuta
6. **Registro:** DEC-XXX en documentación del empalme

### 4.3 Protocolo para Cambios

1. **Solicitud:** INTERNEXA, MME o equipo identifica cambio necesario
2. **Evaluación:** ZEUS analiza impacto (alcance, tiempo, costo)
3. **Recomendación:** ZEUS presenta análisis a Jelkin
4. **Negociación:** Jelkin dialoga con MME o INTERNEXA si es externo
5. **Aprobación:** Documentar aceptación del cambio
6. **Implementación:** Ajustar planes y documentación
7. **Registro:** CAMBIO-XXX en Registro de Cambios

---

## 5. FORMATOS DE COMUNICACIÓN

### 5.1 Informe de Avance Quincenal (al MME)

```
INFORME DE AVANCE - EMPALME SICOM
Fecha: [DD/MM/YYYY] | Período: [Fecha inicio] a [Fecha fin]
Empalme: EMP-SICOM-2026-01 | Gerente: Jelkin Zair Carrillo (CI2)

1. RESUMEN EJECUTIVO
   • Avance general: XX%
   • Estado: [🟢 A tiempo / 🟡 En riesgo / 🔴 Retrasado]
   • Hitos alcanzados: [Lista]

2. DOMINIOS TÉCNICOS
   • Completados: [D1, D2...]
   • En validación: [D3... XX%]
   • Próximos: [D4...]

3. CRONOGRAMA
   • Días restantes: XX
   • Desviación: +/- X días

4. RIESGOS Y PROBLEMAS
   • [Lista de riesgos activos]

5. PRÓXIMAS ACTIVIDADES (Próximos 15 días)
   • [Lista de tareas]

6. DECISIONES REQUERIDAS DEL MME
   • [Si aplica]

Elaborado por: ZEUS | Aprobado por: Jelkin Carrillo, PM CI2
```

### 5.2 Acta de Mesa Técnica (Diaria con INTERNEXA)

```
ACTA DE MESA TÉCNICA - EMPALME SICOM
Fecha: [DD/MM/YYYY] | Hora: [HH:MM] - [HH:MM]
Lugar/Canal: [Presencial / Videollamada]
Empalme: EMP-SICOM-2026-01

ASISTENTES:
• [Nombre] - [Rol] - [Entidad]
• ...

AGENDA:
1. [Tema 1]
2. [Tema 2]
3. ...

ENTREGAS DEL DÍA:
• [Entregable] - [Estado] - [Observaciones]

HALLAZGOS:
• [Hallazgo] - [Severidad] - [Acción]

DECISIONES:
• DEC-XXX: [Descripción de decisión]

ACCIONES PENDIENTES:
| Acción | Responsable | Fecha límite | Entidad |
|--------|-------------|--------------|---------|
| [Acción] | [Nombre] | [Fecha] | [CI2/INTERNEXA/MME] |

PRÓXIMA MESA TÉCNICA:
Fecha: [DD/MM/YYYY] | Hora: [HH:MM]

Registrado por: ZEUS | Fecha acta: [DD/MM/YYYY]
```

### 5.3 Solicitud Formal de Entregables (a INTERNEXA)

```
SOLICITUD DE ENTREGABLES - EMPALME SICOM
Fecha: [DD/MM/YYYY]
Referencia: SOL-XXX-EMP-SICOM-2026
De: Jelkin Zair Carrillo Franco, Gerente Proyecto CI2
Para: [Responsable Técnico], INTERNEXA S.A.
CC: Elizabeth, Supervisora MME

REQUERIMIENTOS:
| # | Entregable | Descripción | Fecha Límite | Criterio Aceptación |
|---|------------|-------------|--------------|---------------------|
| 1 | [Nombre] | [Descripción] | [Fecha] | [Criterio] |

CONSECUENCIAS DE INCUMPLIMIENTO:
• Retraso en hito [M#]
• Riesgo de no cumplimiento contractual
• Escalamiento a MME

Favor confirmar recepción y compromiso de entrega.

Jelkin Zair Carrillo Franco
Gerente de Proyecto del Empalme SICOM
CI2
```

---

## 6. HERRAMIENTAS Y CANALES

| Propósito | Herramienta Principal | Backup |
|-----------|----------------------|--------|
| Comunicación rápida PM | Telegram | WhatsApp |
| Reuniones virtuales | Google Meet | Zoom / Teams |
| Documentos formales | Google Drive | GitHub (backup) |
| Email corporativo | Gmail | - |
| Gestión de tareas | GitHub Issues / ZEUS-CONFIG | Google Sheets |
| Calendario | Google Calendar | - |
| Actas y registros | Markdown en GitHub | PDF en Drive |

---

## 7. GOBERNANZA DE LA INFORMACIÓN

### Clasificación de Información del Empalme

**🔒 CONFIDENCIAL:**
- Credenciales, certificados, claves de SICOM
- Contratos GGC-2034-2025 y anexos
- Información de propuesta técnica no pública
- Datos de acceso a infraestructura
- **Acceso:** Solo Jelkin + Especialistas CI2 + Elizabeth

**📋 INTERNA:**
- Planes de trabajo, cronogramas, matrices RAID
- Documentación técnica en desarrollo
- Registros de riesgos y decisiones
- Actas de reunión
- **Acceso:** Equipo CI2 + Elizabeth

**📢 EXTERNA (MME / INTERNEXA):**
- Informes de avance aprobados
- Actas formales firmadas
- Solicitudes de entregables
- **Acceso:** MME + INTERNEXA + CI2

### Retención de Documentos del Empalme

- **Actas de mesa técnica:** 5 años
- **Contrato GGC-2034-2025:** 10 años
- **Actas de recibo y cesión:** 10 años
- **Documentación técnica SICOM:** 5 años
- **Comunicaciones informales:** 1 año
- **Backups:** Automáticos diarios en GitHub

---

## 8. INDICADORES DE EFECTIVIDAD

| Indicador | Meta | Medición |
|-----------|------|----------|
| Tiempo respuesta alertas críticas | < 1 hora | ZEUS monitorea |
| Entrega informes quincenales | 100% puntual | Fecha de envío |
| Documentación de decisiones | 100% | Registros DEC-XXX |
| Actas de mesa técnica | 100% diaria | Registros en GitHub |
| Satisfacción Elizabeth con información | > 90% | Feedback mensual |
| Respuesta de INTERNEXA a solicitudes | < 24h | Trazabilidad SOL-XXX |

---

## 9. APROBACIÓN DEL PLAN

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| Gerente de Proyecto | Jelkin Zair Carrillo Franco | _________________ | 20/05/2026 |
| Supervisora MME | Elizabeth | _________________ | 20/05/2026 |

---

**Jelkin Zair Carrillo Franco**  
*Gerente de Proyecto del Empalme SICOM — CI2*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*