# COMANDO: /IDC_ESTADO_PROYECTO
## Radiografía Completa de Proyectos INNOVADATACO

### 1. REGISTRO EN INTERFAZ
**Comando:** `/IDC_ESTADO_PROYECTO`  
**Alias:** `estado proyecto`, `status proyecto`  
**Prioridad:** ALTA  
**Acceso:** CEO (Jelkin) directo

---

### 2. FLUJO DE EJECUCIÓN

#### PASO A: Escaneo y Listado
1. Buscar en Google Drive (carpetas IDC_*)
2. Buscar en OneDrive (si configurado)
3. Buscar en memoria local (ZEUS-CONFIG/03-PROYECTOS/)
4. Presentar lista numerada

**Formato de respuesta PASO A:**
```
🦁 INNOVADATACO - PROYECTOS DETECTADOS
══════════════════════════════

Estos son los proyectos que estoy monitoreando:

1. 📌 APP Chía-Girardot (ITS)
   Cliente: TransConsult | Fase: Ejecución

2. ⚪ [Proyecto 2 - pendiente info]

3. ⚪ [Proyecto 3 - pendiente info]

¿Cuál proyecto deseas auditar?
Responde con el número (1, 2 o 3).
```

#### PASO B: Generación de Informe Visual
Una vez seleccionado el proyecto, extraer datos y presentar:

```
══════════════════════════════
📂 PROYECTO: [Nombre del Proyecto]
🏢 Empresa: INNOVADATACO
──────────────────────────────

📝 RESUMEN EJECUTIVO
• Fase PM²: [Iniciación | Planificación | Ejecución | Cierre]
• Objetivo: [Breve descripción]

📅 ESTADO DEL CRONOGRAMA
• Status: [🟢 A tiempo | 🟡 En riesgo | 🔴 Retrasado]
• Progreso: [% completado vs % planeado]
• Fecha fin contrato: [Fecha]
• Días restantes: [N] días

⚒️ ACTIVIDADES RECIENTES
• [Última actualización Drive]
• [Último commit GitHub]
• [Último hito completado]

⚠️ ALERTAS Y BLOQUEOS
• Urgencia: [Documentos o aprobaciones pendientes]
• Deadlines <48h: [Alertas]
• Documentos faltantes: [Checklist PM2]

🎯 PRÓXIMAS TAREAS (RUTA CRÍTICA)
1. [Siguiente paso inmediato]
2. [Tarea secundaria]
3. [Reunión o hito pendiente]

──────────────────────────────
¿CEO, quieres que redacte un borrador de seguimiento?
══════════════════════════════
```

---

### 3. REGLAS DE OPERACIÓN

#### Sincronización
- Guardar nota de revisión en GitHub (`ZEUS-CONFIG/03-PROYECTOS/LOG_REVISIONES.md`)
- Timestamp de cada ejecución
- Cambios detectados vs revisión anterior

#### Proactividad
- Si falta documento PM2 → Alertar en sección "Documentos faltantes"
- Si deadline <48h → ALERTA ROJA
- Si progreso < esperado → Sugerir acciones

#### Tono
- Profesional, ejecutivo
- Enfocado en decisiones rápidas
- Sin tecnicismos innecesarios

---

### 4. TRIGGERS AUTOMÁTICOS

**Activación manual:**
- Usuario escribe: `/IDC_ESTADO_PROYECTO`
- O: `estado proyecto`
- O: `status proyecto`

**Activación automática:**
- Heartbeat diario detecta proyecto en riesgo
- Alerta deadline próximo

---

### 5. DATOS DE CONEXIÓN

**Fuentes de datos:**
1. Google Drive (carpeta IDC_2026_01 y otras)
2. GitHub repos (Innovadataco/)
3. Archivos locales ZEUS-CONFIG/
4. Calendario Google (hitos)

**Proyectos monitoreados actualmente:**
1. APP Chía-Girardot (TC-PS-05-917-2026)
2. [Pendiente: Proyecto 2]
3. [Pendiente: Proyecto 3]

---

*Comando activado: 2026-04-28*  
*Versión: 1.0*
