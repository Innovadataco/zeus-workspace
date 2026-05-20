# RESUMEN EJECUTIVO — ANEXO TÉCNICO CONTRATO SICOM

## 📋 INFORMACIÓN GENERAL

| Campo | Valor |
|-------|-------|
| **Documento** | Anexo de Características Técnicas para la Operación del SICOM |
| **Entidad** | Ministerio de Minas y Energía (MME) |
| **Sistema** | SICOM — Sistema de Información de Combustibles Minerales |
| **Objeto** | Arrendamiento de solución tecnológica en nube privada para garantizar continuidad operativa del SICOM |
| **Plazo** | **5 meses** — 01 julio 2026 al 30 noviembre 2026 |
| **Lugar** | Bogotá D.C. (DC principal en zona metropolitana Bogotá, DC alterno en otra ciudad colombiana) |
| **Vigencia contrato** | 01 julio 2026 — 30 noviembre 2026 |

---

## 🎯 OBJETIVO ESTRATÉGICO DEL SICOM

El SICOM evoluciona de **repositorio de datos** a **Administrador de la información del Mercado de Combustibles Líquidos de Colombia**, centralizando:
- Comercialización inicial
- Transporte
- Almacenamiento
- Distribución final

**Alcance:** Gasolina, diésel, biocombustibles, gas combustible (GNCV, Auto GLP), energéticos alternativos.

---

## 🏗️ ARQUITECTURA TECNOLÓGICA

### Plataformas Principales
| Plataforma | Tecnología |
|------------|------------|
| SICOM Líquidos | JAVA |
| SICOM GNCV | JAVA |
| Nuevo SICOM | BPM (Business Process Management) |

### Plataformas de Apoyo
- Mesa de servicio (ITSM)
- Web SICOM
- E-learning
- APP móviles (Líquidos, GAS)
- Bodega de datos / DataMart
- Web Services
- Software Call Center
- Business Intelligence (BI)
- Portal Web (HOME SICOM)

### Infraestructura Requerida
| Requisito | Especificación |
|-----------|----------------|
| **DC Principal** | Certificación Tier III Uptime Institute o ICREA Nivel V |
| **DC Alterno** | ANSI/TIA 942, en otra ciudad colombiana |
| **Disponibilidad** | 99.90% (Tier III) |
| **Usuarios iniciales** | 25.000 nombrados |
| **Usuarios proyectados** | 45.000 |
| **Crecimiento mensual** | 4% capacidad de cómputo |
| **Transacciones** | 600/min web services, 300/min aplicación |
| **Sesiones activas** | 1.000/hora |
| **Tiempo respuesta** | < 5 segundos |

---

## 📊 ACUERDOS DE NIVELES DE SERVICIO (ANS)

### ANS de Disponibilidad (99.90%)
| # | Línea de Servicio | ANS | Multa |
|---|-------------------|-----|-------|
| 1 | Plataforma Tecnológica SICOM Líquidos | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 2 | Plataforma Tecnológica SICOM Gas | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 3 | Canales de Comunicación SICOM | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 4 | Servicio Web Líquidos | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 5 | Servicio Web Gas | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 6 | Servicio BI Cubos | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 7 | Servicio BI Dashboard | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 10 | App Móvil Líquidos | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 11 | App Móvil GAS | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 12 | Portal Autogestión | >99.90% | 0.5% facturación por cada 0.1% debajo |
| 13 | Soporte Operación | 7×24×365 | 0.5% facturación por cada 0.1% debajo |
| 14 | Administración Plataforma | 7×24×365 | 0.5% facturación por cada 0.1% debajo |

**Multa máxima acumulable:** 5% mensual

### ANS de Continuidad
| # | Ítem | ANS | Multa |
|---|------|-----|-------|
| 15 | Contingencia SICOM Líquidos-GNCV | RPO <30 min, RTO ≤2h (críticos), ≤4h (mayores) | 0.5% por cada 10 min adicional |
| 16 | Recuperación Contingencia | RPO ≤30 min, RTO ≤4h | 5% por cada hora adicional |

### ANS de Call Center
| # | Ítem | ANS | Multa |
|---|------|-----|-------|
| 17 | Abandono llamadas | <20% | 0.5% por cada 0.1% debajo |
| 18 | Satisfacción capacitación | >80% (Bueno) | 0.5% por cada 0.1% debajo |
| 19 | Satisfacción atención | >80% (Bueno) | 0.5% por cada 0.1% debajo |

### ANS de Gestión
| # | Ítem | ANS | Multa |
|---|------|-----|-------|
| 19 | Incidentes técnicos SICOM Líquidos | >95% resueltos en mes | 0.5% por cada 0.1% debajo |
| 20 | Incidentes técnicos SICOM GAS | >95% resueltos en mes | 0.5% por cada 0.1% debajo |
| 21 | Atención incidentes | Críticos ≤2h, Mayores ≤24h, Menores ≤72h | 0.5% por cada 0.1% debajo |
| 22 | Requerimientos funcionales Líquidos | >90% solucionados en mes | 0.5% por cada 0.1% debajo |
| 23 | Requerimientos funcionales GAS | >90% solucionados en mes | 0.5% por cada 0.1% debajo |
| 24 | Seguridad incidentes | MTTD ≤15 min, MTTR ≤4h | 0.5% por cada 0.1% debajo |

---

## 🔒 REQUISITOS DE SEGURIDAD

| # | Requisito |
|---|-----------|
| 1 | Certificación ISO 27001:2022 vigente |
| 2 | Informe SOC II vigente |
| 3 | WAF (Web Application Firewall) en alta disponibilidad |
| 4 | Segmentación de red (VLAN/VPC) |
| 5 | VPN para tráfico de datos |
| 6 | UTM NGFW con IPS y AntiMalware |
| 7 | AntiDDoS |
| 8 | SIEM (Security Information and Event Management) |
| 9 | Logs almacenados ≥6 meses |
| 10 | RBAC (Control de acceso basado en roles) |
| 11 | Certificados TLS Wildcard |
| 12 | Backups diarios + pruebas mensuales |
| 13 | DRP (Plan de recuperación ante desastres) |
| 14 | Seguridad física DC (biométrico, vigilancia) |

---

## 👥 EQUIPO MÍNIMO REQUERIDO (Fase III)

### Dirección del Proyecto
| Rol | Cantidad | Dedicación | Experiencia |
|-----|----------|------------|-------------|
| Director de Proyecto | 1 | 100% | 36 meses en dirección proyectos TI |
| Líder Técnico | 1 | 100% | 36 meses en BPM/Java + Scrum Master |
| Líder Funcional/Temático | 1 | 100% | 36 meses en proyectos informáticos |

### Administración, Operación y Mantenimiento
| Rol | Cantidad | Dedicación | Experiencia |
|-----|----------|------------|-------------|
| DBA Oracle | 2 | 100% | 24 meses + certificación OCA |
| Ingenieros QA | 2 | 100% | 36 meses en pruebas funcionales |
| Desarrolladores Java | 2 | 100% | 36 meses en Java |
| Desarrolladores BPM | 3 | 100% | 36 meses en BPM + 12 meses BPMS |
| Especialistas BI | 2 | 100% | 24 meses en BI/Analytics |
| Analistas de Información | 7 | 100% | 12 meses en análisis datos |
| Profesional Operación Estadística | 1 | 100% | 24 meses + certificación NTC PE 1000 |
| Profesional Calidad | 1 | 100% | 24 meses + certificación ISO 9001 |
| Formadores | 2 | 100% | 12 meses en capacitación |

### Centro de Contacto
| Rol | Cantidad | Dedicación | Experiencia |
|-----|----------|------------|-------------|
| Coordinador Call Center | 1 | 100% | 24 meses en coordinación CC |
| Agentes Call Center | 6 | 100% | No requiere (deseable atención al usuario) |

**TOTAL EQUIPO MÍNIMO:** 31 personas

---

## 📦 ENTREGABLES OBLIGATORIOS

### Informe de Empalme de Operación
- Estado y condiciones de recepción del SICOM
- Actividades detalladas ejecutadas durante fase de empalme

### Informe Mensual de Gestión (5 días hábiles de cada mes)
1. Introducción
2. Cumplimiento ANS
3. Histórico ANS
4. Infraestructura (disponibilidad, arquitectura, BI, desempeño)
5. Administración y mantenimiento (historias usuario, mockups, RFC)
6. Seguridad (diagramas, novedades, ataques)
7. Centros de datos (disponibilidad, contingencia, replicación)
8. Backups (ejecución, restauraciones)
9. Comunicaciones (enlaces, ancho de banda)
10. Call Center (llamadas, abandonadas, duración)
11. Mesa de servicio (requerimientos, tiquetes, top 10)
12. Formación (fechas, usuarios capacitados)
13. Operación estadística (procesos, documentación)
14. Actividades de mejoramiento
15. Resumen actividades por miembro
16. Avance proyectos especiales
17. Novedades del personal

### Informe Mensual Ejecutivo
- Máximo 8 páginas
- Comparativos históricos por servicio
- Acciones de mejora

### Informe Final
- Cierre detallado: infraestructura, seguridad, desarrollo, operación, mesa de servicio
- Diagramas, configuraciones, cuadros históricos, estadísticas

---

## 🔄 TRANSFERENCIA OPERATIVA (Último mes del contrato)

### Migración
- Acceso a información de plataformas principales (JAVA, BPM) y apoyo
- Entrega de máquinas virtuales con configuraciones
- Código fuente en GitLab/GitHub
- Backups y logs de cargue
- Eliminación de información del contratista saliente

### Transferencia de Conocimientos
- Documentación técnica, temática, de actividades
- Manuales actualizados (Java, BPM, implementación, usuario)
- Documentación de procesamiento SO y BD
- Capacitación al equipo entrante
- Transferencia de lineamientos operativos y metodologías estadísticas

### Requisitos Legales
- **Acta de entrega y recibo** de información de administración y operación
- **Acuerdos de confidencialidad** paralelos y simultáneos entre operador saliente y entrante
- Licenciamiento: propiedad exclusiva del MME

---

## ⚠️ REGLAS CRÍTICAS

### Gestión de Cambios
| Tipo de cambio | Anticipación |
|----------------|--------------|
| Menores (parches) | 5 días hábiles |
| Mayores (actualizaciones) | 10-15 días hábiles |
| Críticos (migraciones) | 1 mes |
| Emergencia | Inmediata (notificación + justificación + aprobación post) |

### Consecuencias por Incumplimiento ANS
- **2 meses consecutivos** de incumplimiento o **>20%** incumplimiento acumulado → Reunión de gerencia
- Posibles resultados: Planes de choque, revisión contractual, finalización del contrato

### Reemplazo de Personal
- 3 días para plan temporal
- 10 días calendario para reemplazo definitivo
- Vacaciones cubiertas con perfil similar

---

## 💰 MULTAS Y PENALIDADES

| Incumplimiento | Penalidad |
|----------------|-----------|
| Cada 0.1% debajo de 99.90% disponibilidad | 0.5% descuento facturación mensual |
| Máximo acumulable mensual | 5% |
| RPO/RTO incumplido | 0.5%-5% según caso |
| Abandono llamadas >20% | 0.5% por cada 0.1% |
| Satisfacción <80% | 0.5% por cada 0.1% |
| Incidentes no resueltos | 0.5% por cada 0.1% |

---

## 📅 CRONOGRAMA DE TRANSFERENCIA

| Fase | Periodo | Duración |
|------|---------|----------|
| Empalme/Transición | 19 mayo — 30 junio 2026 | 6 semanas |
| Operación CI2 | 01 julio — 30 noviembre 2026 | 5 meses |
| Transferencia al nuevo operador | Noviembre 2026 | 1 mes |

---

## 🔑 PUNTOS CLAVE PARA NEGOCIACIÓN CON INTERNEXA

1. **Acceso a plataformas:** JAVA, BPM, ITSM, Web, E-learning, APPs, DataMart
2. **Máquinas virtuales:** Catálogo de servidores y servicios con configuraciones
3. **Código fuente:** Repositorio GitLab/GitHub con flujos BPM
4. **Documentación:** Técnica, temática, manuales, procedimientos
5. **Capacitación:** Plan formal al equipo CI2 con cronograma
6. **Acuerdo de confidencialidad:** Paralelo entre INTERNEXA e CI2
7. **Acta de entrega:** Firmada por MME, INTERNEXA, CI2
8. **Licencias:** Verificar propiedad exclusiva MME

---

**Documento analizado por:** ZEUS — Innovadataco
**Fecha análisis:** 20 de mayo de 2026
**Fuente:** Anexo Técnico Contrato SICOM — MME
