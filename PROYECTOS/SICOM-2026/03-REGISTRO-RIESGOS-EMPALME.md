# REGISTRO DE RIESGOS DEL EMPALME SICOM
## Empalme Operativo SICOM — CI2 ↔ INTERNEXA ↔ MME

---

**Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto CI2:** Ludi Felipe Herrera (CI2 / IND TECH)  
**Director de Empalme / PM Ejecutivo:** Jelkin Zair Carrillo Franco (Innovadataco)  
**Versión:** 1.0  
**Fecha:** 20 de Mayo de 2026  
**Próxima Revisión:** Semanal (cada viernes 5:00 PM)  

---

## LEYENDA DE PROBABILIDAD E IMPACTO

**Probabilidad:**
- A (Alta): >70% de ocurrir
- M (Media): 30-70% de ocurrir
- B (Baja): <30% de ocurrir

**Impacto:**
- Crítico: Afecta objetivos principales, plazo o costo >20%
- Alto: Afecta entregables específicos, requiere acción inmediata
- Medio: Genera retrasos menores o costos adicionales
- Bajo: Manejable sin afectar objetivos principales

**Estrategias:**
- Evitar: Eliminar la causa
- Mitigar: Reducir probabilidad/impacto
- Transferir: Tercerizar el riesgo
- Aceptar: Monitorear sin acción

---

## RIESGOS ACTIVOS

### R001: Resistencia de INTERNEXA a entregar información

| Campo | Descripción |
|-------|-------------|
| **Descripción** | INTERNEXA puede resistirse a entregar documentación, accesos, código, backups o conocimiento crítico, ya sea por desinterés, falta de recursos asignados o conflictos internos |
| **Categoría** | Contractual/Operativo |
| **Probabilidad** | A (Alta) — Ya está ocurriendo |
| **Impacto** | Crítico — Bloquea todo el empalme, imposible continuar sin entregas |
| **Prioridad** | 🔴 CRÍTICA |
| **Estrategia** | Mitigar + Transferir |
| **Plan de Acción** | 1) Formalizar TODOS los requerimientos por escrito (matriz de entregables)<br>2) Invocar cláusulas contractuales de entrega y cesión (Contrato GGC-2034-2025)<br>3) Escalar a Elizabeth (MME) en máximo 24h si hay resistencia<br>4) Documentar cada solicitud y respuesta (trazabilidad legal)<br>5) Preparar plan legal de contingencia con Diana Cáceres<br>6) Establecer consecuencias contractuales por incumplimiento |
| **Responsable** | Jelkin Carrillo (Innovadataco) + Elizabeth (MME) |
| **Reporte a** | Ludi Herrera (CI2) — Alerta inmediata si hay resistencia |
| **Fecha Límite** | Continuo — Semana 1 (instalación gobierno) |
| **Estado** | 🔄 En tratamiento |
| **Indicador** | % de entregables recibidos vs solicitados (meta: 100%) |

---

### R002: Documentación incompleta o desactualizada

| Campo | Descripción |
|-------|-------------|
| **Descripción** | El inventario técnico, arquitectura, código o documentación entregada por INTERNEXA puede estar incompleto, desactualizado o no coincidir con la realidad operativa |
| **Categoría** | Técnico/Calidad |
| **Probabilidad** | A (Alta) — Común en empalmes |
| **Impacto** | Alto — Falla en apropiación técnica, retrabajo, hallazgos críticos |
| **Prioridad** | 🔴 CRÍTICA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Validar documentación contra ambiente real (no solo contra documentos)<br>2) Levantamiento técnico independiente por parte de CI2<br>3) Comparar arquitectura aterrizada vs operación real<br>4) Emitir acta de no conformidad si hay brechas<br>5) Exigir completitud como condición de pago/aceptación<br>6) Documentar hallazgos con severidad y plan de cierre |
| **Responsable** | Especialista Infra (CI2) + Especialista BD (CI2) |
| **Fecha Límite** | Semana 2 (31 mayo) — Inventario completo |
| **Estado** | ⏳ Preventivo |
| **Indicador** | % de documentación validada vs requerida (meta: 100%) |

---

### R003: Backups no restaurables

| Campo | Descripción |
|-------|-------------|
| **Descripción** | Los backups de aplicaciones y bases de datos proporcionados por INTERNEXA pueden no restaurarse correctamente en el ambiente de CI2 |
| **Categoría** | Técnico/Continuidad |
| **Probabilidad** | M (Media) |
| **Impacto** | Crítico — Pérdida de datos, imposibilidad de continuidad, falla del empalme |
| **Prioridad** | 🔴 CRÍTICA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Exigir prueba de restore en ambiente controlado (Semana 4)<br>2) Validar integridad de datos post-restore<br>3) Tener plan B: reconstrucción desde código fuente<br>4) No aprobar corte sin restore validado y documentado<br>5) Probar restore en ambiente de ensayo CI2 antes de producción<br>6) Verificar consistencia referencial y completitud de objetos |
| **Responsable** | Especialista BD (CI2) + INTERNEXA (soporte) |
| **Fecha Límite** | Semana 4 (14 junio) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | Restore exitoso documentado (meta: 100% éxito) |

---

### R004: Credenciales o certificados no transferibles

| Campo | Descripción |
|-------|-------------|
| **Descripción** | Claves, certificados SSL, cuentas de servicio, tokens de API o credenciales de terceros pueden no ser transferibles a CI2 |
| **Categoría** | Seguridad |
| **Probabilidad** | M (Media) |
| **Impacto** | Alto — Bloqueo operativo, imposibilidad de integraciones, caída de servicios |
| **Prioridad** | 🟡 ALTA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Inventario completo de credenciales (Semana 1)<br>2) Plan de rotación controlada de secretos<br>3) Identificar certificados con proveedores externos<br>4) Renegociar contratos de terceros si es necesario<br>5) No aprobar corte sin 100% de credenciales transferidas<br>6) Validar RBAC y MFA en ambiente CI2 antes del corte |
| **Responsable** | Especialista Seguridad (CI2) |
| **Fecha Límite** | Semana 6 (30 junio) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | % de credenciales transferidas (meta: 100%) |

---

### R005: Dependencia de personas clave de INTERNEXA

| Campo | Descripción |
|-------|-------------|
| **Descripción** | El conocimiento tácito del sistema puede estar concentrado en pocas personas de INTERNEXA, sin documentación adecuada. Si estas personas no están disponibles, se pierde conocimiento crítico |
| **Categoría** | Conocimiento/Operativo |
| **Probabilidad** | A (Alta) |
| **Impacto** | Alto — Pérdida de conocimiento, imposibilidad de operar post-corte |
| **Prioridad** | 🟡 ALTA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Identificar personas clave desde Semana 1<br>2) Sesiones de transferencia grabadas (audio/video)<br>3) Shadowing obligatorio: CI2 observa y ejecuta junto a INTERNEXA<br>4) Construir runbooks CI2 con operación real, no solo documentos<br>5) Validación funcional en campo con casos críticos<br>6) Plan de contingencia si persona clave no está disponible |
| **Responsable** | Jelkin Carrillo (CI2) + Responsable Operativo (INTERNEXA) |
| **Fecha Límite** | Semana 5-6 (operación en sombra) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | # de sesiones grabadas, # de runbooks construidos (meta: 100% procesos críticos) |

---

### R006: Retraso en aprovisionamiento infraestructura CI2

| Campo | Descripción |
|-------|-------------|
| **Descripción** | La infraestructura destino de CI2 (servidores, redes, almacenamiento, enlaces) puede no estar lista a tiempo para recibir el sistema |
| **Categoría** | Infraestructura |
| **Probabilidad** | M (Media) |
| **Impacto** | Alto — Imposibilidad de replicar, retraso en restore, retraso en pruebas |
| **Prioridad** | 🟡 ALTA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Kickoff inmediato de infraestructura (Semana 1)<br>2) Contratar enlaces telecom con urgencia<br>3) Instalar hardware en rack con prioridad<br>4) Configurar VMware, networking, backups con HA<br>5) Plan B: usar nube temporal si infraestructura propia no está lista<br>6) Monitoreo diario de avance de infraestructura |
| **Responsable** | Especialista Infra (CI2) + Proveedores HW/Telecom |
| **Fecha Límite** | Semana 3 (7 junio) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | % de infraestructura lista (meta: 100% para Semana 3) |

---

### R007: Falla en pruebas de estrés o rendimiento

| Campo | Descripción |
|-------|-------------|
| **Descripción** | El sistema puede no soportar la carga operativa real en el ambiente de CI2, revelando cuellos de botella no detectados |
| **Categoría** | Técnico/Rendimiento |
| **Probabilidad** | M (Media) |
| **Impacto** | Alto — Degradación del servicio post-corte, incumplimiento ANS |
| **Prioridad** | 🟡 ALTA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Definir perfiles de carga basados en operación real<br>2) Ejecutar pruebas de estrés en ambiente de ensayo<br>3) Identificar cuellos de botella y plan de optimización<br>4) Validar escalabilidad horizontal/vertical<br>5) No aprobar corte sin pruebas de rendimiento aprobadas<br>6) Plan de escalación rápida post-corte si se detectan problemas |
| **Responsable** | Especialista Apps (CI2) + Especialista Infra (CI2) |
| **Fecha Límite** | Semana 6 (30 junio) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | Resultado pruebas estrés (meta: aprobado) |

---

### R008: Brechas de seguridad no detectadas

| Campo | Descripción |
|-------|-------------|
| **Descripción** | El sistema puede tener vulnerabilidades de seguridad no detectadas que se manifiesten durante o después del empalme |
| **Categoría** | Seguridad |
| **Probabilidad** | M (Media) |
| **Impacto** | Crítico — Incidente de seguridad, exposición de datos, sanciones |
| **Prioridad** | 🔴 CRÍTICA |
| **Estrategia** | Mitigar |
| **Plan de Acción** | 1) Escaneo de vulnerabilidades externo e interno<br>2) Revisión de presentación en capa perimetral (Firewall/WAF)<br>3) Validación de RBAC, MFA, bóveda de secretos<br>4) Integración con SIEM y verificación de logs<br>5) Identificación de sistemas legacy y controles compensatorios<br>6) No aprobar corte sin informe de seguridad limpio |
| **Responsable** | Especialista Seguridad (CI2) |
| **Fecha Límite** | Semana 5-6 (21-30 junio) |
| **Estado** | ⏳ Preventivo |
| **Indicador** | # de vulnerabilidades críticas abiertas (meta: 0) |

---

## RIESGOS RESIDUALES (Aceptados)

| ID | Riesgo | Prob. | Impacto | Estrategia | Justificación |
|----|--------|-------|---------|------------|---------------|
| RR01 | Cambios en prioridades del MME | B | Alto | Aceptar | Gobierno del empalme gestionará con Elizabeth |
| RR02 | Indisponibilidad de Elizabeth (MME) | B | Medio | Aceptar | Jelkin tiene contacto directo, escalación definida |
| RR03 | Problemas técnicos de plataformas (Drive, GitHub) | B | Bajo | Aceptar | Backups automáticos diarios |
| RR04 | Retraso en aprobaciones formales del MME | M | Medio | Aceptar | Elizabeth comprometida, seguimiento semanal |

---

## HISTORIAL DE RIESGOS ATENDIDOS

| ID | Riesgo | Fecha Cierre | Resultado | Responsable |
|----|--------|--------------|-----------|-------------|
| - | Sin riesgos cerrados aún | - | - | - |

---

## ACCIONES INMEDIATAS (PRÓXIMAS 48 HORAS)

1. 🔴 **URGENTE:** Formalizar matriz de entregables a INTERNEXA (Jelkin)
2. 🔴 **URGENTE:** Identificar personas clave de INTERNEXA (Jelkin)
3. 🟡 **IMPORTANTE:** Iniciar kickoff de infraestructura CI2 (Especialista Infra)
4. 🟡 **IMPORTANTE:** Inventario inicial de credenciales (Especialista Seguridad)
5. 🟢 **PLANIFICADO:** Preparar ambiente de ensayo (Especialista BD)

---

## REVISIÓN Y ACTUALIZACIÓN

**Frecuencia:** Semanal (cada viernes 5:00 PM)  
**Responsable Revisión:** Jelkin Zair Carrillo Franco  
**Participantes:** Especialistas CI2 + Elizabeth (MME)  
**Método:** Mesa Técnica de Empalme  

**Próximas revisiones:**
- 23 Mayo 2026
- 30 Mayo 2026
- 6 Junio 2026
- 13 Junio 2026
- 20 Junio 2026
- 27 Junio 2026

---

**Ludi Felipe Herrera**  
*Gerente de Proyecto CI2 — IND TECH / CI2*

**Jelkin Zair Carrillo Franco**  
*Director de Empalme / PM Ejecutivo — Innovadataco*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*