# CRONOGRAMA DEL EMPALME SICOM - DIAGRAMA DE GANTT
## Empalme Operativo SICOM — CI2 ↔ INTERNEXA ↔ MME

---

**Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto:** Jelkin Zair Carrillo Franco (CI2)  
**Fecha Inicio:** 19 de Mayo de 2026  
**Fecha Fin:** 30 de Junio de 2026  
**Duración:** 6 semanas (42 días calendario)  
**Inicio Operación CI2:** 1 de Julio de 2026  

---

## RESUMEN DE AVANCE

```
PROGRESO ACTUAL: █░░░░░░░░░░░░░░░░░░░ 5% (Semana 1 en curso)
DIAS TRANSCURRIDOS: 2 días (19-20 mayo)
DIAS RESTANTES: 40 días
```

---

## CRONOGRAMA DETALLADO

### SEMANA 1: 19-25 MAYO 2026 — FASE INICIO

```
[19 May] ████████████████████████████████████████ INICIO OFICIAL
├── [19 May] Instalación Gobierno del Empalme
│   ├── Comité Directivo constituido
│   ├── Mesa técnica diaria definida
│   ├── War room / sala de crisis habilitada
│   └── Roles y responsabilidades firmados
├── [19-20 May] Solicitud formal de entregables
│   └── Matriz de requerimiento a INTERNEXA
├── [20-21 May] Recibir accesos SOLO LECTURA
│   ├── Repositorios, herramientas, mesa de servicio
│   ├── Monitoreo, tableros, documentación
│   └── Ambientes de prueba
├── [21-22 May] Levantar mapa de actores
│   └── Contactos, roles, responsabilidades
├── [22-23 May] Abrir matriz RAID
│   └── Riesgos iniciales registrados
├── [23-25 May] Plan de replicación de infraestructura
│   └── Escenarios de comunicaciones para datacenter CI2
└── [25 May] ✅ HITO M1: Gobierno Instalado
```

**Responsable:** Jelkin Carrillo (CI2) + Elizabeth (MME)

---

### SEMANA 2: 26-31 MAYO 2026 — INVENTARIO TÉCNICO

```
[26-31 May] ████████████████████████████████████████ INVENTARIO
├── [26-27 May] Consolidar inventario técnico real
│   ├── Ambientes, VMs, middleware
│   ├── BD, almacenamiento, redes
│   └── Certificados, dominios, jobs, colas
├── [27-28 May] Recibir arquitectura lógica y física
│   └── Validar coincidencia con operación real
├── [28-29 May] Recibir inventario de licencias
│   ├── Contratos de soporte
│   ├── Vencimientos, dependencias críticas
│   └── Matriz de licencias
├── [29-30 May] Recibir matriz de accesos (RBAC)
│   └── Control administrativo y operacional
├── [30-31 May] Recibir línea base de servicio
│   ├── ANS, disponibilidad histórica
│   ├── Incidentes mayores, top de fallas
│   └── Top de integraciones críticas
└── [31 May] ✅ HITO M2: Inventario Técnico Completo
```

**Responsable:** INTERNEXA (entrega) + CI2 (validación)

---

### SEMANA 3: 1-7 JUNIO 2026 — VALIDACIÓN TÉCNICA

```
[1-7 Jun] ████████████████████████████████████████ VALIDACIÓN
├── [1-2 Jun] Clonar o recibir repositorios
│   └── Verificar consistencia código-artefactos-despliegues
├── [2-3 Jun] Levantar estructura de componentes
│   ├── Java, Spring Boot (legado), Bizagi/BPM
│   ├── APIs, front-end, scripts, ETL, BI, APPs
│   └── Servicios de apoyo
├── [3-4 Jun] Recibir y validar estructura de despliegue
│   ├── Ramas, pipelines, variables, secretos
│   └── Scripts, rollback
├── [4-5 Jun] Recibir documentación de BD
│   ├── Modelos, diccionarios, jobs, usuarios
│   ├── Auditorías, volumen de crecimiento
│   └── Políticas de backup/restauración
├── [5-6 Jun] Preparar ambiente de ensayo CI2
│   └── Pruebas de restauración, despliegue, ejecución
└── [7 Jun] Checkpoint técnico semanal
```

**Responsable:** CI2 (validación) + INTERNEXA (entrega)

---

### SEMANA 4: 8-14 JUNIO 2026 — RESTORE Y PRUEBAS

```
[8-14 Jun] ████████████████████████████████████████ PRUEBAS
├── [8-9 Jun] Ejecutar restauración de backups
│   ├── Aplicaciones y BD en ambiente controlado
│   └── Restore ejecutado con evidencia
├── [9-10 Jun] Validar integridad de datos
│   ├── Consistencia referencial
│   └── Completitud de objetos
├── [10-11 Jun] Primera ronda de pruebas técnicas
│   ├── Acceso, servicios web, autenticación
│   ├── Conectividad, jobs, colas, notificaciones
│   └── Monitoreo
├── [11-12 Jun] Levantar hallazgos
│   ├── Configuración, componentes faltantes
│   ├── Errores de restore, divergencias
│   └── Registro de hallazgos con severidad
├── [12-14 Jun] Cerrar acta parcial de recibo técnico
│   ├── Infraestructura, código y datos
│   └── Acta parcial #1 firmada
└── [14 Jun] ✅ HITO M3: Restore Validado
```

**Responsable:** CI2 (ejecución) + INTERNEXA (soporte) + Elizabeth (MME)

---

### SEMANA 5: 15-21 JUNIO 2026 — OPERACIÓN EN SOMBRA

```
[15-21 Jun] ████████████████████████████████████████ SHADOWING
├── [15-16 Jun] Integración con SIEM
│   └── Logs operacionales validados
├── [16-17 Jun] Escaneo de vulnerabilidades
│   ├── Externo e interno
│   └── Informe de vulnerabilidades v1.0
├── [17-18 Jun] Identificación sistemas Legacy
│   ├── Clasificación de obsolescencia
│   └── Controles compensatorios
├── [18-19 Jun] Iniciar operación en sombra
│   └── Equipo CI2 junto a INTERNEXA
├── [19-20 Jun] Sesiones de transferencia funcional
│   ├── Líquidos, GNCV, autogestión, APPs
│   ├── BI, operación estadística
│   └── Mesa de ayuda, contingencias
├── [20-21 Jun] Construir runbooks CI2
│   └── Basados en operación observada
├── [21 Jun] Pruebas funcionales guiadas
│   └── Casos críticos de negocio
└── [21 Jun] ✅ HITO M4: Operación en Sombra Iniciada
```

**Responsable:** CI2 (observación) + INTERNEXA (transferencia)

---

### SEMANA 6: 22-30 JUNIO 2026 — CORTE Y RECIBO FINAL

```
[22-30 Jun] ████████████████████████████████████████ CORTE
├── [22-23 Jun] Pruebas de estrés, rendimiento, seguridad
│   └── Informe de pruebas de estrés y rendimiento
├── [23-24 Jun] Validación sitio alterno
│   ├── Replicación, RPO/RTO
│   └── Procedimiento de conmutación
├── [24-25 Jun] Validar certificados, cuentas, RBAC, MFA
│   └── Seguridad operativa validada
├── [25-26 Jun] Simulacros de contingencia
│   ├── Caída de servicio, error de integración
│   ├── Restore de backup, reversión de despliegue
│   └── Contingencia funcional
├── [26-27 Jun] Informe de brechas críticas
│   └── Fecha de cierre antes del corte
├── [27-28 Jun] Comité Go/No-Go preliminar
│   └── Decisión riesgos impeditivos
├── [28-29 Jun] Handover final
│   ├── Credenciales productivas, custodia de secretos
│   ├── Repositorios, consolas, herramientas
│   └── Custodia completa transferida
├── [29-30 Jun] Corte controlado
│   ├── Validación post-corte
│   └── Monitoreo intensivo
└── [30 Jun] ✅ HITO M5: Acta de Recibo Final Firmada
```

**Responsable:** CI2 (corte) + MME (Elizabeth) + INTERNEXA (handover)

---

## RUTA CRÍTICA

```
[19 May] Inicio Gobierno
  ↓
[25 May] Gobierno Instalado ⭐
  ↓
[31 May] Inventario Técnico Completo ⭐
  ↓
[14 Jun] Restore Validado ⭐
  ↓
[21 Jun] Operación en Sombra Iniciada ⭐
  ↓
[30 Jun] Corte Controlado 🚨 CRÍTICO
  ↓
[30 Jun] Acta de Recibo Final Firmada 🚨 CRÍTICO
  ↓
[15 Jul] Estabilización Completada
```

---

## HITOS (MILESTONES)

| Hito | Fecha Plan | Fecha Real | Estado | Responsable |
|------|------------|------------|--------|-------------|
| M1: Gobierno Instalado | 25 May 2026 | [En curso] | 🟡 En progreso | Jelkin Carrillo |
| M2: Inventario Técnico | 31 May 2026 | - | ⏳ Futuro | INTERNEXA |
| M3: Restore Validado | 14 Jun 2026 | - | ⏳ Futuro | CI2 + INTERNEXA |
| M4: Shadowing Iniciado | 21 Jun 2026 | - | ⏳ Futuro | CI2 |
| M5: Corte Controlado | 30 Jun 2026 | - | ⏳ Futuro | CI2 + MME |
| M6: Recibo Final Firmado | 30 Jun 2026 | - | ⏳ Futuro | MME + CI2 + INTERNEXA |
| M7: Estabilización | 15 Jul 2026 | - | ⏳ Futuro | CI2 |

---

## DEPENDENCIAS CRÍTICAS

| ID | Dependencia | Predecesora | Sucesora | Tipo |
|----|-------------|-------------|----------|------|
| D01 | Gobierno instalado | M1 | M2 | Fin-a-Inicio |
| D02 | Inventario completo | M2 | M3 | Fin-a-Inicio |
| D03 | Restore validado | M3 | M4 | Fin-a-Inicio |
| D04 | Shadowing iniciado | M4 | M5 | Fin-a-Inicio |
| D05 | Acta recibo firmada | M5 | M6 | Fin-a-Inicio |
| D06 | Corte controlado | M5 | M7 | Fin-a-Inicio |

---

## RECURSOS ASIGNADOS

| Recurso | Entidad | Asignación | Período | Rol |
|---------|---------|------------|---------|-----|
| Jelkin Carrillo | CI2 | 100% | 19 May - 15 Jul 2026 | Gerente de Proyecto |
| Especialista Seguridad | CI2 | 100% | 19 May - 30 Jun 2026 | Seguridad |
| Especialista Infra | CI2 | 100% | 19 May - 30 Jun 2026 | Infraestructura |
| Especialista BD | CI2 | 100% | 19 May - 30 Jun 2026 | Bases de Datos |
| Especialista Apps | CI2 | 100% | 19 May - 30 Jun 2026 | Aplicaciones |
| Especialista Operación | CI2 | 100% | 15 Jun - 30 Jun 2026 | Operación |
| Responsable Técnico | INTERNEXA | 50% | 19 May - 30 Jun 2026 | Entrega técnica |
| Responsable Operativo | INTERNEXA | 50% | 15 Jun - 30 Jun 2026 | Transferencia funcional |
| Elizabeth | MME | 25% | 19 May - 30 Jun 2026 | Supervisión |

---

## ALERTAS DE CRONOGRAMA

🔴 **ALERTA CRÍTICA:**
- Semana 1 ya inició (19 mayo) pero gobierno aún en instalación
- Fecha límite M1: 25 mayo — 5 días restantes

🟡 **ATENCIÓN:**
- Dependencia de INTERNEXA para entrega de inventario (M2)
- Si INTERNEXA se retrasa, toda la ruta crítica se desplaza

🟢 **NORMAL:**
- Recursos CI2 asignados y disponibles
- Ambiente de ensayo en preparación

---

**Jelkin Zair Carrillo Franco**  
*Gerente de Proyecto del Empalme SICOM — CI2*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*
