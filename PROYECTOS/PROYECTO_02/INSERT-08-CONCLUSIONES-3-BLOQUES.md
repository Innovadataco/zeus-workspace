# INSERT 08 — CONCLUSIONES REESTRUCTURADAS EN 3 BLOQUES
## Anexo Técnico IV, Conclusiones (Reemplazo completo de estructura)

---

### ESTRUCTURA DE CONCLUSIONES REORGANIZADA

El jurado solicitó separar claramente hallazgos, interpretaciones y propuestas. Esta estructura reemplaza el formato actual de conclusiones por 3 bloques diferenciados con formato visual distinto.

---

## BLOQUE 1: HALLAZGOS EMPÍRICOS VERIFICADOS

*Formato: Numeración continua, texto neutro, fuente al pie de cada hallazgo.*

**H1.** El Índice Multidimensional de Participación Digital (IMPD) evaluó cinco plataformas latinoamericanas de código abierto. Decidim (Chile) obtuvo el puntaje más alto con 89.25/100, seguido de e-Democracia (Brasil) con 79.50/100, Uruguay con 74.50/100, BA Obras/BA Participa (Argentina) con 69.50/100, y Participa.gob.mx (México) con 64.50/100.  
*[Fuente: Cálculo propio mediante IMPD, Anexo Técnico I, Sección 6.5.2]*

**H2.** La auditoría técnica de Decidim confirma arquitectura de código abierto (licencia AGPL), comunidad activa de desarrollo (más de 400 contribuidores en GitHub), y disponibilidad de módulos deliberativos (presupuestos participativos, iniciativas ciudadanas, debates vinculantes).  
*[Fuente: Repositorio oficial decidim/decidim en GitHub, consultado 15 ene 2026]*

**H3.** La solicitud de información al IDPAC (oficio OF-2026-001-INV-UNI, 15 enero 2026) no obtuvo respuesta institucional al cierre de esta investigación (marzo 2026). Por tanto, el diagnóstico institucional se sustenta en datos públicos del IDPAC (IFIS 2022-2023) y proyecciones de tendencias, no en microdatos desagregados. Según los informes de gestión públicos del IDPAC, se estima que aproximadamente dos tercios de las 1.271 instancias de participación registradas cuentan con mecanismos operativos formales, pero esta cifra no ha podido ser verificada con precisión por la ausencia de respuesta institucional.  
*[Fuente: Proyección basada en informes públicos IDPAC 2022-2024 + Solicitud OF-2026-001-INV-UNI sin respuesta]*

**H4.** La Encuesta de Percepción Ciudadana (EPC) 2025 reporta una "paradoja de nicho": solo el 6.5% de ciudadanos bogotanos sin afiliación a instancias organizadas perciben respuesta gubernamental efectiva, mientras que el 91.8% de participantes en instancias formales reportan eficacia percibida.  
*[Fuente: Reporte ejecutivo EPC 2025, IDPAC, ago 2025]*

**H5.** El Índice de Implementación de la Participación Ciudadana (IIPC) 2023 muestra una variación del 400% en madurez organizativa entre localidades: Usaquén (0.82), Chapinero (0.79), La Candelaria (0.74) vs Ciudad Bolívar (0.21), Bosa (0.26), San Cristóbal (0.28).  
*[Fuente: IIPC 2023, Veeduría Distrital, tabla desagregada por localidad]*

**H6.** El Índice de Innovación Pública (IIP) 2024 ubica a Bogotá en el percentil 62 de ciudades latinoamericanas en gobierno digital, con puntaje de 0.71 en interoperabilidad (escala 0-1), superior al promedio regional (0.58).  
*[Fuente: IIP 2024, IDBAC]*

**H7.** El análisis de repositorios técnicos confirma que Decidim es la única plataforma evaluada con (a) licencia OSI-approved (AGPL), (b) más de 100 implementaciones documentadas globalmente, (c) comunidad de mantenimiento activa sin dependencia de proveedor único, y (d) módulos de trazabilidad de propuestas integrados nativamente.  
*[Fuente: Análisis técnico propio, Anexo Técnico I, Sección 6.4]*

**H8.** El diagnóstico institucional identifica que 58% de decisiones de participación en JAC se toman sin evidencia cuantitativa del territorio, y que no existe API pública que permita interoperabilidad entre sistemas de participación (IDPAC) y sistemas de planeación (IDU, Sisbén, SAP).  
*[Fuente: IFIS 2024 + Revisión técnica de arquitecturas distritales, Anexo II, Sección 8.2]*

---

## BLOQUE 2: INTERPRETACIONES ANALÍTICAS DEL EQUIPO INVESTIGADOR

*Formato: Numeración I1-I5, lenguaje condicional, explícitamente atribuido al equipo.*

**I1.** [INTERPRETACIÓN] La superioridad de Decidim en el IMPD (89.25 vs 79.50 del segundo lugar) no implica que sea la "única" plataforma viable para Bogotá. Sin embargo, su combinación de respaldo institucional sostenido en Chile, arquitectura de trazabilidad nativa y licencia AGPL la posicionan como **una de las opciones más robustas** para un contexto distrital con baja confianza institucional y alta demanda de transparencia.

**I2.** [INTERPRETACIÓN] La "paradoja de nicho" (H4) sugiere que la participación ciudadana en Bogotá opera como un **sistema cerrado con alta eficacia interna pero baja permeabilidad externa**. Esto no indica que las instancias formales sean "elitistas", sino que los canales de participación "abierta" (no afiliada) carecen de mecanismos de retroalimentación que cierren el ciclo de incidencia. El problema es de **diseño institucional**, no de voluntad ciudadana.

**I3.** [INTERPRETACIÓN] La variación del 400% en IIPC entre localidades (H5) indica que la apropiación tecnológica no puede ser una política **homogénea** a nivel distrital. Una estrategia única para Bogotá probablemente fracasaría en localidades con baja madurez organizativa (Ciudad Bolívar, Bosa, San Cristóbal) mientras sería insuficiente para localidades maduras (Usaquén, Chapinero). Se requiere **diferenciación territorial**.

**I4.** [INTERPRETACIÓN] El puntaje de 0.71 en interoperabilidad (H6) es técnicamente suficiente para implementar Decidim, pero la **ausencia de APIs abiertas específicas para participación** significa que la trazabilidad de propuestas ciudadanas dependerá de integraciones ad-hoc, no de arquitectura institucionalizada. Esto introduce un riesgo de discontinuidad técnica si cambia el proveedor o la administración.

**I5.** [INTERPRETACIÓN] La combinación de H3 (ausencia de respuesta IDPAC sobre estado de implementación) + H8 (58% sin evidencia cuantitativa) sugiere una **doble brecha institucional**: no solo es difícil verificar cuántos canales operan realmente, sino que los canales existentes no generan información utilizable para la toma de decisiones. La plataforma tecnológica, por sí sola, no cierra esta brecha. Requiere **reforma del proceso de planeación** que exija evidencia de participación como insumo obligatorio, y **rendición de cuentas institucional** que responda solicitudes de información ciudadana.

---

## BLOQUE 3: PROPUESTAS ESTRATÉGICAS

*Formato: Numeración P1-P6, lenguaje prescriptivo pero con condicionantes de factibilidad explícitos.*

**P1.** [PROPUESTA] Se propone que la estrategia de apropiación de Decidim en Bogotá incorpore un **modelo de gobernanza diferenciado por localidades**, con tres modalidades según IIPC: (a) Localidades maduras (IIPC > 0.70): despliegue completo con presupuestos participativos digitales; (b) Localidades intermedias (IIPC 0.40-0.70): módulo de consultas deliberativas con acompañamiento presencial; (c) Localidades emergentes (IIPC < 0.40): puntos de digitalización asistida en bibliotecas públicas y casas de cultura.  
*Condicionante: Requiere convenio IDPAC-BibloRed y asignación de $15-25M COP anuales para infraestructura presencial de soporte.*

**P2.** [PROPUESTA] Se recomienda que el IDPAC establezca un **tablero de control público de cumplimiento del Decreto 477/2023** por localidad, con actualización trimestral, alertas automáticas para instancias rezagadas, y API abierta para consulta ciudadana. Este tablero debería integrarse como módulo dentro de Decidim o como dashboard independiente interoperable.  
*Condicionante: Depende de voluntad del Director del IDPAC y aprobación del Plan Anual de Adquisiciones (PAA) con partida de $20-30M COP anuales.*

**P3.** [PROPUESTA] Se sugiere desarrollar **conectores API** entre Decidim y los sistemas de gestión de proyectos distritales (SGP, SAP del IDU, Sisbén) en una ventana de 18-24 meses, priorizando: (a) Exportación automática de propuestas con más de 100 apoyos al SGP; (b) Visualización de estado de tramitación en tiempo real para proponentes; (c) Notificaciones automáticas por correo y SMS a proponentes cuando su iniciativa cambia de estado.  
*Condicionante: Requiere convenio interadministrativo IDPAC-IDBAC-IDU y disponibilidad de recursos técnicos en ambas entidades.*

**P4.** [PROPUESTA] Se propone un **programa de "alfabetización digital para incidencia"** (no solo navegación) dirigido a 200 líderes comunitarios por año en las 5 localidades con menor IIPC, con certificación distrital y reconocimiento como "Promotores de Participación Incidente". Este programa debería operar en bibliotecas públicas, casas de cultura y puntos de atención del IDPAC.  
*Condicionante: Requiere alianza IDPAC-BibloRed-Secretaría de Educación y asignación de $25-35M COP anuales para capacitación y certificación.*

**P5.** [PROPUESTA] Se recomienda que el IDPAC implemente un **módulo de "trazabilidad ciudadana"** en Decidim que permita a cualquier usuario (organizado o no) visualizar: (a) Estado de tramitación de su propuesta; (b) Funcionario responsable de cada etapa; (c) Fecha estimada de respuesta; (d) Argumento de decisión si la propuesta es desestimada. Este módulo debería ser público y no requerir autenticación para consulta.  
*Condicionante: Requiere ajuste al Decreto 477/2023 o reglamentación operativa que establezca tiempos de respuesta obligatorios y publicidad de trámite.*

**P6.** [PROPUESTA] Se sugiere establecer una **"Mesa de Participación Digital"** de carácter permanente con representantes del IDPAC, IDBAC, IDU, Veeduría Distrital, academia (Politécnico Gran Colombiano, Universidad de los Andes) y sociedad civil (Bogotá Cómo Vamos, Transparencia por Colombia). Esta Mesa debería reunirse trimestralmente para evaluar métricas de uso de Decidim, resolver bloqueos interinstitucionales, y ajustar la estrategia según evidencia.  
*Condicionante: Requiere acto administrativo del Alcalde Mayor o Acuerdo Distrital, y compromiso de asistencia institucional con sanción por inasistencia reiterada.*

---

### TABLA RESUMEN DE CONDICIONANTES DE FACTIBILIDAD

| Propuesta | Condición Crítica | Riesgo si No se Cumple | Estimación Costo (COP) |
|---|---|---|---|
| P1. Gobernanza diferenciada | Convenio IDPAC-BibloRed | Estrategia homogénea fracasa en localidades rezagadas | $15-25M/año |
| P2. Tablero de control | Aprobación PAA + voluntad directiva | Sin monitoreo, no hay rendición de cuentas | $20-30M/año |
| P3. Conectores API | Convenio IDPAC-IDBAC-IDU | Plataforma opera como "isla" sin impacto en decisiones reales | $40-60M único |
| P4. Alfabetización digital | Alianza IDPAC-SecEducación-BibloRed | Brecha de segundo grado persiste | $25-35M/año |
| P5. Trazabilidad ciudadana | Reglamentación Decreto 477 | Sin trazabilidad, persistirá paradoja de nicho | $10-15M único |
| P6. Mesa permanente | Acto administrativo del Alcalde | Sin coordinación interinstitucional, silos persisten | $5-8M/año |

---

*Este insert reemplaza la estructura actual de conclusiones en Anexo Técnico IV, páginas 4-8.*
