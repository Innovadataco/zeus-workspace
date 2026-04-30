# REPORTE DE CUMPLIMIENTO DEL TOR
## Entregable ITS V1 - Oferta Técnica Transconsult
**Proyecto:** Corredor Vial Chía – Mosquera – Tocaima – Girardot (306 km)  
**Modalidad:** Concesión 5G - Brownfield  
**Cliente:** International Finance Corporation (IFC)  
**Entidad Supervisor:** ICCU  
**Fecha de Revisión:** Abril 2026  

---

## 1. RESUMEN EJECUTIVO

| **Aspecto** | **Evaluación** |
|-------------|----------------|
| **Calificación General** | PARCIAL |
| **Nivel de Cumplimiento** | 75-80% de elementos TOR estándar |
| **Estado Documental** | V1 - Fase Estratégica Completa, Fase de Detalle Pendiente |
| **Recomendación** | Documento sólido conceptualmente pero requiere completar elementos contractuales críticos antes de presentación formal |

---

## 2. LISTA DE CUMPLIMIENTO POR SECCIÓN

### 2.1 ELEMENTOS CUMPLIDOS ✓

| # | Sección TOR Estándar | Estado | Evidencia en Documento |
|---|---------------------|--------|------------------------|
| 2.1.1 | **Marco Normativo ITS** | ✅ CUMPLIDO | Secciones 4.1.1 - 4.1.3 (Ley 1702/2013, Decreto 2060/2015, Resolución 28675/2022) |
| 2.1.2 | **Clasificación de Servicios ITS** | ✅ CUMPLIDO | Tablas 3, 4, 5 - Identificación de 10 servicios prioritarios PMITS + 5 complementarios ISO 14813 |
| 2.1.3 | **Arquitectura ITS Multinivel** | ✅ CUMPLIDO | Capítulo 5 - Niveles: Servicios, Lógica, Física, Comunicaciones; referencia ARC-IT V9.1 |
| 2.1.4 | **Concepto de Operación (ConOps)** | ✅ CUMPLIDO | Capítulo 6 - Cadena de Valor Tecnológica con eslabones E.1 a E.5 |
| 2.1.5 | **Metodología en V** | ✅ CUMPLIDO | Sección 6.2, Ilustración 5 - Explícita referencia a la metodología de la Resolución 28675 |
| 2.1.6 | **Escenarios Operativos de Validación (EOV)** | ✅ CUMPLIDO | 15 EOV documentados (EOV-01 a EOV-15) con tablas completas |
| 2.1.7 | **Taxonomía de Componentes de Campo** | ✅ CUMPLIDO | Tablas 10, 11 - 44 componentes identificados con códigos CC-01 a CC-42 |
| 2.1.8 | **Jerarquía de Servicios ITS** | ✅ CUMPLIDO | Dominios → Áreas → Servicios → Subsistemas → Funciones → Componentes |
| 2.1.9 | **Análisis de Aplicabilidad** | ✅ CUMPLIDO | Tabla 5 - Matriz de aplicabilidad con justificación por servicio |
| 2.1.10 | **Marco de Gobernanza de Datos** | ✅ CUMPLIDO | Sección 5.2.3 - Soberanía del Dato, EOV-06 Ciberseguridad |
| 2.1.11 | **Requerimientos Funcionales (RF)** | ✅ PARCIAL | Capítulo 8 - Ejemplo con CC-01 CCTV, RF.01 a RF.02 documentados |
| 2.1.12 | **Requisitos No Funcionales (RNF)** | ✅ PARCIAL | Capítulo 8 - RNF.01 a RNF.02 (nota: duplicados, deben diferenciarse) |
| 2.1.13 | **Indicadores KPI** | ✅ PARCIAL | Tablas de KPIs definidos estructuralmente en cada EOV |
| 2.1.14 | **Referencias y Estándares** | ✅ CUMPLIDO | Tablas 1, 2 - Abreviaturas y estándares técnicos internacionales |
| 2.1.15 | **Casos de Uso** | ✅ CUMPLIDO | CU-01 Verificación de Alerta de Contravía (Capítulo 8) |

### 2.2 ELEMENTOS FALTANTES O INCOMPLETOS ⚠️

| # | Elemento TOR Estándar | Estado | Observación Crítica |
|---|----------------------|--------|---------------------|
| 2.2.1 | **Cronograma de Implementación** | ❌ NO INCLUIDO | No existe diagrama de Gantt ni plan de fases de despliegue (obligatorio en ofertas ITS) |
| 2.2.2 | **Valores Definidos de KPIs** | ⚠️ INCOMPLETO | Múltiples "VALOR POR DEFINIR; PROPUESTA" en todas las tablas de EOV - debe concretarse antes de presentación |
| 2.2.3 | **Matriz de Responsabilidades RAM** | ❌ NO INCLUIDO | No hay matriz RACI para actores: Concesionario, ICCU, Interventoría, MinTransporte |
| 2.2.4 | **Plan de Capacitación y Transferencia** | ❌ NO INCLUIDO | Esencial para concesiones 5G - formación de personal ICCU en operación |
| 2.2.5 | **Análisis de Riesgos Técnicos** | ⚠️ PARCIAL | Mencionados en Contingencias de EOVs pero sin matriz completa de riesgos |
| 2.2.6 | **Estimación de Cantidades (Metrados)** | ❌ NO INCLUIDO | No hay tablas de cantidades de equipos por tramo (fundamental para presupuesto) |
| 2.2.7 | **Plan de Mantenimiento Preventivo** | ⚠️ MENCIONADO | Referido en EOV-07 pero sin detalle de frecuencias ni procedimientos |
| 2.2.8 | **Matriz de Trazabilidad Requisitos** | ❌ NO INCLUIDO | No se vinculan RF/RNF con componentes específicos de forma matricial |
| 2.2.9 | **Especificaciones de Software** | ⚠️ PARCIAL | VMS mencionado pero sin detalle de versiones, licenciamiento, actualizaciones |
| 2.2.10 | **Protocolos de Integración (APIs)** | ⚠️ PARCIAL | Mencionados ESB/DATEX II pero sin especificaciones técnicas de endpoints |
| 2.2.11 | **Plan de Pruebas y Aceptación (PAT)** | ❌ NO INCLUIDO | Fase IV de Metodología en V incompleta sin protocolos FAT/SAT |
| 2.2.12 | **Modelo de Negocio/Business Case** | ⚠️ MENCIONADO | EOV-14 Economía del Dato pero sin proyecciones financieras |
| 2.2.13 | **Análisis de Impacto Ambiental (ITS)** | ⚠️ MENCIONADO | EOV-15 Net Zero pero sin estudio base de huella de carbono |
| 2.2.14 | **Plan de Continuidad del Negocio (PCN)** | ⚠️ PARCIAL | Contingencias por EOV pero sin plan corporativo unificado |
| 2.2.15 | **Especificaciones del CCO (Centro de Control)** | ⚠️ PARCIAL | Mencionado como subsistema pero sin arquitectura de salas, Video Wall, etc. |

---

## 3. ANÁLISIS DE CUMPLIMIENTO RESOLUCIÓN 28675/2022

### 3.1 Metodología en V - Fases

| Fase Metodología en V | Estado | Observaciones |
|-----------------------|--------|---------------|
| **Fase I: Análisis y Conceptualización** | ✅ COMPLETA | Capítulos 1-4 - Análisis de servicios, marco normativo, clasificación |
| **Fase II: Diseño del Sistema** | ✅ COMPLETA | Capítulos 5-6 - Arquitectura multinivel, ConOps, 15 EOVs |
| **Fase III: Diseño de Detalle** | ⚠️ INICIADA | Capítulo 8 - Solo CC-01 CCTV completo, faltan 43 componentes más |
| **Fase IV: Implementación y Validación** | ❌ NO INICIADA | No hay plan de pruebas ni protocolos de aceptación |
| **Fase V: Operación y Mantenimiento** | ⚠️ REFERIDA | Mencionada en EOVs pero sin planes detallados |

### 3.2 Requisitos Específicos Resolución 28675

| Requisito Res. 28675 | Estado | Cumplimiento |
|---------------------|--------|--------------|
| Catálogo de Servicios ITS (Anexo Técnico) | ✅ CUMPLIDO | 10 servicios prioritarios identificados y mapeados |
| Arquitectura Nacional ITS (ARC-IT) | ✅ CUMPLIDO | Referencia explícita a ARC-IT V9.1 |
| Interoperabilidad DATEX II | ✅ CUMPLIDO | Mencionado en estándares de cada EOV |
| Centro de Control de Operación (CCO) | ⚠️ PARCIAL | Conceptualizado pero sin especificaciones físicas |
| Soberanía del Dato | ✅ CUMPLIDO | EOV-06 y sección 5.2.3 |
| Ciberseguridad IEC 62443/NIST | ✅ CUMPLIDO | CC-21 CSG/IoT en todos los EOVs |

---

## 4. ANÁLISIS DE GAPS CRÍTICOS

### 4.1 GAPS DE ALTA PRIORIDAD (Bloqueantes para Oferta)

| # | Gap | Impacto | Acción Requerida |
|---|-----|---------|------------------|
| 4.1.1 | **Valores de KPI sin definir** | Bloqueante contractual | 38 instancias de "VALOR POR DEFINIR" en EOVs - debe asignar valores propuestos técnicamente justificados |
| 4.1.2 | **Sin cronograma de implementación** | Bloqueante evaluación técnica | El evaluador no puede determinar viabilidad temporal del proyecto |
| 4.1.3 | **Sin metrados/cantidades** | Bloqueante económico | Imposible evaluar costo-efectividad sin cantidades de equipos |
| 4.1.4 | **RNF duplicados (RF = RNF)** | Error metodológico | En CC-01, RNF.01 y RNF.02 son idénticos a RF.01 y RF.02 - debe diferenciar funcional vs. no funcional |
| 4.1.5 | **Sin matriz de trazabilidad** | No cumple Metodología en V | La trazabilidad requisitos→diseño→validación es obligatoria |

### 4.2 GAPS DE MEDIA PRIORIDAD (Mejoran competitividad)

| # | Gap | Impacto | Acción Requerida |
|---|-----|---------|------------------|
| 4.2.1 | **Plan de capacitación ausente** | Riesgo operativo post-entrega | Incluir programa de formación ICCU y transferencia |
| 4.2.2 | **Especificaciones CCO incompletas** | Riesgo de no conformidad | Detallar arquitectura física del centro de control |
| 4.2.3 | **Sin análisis de riesgos formal** | Riesgo de contingencias | Matriz de riesgos técnicos con mitigaciones |
| 4.2.4 | **Sin plan de mantenimiento detallado** | Riesgo de disponibilidad | MTTR/MTBF definidos por tipo de componente |

### 4.3 OBSERVACIONES DE FORMA (Menor prioridad)

| # | Observación | Ubicación |
|---|-------------|-----------|
| 4.3.1 | Numeración de funciones discontinua (F-01 a F-122) | Tabla 10 |
| 4.3.2 | Códigos CC con huecos (CC-01 a CC-42 pero faltan algunos en la secuencia) | Tabla 11 |
| 4.3.3 | EOV-06 y EOV-08 tratan temas similares (ciberseguridad/resiliencia) | Considerar consolidar |
| 4.3.4 | Falta numeración de páginas reales (muestra "XX folios") | Portada |
| 4.3.5 | Algunas referencias bibliográficas incompletas | Sección 10 |

---

## 5. VERIFICACIÓN DE COMPONENTES TÍPICOS TOR ITS

### 5.1 Componentes Técnicos Esperados vs. Entregados

| Componente | Esperado | Estado | Comentario |
|------------|----------|--------|------------|
| CCTV/Video | ✅ | CUMPLIDO | CC-01 especificado detalladamente |
| Detección Incidentes (AID) | ✅ | CUMPLIDO | CC-02 AID en EOVs |
| VMS/Mensajería Variable | ✅ | CUMPLIDO | CC-03 DMS/VMS |
| Telefonía Emergencia (SOS) | ✅ | CUMPLIDO | CC-04 ECS/SOS |
| Contadores Tráfico | ✅ | CUMPLIDO | CC-05 VDS/TDS |
| Sensores Ambientales | ✅ | CUMPLIDO | CC-06 ESS/RWIS |
| Pesaje Dinámico (WIM) | ✅ | CUMPLIDO | CC-07 WIM, EOV-03 |
| Geotecnía/Monitoreo Estructural | ✅ | CUMPLIDO | CC-08, CC-09, EOV-07 |
| Monitoreo Hídrico | ✅ | CUMPLIDO | CC-10 WLS |
| Peaje Electrónico | ✅ | CUMPLIDO | CC-11 AVI/ETC, EOV-05 |
| Reconocimiento Placas (ALPR) | ✅ | CUMPLIDO | CC-12 ALPR/LPR |
| Radar Velocidad | ✅ | CUMPLIDO | CC-13 SPD |
| Velocidad Variable (VSL) | ✅ | CUMPLIDO | CC-14 VSL |
| Sensores Parqueo | ✅ | CUMPLIDO | CC-15 PKS |
| Electrolineras (EVCS) | ✅ | CUMPLIDO | CC-16 EVCS, EOV-10 |
| Comunicación V2X | ✅ | CUMPLIDO | CC-26 RSU, EOV-12 |
| Ciberseguridad IoT | ✅ | CUMPLIDO | CC-21 CSG/IoT, EOV-06 |
| Fibra Óptica/Red | ✅ | CUMPLIDO | CC-23 FOC, CC-24 RDL, EOV-08 |
| Drones/UAS | ✅ | CUMPLIDO | CC-19 UAS/UAV |
| **Total Componentes Identificados** | **20** | **20** | **100% cobertura funcional** |

---

## 6. ANÁLISIS DE EOVs (ESCENARIOS OPERATIVOS DE VALIDACIÓN)

### 6.1 Cobertura Funcional de EOVs

| Código | Nombre EOV | Servicio ITS Principal | Calidad |
|--------|-----------|----------------------|---------|
| EOV-01 | Gestión Vida y Seguridad Vial | SE-ITS-4 | ⭐⭐⭐⭐⭐ Completo |
| EOV-02 | Gestión Tráfico y Movilidad | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-03 | Gestión Carga y Pesaje | SE-ITS-6 | ⭐⭐⭐⭐⭐ Completo |
| EOV-04 | Resiliencia Climática | SE-ITS-7 | ⭐⭐⭐⭐⭐ Completo |
| EOV-05 | Peaje Electrónico | SE-ITS-2 | ⭐⭐⭐⭐⭐ Completo |
| EOV-06 | Soberanía del Dato | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-07 | Mantenimiento Infraestructura | SE-ITS-8 | ⭐⭐⭐⭐⭐ Completo |
| EOV-08 | Resiliencia de Red | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-09 | Fiscalización y Control | SE-ITS-5 | ⭐⭐⭐⭐⭐ Completo |
| EOV-10 | Electromovilidad | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-11 | Telegestión Energética | SE-ITS-8 | ⭐⭐⭐⭐⭐ Completo |
| EOV-12 | Conectividad V2X | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-13 | Vehículos Autónomos | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-14 | Economía del Dato | SE-ITS-1 | ⭐⭐⭐⭐⭐ Completo |
| EOV-15 | Autopista Net Zero | SE-ITS-7 | ⭐⭐⭐⭐⭐ Completo |

**Análisis:** Los 15 EOVs cubren exhaustivamente todos los servicios ITS identificados. Cada EOV incluye: contexto, motivación, flujo sistemático (E.1-E.5), alertas, contingencias, criterios de aceptación y KPIs.

---

## 7. CALIFICACIÓN DE CUMPLIMIENTO DEL TOR

### 7.1 Matriz de Evaluación

| Categoría | Peso | Puntaje (0-5) | Ponderado |
|-----------|------|---------------|-----------|
| **Cobertura Normativa** | 20% | 5.0 | 1.00 |
| **Arquitectura Técnica** | 20% | 4.5 | 0.90 |
| **Especificaciones Funcionales** | 15% | 3.0 | 0.45 |
| **Plan de Implementación** | 15% | 1.0 | 0.15 |
| **Indicadores y Métricas** | 10% | 2.5 | 0.25 |
| **Riesgos y Contingencias** | 10% | 3.5 | 0.35 |
| **Documentación Complementaria** | 10% | 2.0 | 0.20 |
| **TOTAL** | **100%** | | **3.30/5.0** |

### 7.2 Interpretación de Calificación

| Rango | Significado | Estado Actual |
|-------|-------------|---------------|
| 4.5 - 5.0 | TOR COMPLETO - Listo para presentación | No alcanzado |
| 3.5 - 4.4 | TOR PARCIAL - Requiere ajustes menores | Cercano (con correcciones) |
| 2.5 - 3.4 | TOR PARCIAL - Requiere ajustes mayores | **ACTUAL** |
| 1.5 - 2.4 | TOR INCOMPLETO - Falta información crítica | Por debajo |
| 0.0 - 1.4 | TOR INSUFICIENTE - No presentable | Por debajo |

---

## 8. RECOMENDACIONES PARA ALCANZAR CUMPLIMIENTO COMPLETO

### 8.1 Acciones Inmediatas (Pre-entrega)

| Prioridad | Acción | Responsable | Tiempo Est. |
|-----------|--------|-------------|-------------|
| 🔴 CRÍTICA | Definir valores numéricos para los 38 KPIs marcados como "VALOR POR DEFINIR" | Equipo Técnico ITS | 2-3 días |
| 🔴 CRÍTICA | Diferenciar RNF de RF en sección 8 (actualmente son duplicados) | Ingeniero Requisitos | 1 día |
| 🔴 CRÍTICA | Crear matriz de trazabilidad requisitos→componentes→EOVs | Ingeniero Sistemas | 2 días |
| 🟡 ALTA | Desarrollar cronograma de implementación (Gantt) con fases | Project Manager | 2 días |
| 🟡 ALTA | Estimar cantidades/metrados de equipos por tramo/km | Ingeniero ITS | 2-3 días |
| 🟡 ALTA | Completar especificaciones de 43 componentes restantes (solo CC-01 está completo) | Equipo Técnico | 5-7 días |

### 8.2 Acciones de Mejora (Post-entrega V1)

| Prioridad | Acción | Valor Agregado |
|-----------|--------|----------------|
| 🟢 MEDIA | Incluir plan de capacitación ICCU | Mejora evaluación técnica |
| 🟢 MEDIA | Detallar arquitectura física CCO | Claridad operativa |
| 🟢 MEDIA | Agregar matriz RACI de responsabilidades | Gestión de stakeholders |
| 🟢 BAJA | Consolidar EOV-06 y EOV-08 (temas similares) | Simplificación |
| 🟢 BAJA | Completar numeración de páginas | Formalidad |

---

## 9. CONCLUSIÓN

El **Entregable ITS V1** representa un documento conceptualmente sólido que demuestra un profundo entendimiento de:
- La normativa ITS colombiana (Resolución 28675/2022)
- La arquitectura de referencia internacional (ARC-IT, ISO 14813)
- La metodología de diseño (Metodología en V)
- Las necesidades operativas de una concesión 5G

Sin embargo, **en su estado actual califica como TOR PARCIAL** debido a:
1. Ausencia de cronograma de implementación
2. Ausencia de metrados/cantidades de equipos
3. KPIs sin valores definidos (38 instancias)
4. Falta de matriz de trazabilidad
5. Duplicación RF/RNF en sección 8

**Recomendación estratégica:** Invertir 5-7 días adicionales en completar los elementos identificados para elevar la calificación a TOR COMPLETO, maximizando así la competitividad de la oferta ante Transconsult/IFC.

El documento evidencia un trabajo técnico serio y alineado con las mejores prácticas internacionales, pero requiere la capa de detalle contracto-ejecutiva para ser considerado una oferta técnica integral según los estándares de una concesión de quinta generación.

---

**Reporte elaborado por:** ZEUS AGENTE IA  
**Fecha:** Abril 2026  
**Clasificación:** Documento de Trabajo Interno  
**Versión:** 1.0
