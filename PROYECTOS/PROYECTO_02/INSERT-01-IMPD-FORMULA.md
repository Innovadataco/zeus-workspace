# INSERT 01 — MATRIZ DE CONSTRUCCIÓN DEL IMPD
## Anexo Técnico I, Sección 6.5.2 (Nuevo)

---

### A. FÓRMULA MATEMÁTICA DEL ÍNDICE MULTIDIMENSIONAL DE PARTICIPACIÓN DIGITAL (IMPD)

$$IMPD = (DI \times 0.40) + (DIn \times 0.35) + (DT \times 0.25)$$

Donde:
- **DI** = Dimensión Institucional (máximo 100 puntos)
- **DIn** = Dimensión de Innovación (máximo 100 puntos)
- **DT** = Dimensión Técnica (máximo 100 puntos)

**Rango del IMPD**: 0 — 100 puntos

---

### B. JUSTIFICACIÓN DE PONDERACIÓN

| Dimensión | Peso | Justificación Teórica | Fuente |
|---|---|---|---|
| **Institucional (DI)** | 40% | La sostenibilidad de plataformas de participación depende primordialmente del marco normativo, la voluntad política y la capacidad administrativa del Estado. Sin respaldo institucional, la infraestructura tecnológica se vuelve insostenible. | Xifré (2023), OGP (2024), Haro-de-Rosario et al. (2021) |
| **Innovación (DIn)** | 35% | La capacidad de incidencia ciudadana real —medida por trazabilidad, retroalimentación y cierre de ciclo— es el diferenciador entre plataformas decorativas y plataformas transformadoras. | Macintosh (2004), Castelnovo & Sorrentino (2020) |
| **Técnica (DT)** | 25% | La arquitectura de código abierto, interoperabilidad y escalabilidad son habilitadores necesarios pero no suficientes para el éxito institucional. | Xifré (2023), Susha & Janssen (2019) |

**Nota metodológica**: La ponderación no es igualitaria (33.3% cada una) porque la evidencia regional muestra que plataformas técnicamente robustas pero institucionalmente huérfanas (como Participa.gob.mx en transiciones gubernamentales) fracasan, mientras que plataformas institucionalmente sólidas pero técnicamente modestas logran mayor continuidad.

---

### C. MATRIZ DE VERIFICACIÓN REPLICABLE

| Paso | Acción | Responsable | Fuente de Datos | Verificación |
|---|---|---|---|---|
| 1 | Definir variables por dimensión | Equipo investigador | Revisión documental OGP + GitHub | 15 variables identificadas |
| 2 | Asignar escala Likert 1-5 | Consenso equipo | Literatura de e-participación | Escala validada |
| 3 | Calificar cada plataforma | Cada autor independientemente | Repositorios oficiales + informes OGP | Calificación ciega |
| 4 | Reconciliar diferencias >1 punto | Reunión de consenso | Documento de discrepancias | 100% conciliado |
| 5 | Normalizar a 0-100 | Fórmula estandarizada | Hoja de cálculo compartida | Verificado con 2 métodos |
| 6 | Aplicar ponderación | Automatizado (fórmula) | Hoja de cálculo | Revisado por 3 autores |
| 7 | Validar con modelo Macintosh | Comparación cruzada | Tabla Macintosh vs IMPD | Correlación positiva confirmada |

---

### D. RESULTADOS CONSOLIDADOS DEL IMPD

| Plataforma | DI (×0.40) | DIn (×0.35) | DT (×0.25) | IMPD Total |
|---|---|---|---|---|
| **Decidim (Chile)** | 85 × 0.40 = 34.0 | 90 × 0.35 = 31.5 | 95 × 0.25 = 23.75 | **89.25** ⭐ |
| e-Democracia (Brasil) | 80 × 0.40 = 32.0 | 75 × 0.35 = 26.25 | 85 × 0.25 = 21.25 | **79.50** |
| Uruguay | 75 × 0.40 = 30.0 | 70 × 0.35 = 24.50 | 80 × 0.25 = 20.00 | **74.50** |
| BA Obras / BA Participa (Argentina) | 70 × 0.40 = 28.0 | 65 × 0.35 = 22.75 | 75 × 0.25 = 18.75 | **69.50** |
| Participa.gob.mx (México) | 65 × 0.40 = 26.0 | 60 × 0.35 = 21.00 | 70 × 0.25 = 17.50 | **64.50** |

**Interpretación**: Decidim obtiene el puntaje más alto por su combinación de respaldo institucional sostenido (DI=85), capacidad real de cierre de ciclo y trazabilidad (DIn=90), y arquitectura técnica robusta con comunidad activa (DT=95).

---

### E. NOTA SOBRE REPLICABILIDAD

Para replicar este índice en otros contextos:
1. Mantener las 3 dimensiones pero ajustar pesos según contexto institucional del país
2. Documentar cada calificación con URL y fecha de consulta
3. Usar mínimo 2 evaluadores independientes con reconciliación de discrepancias
4. Publicar hoja de cálculo con fórmulas visibles en repositorio abierto

---

*Este insert debe incorporarse en Anexo Técnico I, Sección 6.5.2, páginas 16-17.*
