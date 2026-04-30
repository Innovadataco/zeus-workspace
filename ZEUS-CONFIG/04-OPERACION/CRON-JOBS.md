# Cron Jobs - ZEUS

## Configuración de Tareas Programadas

### Reporte Diario 8 AM (Hora Colombia)

**Comando:**
```bash
0 13 * * * cd /root/.openclaw/workspace/ZEUS-CONFIG && node 04-OPERACION/scripts/reporte-diario.js >> /tmp/zeus-cron.log 2>&1 && cd /root/.openclaw/workspace/ZEUS-CONFIG && git add . && git commit -m "Reporte diario $(date +%Y-%m-%d)" && git push origin master
```

**Explicación:**
- `0 13 * * *` = Todos los días a las 13:00 UTC (8:00 AM hora Colombia)
- Ejecuta script de reporte diario
- Guarda log en /tmp/zeus-cron.log
- Commitea y sube al repo automáticamente

**Hora Colombia (GMT-5):**
- 8:00 AM COL = 13:00 UTC
- Ajustar en horario de verano si aplica

### Heartbeat Cada Hora

**Comando:**
```bash
0 8-18 * * * cd /root/.openclaw/workspace/ZEUS-CONFIG && node 04-OPERACION/scripts/heartbeat.js >> /tmp/zeus-heartbeat.log 2>&1
```

**Explicación:**
- Cada hora entre 8 AM y 6 PM hora Colombia
- Ejecuta verificaciones de heartbeat
- No genera commit automático (solo log)

---

## Instalación

Para activar estos cron jobs, ejecutar:
```bash
crontab /root/.openclaw/workspace/ZEUS-CONFIG/04-OPERACION/cron-jobs.txt
```

Verificar instalación:
```bash
crontab -l
```

---

## Notas

- Los jobs persisten incluso si la sesión se cierra
- Los logs se guardan en /tmp/ para debugging
- Los reportes se guardan en 04-OPERACION/REPORTES/
- Cada reporte se commitea al repo automáticamente
