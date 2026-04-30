# Heartbeat Configuration

## Configuración de Chequeos Automáticos

### Frecuencia
- **Intervalo:** Cada hora
- **Horario:** 8:00 AM - 6:00 PM (hora Colombia, GMT-5)
- **Días:** Todos los días (incluyendo fines de semana si hay urgencias)

### Actividades por Heartbeat

```
CADA HORA:
├─ 1. Revisar Google Workspace
│   ├─ Emails (gerencia@innovadataco.com)
│   ├─ Calendario (reuniones próximas 24h)
│   └─ Tareas pendientes
├─ 2. Revisar INSTRUCCIONES-PENDIENTES.md
│   └─ ¿Hay tareas programadas para ahora?
├─ 3. Revisar PROYECTOS-ACTIVOS.md
│   ├─ ¿Algún deadline < 24h?
│   ├─ ¿Algún deadline < 48h?
│   └─ ¿Proyecto estancado > 3 días?
├─ 4. Actualizar DASHBOARD-DIARIO.md
│   └─ Resumen ejecutivo del estado
├─ 5. Revisar fuentes de inteligencia
│   └─ Noticias relevantes (si configurado)
└─ 6. Decidir si alertar al CEO
    ├─ CRÍTICO (< 2h): Alerta inmediata
    └─ URGENTE (hoy/mañana): Acumular para resumen
```

### Niveles de Alerta

| Nivel | Condición | Acción | Canal |
|-------|-----------|--------|-------|
| 🔴 CRÍTICO | Deadline < 2h sin entrega | Alerta inmediata | Telegram |
| 🟡 URGENTE | Deadline hoy o mañana | Incluir en próximo resumen | Telegram |
| 🟢 INFORMATIVO | Novedad relevante | Incluir en resumen diario 8 AM | Telegram |

### Scripts Asociados
- `heartbeat-master.js` - Orquestador principal
- `check-google.js` - Verificación Google Workspace
- `actualizar-dashboard.js` - Generación de resumen

---

*Configuración establecida en Mesa Técnica 2026-04-27*
