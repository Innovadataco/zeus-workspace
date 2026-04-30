# PROTOCOLO DE ARRANQUE - ZEUS

## Acciones Automáticas al Iniciar Sesión

### Paso 0: Información de Contexto (SIEMPRE - OBLIGATORIO)
Al iniciar CUALQUIER sesión, PRIMERO mostrar SIEMPRE:

```
═══════════════════════════════════════════════════
📅 [DÍA SEMANA], [FECHA] - [HORA] (Hora Colombia)
═══════════════════════════════════════════════════
```

**🔴 REGLA OBLIGATORIA PARA TODAS LAS SESIONES:**
- TODAS las respuestas deben incluir timestamp de Colombia
- Formato: 'Lunes, 28 de Abril de 2026 - 02:35 PM (Hora Colombia)'
- Timezone: America/Bogota (GMT-5)
- Sin excepciones, en todo momento, en todo mensaje

Ejemplo:
```
═══════════════════════════════════════════════════
📅 Martes, 27 de Abril de 2026 - 07:30 AM (Hora Colombia)
═══════════════════════════════════════════════════
```

### Paso 1: Detección de Instrucciones
- Leer archivo: `/root/.openclaw/workspace/ZEUS-CONFIG/02-GOBERNANZA/INSTRUCCIONES-PENDIENTES.md`
- Identificar instrucciones con frecuencia "Al iniciar sesión"

### Paso 2: Ejecución Inmediata
Ejecutar SIN preguntar primero:
```bash
node /root/.openclaw/workspace/scripts/validacion-simple.js
```

### Paso 3: Presentación
Mostrar resultado en formato uniforme:

```
🔍 VALIDACIÓN DE ACCESOS - [FECHA/HORA COL]
═══════════════════════════════════════════════════

📧 Gmail (gerencia@innovadataco.com)
   Status: [✅ Conectado / ❌ Error]

📅 Google Calendar
   Status: [✅ Conectado / ❌ Error]

📹 Google Meet
   Status: [✅ Conectado / ❌ Error]

📂 Google Drive
   Status: [✅ Conectado / ❌ Error]

💰 Saldo API KimiClaw
   Status: [✅ Operativo - XX% disponible / ❌ Bajo - XX% disponible]
   Consultar: session_status para ver uso actual
───────────────────────────────────────────────────

[Respuesta al saludo del CEO]
```

### Paso 4: Actualización
- Actualizar archivo INSTRUCCIONES-PENDIENTES.md local
- Commit y push a GitHub con resultado

---

## Formato de Fecha/Hora Colombia

```javascript
const opciones = { 
  timeZone: 'America/Bogota',
  weekday: 'long',
  year: 'numeric',
  month: 'long',
  day: 'numeric',
  hour: '2-digit',
  minute: '2-digit'
};

new Date().toLocaleString('es-CO', opciones);
// Resultado: "martes, 27 de abril de 2026, 07:30"
```

---

*Protocolo actualizado: 2026-04-28*
