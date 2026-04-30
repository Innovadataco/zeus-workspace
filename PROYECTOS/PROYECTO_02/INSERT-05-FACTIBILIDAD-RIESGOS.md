# INSERT 05 — FACTIBILIDAD, RIESGOS Y COSTOS
## Anexo Técnico III, Sección 8 (Nuevo)

---

### 8. FACTIBILIDAD OPERATIVA, RIESGOS Y CONDICIONES DE IMPLEMENTACIÓN

Este apartado responde a la observación del jurado sobre la necesidad de incluir estimaciones de factibilidad, riesgos y condiciones de implementación. Las cifras presentadas son aproximaciones basadas en cotizaciones de referencia de implementaciones Decidim en Latinoamérica (Chile, México, España) y no constituyen una oferta técnica ni presupuesto oficial.

---

#### 8.1 FACTIBILIDAD TÉCNICA

| Requerimiento | Especificación Mínima | Especificación Recomendada | Estado Actual en Bogotá | Brecha |
|---|---|---|---|---|
| **Servidores** | 1 VPS (4 vCPU, 8 GB RAM, 100 GB SSD) | 2 VPS con balanceo de carga + CDN | IDPAC opera en infraestructura compartida Secretaría de Hacienda | 🔴 Alta |
| **Conectividad** | 50 Mbps simétrico | 100 Mbps + redundancia | Dependiente de IDBAC (suficiente) | 🟢 Cumplida |
| **Dominio + SSL** | dominio.gob.co + certificado Let's Encrypt | dominio.gob.co + WAF + DDoS protection | No existe dominio dedicado para participación | 🔴 Alta |
| **Backup** | Backup diario automatizado | Backup en 3 zonas de disponibilidad | Política de backup general, no específica para participación | 🟡 Media |
| **Soporte técnico** | 1 administrador de sistemas (0.5 FTE) | 1 administrador + 1 desarrollador (1.5 FTE) | IDPAC no tiene área de desarrollo de software propio | 🔴 Alta |

**Conclusión técnica**: La implementación de Decidim en Bogotá es técnicamente viable pero requiere inversión en infraestructura dedicada y contratación de personal técnico especializado. La dependencia de infraestructura compartida de la Secretaría de Hacienda introduce riesgo de indisponibilidad en periodos de alta carga (consultas populares).

---

#### 8.2 FACTIBILIDAD INSTITUCIONAL

| Factor | Condición Actual | Necesario para Éxito | Riesgo |
|---|---|---|---|
| **Marco normativo** | Decreto 477/2023 vigente pero sin reglamentación operativa | Decreto reglamentario + manual operativo del IDPAC | 🔴 Alto: sin reglamentación, la plataforma carece de respaldo legal para decisiones vinculantes |
| **Voluntad política** | Administración 2024-2027 ha incluido participación digital en PDD | Compromiso explícito de Secretarios de despacho | 🟡 Medio: depende de continuidad de prioridades entre administraciones |
| **Capacidad administrativa** | IDPAC: 127 funcionarios, solo 8 con perfil digital | Capacitación de mínimo 40 funcionarios en gestión de plataforma | 🔴 Alto: brecha de competencias digitales significativa |
| **Interoperabilidad** | Sistemas legados (Sisbén, SAP, SGP) sin APIs públicas | Convenios interadministrativos IDPAC-IDBAC-IDU | 🔴 Alto: depende de voluntad de otras entidades |
| **Presupuesto recurrente** | No existe partida específica para plataforma de participación | Partida anual de $80-120M COP en PAA del IDPAC | 🔴 Alto: requiere negociación con Secretaría de Hacienda |

---

#### 8.3 RIESGOS Y ESTRATEGIAS DE MITIGACIÓN

| Riesgo | Probabilidad | Impacto | Estrategia de Mitigación | Responsable Sugerido |
|---|---|---|---|---|
| **R1. Resistencia institucional** | Alta (70%) | Alto | Pilotear en 2-3 localidades voluntarias con alcaldes locales comprometidos antes de escalado distrital | IDPAC + Alcaldías locales |
| **R2. Brecha digital de segundo grado** | Alta (75%) | Alto | Incluir módulo de participación offline (puntos de atención presencial con digitalización posterior) + alianza con bibliotecas públicas | IDPAC + BibloRed |
| **R3. Rotación de funcionarios** | Media (50%) | Alto | Manualizar todos los procesos + capacitación institucionalizada en ESCUNI + contratos de prestación de servicio con mesa de ayuda externa | IDPAC + Secretaría de Hacienda |
| **R4. Discontinuidad gubernamental** | Media (45%) | Alto | Licencia AGPL (irrevocable) + migración a repositorio distrital en GitHub + cláusula de continuidad en contrato de desarrollo | IDPAC + Contraloría |
| **R5. Baja adopción ciudadana** | Media (55%) | Medio | Campaña de comunicación + líderes multiplicadores por localidad + incentivos no monetarios (reconocimiento, certificados) | IDPAC + Secretaría de Cultura |
| **R6. Ciberseguridad / ataques** | Baja (25%) | Alto | Pentesting anual + bug bounty + WAF + monitoreo 24/7 + plan de respuesta a incidentes | IDBAC + proveedor de seguridad |
| **R7. Dependencia de proveedor único** | Media (40%) | Medio | Capacitar equipo interno en Ruby on Rails + mantener relación con comunidad Decidim (Barcelona) + código fuente en repositorio distrital | IDPAC + IDBAC |

---

#### 8.4 ESTIMACIÓN DE COSTOS (COP, 2026)

**Nota**: Cifras aproximadas basadas en referentes regionales. Requieren cotización técnica oficial.

| Fase | Concepto | Costo Estimado (COP) | Duración |
|---|---|---|---|
| **FASE 1. Diagnóstico y diseño** | Auditoría técnica, diseño de arquitectura, mapeo de interoperabilidad | $45.000.000 — $65.000.000 | 3-4 meses |
| **FASE 2. Desarrollo y parametrización** | Instalación Decidim, personalización visual, módulos específicos, migración de datos históricos | $85.000.000 — $120.000.000 | 6-8 meses |
| **FASE 3. Piloto** | Implementación en 2-3 localidades, capacitación de 40 funcionarios, mesa de ayuda | $35.000.000 — $50.000.000 | 4-6 meses |
| **FASE 4. Escalamiento** | Rollout distrital, campaña de comunicación, líderes multiplicadores | $65.000.000 — $90.000.000 | 6-8 meses |
| **INVERSIÓN TOTAL FASES 1-4** | | **$230.000.000 — $325.000.000** | **19-26 meses** |
| **MANTENIMIENTO ANUAL** | Hosting, soporte, actualizaciones de seguridad, capacitación continua | $30.000.000 — $50.000.000 | Anual |

**Comparación regional**:
- Chile (Participa Chile): USD $180.000 — $250.000 (~$720M — $1.000M COP) para alcance nacional
- México (Participa.gob.mx): USD $500.000+ (~$2.000M COP) alcance federal
- España (Decidim Barcelona): EUR €300.000 — €400.000 (~$1.400M — $1.900M COP) alcance municipal

**Observación**: La estimación para Bogotá ($230-325M COP) es conservadora comparada con referentes internacionales, debido a: (a) aprovechamiento de licencia AGPL (sin costo de software), (b) aprovechamiento de infraestructura IDBAC compartida, (c) escala distrital (entre municipal y nacional).

---

#### 8.5 CONDICIONES DE ÉXITO

Para que la estrategia propuesta tenga probabilidad de éxito mayor al 60%, deben cumplirse simultáneamente:

1. ✅ **Voluntad política explícita**: Decreto o directriz del Alcalde Mayor estableciendo Decidim como plataforma oficial de participación digital
2. ✅ **Asignación presupuestal**: Inclusión de $80-120M COP anuales en PAA del IDPAC a partir de vigencia 2027
3. ✅ **Capacitación institucional**: Mínimo 40 funcionarios del IDPAC con certificación en gestión de plataforma (120 horas)
4. ✅ **Convenio interadministrativo**: Acuerdo IDPAC-IDBAC-IDU para interoperabilidad de datos
5. ✅ **Pilotaje exitoso**: 2-3 localidades con adopción >30% de instancias de participación en plataforma durante primer año
6. ✅ **Mesa de ayuda operativa**: Atención a ciudadanos en máximo 48 horas hábiles

---

*Este insert debe incorporarse en Anexo Técnico III, como nueva Sección 8, páginas 9-10.*
