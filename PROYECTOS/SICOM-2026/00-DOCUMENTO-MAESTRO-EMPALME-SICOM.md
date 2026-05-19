# DOCUMENTO MAESTRO DE LA OPERACIÓN EMPALME SICOM
## Sistema de Información de Combustibles Minerales — Operador CI2

---

**Código del Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto CI2:** Luis Felipe Herrera (CI2 / IND TECH)  
**Director de Empalme / PM Ejecutivo:** Jelkin Zair Carrillo Franco (Innovadataco)  
**Versión:** 1.0  
**Fecha:** 20 de Mayo de 2026  
**Estado:** Activo — En Ejecución

---

## 1. RESUMEN EJECUTIVO DE LA OPERACIÓN

### 1.1 ¿Qué es el SICOM?

El **Sistema de Información de Combustibles Minerales (SICOM)** es un sistema de información crítico operado por el **Ministerio de Minas y Energía (MME)** de Colombia. Su función principal es:

- **Monitorear** la cadena de suministro de combustibles minerales (gasolina, diesel, etc.)
- **Controlar** precios, inventarios, y movimientos de combustibles
- **Regular** el mercado de combustibles a nivel nacional
- **Reportar** a entidades de control (Contraloría, etc.)

### 1.2 ¿Por qué hay un Empalme?

| Aspecto | Detalle |
|---------|---------|
| **Operador Actual (Saliente)** | INTERNEXA S.A. |
| **Operador Nuevo (Entrante)** | CI2 / IND TECH |
| **Entidad Pública** | Ministerio de Minas y Energía (MME) |
| **Contrato Vigente** | GGC-2034-2025 (MME ↔ INTERNEXA) |
| **Motivo del Cambio** | Fin del contrato con INTERNEXA, selección de CI2 como nuevo operador |
| **Periodo de Empalme** | 19 mayo - 30 junio 2026 (6 semanas) |
| **Inicio Operación CI2** | 1 julio 2026 |

### 1.3 Estructura de Gobernanza del Empalme

```
┌─────────────────────────────────────────────────────────┐
│              MINISTERIO DE MINAS Y ENERGÍA               │
│                      (MME)                               │
│                   Elizabeth                              │
│              Supervisora del Contrato                    │
└──────────────────────┬──────────────────────────────────┘
                       │ Supervisa contractualmente
                       │ Recibe reportes quincenales
                       ▼
┌─────────────────────────────────────────────────────────┐
│              CI2 / IND TECH                              │
│         Luis Felipe Herrera                              │
│       Gerente de Proyecto CI2                            │
│    Recibe reportes de avance semanales                   │
│    Aprueba hitos y decisiones estratégicas               │
│    Reporta al MME quincenalmente                         │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │ Reporta avances semanales
                       │ Coordina ejecución técnica
                       ▼
┌─────────────────────────────────────────────────────────┐
│              INNOVADATACO                                │
│      Jelkin Zair Carrillo Franco                         │
│    Director de Empalme / PM Ejecutivo                    │
│    Contratado por IND TECH para ejecutar el empalme      │
│    Gestiona equipo técnico CI2                           │
│    Controla calidad PM2                                  │
│    Documenta todo el proceso                             │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │ Trabaja con
                       ▼
┌─────────────────────────────────────────────────────────┐
│              INTERNEXA S.A.                              │
│         Operador Saliente                                │
│    Entrega documentación, accesos, código                │
│    Soporte técnico durante el empalme                    │
│    Destruye datos post-cesión                            │
└─────────────────────────────────────────────────────────┘
```

---

## 2. ARQUITECTURA DEL SICOM — LO QUE CONOCEMOS

### 2.1 Componentes Técnicos Identificados (Basado en Análisis del Plan Original)

| Componente | Descripción | Estado de Conocimiento |
|------------|-------------|------------------------|
| **Aplicación Web** | Portal del SICOM para usuarios internos y externos | ⚠️ Parcial — Requiere acceso a código |
| **Base de Datos** | Almacenamiento de información de combustibles | ⚠️ Parcial — Requiere restore para validar |
| **Servicios Web / APIs** | Integraciones con entidades externas (VIGIA, etc.) | ⚠️ Parcial — Requiere documentación de INTERNEXA |
| **Infraestructura** | VMs, redes, almacenamiento, certificados | ⚠️ Parcial — Requiere inventario detallado |
| **Seguridad** | RBAC, MFA, SIEM, hardening | ⚠️ Parcial — Requiere auditoría |
| **Monitoreo** | Herramientas de monitoreo operativo | ⚠️ Parcial — Requiere acceso |
| **Backup / Recuperación** | Estrategia de backup y restore | ⚠️ Parcial — Requiere validación |
| **Integraciones Externas** | VIGIA, entidades de control, etc. | ⚠️ Parcial — Requiere documentación |

### 2.2 Diagrama de Arquitectura Conceptual (Preliminar)

```
┌──────────────────────────────────────────────────────────────┐
│                     USUARIOS DEL SICOM                        │
│  (Funcionarios MME, Operadores, Entidades de Control)        │
└──────────────────────────┬───────────────────────────────────┘
                           │ Acceso Web / APIs
                           ▼
┌──────────────────────────────────────────────────────────────┐
│                  APLICACIÓN WEB SICOM                         │
│              (Front-end, Lógica de Negocio)                  │
└──────────────────────────┬───────────────────────────────────┘
                           │ Consultas / Actualizaciones
                           ▼
┌──────────────────────────────────────────────────────────────┐
│              BASE DE DATOS SICOM                                │
│     (Modelos de combustibles, inventarios, precios)           │
└──────────────────────────┬───────────────────────────────────┘
                           │ Replicación / Backup
                           ▼
┌──────────────────────────────────────────────────────────────┐
│              INFRAESTRUCTURA TÉCNICA                          │
│     (VMs, Red, Storage, Certificados, Seguridad)              │
└──────────────────────────┬───────────────────────────────────┘
                           │ APIs / Servicios Web
                           ▼
┌──────────────────────────────────────────────────────────────┐
│              INTEGRACIONES EXTERNAS                           │
│  (VIGIA, Contraloría, Entidades Reguladoras, etc.)            │
└──────────────────────────────────────────────────────────────┘
```

---

## 3. ARQUITECTURA DEL SICOM — LO QUE NO CONOCEMOS (GAPs)

### 3.1 GAPs Críticos de Información

| # | GAP | Impacto si no se Resuelve | Acción para Cerrar | Responsable | Prioridad |
|---|-----|---------------------------|--------------------|-------------|-----------|
| 1 | **Stack tecnológico exacto** (lenguajes, frameworks, versiones) | No se puede clonar código ni replicar ambiente | Solicitar a INTERNEXA / Documentación | Jelkin Carrillo | 🔴 CRÍTICO |
| 2 | **Inventario detallado de infraestructura** (IPs, puertos, VLANs) | No se puede replicar red ni acceder a servicios | Solicitar a INTERNEXA / Escaneo de red | Especialista Infra CI2 | 🔴 CRÍTICO |
| 3 | **Modelo de datos completo** (tablas, relaciones, volúmenes) | Restore puede fallar o ser incompleto | Solicitar diccionario de datos a INTERNEXA | Especialista BD CI2 | 🔴 CRÍTICO |
| 4 | **Credenciales y certificados** (usuarios, contraseñas, SSL) | No se puede acceder al sistema | Solicitar a INTERNEXA / Resetear credenciales | Especialista Seg CI2 | 🔴 CRÍTICO |
| 5 | **Documentación de APIs / integraciones** (endpoints, contratos) | Las integraciones pueden fallar post-corte | Solicitar a INTERNEXA / Pruebas de conectividad | Especialista Apps CI2 | 🔴 CRÍTICO |
| 6 | **Procedimientos operativos actuales** (runbooks, turnos, escalamiento) | El equipo CI2 no sabrá operar el sistema | Shadowing con INTERNEXA / Construcción de runbooks | Especialista Op CI2 | 🟡 ALTO |
| 7 | **Licencias de software** (qué se usa, vigencia, transferibilidad) | Puede haber costos imprevistos o caída de servicio | Auditar licencias con INTERNEXA | Especialista Seg CI2 | 🟡 ALTO |
| 8 | **Acuerdos de nivel de servicio (SLA)** con entidades externas | Desconocimiento de compromisos operativos | Solicitar contratos a MME | Luis Herrera | 🟡 ALTO |
| 9 | **Historial de incidentes y problemas conocidos** | Riesgo de repetir fallas | Solicitar a INTERNEXA | Jelkin Carrillo | 🟢 MEDIO |
| 10 | **Personal clave de INTERNEXA** (quién sabe qué) | Pérdida de conocimiento tácito | Identificar y entrevistar | Jelkin Carrillo | 🟢 MEDIO |

### 3.2 Mapa de GAPs por Dominio Técnico

```
┌────────────────────────────────────────────────────────────────┐
│                    MAPA DE GAPS CRÍTICOS                        │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  D1. INFRAESTRUCTURA     ████████████████████  90% GAP         │
│  ├─ VMs, storage, red    [No tenemos inventario detallado]     │
│  ├─ Certificados SSL     [No sabemos vigencia ni proveedor]   │
│  └─ Arquitectura         [Diagramas desactualizados]            │
│                                                                 │
│  D2. CÓDIGO              ████████████████████  85% GAP         │
│  ├─ Repositorios         [No tenemos acceso a Git]              │
│  ├─ Pipelines            [Desconocemos CI/CD]                   │
│  └─ Artefactos           [No sabemos versiones]               │
│                                                                 │
│  D3. BASE DE DATOS       ████████████████████  80% GAP         │
│  ├─ Modelo de datos      [No tenemos diccionario]             │
│  ├─ Volumen              [Desconocemos tamaño real]             │
│  └─ Jobs                 [No sabemos qué corre y cuándo]      │
│                                                                 │
│  D4. SEGURIDAD           ████████████████████  75% GAP         │
│  ├─ RBAC                 [No sabemos roles actuales]          │
│  ├─ MFA                  [Desconocemos configuración]           │
│  └─ SIEM                 [No sabemos qué se monitorea]          │
│                                                                 │
│  D5. INTEGRACIONES       ████████████████████  85% GAP         │
│  ├─ APIs externas        [No tenemos documentación]             │
│  ├─ VIGIA                [Desconocemos protocolo]               │
│  └─ Notificaciones       [No sabemos destinatarios]           │
│                                                                 │
│  D6. OPERACIÓN           ████████████████████  90% GAP         │
│  ├─ Runbooks             [No existen documentados]              │
│  ├─ Turnos               [Desconocemos modelo actual]           │
│  └─ Mesa de ayuda        [No sabemos flujo de tickets]            │
│                                                                 │
│  D7. CONTINUIDAD         ████████████████████  85% GAP         │
│  ├─ RPO/RTO              [No sabemos objetivos actuales]      │
│  ├─ Sitio alterno        [Desconocemos estrategia DR]           │
│  └─ Backups              [No hemos validado restore]          │
│                                                                 │
│  D8. DOCUMENTACIÓN       ████████████████████  80% GAP         │
│  ├─ Técnica              [Incompleta o desactualizada]          │
│  ├─ Operativa            [No existe o es oral]                  │
│  └─ Usuario              [Desconocemos existencia]              │
│                                                                 │
│  D9. GOBIERNO            ████████████████████  70% GAP         │
│  ├─ Actas                [No tenemos historial]               │
│  ├─ Decisiones           [Desconocemos lógica]                  │
│  └─ Comité               [No sabemos si existió]              │
│                                                                 │
│  D10. CONOCIMIENTO       ████████████████████  95% GAP         │
│  ├─ Shadowing            [Aún no iniciado]                      │
│  ├─ Runbooks CI2         [No construidos]                     │
│  └─ Validación funcional [No ejecutada]                         │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## 4. QUÉ NECESITAMOS — LISTA DE REQUERIMIENTOS

### 4.1 Requerimientos de INTERNEXA (Operador Saliente)

| # | Requerimiento | Urgencia | Forma de Solicitar | Responsable Solicitud |
|---|---------------|----------|--------------------|----------------------|
| 1 | Inventario completo de infraestructura (IPs, VMs, storage, red) | 🔴 48 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 2 | Acceso a repositorios de código fuente | 🔴 48 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 3 | Diccionario de datos y modelo relacional de BD | 🔴 48 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 4 | Credenciales de servicio (usuarios, contraseñas, certificados) | 🔴 48 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 5 | Documentación de APIs y servicios web | 🔴 48 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 6 | Backups más recientes de BD y configuraciones | 🔴 72 horas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 7 | Documentación técnica actualizada | 🟡 1 semana | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 8 | Runbooks y procedimientos operativos | 🟡 1 semana | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 9 | Licencias de software y vigencias | 🟡 1 semana | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |
| 10 | Historial de incidentes últimos 12 meses | 🟢 2 semanas | Formal por escrito a Elizabeth (MME) | Jelkin Carrillo |

### 4.2 Requerimientos del MME (Entidad Pública)

| # | Requerimiento | Urgencia | Forma de Solicitar | Responsable Solicitud |
|---|---------------|----------|--------------------|----------------------|
| 1 | Confirmación de fechas de empalme | 🔴 Inmediato | Reunión con Elizabeth | Luis Herrera |
| 2 | Aprobación de plan de empalme ajustado | 🔴 Inmediato | Informe formal | Luis Herrera |
| 3 | Designación de Ordenador del Gasto | 🔴 48 horas | Solicitud formal | Luis Herrera |
| 4 | Acceso a contratos relacionados (VIGIA, etc.) | 🟡 1 semana | Solicitud formal | Luis Herrera |
| 5 | Contactos de entidades externas integradas | 🟡 1 semana | Solicitud formal | Luis Herrera |

### 4.3 Requerimientos Internos CI2

| # | Requerimiento | Urgencia | Responsable | Estado |
|---|---------------|----------|-------------|--------|
| 1 | Designar especialistas técnicos (Seg, Infra, BD, Apps, Op) | 🔴 Inmediato | Luis Herrera | ⏳ Pendiente |
| 2 | Preparar infraestructura destino (HW/SW/cloud) | 🔴 1 semana | Especialista Infra CI2 | ⏳ Pendiente |
| 3 | Contratar enlaces de telecomunicaciones | 🔴 1 semana | Especialista Infra CI2 | ⏳ Pendiente |
| 4 | Configurar herramientas de trabajo (GitHub, Drive, Jira) | 🟡 3 días | Jelkin Carrillo | ✅ GitHub listo |
| 5 | Definir plan de comunicación con INTERNEXA | 🟡 3 días | Jelkin Carrillo | ✅ Plan generado |

---

## 5. RIESGOS CRÍTICOS ACTIVOS

### 5.1 Riesgos que Amenazan el Empalme

| ID | Riesgo | Probabilidad | Impacto | Estrategia Actual | Estado |
|----|--------|--------------|---------|-------------------|--------|
| R001 | INTERNEXA no coopera con la entrega | 🔴 Alta | 🔴 Crítico | Escalar a Elizabeth (MME) contractualmente | ⚠️ Vigente |
| R002 | La documentación de INTERNEXA es incompleta | 🔴 Alta | 🟡 Alto | Validar con pruebas técnicas, no confiar ciegamente | ⚠️ Vigente |
| R003 | Los backups no son restaurables | 🟡 Media | 🔴 Crítico | Validar restore en Semana 3, tener plan B | ⚠️ Vigente |
| R004 | Las credenciales no se transfieren | 🟡 Media | 🟡 Alto | Resetear credenciales, no depender de transferencia | ⚠️ Vigente |
| R005 | La operación depende de 1-2 personas clave de INTERNEXA | 🔴 Alta | 🟡 Alto | Identificar y entrevistar ASAP, grabar sesiones | ⚠️ Vigente |
| R006 | La infraestructura destino de CI2 no está lista | 🟡 Media | 🟡 Alto | Plan B: cloud temporal, extender pruebas | ⚠️ Vigente |
| R007 | Las pruebas de estrés revelan fallas | 🟡 Media | 🟡 Alto | Corregir antes del corte, no comprometer calidad | ⚠️ Vigente |
| R008 | Hay brechas de seguridad no detectadas | 🟡 Media | 🔴 Crítico | Auditoría de seguridad en Semana 5 | ⚠️ Vigente |

---

## 6. DOCUMENTACIÓN PM2 GENERADA

### 6.1 Índice de Documentos del Empalme

| Fase | # | Documento | Estado | Ruta en Repo |
|------|---|-----------|--------|--------------|
| **INICIO** | 1 | Acta de Constitución | ✅ | `01-ACTA-CONSTITUCION-EMPALME.md` |
| | 2 | Cronograma Gantt | ✅ | `02-CRONOGRAMA-GANTT-EMPALME.md` |
| | 3 | Registro de Riesgos | ✅ | `03-REGISTRO-RIESGOS-EMPALME.md` |
| | 4 | Matriz de Stakeholders | ✅ | `04-MATRIZ-STAKEHOLDERS-EMPALME.md` |
| | 5 | Plan de Comunicaciones | ✅ | `05-PLAN-COMUNICACIONES-EMPALME.md` |
| **PLANIFICACIÓN** | 6 | Plan de Calidad | ✅ | `06-PLAN-CALIDAD-EMPALME.md` |
| | 7 | Plan de Recursos | ✅ | `08-PLAN-RECURSOS-EMPALME.md` |
| **EJECUCIÓN** | 8 | Acta de Recibo Parcial | ⏳ Plantilla | `13-ACTA-RECIBO-PARCIAL.md` |
| | 9 | Acta de Recibo Final | ⏳ Plantilla | `14-ACTA-RECIBO-FINAL.md` |
| | 10 | Acta de Cesión de Derechos | ⏳ Plantilla | `15-ACTA-CESION-DERECHOS.md` |
| **CIERRE** | 11 | Informe de Cierre | ⏳ Plantilla | `17-INFORME-CIERRE-EMPALME.md` |
| **ANÁLISIS** | 12 | Análisis PM2 | ✅ | `ANALISIS-PM2-EMPALME-SICOM.md` |

### 6.2 Documentos que se Generarán Durante la Ejecución

| Fase | Documento | Cuándo se Genera | Responsable |
|------|-----------|------------------|-------------|
| Ejecución | Actas de Reuniones Semanales | Semanalmente | Jelkin Carrillo |
| Ejecución | Informes de Avance Quincenales | Quincenalmente | Jelkin Carrillo |
| Ejecución | Registro de Cambios | Durante todo el empalme | Jelkin Carrillo |
| Ejecución | Acta de Destrucción de Datos | Post-cesión | INTERNEXA |
| Cierre | Lecciones Aprendidas | Post-empalme | Jelkin Carrillo |
| Cierre | Transferencia de Conocimiento | Post-empalme | Especialista Op CI2 |
| Cierre | Cierre Administrativo | Post-empalme | Jelkin Carrillo |

---

## 7. PRÓXIMAS ACCIONES INMEDIATAS

### 7.1 Acciones de las Próximas 48 Horas

| # | Acción | Responsable | Prioridad | Resultado Esperado |
|---|--------|-------------|-----------|-------------------|
| 1 | Reunión con Luis Herrera para validar estructura de reporte | Jelkin Carrillo | 🔴 Crítico | Confirmar frecuencia y formato de reportes |
| 2 | Solicitud formal a Elizabeth (MME) para obtener acceso a INTERNEXA | Luis Herrera | 🔴 Crítico | Carta oficial del MME exigiendo cooperación |
| 3 | Designar especialistas técnicos CI2 | Luis Herrera | 🔴 Crítico | Equipo técnico asignado |
| 4 | Preparar infraestructura destino mínima | Especialista Infra CI2 | 🔴 Crítico | Ambiente listo para restore |
| 5 | Reunión inicial con INTERNEXA (si cooperan) | Jelkin Carrillo | 🟡 Alta | Primer contacto, establecer mesa técnica |

### 7.2 Acciones de la Primera Semana

| # | Acción | Responsable | Prioridad | Resultado Esperado |
|---|--------|-------------|-----------|-------------------|
| 1 | Obtener inventario técnico de INTERNEXA | Jelkin Carrillo | 🔴 Crítico | Lista de VMs, IPs, storage, red |
| 2 | Obtener acceso a repositorios de código | Especialista Apps CI2 | 🔴 Crítico | Repositorios clonados |
| 3 | Obtener backups de BD | Especialista BD CI2 | 🔴 Crítico | Backups descargados |
| 4 | Obtener credenciales y certificados | Especialista Seg CI2 | 🔴 Crítico | Acceso al sistema confirmado |
| 5 | Validar arquitectura técnica | Especialista Infra CI2 | 🟡 Alta | Diagrama actualizado |

---

## 8. CONTACTOS CLAVE

| Rol | Nombre | Entidad | Teléfono | Email | Función |
|-----|--------|---------|----------|-------|---------|
| Gerente de Proyecto CI2 | Luis Felipe Herrera | CI2 / IND TECH | [Por obtener] | [Por obtener] | Recibe reportes, aprueba hitos |
| Director de Empalme | Jelkin Zair Carrillo Franco | Innovadataco | [Por obtener] | [Por obtener] | Ejecuta empalme, reporta a Luis |
| Supervisora MME | Elizabeth | Ministerio de Minas y Energía | [Por obtener] | [Por obtener] | Supervisa contractualmente |
| Representante IND TECH | Nicolás Ramírez Aguilar | IND TECH S.A.S. | 316 8333460 | administrativa@indtechcol.com | Representante legal |
| Representante Innovadataco | Diana Marcela Cáceres Valderrama | Innovadataco | [Por obtener] | [Por obtener] | Representante legal |
| Responsable Técnico INTERNEXA | [Por designar] | INTERNEXA S.A. | [Por obtener] | [Por obtener] | Entrega técnica |

---

## 9. GLOSARIO

| Término | Definición |
|---------|------------|
| **SICOM** | Sistema de Información de Combustibles Minerales |
| **MME** | Ministerio de Minas y Energía de Colombia |
| **CI2** | Nuevo operador del SICOM |
| **IND TECH** | Filial/empresa relacionada con CI2 que contrata a Innovadataco |
| **INTERNEXA** | Operador actual (saliente) del SICOM |
| **Empalme** | Proceso de transferencia de operación de un sistema entre operadores |
| **PM2** | Project Management Methodology (Metodología de Gestión de Proyectos) |
| **D1-D10** | Dominios técnicos del empalme (Infraestructura, Código, BD, Seguridad, etc.) |
| **Shadowing** | Proceso de acompañamiento operativo donde el equipo entrante observa al saliente |
| **RPO** | Recovery Point Objective (Tiempo máximo de pérdida de datos aceptable) |
| **RTO** | Recovery Time Objective (Tiempo máximo de recuperación del servicio) |
| **RBAC** | Role-Based Access Control (Control de acceso basado en roles) |
| **MFA** | Multi-Factor Authentication (Autenticación de múltiples factores) |
| **SIEM** | Security Information and Event Management |

---

## 10. HISTORIAL DE VERSIONES

| Versión | Fecha | Autor | Cambios |
|---------|-------|-------|---------|
| 1.0 | 20/05/2026 | ZEUS (Innovadataco) | Documento Maestro inicial con arquitectura, GAPs, requerimientos y acciones |

---

**Luis Felipe Herrera**  
*Gerente de Proyecto CI2 — IND TECH / CI2*

**Jelkin Zair Carrillo Franco**  
*Director de Empalme / PM Ejecutivo — Innovadataco*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*