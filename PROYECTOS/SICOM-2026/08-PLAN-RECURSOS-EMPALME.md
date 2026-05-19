# PLAN DE RECURSOS DEL EMPALME SICOM
## Empalme Operativo SICOM — CI2 ↔ INTERNEXA ↔ MME

---

**Empalme:** EMP-SICOM-2026-01  
**Gerente de Proyecto CI2:** Luis Felipe Herrera (CI2 / IND TECH)  
**Director de Empalme / PM Ejecutivo:** Jelkin Zair Carrillo Franco (Innovadataco)  
**Versión:** 1.0  
**Fecha:** 20 de Mayo de 2026  
**Aprobador:** Luis Felipe Herrera (CI2)

---

## 1. RECURSOS HUMANOS

### 1.1 Equipo CI2 — Innovadataco (Contratado por IND TECH)

| Rol | Nombre | Asignación | Período | Función Principal | Costo Estimado |
|-----|--------|------------|---------|-------------------|----------------|
| **Director de Empalme / PM Ejecutivo** | Jelkin Zair Carrillo Franco | 100% | 15 May - 30 Jun 2026 | Gestión PM2, coordinación, reporte a Luis Herrera, control de calidad | $25.000.000 (contrato IND TECH) |
| **Especialista Seguridad** | [Por asignar] | 100% | 19 May - 30 Jun 2026 | Hardening, RBAC, MFA, SIEM, vulnerabilidades | Por definir |
| **Especialista Infraestructura** | [Por asignar] | 100% | 19 May - 30 Jun 2026 | VMs, redes, almacenamiento, backups, replicación | Por definir |
| **Especialista Base de Datos** | [Por asignar] | 100% | 19 May - 30 Jun 2026 | Restore, integridad, jobs, replicación | Por definir |
| **Especialista Aplicaciones** | [Por asignar] | 100% | 19 May - 30 Jun 2026 | Código, despliegues, APIs, front-end | Por definir |
| **Especialista Operación** | [Por asignar] | 100% | 15 Jun - 30 Jun 2026 | Runbooks, turnos 24/7, mesa de ayuda | Por definir |

**Total Equipo CI2:** 6 personas (incluyendo Jelkin)

### 1.2 Equipo INTERNEXA (Saliente)

| Rol | Nombre | Asignación | Período | Función Principal |
|-----|--------|------------|---------|-------------------|
| **Responsable Técnico** | [Por designar] | 50% | 19 May - 30 Jun 2026 | Entrega documentación, accesos, soporte técnico |
| **Responsable Operativo** | [Por designar] | 50% | 15 Jun - 30 Jun 2026 | Transferencia funcional, shadowing, runbooks |
| **Responsable Seguridad** | [Por designar] | 25% | 19 May - 30 Jun 2026 | Entrega credenciales, certificados, RBAC |

**Total Equipo INTERNEXA:** 3 personas

### 1.3 Recursos MME

| Rol | Nombre | Asignación | Período | Función Principal |
|-----|--------|------------|---------|-------------------|
| **Supervisora del Contrato** | Elizabeth | 25% | 19 May - 30 Jun 2026 | Supervisión contractual, aceptaciones, pagos |
| **Ordenador del Gasto** | [Por identificar] | 10% | Eventos clave | Aprobación de pagos, decisiones contractuales |

---

## 2. RECURSOS TÉCNICOS / INFRAESTRUCTURA

### 2.1 Infraestructura Destino CI2

| Recurso | Especificación | Estado | Fecha Requerida | Responsable |
|---------|---------------|--------|-----------------|-------------|
| **Servidores / VMs** | [Por definir según inventario INTERNEXA] | En preparación | Semana 3 (7 Jun) | Especialista Infra CI2 |
| **Almacenamiento** | [Por definir según volumen BD] | En preparación | Semana 3 (7 Jun) | Especialista Infra CI2 |
| **Red / Networking** | VLANs, firewalls, balanceadores | En preparación | Semana 3 (7 Jun) | Especialista Infra CI2 |
| **Enlaces Telecom** | MPLS, internet dedicado | Por contratar | Semana 2 (31 May) | Especialista Infra CI2 |
| **Sitio Alterno / DR** | Replicación geográfica | En evaluación | Semana 5 (21 Jun) | Especialista Infra CI2 |

### 2.2 Licencias y Software

| Recurso | Proveedor | Vigencia | Estado | Responsable |
|---------|-----------|----------|--------|-------------|
| **Sistema Operativo** | [Por identificar] | [Por verificar] | Por transferir | INTERNEXA |
| **Base de Datos** | [Por identificar] | [Por verificar] | Por transferir | INTERNEXA |
| **Middleware** | [Por identificar] | [Por verificar] | Por transferir | INTERNEXA |
| **Herramientas de Monitoreo** | [Por identificar] | [Por verificar] | Por transferir | INTERNEXA |
| **Certificados SSL** | [Por identificar] | [Por verificar] | Por transferir | INTERNEXA |

### 2.3 Herramientas de Trabajo del Empalme

| Herramienta | Propósito | Proveedor | Acceso |
|-------------|-----------|-----------|--------|
| **GitHub / GitLab** | Repositorio de código y documentación PM2 | Innovadataco | Equipo CI2 + Luis Herrera |
| **Google Drive** | Documentación compartida con MME e INTERNEXA | MME / CI2 | Todos los stakeholders |
| **Google Meet / Teams** | Reuniones virtuales | CI2 | Todos |
| **Telegram** | Comunicación rápida PM | Innovadataco | Jelkin + ZEUS + Luis Herrera |
| **Jira / GitHub Issues** | Gestión de tareas y hallazgos | Innovadataco | Equipo CI2 |
| **SIEM** | Monitoreo de seguridad | CI2 | Especialista Seguridad |

---

## 3. PRESUPUESTO DEL EMPALME

### 3.1 Costos de Personal (Estimados)

| Concepto | Valor | Notas |
|----------|-------|-------|
| **Contrato Innovadataco ↔ IND TECH** | $25.000.000 | Vigente 15 May - 14 Jun 2026 |
| **Prórroga / Adenda contractual** | [Por negociar] | Necesaria para cubrir hasta 30 Jun |
| **Personal adicional CI2** | [Por definir] | Especialistas técnicos |
| **Total Personal** | **$25.000.000 + adicionales** | |

### 3.2 Costos de Infraestructura (Estimados)

| Concepto | Valor | Notas |
|----------|-------|-------|
| **Hardware / Servidores** | [Por definir] | Si aplica compra/alquiler |
| **Enlaces Telecom** | [Por definir] | Contrato con proveedor |
| **Licencias de software** | [Por definir] | Transferidas o nuevas |
| **Cloud / Hosting temporal** | [Por definir] | Si aplica plan B |
| **Total Infraestructura** | **[Por definir]** | |

### 3.3 Costos Operativos del Empalme

| Concepto | Valor | Notas |
|----------|-------|-------|
| **Viajes / Traslados** | [Por definir] | Si equipo CI2 debe desplazarse |
| **Capacitaciones / Certificaciones** | [Por definir] | Si aplica |
| **Herramientas de prueba** | [Por definir] | Licencias de testing |
| **Contingencia (10%)** | [Por calcular] | Reserva para imprevistos |
| **Total Operativo** | **[Por definir]** | |

---

## 4. PLAN DE ADQUISICIONES

### 4.1 Adquisiciones Urgentes (Semana 1-2)

| Adquisición | Justificación | Fecha Límite | Responsable | Estado |
|-------------|---------------|--------------|-------------|--------|
| **Enlaces Telecom** | Conectividad entre sedes para replicación | 31 May 2026 | Especialista Infra CI2 | ⏳ Pendiente |
| **Infraestructura HW/SW destino** | Ambiente para restore y pruebas | 7 Jun 2026 | Especialista Infra CI2 | ⏳ Pendiente |
| **Licencias adicionales** | Si INTERNEXA no transfiere todas | 14 Jun 2026 | Especialista Seguridad CI2 | ⏳ Pendiente |

### 4.2 Adquisiciones Planificadas (Semana 3-4)

| Adquisición | Justificación | Fecha Límite | Responsable | Estado |
|-------------|---------------|--------------|-------------|--------|
| **Herramientas de monitoreo** | SIEM, APM, logging para CI2 | 21 Jun 2026 | Especialista Seguridad CI2 | ⏳ Pendiente |
| **Backup adicional** | Solución de backup propia de CI2 | 21 Jun 2026 | Especialista BD CI2 | ⏳ Pendiente |

---

## 5. MATRIZ DE RESPONSABILIDADES (RACI)

### 5.1 RACI por Actividad del Empalme

| Actividad | Jelkin (PM) | Esp. Seg | Esp. Infra | Esp. BD | Esp. Apps | Esp. Op | INTERNEXA | MME |
|-----------|:-----------:|:--------:|:----------:|:-------:|:---------:|:-------:|:---------:|:---:|
| **Instalación gobierno** | A/R | C | C | C | C | I | I | C |
| **Recibir inventario técnico** | A | C | R | C | C | I | R | I |
| **Validar arquitectura** | A | C | R | C | C | I | C | I |
| **Restore de backups** | A | C | C | R | C | I | C | I |
| **Validar integridad BD** | A | C | C | R | C | I | C | I |
| **Clonar repositorios** | A | C | C | C | R | I | C | I |
| **Pruebas de seguridad** | A | R | C | C | C | I | C | I |
| **Operación en sombra** | A | C | C | C | C | R | R | I |
| **Construir runbooks** | A | C | C | C | C | R | C | I |
| **Pruebas de estrés** | A | C | R | C | R | I | C | I |
| **Simulacro de contingencia** | A | C | R | C | C | I | C | I |
| **Corte controlado** | A/R | C | C | C | C | C | C | A |
| **Acta de recibo final** | R | C | C | C | C | I | C | A |

**Leyenda RACI:**
- **R** = Responsible (Ejecuta)
- **A** = Accountable (Aprobador, único)
- **C** = Consulted (Consultado)
- **I** = Informed (Informado)

---

## 6. PLAN DE FORMACIÓN / CAPACITACIÓN

### 6.1 Formación del Equipo CI2

| Capacitación | Destinatarios | Duración | Fecha | Responsable | Estado |
|--------------|---------------|----------|-------|-------------|--------|
| **Inducción al SICOM** | Todo el equipo CI2 | 4 horas | Semana 1 | INTERNEXA (si coopera) / Documentación | ⏳ Pendiente |
| **Arquitectura técnica del SICOM** | Esp. Infra, BD, Apps | 4 horas | Semana 2 | INTERNEXA / Documentación | ⏳ Pendiente |
| **Seguridad y RBAC del SICOM** | Esp. Seguridad | 4 horas | Semana 2 | INTERNEXA / Documentación | ⏳ Pendiente |
| **Operación y procedimientos** | Esp. Operación | 8 horas | Semana 5 | INTERNEXA (shadowing) | ⏳ Pendiente |
| **Mesa de ayuda y escalamiento** | Esp. Operación | 4 horas | Semana 5 | INTERNEXA (shadowing) | ⏳ Pendiente |

### 6.2 Formación por Shadowing (Operación en Sombra)

| Shadowing | Especialista CI2 | Especialista INTERNEXA | Duración | Período |
|-----------|------------------|------------------------|----------|---------|
| **Operación de infraestructura** | Esp. Infra CI2 | Esp. Infra INTERNEXA | 40 horas | Semana 5 |
| **Administración de BD** | Esp. BD CI2 | Esp. BD INTERNEXA | 40 horas | Semana 5 |
| **Despliegue y aplicaciones** | Esp. Apps CI2 | Esp. Apps INTERNEXA | 40 horas | Semana 5 |
| **Seguridad y monitoreo** | Esp. Seguridad CI2 | Esp. Seg INTERNEXA | 40 horas | Semana 5 |
| **Operación funcional (turnos)** | Esp. Operación CI2 | Esp. Operación INTERNEXA | 40 horas | Semana 5-6 |

---

## 7. GESTIÓN DE RECURSOS

### 7.1 Asignación de Recursos por Semana

| Semana | Recursos CI2 | Recursos INTERNEXA | Recursos MME | Enfoque |
|--------|--------------|--------------------|--------------|---------|
| **Semana 1** | Jelkin 100% + Esp. Seg/Infra/BD/Apps 50% | Responsable Técnico 25% | Elizabeth 10% | Gobierno, accesos, planificación |
| **Semana 2** | Todo el equipo 100% | Responsable Técnico 50% | Elizabeth 10% | Inventario, validación técnica |
| **Semana 3** | Todo el equipo 100% | Responsable Técnico 50% | Elizabeth 10% | Restore, pruebas técnicas |
| **Semana 4** | Todo el equipo 100% | Responsable Técnico 50% | Elizabeth 25% | Pruebas, acta parcial |
| **Semana 5** | Todo el equipo 100% + Esp. Operación 100% | Responsable Operativo 50% | Elizabeth 25% | Shadowing, transferencia |
| **Semana 6** | Todo el equipo 100% | Responsable Técnico 25% + Operativo 50% | Elizabeth 50% | Corte, recibo final |

### 7.2 Gestión de Conflictos de Recursos

| Conflicto | Mitigación | Responsable |
|-----------|------------|-------------|
| INTERNEXA no asigna personal clave | Escalar a Elizabeth (MME) contractualmente | Jelkin Carrillo |
| Especialista CI2 no disponible | Reasignar tareas o contratar temporal | Jelkin Carrillo |
| Infraestructura destino no lista | Plan B: nube temporal, extender pruebas | Jelkin + Luis Herrera |
| Licencias no transferibles | Renegociar con proveedor o comprar nuevas | Luis Herrera (CI2) |

---

## 8. APROBACIÓN DEL PLAN DE RECURSOS

| Rol | Nombre | Firma | Fecha |
|-----|--------|-------|-------|
| Gerente de Proyecto CI2 | Luis Felipe Herrera | _________________ | 20/05/2026 |
| Director de Empalme / PM Ejecutivo | Jelkin Zair Carrillo Franco | _________________ | 20/05/2026 |
| Supervisora MME | Elizabeth | _________________ | 20/05/2026 |

---

**Luis Felipe Herrera**  
*Gerente de Proyecto CI2 — IND TECH / CI2*

**Jelkin Zair Carrillo Franco**  
*Director de Empalme / PM Ejecutivo — Innovadataco*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*