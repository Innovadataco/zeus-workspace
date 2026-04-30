# Instrucciones Pendientes - Innovadataco

## Formato de Instrucción

```
### INST-YYYY-MM-DD-NNN: [Título]
- **Fecha asignación:** [Cuándo se dio la instrucción]
- **Instrucción:** [Qué hay que hacer exactamente]
- **Prioridad:** [CRÍTICA | ALTA | MEDIA | BAJA]
- **Deadline:** [Cuándo debe ejecutarse]
- **Frecuencia:** [Una vez | Diaria | Semanal | Al iniciar sesión]
- **Status:** [PENDIENTE | PROGRAMADA | EJECUTADA]
- **Ejecutada el:** [Fecha de ejecución]
- **Resultado:** [Resumen de lo que se hizo]
```

---

### INST-2026-04-28-001: Validación de Accesos al Iniciar Sesión
- **Fecha asignación:** 28 abril 2026
- **Instrucción:** Cada vez que se abra una nueva sesión, validar acceso a:
  - Gmail (gerencia@innovadataco.com)
  - Google Calendar
  - Google Meet
  - Google Drive
  - Saldo API KimiClaw
- **Prioridad:** ALTA
- **Deadline:** Inmediato al iniciar sesión
- **Frecuencia:** Al iniciar cada sesión
- **Status:** EJECUTADA
- **Ejecutada el:** 2026-04-27 19:27:12 UTC
- **Resultado:** ✅ Todos los servicios accesibles (5/5 OK) - Nueva sesión detectada 

**Formato de entrega:**
```
═══════════════════════════════════════════════════
🔍 VALIDACIÓN DE ACCESOS - [FECHA/HORA]
═══════════════════════════════════════════════════

📧 Gmail (gerencia@innovadataco.com)
   Status: [✅ Conectado / ❌ Error: X]

📅 Google Calendar
   Status: [✅ Conectado / ❌ Error: X]

📹 Google Meet
   Status: [✅ Conectado / ❌ Error: X]

📂 Google Drive
   Status: [✅ Conectado / ❌ Error: X]

💰 Saldo API KimiClaw
   Status: [✅ OK - XX% / ❌ Bajo - XX%]
───────────────────────────────────────────────────
```

---

### INST-2026-04-28-002: Revisión Saldo API
- **Fecha asignación:** 28 abril 2026
- **Instrucción:** Verificar saldo/créditos disponibles de la API configurada en KimiClaw
- **Prioridad:** ALTA
- **Deadline:** Inmediato al iniciar sesión
- **Frecuencia:** Al iniciar cada sesión
- **Status:** EJECUTADA
- **Ejecutada el:** 2026-04-27 19:18:55 UTC
- **Resultado:** API operativa - Sesión activa 

---

### INST-2026-04-28-003: Reporte Diario 8 AM
- **Fecha asignación:** 28 abril 2026
- **Instrucción:** Generar reporte ejecutivo todos los días a las 8:00 AM hora Colombia (GMT-5) con:
  - Emails recibidos overnight (últimas 12h)
  - Reuniones del día (próximas 24h)
  - Deadlines próximos (< 48h)
  - Estado de proyectos activos
  - Alertas críticas
- **Prioridad:** CRÍTICA
- **Deadline:** Todos los días 8:00 AM COL
- **Frecuencia:** Diaria
- **Status:** PROGRAMADA
- **Ejecutada el:** 
- **Resultado:** 

---

## Notas para ZEUS

### Al iniciar cada sesión:
1. Leer este archivo
2. Ejecutar INST-001 y INST-002 inmediatamente
3. Mostrar resultado en formato uniforme y práctico
4. Actualizar campo "Ejecutada el" y "Resultado"
5. Hacer commit al repo con los cambios

### Para INST-003 (Cron Job):
- Programar ejecución automática: 8:00 AM COL todos los días
- Si el usuario está offline, el mensaje se encola y se envía cuando vuelva
- El job persiste incluso si la sesión se cierra

### Persistencia garantizada:
- Este archivo está en GitHub: Innovadataco/ZEUS
- Cada cambio se commitea y sube automáticamente
- Al cerrar y volver a abrir sesión, las instrucciones permanecen
- Se puede verificar en el historial del repo que se están cumpliendo

---

*Última actualización: 28 abril 2026*
il 2026*
