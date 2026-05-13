# INFORME DIAGNÓSTICO — CARPETA ABRIL 2026 SICOM

**Para:** Jelkin Zair Carrillo Franco — CEO Innovadataco  
**De:** ZEUS — Análisis Documental  
**Fecha:** 14 de mayo de 2026  
**Asunto:** Diagnóstico completo de documentación Abril 2026 + percepción del proyecto + arqueo de información

---

## PARTE 1: PERCEPCIÓN EJECUTIVA DEL PROYECTO

### Veredicto: 🔴 ALTO RIESGO DE FRACASO OPERATIVO

Innovadataco está a punto de heredar una plataforma que **ya está fallando** en manos del operador actual. La documentación de abril 2026 no muestra una operación estable lista para transición. Muestra una operación con problemas crónicos sin resolver, cronograma atrasado, y deuda técnica significativa.

### Evidencias que sostienen este veredicto

| Hallazgo | Severidad | Implicación para Innovadataco |
|----------|-----------|--------------------------------|
| **ANS incumplidos en abril 2026** | 🔴 Crítico | Si asumimos el 1 julio con la misma infraestructura, seremos nosotros los multados (0.5% por cada 0.1% de falla) |
| **Saturación crónica de Oracle RAC** | 🔴 Crítico | 3 mantenimientos de emergencia en 2025 por 400,000 peticiones masivas de agentes GAS. La BD no soporta la carga real |
| **Cronograma Vigencia 7 atrasado 4%** | 🟡 Alto | Mayo y junio 2026 al 0%. Hay entregables pendientes de la vigencia anterior que podrían recaer sobre nosotros |
| **Aplicaciones móviles sin publicar** | 🟡 Alto | Aún en UAT en abril. Si no se publican antes del corte, será nuestro problema |
| **GAS a BPM sin migrar** | 🟡 Alto | Levantamiento de procesos en curso. No hay sistema GNCV funcional en BPM todavía |
| **Innovadataco sin equipo técnico conformado** | 🔴 Crítico | No tenemos arquitecto, DBA Oracle, ni infraestructura Tier III lista |

### Mi recomendación estratégica

**NO asumir operación el 1 julio sin antes:**
1. Validar que los problemas de infraestructura (saturación Oracle) tienen solución técnica
2. Obtener compromiso escrito de CI2 sobre quién asume multas de la transición
3. Tener al menos 1 DBA Oracle y 1 Arquitecto de nube contratados antes del 15 junio
4. Validar que nube privada propia puede soportar la carga real (45,000 usuarios, 210,000 procesos/mes)
5. Exigir a Internexa entrega con "operación estable" definida por métricas, no por acta sin datos

---

## PARTE 2: HALLAZGOS DE LA CARPETA ABRIL 2026

### 2.1 Documentos Encontrados y Analizados

| Documento | Estado | Hallazgo Clave |
|-----------|--------|---------------|
| **RESUMEN EJECUTIVO ABRIL V1** | ✅ Leído (20 páginas) | Operación reportada como "normal" pero con evolutivos pendientes y migración GAS a BPM en curso |
| **INFORME RESULTADOS RFC ABRIL** | ✅ Leído (11 RFCs) | Historial de mantenimientos de emergencia por saturación BD. Rollback necesitado. Indisponibilidades documentadas |
| **REPORTE ANS ABRIL 2026** | ✅ Leído (Excel) | **2 ANS incumplidos:** Nuevo SICOM Líquidos 99.88% (meta >99.98%), Web Service Nuevo SICOM 99.90% (meta >99.98%) |
| **INFORME WAF ABRIL 2026** | ✅ Leído (12 páginas) | FortiWeb operando estable. portal.sicom.gov.co con más tráfico. OWASP detectado. Geobloqueo activo |
| **CRONOGRAMA GENERAL VIGENCIA 7** | ✅ Leído (PDF exportado) | Proyecto 57% real vs 61% planeado. Abril 25% sin iniciar. Mayo/Junio 0%. Erika Tarazona, Cesar Castro, Ivan Arteaga, Carolina Perdomo, Victor Galvis |
| **DATA CASOS ARANDA ABRIL** | ✅ Leído (Excel) | 1+ incidente: FALLA TRANSMISIÓN DATOS WEB SERVICE SICOM. Estado CANCELADO. Atención ~8 min |
| **DETALLE LLAMADAS WOLKVOX ABRIL** | ✅ Leído (Excel) | Datos de call center disponibles. Reporte histórico CDR |
| **ANÁLISIS SATISFACCIÓN NIVEL 1** | ✅ Leído (Excel) | 1 caso insatisfecho (caso 227590, usuario MARIA EUGENIA SOLIS, justificación: "no me atendio nadie") |
| **SATISFACCIÓN CASOS NIVEL 2** | ✅ Leído (Excel) | Datos parciales por día. Requiere análisis más profundo |
| **CASOS UAT ABRIL 2026** | ✅ Leído (Excel) | 13+ casos UAT completados (GPC, ActualizarDI, ActuAgente). Operadores GTG, LCQ, DKR |

### 2.2 Hallazgo #1: ANS Incumplidos en Abril 2026

| Línea de Servicio | Meta Contrato | Real Abril 2026 | Estado | Multa Potencial |
|-------------------|--------------|-----------------|--------|----------------|
| Disponibilidad Nuevo SICOM Líquidos | >99.98% | **99.88%** | ❌ **NO CUMPLIDO** | 0.5% facturación mensual |
| Disponibilidad Web Service Nuevo SICOM | >99.98% | **99.90%** | ❌ **NO CUMPLIDO** | 0.5% facturación mensual |
| Disponibilidad SICOM Líquidos (legado) | >99.98% | 100% | ✅ Cumplido | Ninguna |
| Disponibilidad Canales Comunicación | >99.98% | 100% | ✅ Cumplido | Ninguna |
| Disponibilidad Web Service GNCV | >99.98% | 99.99% | ✅ Cumplido | Ninguna |
| Disponibilidad Servicio Cubos | >99.98% | 99.999% | ✅ Cumplido | Ninguna |
| Dashboard | >99.98% | 100% | ✅ Cumplido | Ninguna |
| App Móvil Líquidos | >99.98% | 100% | ✅ Cumplido | Ninguna |
| App Móvil Gas | >99.98% | 100% | ✅ Cumplido | Ninguna |
| Portal Autogestión | >99.98% | 100% | ✅ Cumplido | Ninguna |
| Contingencia RPO <30 min | Cumplir | 100% | ✅ Cumplido | Ninguna |
| Periodicidad Actualización Info | <6 horas | 99.58% | ⚠️ Riesgo | A evaluar |

**Análisis:** Internexa ya tuvo problemas de disponibilidad en abril. El "Nuevo SICOM" (el sistema en BPM/portal moderno) es el que falla. El legado SICOM Líquidos funciona al 100%. Esto sugiere que la arquitectura nueva tiene problemas de estabilidad.

### 2.3 Hallazgo #2: RFCs Revelan Problemas Crónicos de Infraestructura

| RFC | Fecha | Tipo | Problema | Indisponibilidad | Root Cause |
|-----|-------|------|----------|-----------------|------------|
| 225 | 10/09/2025 | Rollback | Incompatibilidad actualizaciones SO con ETL Datawarehouse | Sí, ETL 3am falló | Parches SO vs ETL |
| 226 | 13/08/2025 | Emergencia | Depuración archives rack BD GNCV | ~70 minutos GNCV | **400,000 peticiones masivas de agentes GAS** (vehículos inactivos/inexistentes) |
| 228 | 16/09/2025 | Emergencia | Depuración archives rack BD GNCV (otra vez) | ~30 minutos GNCV | **Misma causa: 400,000 peticiones masivas** |
| 229 | 19/08/2025 | Emergencia | Depuración almacenamiento BD Nuevo SICOM | ~45 minutos portal.sicom.gov.co | **Misma causa: 400,000 peticiones masivas** |
| 230 | 19/09/2025 | Cambio | Reducir conexiones concurrentes GNCV de 1000 a 500 | No | Saturación BD por conexiones |
| 232 | 27/09/2025 | Emergencia | Bloqueo usuario BISA en Oracle RAC DWH | Sí, ETL líquidos | Usuario bloqueado en BD |

**Patrón crítico identificado:** Los agentes de GAS envían **400,000 peticiones masivas de vehículos inactivos o inexistentes**. Esto satura los archives del rack de Oracle, llena almacenamiento, y causa indisponibilidad recurrente. Esto pasó **al menos 3 veces** en 2025.

**¿Innovadataco tiene plan para mitigar esto?** No que yo sepa.

### 2.4 Hallazgo #3: Cronograma Vigencia 7 Está Atrasado

| Fase | Planeado | Real | Diferencia | Estado Mayo | Estado Junio |
|------|----------|------|------------|-------------|--------------|
| CRONOGRAMA GENERAL | 61% | 57% | **-4%** | 0% Sin iniciar | 0% Sin iniciar |
| Gestión Arquitectura | 61% | 61% | 0% | 0% Sin iniciar | 0% Sin iniciar |
| Proceso Estadístico Líquidos | 61% | 61% | 0% | 0% Sin iniciar | 0% Sin iniciar |
| Gas | 61% | 61% | 0% | 0% Sin iniciar | 0% Sin iniciar |
| Calidad (Procesos) | 61% | 61% | 0% | 0% Sin iniciar | 0% Sin iniciar |

**Nota:** El PDF del cronograma fue exportado el **7 de abril de 2026**. En ese momento, los entregables de abril estaban marcados como "Sin iniciar" o "En progreso" al 25%. Esto significa que a mitad de abril, aún no se habían completado las tareas de abril.

**Esto es preocupante porque:** la vigencia 7 termina el 1 julio 2026. Si a abril estaban atrasados, ¿cómo terminarán mayo y junio?

### 2.5 Hallazgo #4: Operación en Abril 2026 (Resumen Ejecutivo)

| Aspecto | Estado | Detalle |
|---------|--------|---------|
| **Quemadores Industriales** | En certificación | Proceso de Declaración de Información en pruebas, paso a producción en mayo |
| **Petrobras / Ecopetrol** | Acompañamiento | Sesiones de aclaración de procesos SICOM |
| **HU 1206** | Certificada | Actualización agentes, puntos entrega comercializadores industriales |
| **HU 886** | QA finalizada | Autorización creación plantas por operador |
| **HU 2454** | QA en curso | Ajustes a procesos de cumplidos |
| **HU 1904** | QA finalizada | Asociación OPS a plantas configuradas contingencia |
| **Apps Móviles** | Preparando UAT | Ambiente listo, publicación en tiendas pendiente |
| **BI Cubo OP-BPM** | Pruebas funcionales | HU-2407 desarrollo 100%, cerrando pruebas con MME |
| **Series Históricas** | Reactivado | HU 2594, 2596, 2222, 2225 en construcción |
| **SIGDI HU 1445** | Paso a producción | Reporte General y Horas de Vigencia Guías |
| **Migración GAS a BPM** | Levantamiento | HU 2946, 2994, 2999, 3019, 3046, 3047, 3052, 3082 |
| **Mesa de Servicio** | 67.81% en 5 temas | Ajuste órdenes pedido (19.97%), PQR (17.03%), Declaración info (11.30%), Consultas (9.91%) |

### 2.6 Hallazgo #5: Seguridad (WAF FortiWeb Abril)

| Aspecto | Estado |
|---------|--------|
| Alta Disponibilidad | ✅ Operativa, sin novedades |
| CPU/Memoria | ✅ Uso normal |
| Sitio con más tráfico | portal.sicom.gov.co |
| Sitio con más ancho de banda | portal.sicom.gov.co |
| Amenazas detectadas | Top 10 OWASP (sin detalle numérico en texto) |
| Geobloqueo | ✅ Activo |
| IP Reputation | ✅ Activo |
| Listas negras | ✅ Configuradas |

**Nota:** El PDF del WAF contiene solo referencias a gráficas. Las métricas numéricas específicas (cuántos ataques, de qué tipo, desde qué IPs) están solo en las imágenes, no en el texto extraído.

### 2.7 Hallazgo #6: UAT y Pruebas

| Proceso UAT | Casos | Estado | Usuario |
|-------------|-------|--------|---------|
| GPC_GestionPlantasDeContin | GPC-27 a GPC-37 | ✅ Completed | GTG-OperadorGTG |
| Pr_ActuAgente | ACA-125311 | ✅ Completed | LCQ-OperadorLCQ |
| Pr_ActualizarDI | ACDI-1449 a 1451 | ✅ Completed | OPERDORDKR |

**Fechas:** 13/04/2026 a 22/04/2026. Todos completados exitosamente.

### 2.8 Hallazgo #7: Call Center y Satisfacción

| Métrica | Valor |
|---------|-------|
| Casos Aranda | 1+ incidente web service SICOM líquidos |
| Tiempo atención incidente | ~8 minutos |
| Estado incidente | CANCELADO |
| Satisfacción Nivel 1 | 1 caso insatisfecho (no atendieron) |
| Satisfacción Nivel 2 | Datos parciales, requiere análisis |
| Llamadas Wolkvox | Datos históricos CDR disponibles abril 2026 |

---

## PARTE 3: ARQUEO DE INFORMACIÓN — RETROCESO NECESARIO

### 3.1 Información Crítica que NO Tenemos y SÍ Necesitamos

| # | Información | ¿Por qué es crítica? | ¿Dónde debería estar? | ¿Quién la tiene? |
|---|-------------|---------------------|----------------------|----------------|
| 1 | **Inventario técnico completo de VMs, servidores, IPs, recursos asignados** | Para dimensionar nuestra nube privada | `INFORMES INFRAESTRUCTURA` | ITX / Internexa |
| 2 | **Root cause analysis de la saturación Oracle por 400K peticiones GAS** | Para saber si es arquitectura, capacidad, o índices | `INFORMES INFRAESTRUCTURA` o actas técnicas | ITX / Internexa |
| 3 | **Plan de remediación de deuda técnica (HU en backlog, desarrollo, pruebas)** | Para saber cuánto trabajo heredamos | `INFORMES INFRAESTRUCTURA` o backlog | ITX / Internexa |
| 4 | **Contrato CI2-MME completo (cláusulas, multas, responsabilidades)** | Para saber quién paga si fallamos | `INFORMACIÓN CONTRACTUAL` | CI2 |
| 5 | **Acta de entrega de Internexa con estado exacto del sistema** | Para saber qué recibimos vs qué deberíamos recibir | `ENTREGA VIGENCIA` | ITX / Internexa |
| 6 | **Detalle de multas/penalizaciones de abril 2026** | Para saber si Internexa ya fue sancionada y cuánto | Reporte financiero CI2 | CI2 |
| 7 | **Fichas técnicas de licenciamiento Oracle, VMware, Bizagi** | Para cotizar licencias propias | `FICHAS TECNICAS LICENCIAMIENTO` | ITX / Internexa |
| 8 | **Diagramas de arquitectura lógica/física actualizados** | Para replicar o mejorar la arquitectura | `ARQUITECTURA` | ITX / Internexa |
| 9 | **Plan DRP detallado (procedimiento failover, RTO exacto, runbooks)** | Para garantizar continuidad | `DRP` | ITX / Internexa |
| 10 | **Mapa de integraciones y APIs externas** | Para saber dependencias de terceros | `MATRICES MME-ITX` | ITX / Internexa |
| 11 | **Esquema ER y diccionario de datos Oracle/SQL Server** | Para operar la base de datos | No identificado | ITX / Internexa |
| 12 | **Logs de operación últimos 6 meses** | Para entender patrones de falla | `INFORMES INFRAESTRUCTURA` | ITX / Internexa |
| 13 | **Repositorio Git con código fuente SICOM** | Para mantener y evolucionar el sistema | No identificado | ITX / Internexa |
| 14 | **Credenciales de acceso a sistemas (solo lectura)** | Para reconocimiento técnico propio | No compartido (seguridad) | ITX / Internexa |
| 15 | **Informe de deuda técnica y librerías obsoletas** | Para planificar modernización | No identificado | ITX / Internexa |

### 3.2 Retroceso por Área

| Área | ¿Qué sabemos? | ¿Qué nos falta? | Impacto si no lo tenemos |
|------|---------------|-----------------|--------------------------|
| **Infraestructura** | Nube privada, VMware, Oracle RAC, Tier III | VMs actuales, recursos usados, línea base, capacidad real | No podemos dimensionar nuestra nube. Riesgo de saturación inmediata |
| **Base de Datos** | Oracle 19c RAC, SQL Server | Esquema ER, diccionario datos, índices, procedures, tamaño BD | No podemos operar ni optimizar. Riesgo de réplica fallida |
| **Seguridad** | FortiWeb estable, OWASP, geobloqueo | Reglas exactas, políticas, usuarios, certificados, MFA config | Riesgo de brecha de seguridad en transición |
| **Operación** | 210K procesos/mes, 45K usuarios | Runbooks, procedimientos, escalamiento, contactos soporte | No podemos operar 24/7 el primer día |
| **Desarrollo** | HU en backlog, certificación, producción | Código fuente, repositorio Git, pipelines de despliegue | No podemos hacer evolutivos ni corregir bugs |
| **Call Center** | Wolkvox, Aranda, 15K concurrentes | Configuración, IVR, scripts, malla turnos actual | No podemos atender usuarios día 1 |
| **BI** | Cubos, tableros, ETL | Herramienta BI exacta, ETLs, schedules, data sources | No podemos generar informes mensuales obligatorios |
| **GNCV/GAS** | Bizagi BPM en levantamiento | Procesos actuales legado, migración parcial, datos maestros | Riesgo de no tener sistema GNCV funcional al corte |
| **Contractual** | 6 meses, 25M mensual, empalme mayo-junio | Cláusulas de multa, responsabilidades, alcance exacto Innovadataco | Podemos asumir obligaciones que no nos corresponden |

---

## PARTE 4: CONCLUSIONES Y RECOMENDACIONES INMEDIATAS

### 4.1 Conclusiones

1. **La operación Abril 2026 no es estable.** Internexa ya incumplió 2 ANS críticos. La plataforma "Nuevo SICOM" tiene problemas de disponibilidad que el legado no tiene.

2. **La infraestructura Oracle RAC tiene un problema crónico no resuelto.** Los 400,000 registros masivos de agentes GAS siguen siendo una amenaza. Sin mitigación, esto explotará en nuestras manos.

3. **Hay deuda técnica significativa.** Aplicaciones móviles sin publicar, GAS a BPM sin migrar, BI en pruebas, SIGDI con HU pendientes. Esto no es una operación lista para "mantener". Es una operación en medio de una transformación.

4. **Innovadataco no está listo.** No tenemos equipo técnico, no tenemos nube privada confirmada, no tenemos licencias Oracle, no tenemos acceso a los sistemas.

### 4.2 Recomendaciones para Luis Felipe y CI2

| # | Recomendación | Prioridad | Plazo |
|---|-------------|-----------|-------|
| 1 | **Exigir a Internexa un informe técnico de remediación** de los problemas de saturación Oracle antes del corte | 🔴 Crítico | 20 mayo 2026 |
| 2 | **Definir en contrato quién asume multas de transición** (Internexa vs Innovadataco vs CI2) | 🔴 Crítico | 20 mayo 2026 |
| 3 | **Solicitar acceso a las 15 carpetas técnicas vacías** del Drive (ARQUITECTURA, DRP, LICENCIAS, etc.) | 🔴 Crítico | 15 mayo 2026 |
| 4 | **Programar reunión técnica Internexa-Innovadataco** con arquitecto, DBA, y líder seguridad de ambas partes | 🔴 Crítico | 18 mayo 2026 |
| 5 | **Validar si CI2 ya aplicó multas a Internexa** por ANS incumplidos de abril | 🟡 Alta | 15 mayo 2026 |
| 6 | **Confirmar que Innovadataco NO hereda deuda técnica** de vigencia 7 como obligación contractual | 🟡 Alta | 20 mayo 2026 |
| 7 | **Exigir a Internexa entrega de runbooks operativos** actualizados (no solo listas de chequeo) | 🟡 Alta | 25 mayo 2026 |
| 8 | **Confirmar estado real de aplicaciones móviles** (¿publicadas? ¿en tiendas? ¿aprobadas por MME?) | 🟡 Alta | 18 mayo 2026 |
| 9 | **Evaluar si es viable postergar inicio operación** del 1 julio al 15 julio si faltan entregables críticos | 🟡 Alta | 20 mayo 2026 |
| 10 | **Innovadataco contratar DBA Oracle y Arquitecto Nube** de inmediato | 🔴 Crítico | 15 junio 2026 |

---

## PARTE 5: APÉNDICE — DATOS CRUDOS POR DOCUMENTO

### A.1 Resumen Ejecutivo Abril 2026 — Firmas y Equipo

| Rol | Nombre |
|-----|--------|
| Director Proyecto | Alejandro Martínez |
| Ingeniero Experiencia | Luis Javier Ortiz |
| Líder Temático | Ronald Salinas |
| Gerente del Proyecto (dueño documento) | [No nombrado en firma] |
| Contrato | 2034 de 2025 |
| Cliente | Ministerio de Minas y Energía |
| Vigencia | 7 (2025-2026) |

### A.2 RFCs Detallados (Mantenimientos de Emergencia)

**RFC 226** (13/08/2025): Depuración archives rack BD GNCV. Indisponibilidad 70 min. Causa: 400K peticiones masivas de agentes GAS.

**RFC 228** (16/09/2025): Depuración archives rack BD GNCV (segunda vez). Indisponibilidad 30 min. Misma causa.

**RFC 229** (19/08/2025): Depuración almacenamiento BD Nuevo SICOM. Indisponibilidad 45 min. Misma causa.

**RFC 232** (27/09/2025): Bloqueo usuario BISA Oracle RAC DWH. Indisponibilidad ETL líquidos. Resuelto manualmente.

### A.3 ANS Abril 2026 — Tabla Completa

| Servicio | Comprometido | Real | Estado |
|----------|-------------|------|--------|
| Disponibilidad Nuevo SICOM Líquidos | >99.98% | 99.88% | ❌ |
| Disponibilidad SICOM Líquidos | >99.98% | 100% | ✅ |
| Canales Comunicación | >99.98% | 100% | ✅ |
| Web Service Nuevo SICOM | >99.98% | 99.90% | ❌ |
| Web Service GNCV | >99.98% | 99.99% | ✅ |
| Servicio Cubos | >99.98% | 99.999% | ✅ |
| Periodicidad Actualización Info | <6 horas | 99.58% | ✅ |
| Dashboard | >99.98% | 100% | ✅ |
| App Móvil Líquidos | >99.98% | 100% | ✅ |
| App Móvil Gas | >99.98% | 100% | ✅ |
| Portal Autogestión | >99.98% | 100% | ✅ |
| Contingencia RPO | <30 min | 100% | ✅ |

---

**Preparado por:** ZEUS — Análisis Documental SICOM, Innovadataco  
**Fecha:** 14 de mayo de 2026  
**Nivel confidencial:** ALTO — Solo para CEO y Consejo Asesor

---

*Este informe se basa en la revisión completa de 10 documentos descargados de la carpeta "5. ABRIL" del proyecto SICOM MME. Las conclusiones son inferencias técnicas basadas en evidencia documental. No son opiniones sin fundamento.*