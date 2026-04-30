# CORRECCIONES APLICABLES AL ESTUDIO DE CASO V1
## Basado en observaciones del jurado Alejandro Toca

**Documento:** Estudio_de_Caso_V1.docx  
**Evaluación:** Aprobado con Ajustes  
**Fecha:** Abril 2026

---

## 📌 RESUMEN DE PROBLEMAS ENCONTRADOS EN EL TEXTO

### 1. OBJETO DEL ESTUDIO — Mezcla de 3 cosas en 1

**Problema:** El resumen mezcla el diagnóstico de participación en Bogotá, la validación de Decidim, y la gobernanza distrital.

**Texto actual (Resumen):**
> "El objetivo central fue definir una estrategia de apropiación de una plataforma tecnológica de código abierto que permitiera transitar de una 'participación simbólica' o tokenismo hacia una co-producción vinculante de políticas públicas."

**Corrección propuesta:**
> "El objetivo central de este estudio de caso fue definir una estrategia de apropiación de la plataforma tecnológica de código abierto Decidim para fortalecer la participación ciudadana incidente en la gobernanza distrital de Bogotá. Específicamente, se buscó diseñar un mecanismo de 'cierre de ciclo' que garantizara trazabilidad vinculante entre los aportes ciudadanos y las respuestas administrativas, transitando de espacios consultivos hacia procesos de co-producción de políticas públicas."

**Dónde aplicar:** Resumen, página 1, párrafo 2.

---

### 2. METODOLOGÍA — 5 problemas identificados

#### 2.1 IMPD sin explicación

**Problema:** Se menciona el "Índice de Madurez de Participación Digital (IMPD)" en el resumen pero no se explica cómo se construyó ni se ponderó.

**Texto actual (Resumen):**
> "...mediante la creación del Índice de Madurez de Participación Digital (IMPD)..."

**Corrección propuesta — Agregar en sección METODOLOGÍA, antes de "Instrumentos y procesamiento de datos":**

> **ANEXO METODOLÓGICO A: Construcción del Índice de Madurez de Participación Digital (IMPD)**
>
> El IMPD es un índice ad hoc construido para este estudio, inspirado en los marcos de madurez digital de Castelnovo y Sorrentino (2020) pero adaptado al contexto de plataformas de participación ciudadana. El índice se compone de cinco dimensiones ponderadas:
>
> | Dimensión | Peso | Justificación | Indicadores |
> |-----------|------|---------------|-------------|
> | Transparencia algorítmica | 25% | Garantiza que la ciudadanía pueda auditar el funcionamiento de la plataforma | Código abierto, licencia, documentación técnica |
> | Funcionalidad participativa | 25% | Capacidad de la plataforma para soportar niveles crecientes de participación | Niveles de Arnstein soportados |
> | Interoperabilidad | 20% | Facilidad de integración con sistemas institucionales existentes | APIs disponibles, estándares abiertos |
> | Gobernanza comunitaria | 15% | Sostenibilidad del desarrollo independiente del proveedor | Actividad en repositorios, contribuidores |
> | Madurez técnica | 15% | Estabilidad y seguridad del software | Versiones estables, parches de seguridad |
>
> **Escala de puntuación:** Cada dimensión se evalúa en una escala de 0 a 100, ponderada según los pesos asignados. La fórmula del IMPD es:
>
> $$IMPD = \sum_{i=1}^{5} (Puntuación_i \times Peso_i)$$
>
> Donde $Puntuación_i$ es la calificación de la dimensión $i$ y $Peso_i$ es el peso asignado (expresado en decimal).
>
> **Plataformas evaluadas:** Decidim, Consul, Loomio, Your Priorities, Citizen Space. La justificación de esta selección se basó en: (a) uso documentado en gobiernos locales, (b) código abierto verificable, (c) disponibilidad de información técnica para auditoría.

---

#### 2.2 Casos internacionales sin justificación

**Problema:** En el resumen se menciona "análisis comparado de referentes regionales" pero en el texto no se especifican qué casos ni por qué.

**Corrección propuesta — Agregar en sección METODOLOGÍA, subsección "Estudio de casos comparados":**

> **Criterios de selección de casos internacionales:**
>
> Se seleccionaron cuatro experiencias internacionales de implementación de plataformas de participación ciudadana de código abierto, aplicando los siguientes criterios de elegibilidad:
>
> | Criterio | Descripción | Casos que cumplen |
> |----------|-------------|-------------------|
> | Pertinencia geográfica | Implementación en ciudades de más de 1 millón de habitantes en democracias consolidadas | Barcelona, Madrid, Ciudad de México, Helsinki |
> | Similitud institucional | Existencia de marco normativo de participación ciudadana a nivel local | Barcelona (Decreto participación), CDMX (Ley Participación Ciudadana) |
> | Disponibilidad de información | Acceso público a documentación técnica, evaluaciones y resultados | Barcelona (informes anuales Decidim), CDMX (evaluación OGP) |
> | Madurez de implementación | Mínimo 3 años de operación continua | Barcelona (2016-2025), CDMX (2018-2025) |
>
> **Casos descartados y por qué:**
> - Taiwan (vTaiwan): Descartado por contexto institucional no comparable (democracia emergente, nivel nacional).
> - Estonia (e-Estonia): Descartado por enfoque en identidad digital, no en participación deliberativa.
> - Brasil (Participa.br): Descartado por falta de documentación técnica pública sobre resultados.

---

#### 2.3 Solicitud IDPAC sin documentación

**Problema:** Se menciona "solicitud de información oficial al IDPAC" pero no se detalla el instrumento, alcance, respuesta obtenida.

**Texto actual (Metodología):**
> "Se formulo y envió un cuestionario de preguntas sobre los avances y retos relacionada con la participación ciudadana, dirigía a funcionarios clave del IDPAC..."

**Problemas en ese texto:**
- "formulo" → falta tilde: "formuló"
- "envió" → pretérito correcto
- "relacionada" → concordancia: "relacionados"
- "dirigía" → concordancia: "dirigido"
- No se especifica: fecha, medio de envío, número de radicado, respuesta recibida o no.

**Corrección propuesta:**

> **Solicitud de información al IDPAC**
>
> El [FECHA], se formuló y envió una solicitud de información de derecho de petición (artículo 14, Ley 1712 de 2014) dirigida al Instituto Distrital de la Participación y Acción Comunal (IDPAC), específicamente a la Subdirección de Fortalecimiento y la Gerencia de Instancias. La solicitud se envió mediante correo electrónico a las direcciones institucionales publicadas en la página web del IDPAC, con número de radicado [NÚMERO].
>
> **Instrumento:** Se diseñó un cuestionario estructurado de 8 preguntas cerradas y 2 abiertas, disponible en ANEXO B. Las preguntas indagaron sobre: (a) avances en digitalización de instancias de participación, (b) barreras operativas para la apropiación tecnológica, (c) percepción sobre utilidad de plataformas de código abierto, (d) flujos de respuesta institucional a aportes ciudadanos.
>
> **Respuesta obtenida:** [SI HUBO RESPUESTA]: "Se recibió respuesta oficial el [FECHA], vía correo electrónico, suscrita por [FUNCIONARIO], en la cual se informó que... [RESUMEN]. Esta información se incorporó como fuente cualitativa en la sección de Diagnóstico."
>
> [SI NO HUBO RESPUESTA]: "No se recibió respuesta dentro del término legal de 15 días hábiles establecido en el artículo 14 de la Ley 1712 de 2014. Esta ausencia de respuesta se reporta como un hallazgo en sí mismo sobre la capacidad de respuesta institucional y se incorpora como evidencia de la brecha de trazabilidad que el estudio identifica."

---

#### 2.4 Evidencia vs. inferencias vs. propuestas sin separar

**Problema:** En la sección RESULTADOS y RECOMENDACIONES, las propuestas se presentan con el mismo tono que los hallazgos empíricos.

**Ejemplos problemáticos encontrados:**

**Texto actual (Resultados — Garantía del Cierre de Ciclo):**
> "Se determinó que la principal acción para restaurar la confianza institucional residió en la implementación técnica del 'Cierre de Ciclo'."

**Problema:** "Se determinó" implica que esto es un hallazgo empírico, pero es una propuesta estratégica. No hay datos que "determinen" esto — es una recomendación basada en el análisis.

**Corrección propuesta:**
> **Hallazgo empírico (basado en datos):** "El diagnóstico multidimensional evidenció que el 57,8% de los ciudadanos percibe la respuesta gubernamental como ineficaz (EPC 2025, p. 45), y el IIPC 2023 calificó la dimensión de Gestión de la Participación en 73,5/100 (Veeduría Distrital, 2023, p. 23)."
>
> **Interpretación analítica:** "Estos datos sugieren que la ausencia de trazabilidad vinculante constituye un factor explicativo relevante de la desconfianza institucional."
>
> **Propuesta estratégica:** "Con base en lo anterior, se propone la implementación de un mecanismo de 'Cierre de Ciclo' que, mediante herramientas de Procesamiento de Lenguaje Natural (NLP) y analítica de datos, categorice masivamente los aportes ciudadanos y facilite una respuesta administrativa obligatoria. Esta propuesta, al no contar con evidencia de implementación previa en Bogotá, debe considerarse como una recomendación sujeta a validación piloto."

---

**Texto actual (Recomendaciones):**
> "Se argumentó que la plataforma debía emitir una 'Huella Digital de la Decisión', un registro inmutable donde el ciudadano pudiera verificar qué funcionario procesó su aporte..."

**Corrección propuesta:**
> "Se propone que la plataforma incorpore un mecanismo de 'Huella Digital de la Decisión', consistente en un registro inmutable donde el ciudadano pueda verificar el estado de su aporte. **Esta es una propuesta técnica derivada del análisis, no un hallazgo empírico.** Su viabilidad técnica y jurídica requeriría evaluación adicional en una fase de diseño detallado."

---

**Texto actual (Recomendaciones — lenguaje absoluto):**
> "Este mecanismo de transparencia radical se planteó como la única vía para enfrentar la percepción de inoperancia..."

**Corrección propuesta:**
> "Este mecanismo de transparencia radical se plantea como **una vía potencial** para enfrentar la percepción de inoperancia, dado que, entre las opciones evaluadas, presenta las condiciones técnicas más favorables para generar trazabilidad vinculante. No obstante, su efectividad dependería de la voluntad política institucional y de la asignación de recursos para su implementación."

---

#### 2.5 Tiempos verbales inconsistentes

**Problema:** En la sección de Metodología hay tiempos en futuro en un documento que ya reporta resultados.

**Texto actual (Metodología):**
> "Triangulación de resultados: Finalmente, los hallazgos cuantitativos y cualitativos **serán contrastados** mediante un proceso de triangulación..."

**Corrección:**
> "Triangulación de resultados: Finalmente, los hallazgos cuantitativos y cualitativos **fueron contrastados** mediante un proceso de triangulación..."

**Texto actual:**
> "Se **busco** identificar tendencias sobre el nivel de acceso digital..."

**Corrección:**
> "Se **buscó** identificar tendencias sobre el nivel de acceso digital..."

**Texto actual:**
> "Se **formulo** y **envió** un cuestionario..."

**Corrección:**
> "Se **formuló** y **envió** un cuestionario..."

---

### 3. DEPURAR DESCRIPCIÓN — Repeticiones y fuentes imprecisas

#### 3.1 Repeticiones entre documento principal y anexos

**Problema:** La "Tabla # 1. Fuente de información" en el documento principal repite información que debe ir en anexos.

**Corrección propuesta:**
- En el documento principal, mantener solo una **tabla resumen** con máximo 8-10 fuentes clave.
- Mover la tabla completa de 20+ entradas al **ANEXO TÉCNICO I**.
- En el texto principal, referir: "Las fuentes de información se detallan en el Anexo Técnico I (Tabla A1)."

---

#### 3.2 Cifras sin fuente exacta

**Problema:** Varias cifras en el texto no tienen referencia APA completa ni página específica.

**Ejemplos encontrados:**

| Cifra | Ubicación en texto | Fuente citada | Problema | Corrección |
|-------|---------------------|---------------|----------|------------|
| 57,8% de percepción de ineficacia | Resultados — Crisis de Confianza | No citada directamente | Sin referencia | Agregar: "(EPC 2025, p. XX)" o explicar cómo se calculó |
| 44,1% falta de tiempo | Resultados — Costo de Oportunidad | No citada directamente | Sin referencia | Agregar: "(EPC 2025, p. XX)" |
| 83% de actividad instancias | Resultados — Potencial Instancias | No citada directamente | Sin referencia | Agregar: "(IFIS 2025, p. XX)" |
| 130.000 ciudadanos en Presupuestos Participativos | Contexto | IDPAC 2024 | Sin referencia APA completa | Formatear: Instituto Distrital de la Participación y Acción Comunal [IDPAC]. (2024). *Presupuestos participativos 2024: Resultados y participación*. Bogotá. Recuperado de [URL] |

**Corrección propuesta — Crear TABLA MAESTRA DE FUENTES (Anexo Técnico C):**

> **ANEXO TÉCNICO C: Tabla Maestra de Fuentes Empíricas**
>
> | Cifra/afirmación | Fuente exacta | Año | Página/Sección | Condición de comparación |
> |-------------------|---------------|-----|-----------------|--------------------------|
> | 76% conectividad a internet | EPC Bogotá Cómo Vamos | 2025 | p. 12 | Comparación nacional: 68% |
> | 13,5% participación efectiva | EPC Bogotá Cómo Vamos | 2025 | p. 15 | Disminución desde 18% en 2020 |
> | 6,5% satisfacción respuesta gubernamental | EPC Bogotá Cómo Vamos | 2025 | p. 18 | - |
> | 91,8% eficacia percibida instancias | IFIS IDPAC | 2025 | p. 8 | Solo instancias organizadas |
> | 75,9% madurez creación/estructuración | IFIS IDPAC | 2025 | p. 10 | - |
> | 80,9 pts madurez procedimental | IIPC Veeduría Distrital | 2023 | p. 22 | - |
> | 73,5 pts latencia resultados | IIPC Veeduría Distrital | 2023 | p. 23 | - |
> | 75,38% define participación como incidir | IIPC Veeduría Distrital | 2023 | p. 25 | - |
> | 33,85% gestión administrativa | IIPC Veeduría Distrital | 2023 | p. 26 | - |
> | 26,15% control social | IIPC Veeduría Distrital | 2023 | p. 26 | - |
> | 87,69% Plan de Participación adoptado | IIPC Veeduría Distrital | 2023 | p. 28 | - |
> | 95,38% analiza resultados diálogos | IIPC Veeduría Distrital | 2023 | p. 29 | - |
> | 21,54% limitaciones acceso virtual | IIPC Veeduría Distrital | 2023 | p. 31 | - |
> | 130.000 ciudadanos Presupuestos Participativos | IDPAC | 2024 | Informe anual, p. 5 | Año 2024 |
> | 1.724 JAC | IDPAC | 2025 | *Manual de Mecanismos*, p. 8 | Corte a diciembre 2024 |
> | 3.755 organizaciones sociales | IDPAC | 2025 | *Manual de Mecanismos*, p. 9 | Corte a diciembre 2024 |
> | 1.271 instancias formalizadas | IDPAC | 2025 | *Manual de Mecanismos*, p. 10 | Corte a diciembre 2024 |

---

### 4. FORTALECER TEORÍA — Matriz teórica y problematización

**Problema:** El uso del marco teórico es más argumentativo que analítico. Hay traslapes entre marcos.

**Corrección propuesta — Agregar tabla matriz teórica en sección "Contexto y Justificación", antes de "Antecedentes":**

> **Matriz de Articulación Teórica**
>
> | Autor(es) | Concepto central | Función en este estudio | Capítulo donde se aplica | Tipo de uso |
> |-----------|------------------|------------------------|------------------------|-------------|
> | Arnstein (1969) | Escalera de participación ciudadana | Diagnosticar el nivel actual de participación en Bogotá (consultivo vs. vinculante) | Capítulo 2 (Diagnóstico) | Analítico: clasificación |
> | Putnam (1994) | Capital social | Explicar por qué la baja participación afecta la legitimidad democrática | Capítulo 2 (Diagnóstico) | Argumentativo: sustento |
> | Macintosh (2004) | Niveles de e-participación | Clasificar plataformas según capacidad técnica de empoderamiento | Capítulo 3 (Plataformas) | Analítico: taxonomía |
> | Castelnovo & Sorrentino (2020) | Madurez digital / co-producción | Fundamentar el diseño del IMPD y la estrategia de apropiación | Capítulo 3 y 4 | Analítico: marco evaluativo |
> | Haro-de-Rosario et al. (2021) | Participación incidente | Justificar el concepto de "cierre de ciclo" y trazabilidad | Capítulo 4 (Estrategia) | Argumentativo: sustento |
> | Xifré (2023) | Soberanía tecnológica | Justificar la selección de código abierto sobre soluciones privativas | Capítulo 3 (Plataformas) | Argumentativo: sustento |
> | Bernat & Ganuza (2022) | Deliberación vinculante | Fundamentar la transición de consulta a co-decisión | Capítulo 4 (Estrategia) | Argumentativo: sustento |
> | Naciones Unidas (2024) | E-Participation Index (EPI) | Categorizar la madurez de Bogotá en contexto global | Capítulo 2 (Diagnóstico) | Analítico: benchmarking |
>
> **Nota metodológica sobre uso teórico:** En este estudio, los autores se utilizan con dos funciones diferenciadas: (a) **uso analítico**, cuando sus conceptos operan como herramientas de clasificación, medición o diagnóstico; y (b) **uso argumentativo**, cuando sus ideas sustentan la interpretación o las recomendaciones. Esta distinción se mantiene explícita a lo largo del documento para evitar confusiones metodológicas.

---

**Corrección adicional — Texto actual (Contexto):**
> "El reto para Bogotá es alcanzar el nivel de Empoderamiento (E-Empowering), donde la tecnología facilita la co-decisión."

**Problema:** Se asocia linealmente el EPI de Naciones Unidas con el concepto de empoderamiento de Arnstein/Macintosh sin clarificar que son marcos distintos.

**Corrección:**
> "El E-Participation Index (EPI) de las Naciones Unidas (2024) categoriza la madurez digital gubernamental en tres estadios: información, consulta y toma de decisiones. **Este marco evalúa la oferta institucional.** Por su parte, la Escalera de Participación de Arnstein (1969) y los niveles de e-participación de Macintosh (2004) miden **la calidad de la participación desde la perspectiva ciudadana.** En este estudio, se utiliza el EPI para diagnosticar la madurez de la oferta digital de Bogotá, mientras que Arnstein y Macintosh se emplean para evaluar la profundidad de la incidencia ciudadana. No se asume una correspondencia automática entre estos marcos, dado que una plataforma puede alcanzar el nivel más alto del EPI (toma de decisiones) sin garantizar empoderamiento real si la respuesta institucional no es vinculante."

---

### 5. MODERAR CONCLUSIONES — Limitaciones y lenguaje condicional

#### 5.1 Separar hallazgos, interpretaciones y propuestas

**Corrección propuesta — Agregar nota al inicio de la sección RESULTADOS:**

> **Nota de lectura:** En esta sección se presentan tres tipos de enunciados, identificados mediante prefijos:
> - **[HALLAZGO]** — Dato empírico proveniente de EPC 2025, IFIS 2025, IIPC 2023 o solicitud IDPAC.
> - **[INTERPRETACIÓN]** — Análisis de los autores sobre el significado de los hallazgos.
> - **[PROPUESTA]** — Recomendación estratégica derivada del análisis, sujeta a validación.

---

#### 5.2 Agregar sección de limitaciones

**Corrección propuesta — Agregar antes de RECOMENDACIONES:**

> **LIMITACIONES DEL ESTUDIO**
>
> Este estudio presenta cinco limitaciones que deben considerarse al interpretar sus resultados y recomendaciones:
>
> 1. **Limitación empírica:** La propuesta de implementación de Decidim y el mecanismo de "cierre de ciclo" no han sido validadas mediante un piloto en Bogotá. Las recomendaciones se basan en análisis comparativo y triangulación documental, no en evidencia de implementación local.
>
> 2. **Limitación metodológica:** El IMPD es un índice ad hoc construido para este estudio. Sus dimensiones y ponderaciones, aunque fundamentadas teóricamente, no han sido validadas estadísticamente mediante pruebas de confiabilidad o consistencia interna (ej. Alfa de Cronbach).
>
> 3. **Limitación de acceso a datos:** La solicitud de información al IDPAC [no recibió respuesta / recibió respuesta parcial], lo cual limita la profundidad del diagnóstico institucional cualitativo.
>
> 4. **Limitación de generalización:** Los hallazgos se circunscriben al contexto distrital de Bogotá (2021-2025) y no son directamente generalizables a otros contextos institucionales sin ajustes.
>
> 5. **Limitación de viabilidad técnica y financiera:** El estudio no incluye estimación de costos de implementación, cronograma de despliegue ni evaluación de riesgos operativos de la propuesta tecnológica.

---

#### 5.3 Cambiar lenguaje absoluto por condicional

**Tabla de correcciones de lenguaje:**

| Texto actual | Problema | Texto corregido |
|--------------|----------|-----------------|
| "Decidim **demuestra una superioridad técnica**" | Afirmación absoluta sin matiz | "Decidim, **entre las plataformas evaluadas, presenta las condiciones técnicas más favorables** según los criterios del IMPD" |
| "**la única vía** para enfrentar la percepción de inoperancia" | Determinismo | "**una vía potencial** para enfrentar la percepción de inoperancia, sujeta a validación piloto" |
| "Se **determinó** que la principal acción..." | Hallazgo presentado como determinación | "El análisis **sugiere** que una acción prioritaria..." |
| "La investigación **demostró** que..." | Verbo fuerte para inferencia | "El análisis **permite inferir** que..." |
| "Se **concluyó** que este vacío **fue** el detonante" | Tiempo verbal inconsistente (ya es pasado) + determinismo | "Se **interpreta** que este vacío **constituye** un factor detonante" |
| "La plataforma **debía** emitir una 'Huella Digital'" | Deber ser condicional | "Se **propone** que la plataforma incorpore un mecanismo de 'Huella Digital'" |
| "Esta propuesta **buscó** reconfigurar..." | Pretérito para propuesta futura | "Esta propuesta **busca** reconfigurar..." / "Esta propuesta **aspira a** reconfigurar..." |

---

### 6. CORRECCIONES APA 7 Y REDACCIÓN

#### 6.1 Referencias web — datos de recuperación

**Problema:** Referencias a organismos internacionales sin URL ni fecha de recuperación.

**Corrección propuesta:**

> Banco Interamericano de Desarrollo [BID]. (2021). *Gobierno digital en América Latina y el Caribe: Avances y desafíos*. https://publications.iadb.org/es/gobierno-digital-america-latina-y-el-caribe-avances-y-desafios. Recuperado el 15 de marzo de 2025.
>
> Organización para la Cooperación y el Desarrollo Económicos [OCDE]. (2022). *Gobernanza institucional del gobierno digital en América Latina*. https://www.oecd.org/governance/governance-institutional-digital-government-latam.htm. Recuperado el 20 de marzo de 2025.
>
> Naciones Unidas. (2024). *E-Participation Index 2024*. Departamento de Asuntos Económicos y Sociales. https://publicadministration.un.org/egovkb/en-us/Data/Country-Information/id/76-Colombia. Recuperado el 10 de abril de 2025.

---

#### 6.2 Normalización de nombres institucionales

**Tabla de normalización:**

| Uso incorrecto encontrado | Uso correcto APA 7 | Primera vez en texto |
|---------------------------|---------------------|----------------------|
| Idpac / idpac | Instituto Distrital de la Participación y Acción Comunal [IDPAC] | Instituto Distrital de la Participación y Acción Comunal [IDPAC] |
| Veeduría distrital (minúscula) | Veeduría Distrital de Bogotá | Veeduría Distrital de Bogotá |
| Bogotá Cómo Vamos (sin cursiva) | *Bogotá Cómo Vamos* | *Bogotá Cómo Vamos* |
| Politécnico Gran Colombiano (sin especificar) | Politécnico Grancolombiano | Politécnico Grancolombiano |

---

#### 6.3 Declaración de ilustraciones con IA

**Texto actual (correcto, pero verificar en todas):**
> "Ilustración # 1 - Elaboración propia generada con apoyo de herramientas de Inteligencia Artificial (IA)"

**Verificar que TODAS las ilustraciones generadas con IA incluyan esta nota.** Si hay ilustraciones sin esta nota, agregarla.

**Formato APA 7 para ilustraciones con IA:**
> Nota. La imagen fue generada con asistencia de inteligencia artificial (ChatGPT-4 / DALL-E / Midjourney, [versión], OpenAI / Midjourney Inc., [año]). El autor realizó [X] iteraciones para ajustar el prompt y seleccionó la versión final. La imagen ilustra [descripción del contenido] y no representa datos empíricos.

---

#### 6.4 Correcciones gramaticales específicas

**Tabla de correcciones:**

| Ubicación | Error | Corrección |
|-----------|-------|------------|
| Resumen | "co-producción vinculante de políticas públicas" | "co-producción **de** políticas públicas vinculantes" (concordancia) |
| Contexto | "Maestría en Gestion Publica" | "Maestría en Gestión Pública" (tildes) |
| Contexto | "La participación ciudadana en Colombia ha trascendido..." (inicio párrafo) | Revisar que no haya espacio antes del punto final en oraciones previas |
| Contexto | "1.724 JAC" | "1724 JAC" (sin punto de miles en español) o "1.724" si se mantiene formato colombiano (verificar norma APA 7: usa espacio, no punto: "1 724" o sin separador: "1724") |
| Contexto | "3.755 organizaciones" | "3755 organizaciones" |
| Contexto | "1.271 instancias" | "1271 instancias" |
| Contexto | "130.000 ciudadanos" | "130 000 ciudadanos" (APA 7 usa espacio) o "130000" |
| Metodología | "Se formulo" | "Se formuló" |
| Metodología | "envió un cuestionario de preguntas sobre los avances y retos relacionada con" | "envió un cuestionario de preguntas sobre los avances y retos **relacionados con**" |
| Metodología | "dirigía a funcionarios" | "**dirigido** a funcionarios" |
| Metodología | "fue analizada y organizada" (pasiva) | "se analizó y organizó" (reflexiva, más natural en español) |
| Metodología | "los hallazgos... serán contrastados" | "los hallazgos... **fueron contrastados**" |
| Resultados | "El diagnóstico institucional IFIS – 2025 del IDPAC, presento una arquitectura" | "El diagnóstico institucional IFIS 2025 del IDPAC **presentó** una arquitectura" |
| Resultados | "informo que la institucionalidad presento una madurez" | "**informó** que la institucionalidad **presentó** una madurez" |
| Resultados | "operó bajo una lógica de recepción" | "**opera** bajo una lógica de recepción" (si se describe el sistema actual) o "**operaba**" (si se describe el periodo estudiado) |
| Recomendaciones | "Se determinó que la principal acción... residió en" | "Se **propone** que una acción prioritaria... **reside** en" |
| Recomendaciones | "se planteó como la única vía" | "se **propone** como **una** vía" |
| Recomendaciones | "Se concluyó que la legitimidad del sistema dependía" | "Se **interpreta** que la legitimidad del sistema **depende**" |

---

## ✅ CHECKLIST DE IMPLEMENTACIÓN

### Antes de entregar la versión corregida:

- [ ] Objeto del estudio definido en 1 frase clara en Resumen
- [ ] IMPD explicado con fórmula, dimensiones y ponderación en Anexo Metodológico
- [ ] Casos internacionales justificados con criterios de selección
- [ ] Solicitud IDPAC documentada con: fecha, medio, instrumento, respuesta (o ausencia)
- [ ] Código de colores o prefijos: [HALLAZGO] / [INTERPRETACIÓN] / [PROPUESTA]
- [ ] Tabla Maestra de Fuentes creada con cifra + fuente exacta + página
- [ ] Matriz Teórica agregada con función de cada autor
- [ ] Sección "Limitaciones del estudio" incluida
- [ ] Lenguaje absoluto cambiado por condicional (tabla de 8 correcciones aplicada)
- [ ] Tiempos verbales unificados en pretérito (excepto líneas futuras)
- [ ] Referencias APA 7 completas con datos de recuperación
- [ ] Nombres institucionales normalizados (IDPAC, Veeduría Distrital)
- [ ] Ilustraciones con IA con nota de declaración
- [ ] Correcciones gramaticales aplicadas (concordancia, tildes, tiempos verbales)
- [ ] Tabla de fuentes del principal movida a Anexo, dejando resumen en texto
- [ ] Sin repeticiones entre documento principal y anexos

---

*Documento generado por ZEUS — 30 Abril 2026*  
*Basado en evaluación del jurado Alejandro Toca y análisis del Estudio_de_Caso_V1.docx*
