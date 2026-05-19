# ACTA DE CONSTITUCIÓN DEL EMPALME
## SICOM — Sistema de Información de Combustibles Minerales

---

**Código del Empalme:** EMP-SICOM-2026-01  
**Nombre del Proyecto:** Empalme Operativo SICOM  
**Fecha de Constitución:** 20 de Mayo de 2026  
**Versión:** 1.0  
**Estado:** Activo

---

## 1. INFORMACIÓN GENERAL

### 1.1 Justificación del Empalme
El empalme se requiere para garantizar la continuidad operativa del Sistema de Información de Combustibles Minerales (SICOM) ante la transición del operador actual (INTERNEXA S.A.) al nuevo operador (CI2), en cumplimiento del Contrato Interadministrativo GGC-2034-2025 suscrito entre el Ministerio de Minas y Energía (MME) e INTERNEXA S.A.

### 1.2 Objetivo del Empalme
**Objetivo General:**  
Recibir el sistema SICOM sin interrupción del servicio, con dominio técnico mínimo viable y con evidencia formal de todo lo entregado por el operador saliente.

**Objetivos Específicos:**
1. Transferir conocimiento técnico y operativo de INTERNEXA a CI2
2. Validar infraestructura, código, bases de datos y documentación
3. Establecer operación en sombra con shadowing obligatorio
4. Ejecutar pruebas de estrés, rendimiento, seguridad e integración
5. Validar continuidad del negocio (RPO/RTO, sitio alterno, simulacros)
6. Realizar corte controlado con checklist Go/No-Go
7. Firmar actas de recibo final por dominios técnicos

---

## 2. ESTRUCTURA DE GOBERNANZA

### 2.1 Comité Directivo del Empalme

| Rol | Nombre | Entidad | Responsabilidad |
|-----|--------|---------|-----------------|
| **Gerente de Proyecto CI2** | Ludi Felipe Herrera | CI2 / IND TECH | Dirección estratégica, aprobación de hitos, reporte al MME, decisiones ejecutivas |
| **Director de Empalme / PM Ejecutivo** | Jelkin Zair Carrillo Franco | Innovadataco (contratado por IND TECH) | Ejecución técnica del empalme, coordinación operativa, reporte a Ludi Herrera, validación de entregas, control de calidad |
| **Supervisora MME** | Elizabeth | Ministerio de Minas y Energía | Supervisión contractual, aceptación formal, pagos, resolución conflictos |
| **Representante Saliente** | [Por designar] | INTERNEXA S.A. | Entrega de activos, transferencia conocimiento, soporte durante empalme |
| **Especialista Seguridad** | [Por designar] | CI2 | Hardening, RBAC, MFA, SIEM, vulnerabilidades |
| **Especialista BD/Infra** | [Por designar] | CI2 | Restore, replicación, validación técnica |

### 2.2 Equipo de Empalme CI2 (Entrante)

| Rol | Nombre | Asignación | Función |
|-----|--------|------------|---------|
| **Gerente de Proyecto CI2** | Ludi Felipe Herrera | CI2 / IND TECH | 100% | Dirección estratégica, aprobación de hitos, reporte al MME, decisiones ejecutivas |
| **Director de Empalme / PM Ejecutivo** | Jelkin Zair Carrillo Franco | Innovadataco (contratado por IND TECH) | 100% | Ejecución técnica del empalme, coordinación operativa, reporte a Ludi Herrera, validación de entregas, control de calidad PM2 |
| Especialista Seguridad | [Por asignar] | 100% | Seguridad, credenciales, hardening |
| Especialista Infraestructura | [Por asignar] | 100% | VMs, redes, almacenamiento, backups |
| Especialista Base de Datos | [Por asignar] | 100% | Restore, integridad, replicación |
| Especialista Aplicaciones | [Por asignar] | 100% | Código, despliegues, APIs, front-end |
| Especialista Operación | [Por asignar] | 100% | Runbooks, turnos 24/7, mesa de ayuda |

### 2.3 Equipo de Soporte INTERNEXA (Saliente)

| Rol | Nombre | Asignación | Función |
|-----|--------|------------|---------|
| Responsable Técnico | [Por designar] | 50% | Entrega documentación, accesos, soporte técnico |
| Responsable Operativo | [Por designar] | 50% | Transferencia funcional, shadowing, runbooks |
| Responsable Seguridad | [Por designar] | 25% | Entrega credenciales, certificados, RBAC |

---

## 3. ALCANCE DEL EMPALME

### 3.1 Dentro del Alcance (10 Dominios Técnicos)

| Dominio | Descripción | Criterio de Aceptación |
|---------|-------------|------------------------|
| D1. Infraestructura | VMs, almacenamiento, red, certificados | Inventario validado, arquitectura aterrizada |
| D2. Código y Despliegue | Repositorios, pipelines, artefactos, rollback | Repositorios clonados, pipelines validados |
| D3. Base de Datos | Modelos, diccionarios, jobs, backups, restore | Restore exitoso, integridad validada |
| D4. Seguridad | RBAC, MFA, SIEM, hardening, vulnerabilidades | Escaneo limpio, credenciales transferidas |
| D5. Integraciones | APIs, servicios web, colas, notificaciones | Pruebas de conectividad exitosas |
| D6. Operación | Runbooks, turnos 24/7, mesa de ayuda, escalamiento | Operación en sombra validada |
| D7. Continuidad | RPO/RTO, sitio alterno, simulacros, DRP | Simulacro ejecutado con éxito |
| D8. Documentación | Técnica, operativa, de usuario, de arquitectura | Carpeta maestra consolidada |
| D9. Gobierno y Calidad | Actas, RAID, comité, criterios de aceptación | Documentación completa firmada |
| D10. Conocimiento | Transferencia funcional, sesiones grabadas, validación | Sesiones grabadas, runbooks construidos |

### 3.2 Fuera del Alcance

- Desarrollo de nuevas funcionalidades para SICOM
- Modificación de la arquitectura base sin aprobación del MME
- Migración de datos históricos anteriores al período de operación de INTERNEXA
- Capacitación de usuarios finales del MME (se entrega material, no sesiones)
- Mantenimiento post-empalme (cubre solo transferencia, no operación continua)

---

## 4. CRONOGRAMA DEL EMPALME

### 4.1 Periodo General

| Fase | Fechas | Duración |
|------|--------|----------|
| Preparación e Inicio | 19 mayo - 25 mayo 2026 | 1 semana |
| Inventario y Validación Técnica | 26 mayo - 14 junio 2026 | 3 semanas |
| Operación en Sombra y Transferencia | 15 junio - 21 junio 2026 | 1 semana |
| Corte y Recibo Final | 22 junio - 30 junio 2026 | 1 semana |
| Estabilización Post-Corte | 1 julio - 15 julio 2026 | 15 días |

**Total del Empalme:** 6 semanas efectivas (19 mayo - 30 junio 2026)  
**Inicio Operación CI2:** 1 julio 2026

### 4.2 Hitos (Milestones)

| Hito | Fecha Plan | Responsable | Estado |
|------|------------|-------------|--------|
| M1: Instalación Gobierno | 20 mayo 2026 | Jelkin Carrillo | 🟡 En curso |
| M2: Accesos Solo Lectura | 25 mayo 2026 | INTERNEXA | ⏳ Futuro |
| M3: Inventario Técnico Completo | 31 mayo 2026 | INTERNEXA | ⏳ Futuro |
| M4: Restore Validado | 14 junio 2026 | CI2 + INTERNEXA | ⏳ Futuro |
| M5: Operación en Sombra Iniciada | 15 junio 2026 | CI2 | ⏳ Futuro |
| M6: Pruebas de Estrés y Seguridad | 21 junio 2026 | CI2 | ⏳ Futuro |
| M7: Corte Controlado | 30 junio 2026 | CI2 + MME | ⏳ Futuro |
| M8: Acta de Recibo Final Firmada | 30 junio 2026 | MME + CI2 + INTERNEXA | ⏳ Futuro |
| M9: Estabilización Completada | 15 julio 2026 | CI2 | ⏳ Futuro |

---

## 5. RESTRICCIONES Y SUPUESTOS

### 5.1 Restricciones

- **Plazo:** 6 semanas calendario (19 mayo - 30 junio 2026), inamovible
- **Presupuesto:** Limitado al valor del contrato GGC-2034-2025
- **Disponibilidad del sistema:** SICOM debe mantenerse operativo durante todo el empalme
- **Operador saliente:** INTERNEXA debe cooperar con entregas según plan
- **Acceso a sedes:** INTERNEXA debe permitir acceso del equipo CI2 a instalaciones si aplica

### 5.2 Supuestos

- INTERNEXA entregará documentación completa y actualizada
- Los backups de INTERNEXA son restaurables y validados
- Las credenciales y certificados son transferibles
- El equipo de INTERNEXA asignará personal clave para shadowing
- El MME (Elizabeth) estará disponible para decisiones en máximo 24 horas
- CI2 tiene infraestructura destino lista o en proceso de aprovisionamiento

---

## 6. CRITERIOS DE ÉXITO DEL EMPALME

1. **Cero interrupción del servicio SICOM** durante el empalme
2. **100% de dominios técnicos aceptados** con actas firmadas
3. **Restore de backups validado** con evidencia documentada
4. **Operación en sombra completada** con runbooks propios de CI2
5. **Simulacro de continuidad ejecutado** con RPO/RTO validados
6. **Corte controlado exitoso** con monitoreo intensivo post-corte
7. **Acta de recibo final firmada** por MME, CI2 e INTERNEXA
8. **Acta de cesión de derechos** suscrita
9. **Certificación de destrucción de datos** en infraestructura de INTERNEXA
10. **Informe de cierre del empalme** aprobado por el MME

---

## 7. RIESGOS INICIALES IDENTIFICADOS

| ID | Riesgo | Probabilidad | Impacto | Estrategia |
|----|--------|--------------|---------|------------|
| R001 | Resistencia de INTERNEXA a entregar información | Alta | Crítico | Mitigar + Escalar a MME |
| R002 | Documentación incompleta o desactualizada | Alta | Alto | Mitigar + Levantamiento independiente |
| R003 | Backups no restaurables | Media | Crítico | Mitigar + Plan B reconstrucción |
| R004 | Credenciales no transferibles | Media | Alto | Mitigar + Rotación controlada |
| R005 | Dependencia de personas clave de INTERNEXA | Alta | Alto | Mitigar + Sesiones grabadas |
| R006 | Retraso en aprovisionamiento infraestructura CI2 | Media | Alto | Mitigar + Kickoff inmediato |

*(Detalle completo en 03-REGISTRO-RIESGOS-EMPALME.md)*

---

## 8. APROBACIÓN DEL ACTA

Este Acta de Constitución establece la forma oficial del Empalme SICOM y autoriza el uso de recursos para su ejecución.

| Rol | Nombre | Entidad | Firma | Fecha |
|-----|--------|---------|-------|-------|
| Gerente de Proyecto CI2 | Ludi Felipe Herrera | CI2 / IND TECH | _________________ | 20/05/2026 |
| Director de Empalme / PM Ejecutivo | Jelkin Zair Carrillo Franco | Innovadataco | _________________ | 20/05/2026 |
| Supervisora MME | Elizabeth | Ministerio de Minas y Energía | _________________ | 20/05/2026 |
| Representante Saliente | [Por designar] | INTERNEXA S.A. | _________________ | 20/05/2026 |

---

## 9. HISTORIAL DE CAMBIOS

| Versión | Fecha | Autor | Descripción |
|---------|-------|-------|-------------|
| 1.0 | 20/05/2026 | ZEUS - Agente IA InnovaDataCo | Creación inicial del Acta de Constitución del Empalme SICOM |

---

**Ludi Felipe Herrera**  
*Gerente de Proyecto CI2 — IND TECH / CI2*

**Jelkin Zair Carrillo Franco**  
*Director de Empalme / PM Ejecutivo — Innovadataco*

**ZEUS - Agente IA InnovaDataCo**  
*Soporte PM2 y Gestión Documental*
