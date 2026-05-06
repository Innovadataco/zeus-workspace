# INSERT 04 — TABLA DE TRAZABILIDAD: HALLAZGOS vs INFERENCIAS vs PROPUESTAS
## Anexo Técnico II, Sección 9.1 (Reestructurado)
## Anexo Técnico III, Secciones 5-6
## Anexo Técnico IV, Conclusiones

---

### A. SISTEMA DE CODIFICACIÓN

Para distinguir claramente la proveniencia de cada afirmación en el documento, se adopta el siguiente código de colores/letras:

| Código | Tipo | Definición | ¿Puede ser verificado por otro investigador? |
|---|---|---|---|
| **[HALLAZGO]** | Hallazgo empírico verificado | Dato estadístico, cifra oficial, resultado de encuesta, dato documental. Proviene de evidencia empírica directa. | ✅ Sí, con acceso a la misma fuente |
| **[INTERPRETACIÓN]** | Interpretación analítica del equipo | Análisis, síntesis, correlación o explicación causal elaborada por los autores a partir de hallazgos. | ⚠️ Parcialmente, con la misma base de datos |
| **[PROPUESTA]** | Propuesta estratégica del equipo | Recomendación, estrategia, modelo o intervención sugerida por los autores para resolver un problema identificado. | ❌ No, es una propuesta normativa |

---

### B. EJEMPLOS APLICADOS AL TEXTO

#### Ejemplo 1 (Anexo II — Diagnóstico Institucional)

> **[HALLAZGO]** De las 1.271 instancias de participación registradas por el Instituto Distrital de la Participación y Acción Comunal [IDPAC] según informes de gestión públicos 2022-2024, se proyecta que aproximadamente dos tercios cuentan con mecanismos de participación incidente operativos al amparo del Decreto 477 de 2023. Esta cifra no ha podido ser verificada con microdatos debido a que la solicitud de información OF-2026-001-INV-UNI enviada al IDPAC no obtuvo respuesta institucional al cierre de esta investigación. <br>*[Fuente: Proyección basada en informes públicos IDPAC 2022-2024. Nota: Solicitud OF-2026-001-INV-UNI sin respuesta]*

> **[INTERPRETACIÓN]** La ausencia de verificación precisa (debido a la no respuesta del IDPAC) sugiere una implementación normativa potencialmente desigual, donde la existencia de instancias formales no necesariamente se traduce en canales efectivos de incidencia ciudadana. La discontinuidad entre cobertura nominal y operativa podría explicarse por la falta de presupuesto ejecutado específico para mecanismos digitales en las localidades de menor IIPC.

> **[PROPUESTA]** Se propone que el IDPAC establezca un tablero de control público de cumplimiento del Decreto 477/2023 por localidad, con actualización trimestral y alertas automáticas para instancias rezagadas.

---

#### Ejemplo 2 (Anexo II — Dimensión Socio-Cultural)

> **[HALLAZGO]** La Encuesta de Percepción Ciudadana (EPC) 2025 reporta que solo el 6.5% de los ciudadanos bogotanos sin afiliación a instancias organizadas (JAC, veedurías) perciben que sus aportes generan respuesta gubernamental efectiva. En contraste, el 91.8% de participantes activos en instancias formales reportan eficacia percibida de la participación. <br>*[Fuente: Reporte ejecutivo EPC 2025, IDPAC, ago 2025]*

> **[INTERPRETACIÓN]** Esta "paradoja de nicho" indica que la participación ciudadana en Bogotá opera como un sistema cerrado: funciona bien para quienes ya están dentro de las estructuras organizadas, pero no genera canales efectivos para el ciudadano general. La brecha no es de acceso a internet (76% de cobertura) sino de trazabilidad institucional: el ciudadano aislado no ve el destino de sus aportes.

> **[PROPUESTA]** La estrategia de apropiación de Decidim debe incluir un módulo de "trazabilidad ciudadana" que permita a cualquier usuario (organizado o no) visualizar el estado de tramitación de su propuesta, con notificaciones automáticas por correo y SMS.

---

#### Ejemplo 3 (Anexo III — Estrategia Tecnológica)

> **[HALLAZGO]** El Índice de Innovación Pública (IIP) del IDBAC 2024 ubica a Bogotá en el percentil 62 de ciudades latinoamericanas en gobierno digital, con puntaje específico de 0.71 en interoperabilidad (escala 0-1). <br>*[Fuente: IIP 2024, IDBAC]*

> **[INTERPRETACIÓN]** Aunque el puntaje de 0.71 en interoperabilidad supera el promedio regional (0.58), la ausencia de APIs abiertas para sistemas de participación ciudadana (Sisbén, POT, IDU) impide que una plataforma como Decidim pueda integrarse nativamente con los sistemas de seguimiento de políticas públicas existentes.

> **[PROPUESTA]** Se recomienda que la estrategia de apropiación incluya una fase de "puentes de interoperabilidad" con el IDBAC y el IDU, desarrollando conectores API entre Decidim y los sistemas de gestión de proyectos distritales (SGP, SAP), con cronograma de 18-24 meses.

---

### C. MATRIZ DE TRAZABILIDAD CONSOLIDADA (Anexo II, Sección 9.1)

| # | Afirmación | Código | Fuente Empírica | ¿Verificable? |
|---|---|---|---|---|
| 1 | ~66% de instancias estimadas con mecanismos operativos (proyección, no dato verificado) | [HALLAZGO] | IFIS público IDPAC + proyección | ⚠️ Parcial |
| 2 | Brecha sugerida por ausencia de respuesta IDPAC | [INTERPRETACIÓN] | Derivado de H1 | ⚠️ Parcial |
| 3 | Falta de presupuesto en 40% de localidades | [INTERPRETACIÓN] | Derivado de H1 + OGPD | ⚠️ Parcial |
| 4 | Tablero de control público por localidad | [PROPUESTA] | N/A | ❌ No |
| 5 | 6.5% de ciudadanos aislados perciben respuesta vs 91.8% organizados | [HALLAZGO] | EPC 2025, IDPAC | ✅ Sí |
| 6 | "Paradoja de nicho": sistema cerrado de participación | [INTERPRETACIÓN] | Derivado de H5 | ⚠️ Parcial |
| 7 | Brecha es de trazabilidad, no de acceso | [INTERPRETACIÓN] | Derivado de H5 + IFIS | ⚠️ Parcial |
| 8 | Módulo de trazabilidad ciudadana en Decidim | [PROPUESTA] | N/A | ❌ No |
| 9 | Bogotá en percentil 62 de IIP 2024 | [HALLAZGO] | IIP 2024, IDBAC | ✅ Sí |
| 10 | Ausencia de APIs abiertas para participación | [INTERPRETACIÓN] | Derivado de H9 + revisión técnica | ⚠️ Parcial |
| 11 | Conectores API Decidim-SGP en 18-24 meses | [PROPUESTA] | N/A | ❌ No |

---

### D. INSTRUCCIONES DE USO EN EL DOCUMENTO

1. **Primera aparición de cada fuente**: Nombre completo + sigla entre corchetes. Ejemplo: "Instituto Distrital de la Participación y Acción Comunal [IDPAC]".
2. **Siguientes citas**: Solo sigla. Ejemplo: "Según el IDPAC...".
3. **Toda cifra**: Debe llevar nota al pie con fuente exacta, año y página/documento.
4. **Toda interpretación**: Debe poder rastrearse a un hallazgo específico (ver Matriz de Trazabilidad).
5. **Toda propuesta**: Debe incluir condicionante de factibilidad. Ejemplo: "...sujeto a disponibilidad presupuestal del IDPAC".

---

*Este insert debe incorporarse como sistema de codificación al inicio de Anexo II (Sección 9.1), y aplicarse consistentemente en Anexos III y IV.*
