# INSERT 05 — FACTIBILIDAD, RIESGOS Y CONDICIONES DE IMPLEMENTACIÓN
## Anexo Técnico III, Sección 8 (Nuevo)

---

### 8. FACTIBILIDAD OPERATIVA, RIESGOS Y CONDICIONES DE IMPLEMENTACIÓN

Este apartado responde a la observación del jurado sobre la necesidad de incluir estimaciones de factibilidad, riesgos y condiciones de implementación. Las cifras presentadas son **aproximaciones basadas en referentes de implementaciones Decidim en Latinoamérica y Europa** (Chile, México, España, Francia) y no constituyen una oferta técnica ni presupuesto oficial. Requieren cotización técnica específica para Bogotá.

---

#### 8.1 FACTIBILIDAD TÉCNICA

| Requerimiento | Especificación Mínima | Especificación Recomendada | Estado Actual Estimado en Bogotá | Brecha |
|---|---|---|---|---|
| **Servidores** | 1 VPS (4 vCPU, 8 GB RAM, 100 GB SSD) | 2 VPS con balanceo de carga + CDN | Infraestructura compartida de entidades distritales (IDPAC/IDBAC) | 🔴 Alta |
| **Conectividad** | 50 Mbps simétrico | 100 Mbps + redundancia | Dependiente de infraestructura distrital existente (suficiente) | 🟢 Cumplida |
| **Dominio + SSL** | dominio.gob.co + certificado Let's Encrypt | dominio.gob.co + WAF + protección DDoS | No existe dominio dedicado para participación ciudadana | 🔴 Alta |
| **Backup** | Backup diario automatizado | Backup en múltiples zonas de disponibilidad | Política de backup general distrital, no específica para participación | 🟡 Media |
| **Soporte técnico** | 1 administrador de sistemas (0.5 FTE) | 1 administrador + 1 desarrollador (1.5 FTE) | El IDPAC no tiene área de desarrollo de software propio documentada | 🔴 Alta |

**Conclusión técnica**: La implementación de Decidim en Bogotá es técnicamente viable pero requiere inversión en infraestructura dedicada y contratación o capacitación de personal técnico especializado. La dependencia de infraestructura compartida introduce riesgo de indisponibilidad en periodos de alta carga (consultas populares).

---

#### 8.2 FACTIBILIDAD INSTITUCIONAL

| Factor | Condición Actual Estimada | Necesario para Éxito | Riesgo |
|---|---|---|---|
| **Marco normativo** | Decreto 477/2023 vigente pero sin reglamentación operativa detallada | Decreto reglamentario + manual operativo del IDPAC | 🔴 Alto: sin reglamentación, la plataforma carece de respaldo legal para decisiones vinculantes |
| **Voluntad política** | Administración 2024-2027 ha incluido participación digital en Plan Distrital de Desarrollo | Compromiso explícito de Secretarios de despacho | 🟡 Medio: depende de continuidad de prioridades entre administraciones |
| **Capacidad administrativa** | IDPAC con personal administrativo; requiere perfil digital para gestión de plataforma | Capacitación de funcionarios en gestión de plataforma de participación | 🔴 Alto: brecha de competencias digitales para administración de software |
| **Interoperabilidad** | Sistemas legados distritales (Sisbén, SAP, SGP) sin APIs públicas documentadas para participación | Convenios interadministrativos IDPAC-IDBAC-IDU | 🔴 Alto: depende de voluntad de otras entidades |
| **Presupuesto recurrente** | No existe partida específica documentada para plataforma de participación digital | Partida anual en Plan Anual de Adquisiciones (PAA) del IDPAC | 🔴 Alto: requiere negociación con Secretaría de Hacienda |

---

#### 8.3 RIESGOS Y ESTRATEGIAS DE MITIGACIÓN

| Riesgo | Probabilidad Estimada | Impacto | Estrategia de Mitigación | Responsable Sugerido |
|---|---|---|---|---|
| **R1. Resistencia institucional** | Alta | Alto | Pilotear en 2-3 localidades voluntarias con alcaldes locales comprometidos antes de escalado distrital | IDPAC + Alcaldías locales |
| **R2. Brecha digital de segundo grado** | Alta | Alto | Incluir módulo de participación offline (puntos de atención presencial con digitalización posterior) + alianza con bibliotecas públicas | IDPAC + BibloRed |
| **R3. Rotación de funcionarios** | Media | Alto | Manualizar todos los procesos + capacitación institucionalizada + contratos de prestación de servicio con mesa de ayuda externa | IDPAC + Secretaría de Hacienda |
| **R4. Discontinuidad gubernamental** | Media | Alto | Licencia AGPL (irrevocable) + migración a repositorio distrital en GitHub + cláusula de continuidad en contrato de desarrollo | IDPAC + Contraloría |
| **R5. Baja adopción ciudadana** | Media | Medio | Campaña de comunicación + líderes multiplicadores por localidad + incentivos no monetarios (reconocimiento, certificados) | IDPAC + Secretaría de Cultura |
| **R6. Ciberseguridad / ataques** | Baja | Alto | Pentesting anual + WAF + monitoreo + plan de respuesta a incidentes | IDBAC + proveedor de seguridad |
| **R7. Dependencia de proveedor único** | Media | Medio | Capacitar equipo interno en Ruby on Rails + mantener relación con comunidad Decidim + código fuente en repositorio distrital | IDPAC + IDBAC |

---

#### 8.4 ESTIMACIÓN DE COSTOS (COP, 2026)

**Nota importante**: Las siguientes cifras son **estimaciones aproximadas basadas en referentes regionales** de implementaciones Decidim. No constituyen cotización técnica ni presupuesto oficial. Requieren validación con proveedores locales.

| Fase | Concepto | Costo Estimado Aproximado (COP) | Duración Estimada |
|---|---|---|---|
| **FASE 1. Diagnóstico y diseño** | Auditoría técnica, diseño de arquitectura, mapeo de interoperabilidad | $40.000.000 — $70.000.000 | 3-4 meses |
| **FASE 2. Desarrollo y parametrización** | Instalación Decidim, personalización visual, módulos específicos, migración de datos históricos | $80.000.000 — $130.000.000 | 6-8 meses |
| **FASE 3. Piloto** | Implementación en 2-3 localidades, capacitación de funcionarios, mesa de ayuda | $30.000.000 — $60.000.000 | 4-6 meses |
| **FASE 4. Escalamiento** | Rollout distrital, campaña de comunicación, líderes multiplicadores | $60.000.000 — $100.000.000 | 6-8 meses |
| **INVERSIÓN TOTAL FASES 1-4** | | **$210.000.000 — $360.000.000** | **19-26 meses** |
| **MANTENIMIENTO ANUAL** | Hosting, soporte, actualizaciones de seguridad, capacitación continua | $25.000.000 — $55.000.000 | Anual |

**Comparación regional (referentes públicos)**:
- Chile (Participa Chile): ~USD $180.000 — $250.000 para alcance nacional
- México (Participa.gob.mx): ~USD $500.000+ alcance federal
- España (Decidim Barcelona): ~EUR €300.000 — €400.000 alcance municipal

**Observación**: La estimación para Bogotá es conservadora comparada con referentes internacionales, debido a: (a) aprovechamiento de licencia AGPL (sin costo de software), (b) potencial aprovechamiento de infraestructura IDBAC compartida, (c) escala distrital (entre municipal y nacional).

---

#### 8.5 CONDICIONES DE ÉXITO

Para que la estrategia propuesta tenga probabilidad de éxito mayor al 60%, deben cumplirse simultáneamente:

1. ✅ **Voluntad política explícita**: Decreto o directriz del Alcalde Mayor estableciendo Decidim como plataforma oficial de participación digital
2. ✅ **Asignación presupuestal**: Inclusión de partida anual en PAA del IDPAC
3. ✅ **Capacitación institucional**: Mínimo 40 funcionarios del IDPAC con certificación en gestión de plataforma (120 horas)
4. ✅ **Convenio interadministrativo**: Acuerdo IDPAC-IDBAC-IDU para interoperabilidad de datos
5. ✅ **Pilotaje exitoso**: 2-3 localidades con adopción significativa de instancias de participación en plataforma durante primer año
6. ✅ **Mesa de ayuda operativa**: Atención a ciudadanos en máximo 48 horas hábiles

---

*Este insert debe incorporarse en Anexo Técnico III, como nueva Sección 8, páginas 9-10.*
