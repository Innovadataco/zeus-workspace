# INSERT 01 — FÓRMULA Y RESULTADOS DEL IMPD
## Anexo Técnico I, Sección 6.5.2 (Ampliado)

---

### 6.5.2 FÓRMULA Y RESULTADOS DEL ÍNDICE DE MADUREZ DE PARTICIPACIÓN DIGITAL (IMPD)

El Índice de Madurez de Participación Digital (IMPD) fue calculado en el Anexo Técnico I de este trabajo mediante fórmula de promedio simple (pesos equitativos). A continuación se detalla la metodología, fórmula, cálculo paso a paso y matriz de verificación replicable.

---

#### A. FÓRMULA MATEMÁTICA DEL IMPD

El IMPD se define como el promedio aritmético simple de tres dimensiones:

```
IMPD = ( DI + DIn + DT ) / 3
```

Donde:

| Dimensión | Abreviatura | Fuente | ¿Qué mide? |
|---|---|---|---|
| **Dimensión Institucional** | DI | EPI ONU (e-participation index) | Madurez institucional del Estado en gobierno digital y participación |
| **Dimensión Innovación** | DIn | OGP (Open Government Partnership) | Compromisos de gobierno abierto y evaluación independiente |
| **Dimensión Técnica** | DT | Auditoría de código fuente (GitHub/GitLab) | Robustez técnica: actividad de repositorio, licencia, módulos deliberativos, trazabilidad |

**Nota**: El documento original del Anexo Técnico I utiliza **pesos equitativos** (1/3 por dimensión). La siguiente tabla muestra los valores REALES extraídos de la Tabla 4 del Anexo Técnico I, página 16.

---

#### B. RESULTADOS CONSOLIDADOS REALES (Tabla 4 Anexo I)

| Ranking | País / Plataforma | DI (EPI ONU) | DIn (OGP) | DT (Auditoría Técnica) | **IMPD** | Clasificación Macintosh |
|---|---|---|---|---|---|---|
| 🥇 1 | **Uruguay** (Portal Participación) | 86.30 | 92.00 | 88.00 | **88.77** | E-Empowering |
| 🥈 2 | **Brasil** (e-Democracia) | 86.30 | 88.00 | 90.00 | **88.10** | E-Empowering |
| 🥉 3 | **Chile** (Decidim / Participa) | 83.56 | 85.00 | 95.00 | **87.85** | E-Empowering |
| 4 | **México** (Participa.gob.mx) | 73.97 | 78.00 | 72.00 | **74.66** | E-Engaging |
| 5 | **Argentina** (BA Obras / BA Participa) | 63.01 | 70.00 | 65.00 | **66.00** | E-Enabling |

*Fuente: Tabla 4, Matriz de Resultados Consolidados del IMPD, Anexo Técnico I, pág. 16. Elaboración propia.*

**Fórmula aplicada**: IMPD = ( DI + DIn + DT ) / 3

**Ejemplo cálculo Uruguay**: (86.30 + 92.00 + 88.00) / 3 = 266.30 / 3 = **88.77**

---

#### C. MATRIZ DE VERIFICACIÓN REPLICABLE

Para que cualquier investigador pueda replicar el cálculo:

| Paso | Acción | Fuente de Datos | Método |
|---|---|---|---|
| 1 | Obtener EPI del país | ONU E-Participation Index [1] | Descargar reporte anual, extraer puntaje e-participation |
| 2 | Obtener evaluación OGP | OGP Independent Reporting Mechanism [2] | Consultar evaluación de compromisos de participación ciudadana |
| 3 | Auditar repositorio técnico | GitHub / GitLab oficial de la plataforma | Verificar: licencia OSI-approved, commits últimos 12 meses, módulos deliberativos, issues cerrados, contribuidores activos |
| 4 | Normalizar cada dimensión | Escala 0-100 | Si la fuente usa escala diferente (ej. 0-1), multiplicar por 100 |
| 5 | Calcular IMPD | Fórmula: (DI + DIn + DT) / 3 | Promedio simple con 2 decimales |
| 6 | Clasificar por Macintosh | Rangos del Anexo I, pág. 16 | < 70 = E-Enabling; 70-85 = E-Engaging; > 85 = E-Empowering |

**Fuentes oficiales verificables**:
1. ONU E-Participation Index: https://publicadministration.un.org/egovkb/en-us/Data-Center
2. OGP Independent Reporting Mechanism: https://www.opengovpartnership.org/irm_reports/
3. Repositorios auditados:
   - Decidim (Chile): https://github.com/decidim/decidim
   - e-Democracia (Brasil): https://github.com/labhackercd/e-democracia
   - BA Obras (Argentina): repositorio del Gobierno de la Ciudad de Buenos Aires
   - Participa.gob.mx (México): https://github.com/participagob/

---

#### D. NOTA IMPORTANTE SOBRE INTERPRETACIÓN

El documento original del Anexo Técnico I señala (pág. 16):

> "A pesar de que el referente de Uruguay se consolida como el estándar de oro en términos de impacto político regional, la rigurosidad técnica de esta auditoría concluye que la infraestructura de Decidim ofrece una superioridad estructural. La diferencia cualitativa de siete puntos en la Dimensión Técnica (95.00 vs. 88.00 de Consul), se traduce en una vitalidad de código superior..."

Esto significa que:
- **Uruguay lidera en IMPD total** (88.77) por equilibrio institucional
- **Chile (Decidim) lidera en Dimensión Técnica** (95.00), lo que justifica su selección para Bogotá
- La selección final no se basó únicamente en puntaje IMPD, sino en **diferenciación técnica** (trazabilidad de código, comunidad activa, licencia AGPL)

---

#### E. DECLARACIÓN DE TRAZABILIDAD

Todas las cifras de esta sección provienen de:
- **Anexo Técnico I, Tabla 4, pág. 16** del trabajo de grado original
- Fuentes primarias citadas en dicho anexo (EPI ONU 2024, OGP IRM, auditoría GitHub propia)

No se han modificado puntajes, pesos ni fórmulas respecto al documento original.
