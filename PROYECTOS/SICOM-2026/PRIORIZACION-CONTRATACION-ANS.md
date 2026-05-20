# PRIORIZACIÓN DE CONTRATACIÓN — Cumplimiento Anexo Técnico SICOM
## Orden de Contratación por Criticidad Operativa

**Proyecto:** Empalme y Operación SICOM MME  
**Empresa:** CI2  
**Fecha:** 20 de mayo de 2026  
**Documento base:** Anexo Técnico Contrato GGC-2034-2025  

---

## 1. CRITERIOS DE PRIORIZACIÓN

Según el Anexo Técnico del contrato SICOM, la priorización se basa en:

| Criterio | Peso | Justificación |
|----------|------|---------------|
| **Disponibilidad 7×24** | 40% | ANS 99.90% requiere cobertura ininterrumpida |
| **Conocimiento del sistema** | 30% | Transferencia de INTERNEXA necesita receptores técnicos |
| **Criticidad para corte** | 20% | Sin estos roles, no hay migración posible |
| **Tiempo de onboarding** | 10% | Roles complejos necesitan más tiempo de adaptación |

---

## 2. PRIORIDAD 1: CRÍTICOS 7×24 (Contratar Día 1-3)

### ¿Por qué primero?
> El Anexo Técnico exige disponibilidad **7×24×365** con ANS 99.90%. Sin equipo de operación y bases de datos, no hay servicio.

---

### VACANTE 004A — DBA ORACLE #1 (Turno Día)

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔴 P1 — CRÍTICO |
| **Día de contratación** | 1 (inmediato) |
| **Justificación** | Sin DBA no hay base de datos, sin BD no hay SICOM |
| **Dependencia** | Ninguna (rol raíz) |
| **Bloquea** | Toda la operación |
| **Riesgo si no se contrata** | Proyecto detenido, incumplimiento contractual |
| **Acción inmediata** | Publicar hoy, entrevista mañana, oferta en 48h |

**Requisitos no negociables:**
- Certificación Oracle OCA (OBLIGATORIO)
- 24 meses en Oracle producción
- Disponibilidad 7×24

**Estrategia de reclutamiento:**
- Canal prioritario: LinkedIn + consultora Oracle especializada
- Incentivo: Bono de retención $5M al mes 3
- Alternativa: Consultor Oracle freelance → contrato indefinido

---

### VACANTE 004B — DBA ORACLE #2 (Turno Noche)

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔴 P1 — CRÍTICO |
| **Día de contratación** | 2 |
| **Justificación** | Cobertura 7×24 requiere 2 DBA (turnos rotativos) |
| **Dependencia** | DBA #1 (para transferencia de conocimiento) |
| **Bloquea** | Operación nocturna, backups, mantenimiento |

---

### VACANTE 012 — COORDINADOR DE CALL CENTER

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔴 P1 — CRÍTICO |
| **Día de contratación** | 1-2 |
| **Justificación** | ANS Call Center: abandono <20%, satisfacción >80%. Sin coordinador, no hay métricas ni control |
| **Dependencia** | Ninguna |
| **Bloquea** | Operación Call Center, reportes al MME |
| **Riesgo si no se contrata** | Incumplimiento ANS desde día 1 |

**Requisitos no negociables:**
- 24 meses coordinando Call Center
- Conocimiento de métricas: ASA, AHT, abandono

---

### VACANTE 013A-F — AGENTES DE CALL CENTER (6 personas)

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔴 P1 — CRÍTICO |
| **Día de contratación** | 3-7 (batch de 2 cada 2 días) |
| **Justificación** | 6 agentes = cobertura 7×24 (2 por turno). Sin agentes, usuarios no tienen soporte |
| **Dependencia** | Coordinador CC (para entrenamiento) |
| **Bloquea** | Atención al usuario, tickets, escalamientos |

**Estrategia:**
- Batch 1 (2 agentes): Día 3 — Perfiles con experiencia
- Batch 2 (2 agentes): Día 5 — Perfiles junior + capacitación express
- Batch 3 (2 agentes): Día 7 — Perfiles trainee + shadowing intensivo

---

## 3. PRIORIDAD 2: TÉCNICOS ESENCIALES (Contratar Día 3-7)

### ¿Por qué segundo?
> El Anexo Técnico exige transferencia de conocimiento de INTERNEXA. Necesitamos técnicos que reciban el conocimiento **antes** de que INTERNEXA se desvincule.

---

### VACANTE 002 — LÍDER TÉCNICO

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟠 P2 — ESENCIAL |
| **Día de contratación** | 3 |
| **Justificación** | Sin Líder Técnico, no hay quien valide arquitectura, decida tecnología, lidere al equipo dev |
| **Dependencia** | Ninguna |
| **Bloquea** | Todas las decisiones técnicas, empalme, corte |
| **Riesgo si no se contrata** | Caos técnico, decisiones sin dirección |

**Requisitos no negociables:**
- 36 meses liderando proyectos Java o BPM
- 12 meses en metodologías ágiles
- Capacidad de decisión bajo presión

---

### VACANTE 006A — DESARROLLADOR JAVA #1

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟠 P2 — ESENCIAL |
| **Día de contratación** | 4 |
| **Justificación** | SICOM Líquidos y Gas están en Java. Sin dev Java, no hay mantenimiento ni evolutivos |
| **Dependencia** | Líder Técnico (para asignación) |
| **Bloquea** | Mantenimiento SICOM Java, corrección errores |

---

### VACANTE 006B — DESARROLLADOR JAVA #2

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟠 P2 — ESENCIAL |
| **Día de contratación** | 5 |
| **Justificación** | Redundancia: si uno falla, el otro cubre. Además, uno migrará a BPM post-transición |
| **Dependencia** | Dev Java #1 |
| **Bloquea** | Respaldo técnico, migración a BPM |

---

### VACANTE 007A — DESARROLLADOR BPM #1

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟠 P2 — ESENCIAL |
| **Día de contratación** | 5 |
| **Justificación** | Nuevo SICOM está en BPM. Sin dev BPM, no hay futuro del sistema |
| **Dependencia** | Líder Técnico |
| **Bloquea** | Desarrollo Nuevo SICOM, automatización procesos |

---

### VACANTE 005A — QA #1

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟠 P2 — ESENCIAL |
| **Día de contratación** | 6 |
| **Justificación** | ANS exige >95% incidentes resueltos. Sin QA, no hay control de calidad |
| **Dependencia** | Líder Técnico (para definir estándares) |
| **Bloquea** | Pruebas, validación, control de calidad |

---

## 4. PRIORIDAD 3: OPERACIÓN Y ANÁLISIS (Contratar Día 7-10)

### ¿Por qué tercero?
> El Anexo Técnico exige informes mensuales, análisis de datos, y operación del Observatorio. Necesitamos analistas que procesen información **después** de que los técnicos estabilicen la plataforma.

---

### VACANTE 009A-C — ANALISTAS DE INFORMACIÓN (3 primeros)

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟡 P3 — IMPORTANTE |
| **Día de contratación** | 7-9 (1 cada día) |
| **Justificación** | Procesan datos de precios, generan reportes, atienden usuarios. Sin analistas, no hay informes al MME |
| **Dependencia** | DBA (para acceso a datos), Líder Funcional (para procedimientos) |
| **Bloquea** | Informes mensuales, atención a usuarios |

---

### VACANTE 010 — PROFESIONAL DE ESTADÍSTICA

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟡 P3 — IMPORTANTE |
| **Día de contratación** | 8 |
| **Justificación** | NTC PE 1000 obligatoria. Valida metodologías de precios de referencia. Sin estadístico, no hay precios |
| **Dependencia** | Analistas (para datos) |
| **Bloquea** | Formulación de precios, validación metodológica |

**Requisito crítico:** Certificación NTC PE 1000 (si no la tiene, debe obtenerla en 30 días)

---

### VACANTE 011 — PROFESIONAL DE CALIDAD

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟡 P3 — IMPORTANTE |
| **Día de contratación** | 9 |
| **Justificación** | ISO 9001 obligatoria. Audita procesos, asegura cumplimiento. Sin calidad, no hay certificación |
| **Dependencia** | Director de Proyecto (para procesos) |
| **Bloquea** | Auditorías, certificaciones, SOPs |

---

## 5. PRIORIDAD 4: DIRECCIÓN Y ESPECIALISTAS (Contratar Día 10-12)

### ¿Por qué cuarto?
> El Anexo Técnico exige dirección del proyecto, pero la dirección puede ser asumida temporalmente por Luis (Gerente CI2) hasta que se contrate el Director.

---

### VACANTE 001 — DIRECTOR DE PROYECTO

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟢 P4 — NECESARIO |
| **Día de contratación** | 10 |
| **Justificación** | Dirección estratégica, reporte MME, gestión de riesgos. Luis puede cubrir temporalmente |
| **Dependencia** | Ninguna (pero Luis cubre interinamente) |
| **Bloquea** | Reportes formales al MME, gobierno del proyecto |

**Nota:** Luis (Gerente CI2) asume dirección interina hasta contratar Director. Esto no bloquea el empalme.

---

### VACANTE 003 — LÍDER FUNCIONAL

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟢 P4 — NECESARIO |
| **Día de contratación** | 11 |
| **Justificación** | Levanta requisitos, valida funcionalidad con usuarios. Puede ser asumido por Jelkin temporalmente |
| **Dependencia** | Director de Proyecto |
| **Bloquea** | Levantamiento de requisitos, validación con MME |

---

### VACANTE 008A — ESPECIALISTA BI #1

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟢 P4 — NECESARIO |
| **Día de contratación** | 11 |
| **Justificación** | BI es crítico pero puede operar con consultor externo temporalmente |
| **Dependencia** | DBA (para acceso a datos) |
| **Bloquea** | Cubos, dashboards, reportes ejecutivos |

---

### VACANTE 008B — ESPECIALISTA BI #2

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🟢 P4 — NECESARIO |
| **Día de contratación** | 12 |
| **Justificación** | Redundancia BI. Cubre si uno está ausente |
| **Dependencia** | Especialista BI #1 |
| **Bloquea** | Respaldo BI |

---

## 6. PRIORIDAD 5: COMPLEMENTARIOS (Contratar Día 12-15)

### ¿Por qué quinto?
> Roles que completan el equipo pero no bloquean operación inicial.

---

### VACANTE 007B-C — DESARROLLADORES BPM #2-3

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔵 P5 — COMPLEMENTARIO |
| **Día de contratación** | 12-13 |
| **Justificación** | Escalar equipo BPM para futuro. Con 1 BPM ya se puede operar |
| **Dependencia** | Dev BPM #1, Líder Técnico |
| **Bloquea** | Escalabilidad del equipo BPM |

---

### VACANTE 005B — QA #2

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔵 P5 — COMPLEMENTARIO |
| **Día de contratación** | 13 |
| **Justificación** | Redundancia QA. Con 1 QA se cubre operación inicial |
| **Dependencia** | QA #1 |
| **Bloquea** | Respaldo QA |

---

### VACANTE 009D-G — ANALISTAS DE INFORMACIÓN #4-7

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔵 P5 — COMPLEMENTARIO |
| **Día de contratación** | 13-15 (1 cada día) |
| **Justificación** | Completar equipo de 7 analistas. Con 3 se cubre operación inicial |
| **Dependencia** | Analistas #1-3 |
| **Bloquea** | Capacidad de procesamiento de datos |

---

### VACANTE 014A-B — FORMADORES #1-2

| Campo | Valor |
|-------|-------|
| **Prioridad** | 🔵 P5 — COMPLEMENTARIO |
| **Día de contratación** | 14-15 |
| **Justificación** | Capacitación es continua pero no bloquea operación inicial. Jelkin puede capacitar temporalmente |
| **Dependencia** | Equipo técnico contratado (para conocimiento) |
| **Bloquea** | Plan de capacitación formal |

---

## 7. CRONOGRAMA VISUAL DE CONTRATACIÓN

```
DÍA:  1   2   3   4   5   6   7   8   9   10  11  12  13  14  15
      │   │   │   │   │   │   │   │   │   │   │   │   │   │   │
P1:   🟥   🟥   🟥   🟥   🟥   🟥   🟥
      DBA1 DBA2 CC   A1   A2   A3   A4
           Coord

P2:           🟧   🟧   🟧   🟧   🟧   🟧
              LT   DJ1  DJ2  DB1  DB2  QA1

P3:                       🟨   🟨   🟨   🟨   🟨
                          AN1  AN2  AN3  EST  CAL

P4:                                   🟩   🟩   🟩   🟩
                                      DP   LF   BI1  BI2

P5:                                               🟦   🟦   🟦   🟦   🟦   🟦
                                                  DB3  QA2  AN4  AN5  AN6  AN7
                                                              F1   F2

LEYENDA:
🟥 P1 — CRÍTICO 7×24 (8 personas)
🟧 P2 — ESENCIAL TÉCNICO (6 personas)
🟨 P3 — IMPORTANTE OPERACIÓN (5 personas)
🟩 P4 — NECESARIO DIRECCIÓN (4 personas)
🟦 P5 — COMPLEMENTARIO (8 personas)
```

---

## 8. MATRIZ DE DEPENDENCIAS

| Rol | Depende de | Bloquea | Estrategia si no se encuentra |
|-----|-----------|---------|------------------------------|
| DBA #1 | Ninguno | TODA LA OPERACIÓN | Consultor Oracle freelance → contrato |
| DBA #2 | DBA #1 | Turno noche | DBA #1 hace doble turno temporal |
| Coord CC | Ninguno | Call Center | Supervisor de INTERNEXA → contrato |
| Agentes CC | Coord CC | Atención usuario | Outsourcing temporal (1 mes) |
| Líder Técnico | Ninguno | Decisiones técnicas | Jelkin asume interinamente |
| Dev Java #1 | Líder Técnico | Mantenimiento Java | Consultor Java freelance |
| Dev Java #2 | Dev Java #1 | Respaldo Java | Dev Java #1 doble carga |
| Dev BPM #1 | Líder Técnico | Nuevo SICOM | Consultor BPM freelance |
| QA #1 | Líder Técnico | Calidad | Jelkin hace QA temporal |
| Analistas #1-3 | DBA | Informes | Jelkin + Luis generan informes básicos |
| Estadístico | Analistas | Precios de referencia | Consultor estadístico externo |
| Calidad | Director | Auditorías | Jelkin documenta procesos básicos |
| Director | Ninguno | Gobierno | Luis asume dirección |
| Líder Funcional | Director | Requisitos | Jelkin asume funcional |
| BI #1-2 | DBA | Dashboards | Consultor BI externo |
| Formadores | Equipo técnico | Capacitación | Jelkin + Líder Técnico capacitan |

---

## 9. PLAN DE CONTINGENCIA POR ROL NO ENCONTRADO

### Estrategia de Sustitución Temporal

| Rol | Sustituto Temporal | Duración Máxima | Costo |
|-----|-------------------|-----------------|-------|
| DBA Oracle | Consultor Oracle freelance | 30 días | $15M/mes |
| Líder Técnico | Jelkin (Innovadataco) | 15 días | Incluido en contrato |
| Dev Java | Consultor Java freelance | 30 días | $12M/mes |
| Dev BPM | Consultor BPM freelance | 30 días | $12M/mes |
| QA | Jelkin + herramientas automáticas | 15 días | Incluido |
| BI | Consultor BI freelance | 30 días | $10M/mes |
| Analistas | Jelkin + Luis + automatización | 15 días | Incluido |
| Formadores | Jelkin + Líder Técnico | 30 días | Incluido |
| Agentes CC | Outsourcing Call Center | 30 días | $8M/mes |

---

## 10. INDICADORES DE ÉXITO POR PRIORIDAD

### P1 — CRÍTICOS (Día 7)

| KPI | Meta | Medición |
|-----|------|----------|
| DBA #1 contratado | 100% | Día 3 |
| DBA #2 contratado | 100% | Día 5 |
| Coordinador CC contratado | 100% | Día 5 |
| 4 agentes CC contratados | 100% | Día 7 |
| Onboarding P1 completado | 100% | Día 10 |

### P2 — ESENCIALES (Día 10)

| KPI | Meta | Medición |
|-----|------|----------|
| Líder Técnico contratado | 100% | Día 8 |
| 2 Dev Java contratados | 100% | Día 10 |
| 2 Dev BPM contratados | 100% | Día 10 |
| QA #1 contratado | 100% | Día 10 |

### P3 — IMPORTANTES (Día 12)

| KPI | Meta | Medición |
|-----|------|----------|
| 3 Analistas contratados | 100% | Día 12 |
| Estadístico contratado | 100% | Día 12 |
| Calidad contratado | 100% | Día 12 |

### P4 — NECESARIOS (Día 14)

| KPI | Meta | Medición |
|-----|------|----------|
| Director contratado | 100% | Día 14 |
| Líder Funcional contratado | 100% | Día 14 |
| 2 BI contratados | 100% | Día 14 |

### P5 — COMPLEMENTARIOS (Día 15)

| KPI | Meta | Medición |
|-----|------|----------|
| 3 Dev BPM contratados | 100% | Día 15 |
| QA #2 contratado | 100% | Día 15 |
| 7 Analistas contratados | 100% | Día 15 |
| 2 Formadores contratados | 100% | Día 15 |

---

## 11. RESUMEN EJECUTIVO PARA LUIS

### Mensaje clave:

> "Necesitamos contratar **8 personas en los primeros 7 días** para garantizar operación 7×24. El resto (23 personas) se contrata en los siguientes 8 días. Sin los primeros 8, no hay servicio."

### Prioridades de aprobación:

| Prioridad | Personas | Días | Presupuesto Mensual | Acción para Luis |
|-----------|----------|------|---------------------|------------------|
| **P1 — CRÍTICOS** | 8 | 1-7 | $65.500.000 | **APROBAR HOY** — Publicar vacantes mañana |
| **P2 — ESENCIALES** | 6 | 3-10 | $54.000.000 | Aprobar día 3 — Iniciar entrevistas día 4 |
| **P3 — IMPORTANTES** | 5 | 7-12 | $22.500.000 | Aprobar día 7 — Contratar día 8 |
| **P4 — NECESARIOS** | 4 | 10-14 | $30.000.000 | Aprobar día 10 — Contratar día 11 |
| **P5 — COMPLEMENTARIOS** | 8 | 12-15 | $30.750.000 | Aprobar día 12 — Contratar día 13 |
| **TOTAL** | **31** | **15** | **$202.750.000** | |

### Decisión requerida de Luis:

1. **¿Aprueba presupuesto para P1 (8 personas, $65.5M/mes)?** → Si sí, publicamos mañana
2. **¿CI2 tiene HR o contratamos consultora?** → Si no hay HR, necesitamos consultora día 1
3. **¿Puede asumir dirección interina hasta contratar Director (día 10)?** → Si sí, no bloqueamos

---

**Documento generado por:** ZEUS — Innovadataco  
**Fecha generación:** 20 de mayo de 2026  
**Versión:** 1.0  
**Basado en:** Anexo Técnico Contrato GGC-2034-2025 — Requerimientos de equipo mínimo y ANS  

---

**¿Aprobamos la priorización para iniciar contratación P1 mañana?**
