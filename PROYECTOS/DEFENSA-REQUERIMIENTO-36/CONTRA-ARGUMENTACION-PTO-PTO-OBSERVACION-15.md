# CONTRA-ARGUMENTACIÓN PUNTO POR PUNTO — OBSERVACIÓN 15 CGR AF-ST-2024-36
## Análisis forense del texto de la Contraloría y respuesta documentada

---

## 📋 TEXTO COMPLETO DE LA CGR (Observación 15) vs. CONTRA-ARGUMENTACIÓN

La Contraloría General de la República formuló 6 razones de "no uso" de los módulos y concluyó que **ninguna es legalmente justificada**, sino que evidencia **"falta de gestión por parte de la Entidad"**.

A continuación se rebate CADA punto con evidencia documental:

---

## ❖ PUNTO 1 CGR: "Las direcciones únicamente trabajaron apoyando en el suministro de información y no recibieron los módulos para su operación"

### Reproducción textual CGR:
> "Las direcciones únicamente trabajaron apoyando en el suministro de información y no recibieron los módulos para su operación."

### CONTRA-ARGUMENTO 1.1: Los módulos de software a medida NO se "reciben" como un producto físico

La CGR aplica una lógica de **compra de bienes muebles** a un contrato de **desarrollo de software institucional**. En un desarrollo de software a medida:

- **NO existe una "entrega física"** que se "recibe" como un vehículo o un equipo.
- **La "recepción" es un proceso técnico**: despliegue en servidores, configuración de bases de datos, integración con sistemas legados (VIGIA), asignación de permisos, pruebas de funcionalidad.
- **Las áreas funcionales NO son las receptoras técnicas**: La OTIC (Oficina de Tecnologías de la Información) es el área técnicamente responsable de la recepción, configuración y puesta en producción de sistemas informáticos.

**Evidencia:** El Capítulo 9 del Contrato 362-2024 establece que la OTIC, a través de su Jefe (Supervisor), es la encargada del seguimiento técnico. Las áreas funcionales (VIC, Infraestructura, Jurídica) son **usuarias finales**, no receptoras técnicas.

*(Acta de Inicio Contrato 362-2024, Capítulo 9 — Funciones del Supervisor)*

### CONTRA-ARGUMENTO 1.2: Las áreas SÍ cumplieron con suministrar información

La CGR reconoce implícitamente que las áreas "trabajaron apoyando en el suministro de información". Esto demuestra que:

- **Hubo coordinación** entre contratista (UTP) y áreas funcionales.
- **Las áreas aportaron insumos** para el desarrollo de los módulos.
- **El "no uso" NO obedece a desidia**, sino a que la información suministrada requiere ser procesada, cargada, parametrizada y entrenada en modelos de IA.

**Evidencia documental:** La OAJ (Oficina Asesora Jurídica) entregó:
- Versión consolidada inicial de información jurídica
- Versión reorganizada y clasificada conforme a especificaciones técnicas de la OTIC

*(Oficio 20265000234971 — Respuesta OAJ, citado en oficio CGR)*

### CONTRA-ARGUMENTO 1.3: La responsabilidad de "entrega para operación" es de la OTIC, no de las áreas funcionales

La CGR confunde **roles institucionales**:

| Rol | Responsabilidad |
|---|---|
| Áreas funcionales (VIC, Jurídica, Infraestructura) | Definir requerimientos, suministrar información de negocio, validar funcionalidad |
| OTIC / Supervisor | Recibir técnicamente los módulos, desplegar en infraestructura, configurar, parametrizar, integrar con sistemas existentes |
| Contratista (UTP) | Desarrollar, entregar código fuente, documentar, capacitar |

**Conclusión:** Si las áreas "no recibieron los módulos para su operación", la responsabilidad recae en la **cadena de despliegue técnico** (OTIC → Infraestructura TI), no en una "falta de gestión" generalizada de la Entidad.

---

## ❖ PUNTO 2 CGR: "La no entrega formal de los módulos a las áreas operativas"

### Reproducción textual CGR:
> "La no entrega formal de los módulos a las áreas operativas."

### CONTRA-ARGUMENTO 2.1: ¿Qué significa "entrega formal" en desarrollo de software?

La CGR parece esperar un **acta de entrega física** tipo "recibí un lote de mercancía". En desarrollo de software institucional:

- La "entrega" se materializa en: acceso a repositorios de código, despliegue en servidores de prueba, demos funcionales, documentación técnica.
- Los módulos fueron **implementados** (la CGR misma lo verificó: "pese a que todos fueron implementados").
- La "entrega a áreas operativas" requiere: parametrización con datos reales, integración con VIGIA, pruebas de usuario (UAT), aprobación de cambio a producción.

**Esto es un proceso técnico de implementación, no una "entrega formal" que se hace con un simple oficio.**

*(Verificación CGR visitas técnicas 20-22/04/2026 — todos los módulos implementados)*

### CONTRA-ARGUMENTO 2.2: La CGR verificó que los módulos están implementados

> "pese a que todos fueron implementados" — CGR, Observación 15

**Contradicción interna de la CGR:**
- Dice que "no se entregaron formalmente"
- Pero reconoce que "todos fueron implementados"

**Resolución de la contradicción:** Los módulos fueron implementados técnicamente (existen, corren, tienen código), pero NO están en **producción operativa** porque falta la fase de apropiación institucional (parametrización, integración, entrenamiento, autorización de cambio).

---

## ❖ PUNTO 3 CGR: "Persistencia de Fallas reportadas, porque se debían implementar algunos ajustes tecnológicos en los módulos para poder ponerlos en producción"

### Reproducción textual CGR:
> "Persistencia de Fallas reportadas, porque se debían implementar algunos ajustes tecnológicos en los módulos para poder ponerlos en producción."

### CONTRA-ARGUMENTO 3.1: ¿Quién reportó las fallas y qué hizo al respecto?

La existencia de **fallas reportadas** demuestra que:
1. **Hubo un proceso de pruebas** (testing) funcional.
2. **Se identificaron incidencias** técnicas.
3. **Se requirieron ajustes** (fixes, patches, parametrizaciones).

**Esto es NORMAL en desarrollo de software.** No es evidencia de "falta de gestión", sino de **gestión técnica adecuada**.

### CONTRA-ARGUMENTO 3.2: El Supervisor emitió Requerimiento de Cumplimiento con 19 observaciones técnicas

El Supervisor del contrato (Urias Romero Hernández) NO se quedó pasivo ante las fallas. Emitió un **Requerimiento de Cumplimiento** con **diecinueve (19) observaciones técnicas específicas** por módulo, exigiendo correcciones a la UTP.

**Esto demuestra supervisión activa, no pasiva.**

*(Requerimiento de Cumplimiento del Supervisor Contrato 362-2024 — documento disponible)*

### CONTRA-ARGUMENTO 3.3: Las fallas en software son inherentes a la complejidad del desarrollo

Los módulos desarrollados incluyen:
- Inteligencia Artificial (IA Abogado, OCR)
- Integración con sistemas legados (VIGIA)
- Procesamiento de datos masivos (Universo de Vigilados)
- Algoritmos actuariales complejos

**No es razonable esperar que un sistema de esta magnitud (10 módulos, 9.5 meses de desarrollo) esté 100% libre de fallas al momento de la entrega.** La metodología PMV justifica entregas iterativas con ajustes posteriores.

---

## ❖ PUNTO 4 CGR: "Falta de parametrización y autorizaciones, porque no se evidenció la incorporación de los parámetros técnicos establecidos en la normatividad requeridos para el correcto funcionamiento"

### Reproducción textual CGR:
> "Falta de parametrización y autorizaciones, porque no se evidenció la incorporación de los parámetros técnicos establecidos en la normatividad requeridos para el correcto funcionamiento."

### CONTRA-ARGUMENTO 4.1: La parametrización requiere datos institucionales

Los módulos de la Superintendencia de Transporte NO pueden funcionar con datos genéricos. Requieren:

| Módulo | Parámetros requeridos | Fuente de datos |
|---|---|---|
| IA Abogado | Normativa jurídica del sector transporte, jurisprudencia, conceptos institucionales | OAJ |
| Visitas de Inspección | Formato de visitas, checklists, rutas de supervisión, perfiles de vigilados | VIC / Delegaturas |
| Infraestructura de Transporte | Tipos de infraestructura, indicadores de estado, umbrales de alerta | Infraestructura |
| Alta Temporada, Tarifas y Costos | Tarifas reguladas, datos históricos de demanda, rutas | VIC / Tarifas |
| Cálculos Actuariales | Fórmulas actuariales, tablas de mortalidad, reservas técnicas | VIC / Actuarial |
| Sancionatorio | Tipos de sanciones, procedimientos, tiempos de respuesta | Jurídica / VIC |

**La parametrización es un trabajo conjunto** entre:
- **Contratista (UTP):** Tecnología, código, estructura de datos
- **Áreas funcionales:** Contenido, reglas de negocio, normativa
- **OTIC:** Infraestructura técnica, seguridad, integración

### CONTRA-ARGUMENTO 4.2: Las áreas SÍ aportaron parámetros

La CGR cita textualmente que las áreas "trabajaron apoyando en el suministro de información". Esta información ES el insumo para la parametrización.

**Ejemplo: OAJ cumplió con información jurídica**

> "La OAJ cumplió oportuna y diligentemente con su responsabilidad de proveer la información jurídica necesaria para el adiestramiento del módulo 'IA Abogado', tanto en su versión consolidada inicial como en la versión reorganizada y clasificada conforme a las especificaciones técnicas requeridas por la OTIC."

*(Oficio 20265000234971 — Respuesta OAJ)*

**Pregunta para la CGR:** Si las áreas SÍ suministraron información, ¿dónde está la evidencia de que la OTIC la incorporó a los módulos? ¿Se le requirio formalmente a la OTIC que completara la parametrización?

### CONTRA-ARGUMENTO 4.3: La "autorización" es un trámite de gobierno TI

La "falta de autorizaciones" mencionada por la CGR probablemente se refiere a:
- Autorización de cambio (change management) para poner en producción
- Aprobación de seguridad de la información
- Homologación con arquitectura institucional

**Estos trámites dependen del Comité de Gobierno Digital / OTIC**, no de las áreas funcionales ni del Supervisor del contrato. Si estos trámites no se completaron, la responsabilidad recae en la estructura de gobierno TI de la entidad, no en una "falta de gestión" de la ejecución contractual.

---

## ❖ PUNTO 5 CGR: "Falta de integración funcional general de los módulos y las necesidades operativas especializadas de las áreas"

### Reproducción textual CGR:
> "Falta de integración funcional general de los módulos y las necesidades operativas especializadas de las áreas."

### CONTRA-ARGUMENTO 5.1: La integración con VIGIA es un proyecto separado

La Superintendencia de Transporte tiene un sistema legado central: **VIGIA** (Sistema de Información para la Vigilancia de la Actividad de los Agentes del Transporte).

La integración de 10 módulos nuevos con VIGIA requiere:
- Análisis de APIs existentes
- Mapeo de datos
- Desarrollo de interfaces
- Pruebas de integración
- Migración de datos históricos

**Esto NO era parte del objeto contractual del 362-2024.** El contrato era de desarrollo de los módulos del Sistema de Supervisión Inteligente, NO de integración total con VIGIA.

**La integración funcional general es un proyecto de mayor envergadura** que requiere:
- Presupuesto adicional
- Tiempo adicional
- Coordinación institucional (no solo contractual)

### CONTRA-ARGUMENTO 5.2: Las "necesidades operativas especializadas" evolucionan

Las áreas funcionales de la Superintendencia tienen procesos complejos que:
- **Evolucionan** con la normativa (decretos, resoluciones)
- **Varían** por tipo de vigilado (transporte terrestre, aéreo, marítimo, ferroviario)
- **Dependen** de la Delegatura (Bogotá, Medellín, Cali, Barranquilla)

**No es razonable esperar que un contratista externo (UTP) conozca en 9.5 meses TODAS las necesidades operativas especializadas** de una entidad regulatoria tan compleja. La metodología PMV contempla que las necesidades se van descubriendo iterativamente.

---

## ❖ PUNTO 6 CGR: "Falta de adiestramiento de algunos módulos para no afectar la operación"

### Reproducción textual CGR:
> "Falta de adiestramiento de algunos módulos para no afectar la operación."

### CONTRA-ARGUMENTO 6.1: "Adiestramiento de módulos" = Entrenamiento de IA

La CGR usa el término "adiestramiento" en sentido coloquial. Técnicamente, se refiere al **entrenamiento de modelos de Inteligencia Artificial**:

- **IA Abogado:** Modelo de lenguaje que requiere entrenamiento con documentos jurídicos de la Supertransporte para dar respuestas precisas.
- **OCR:** Modelo de reconocimiento óptico de caracteres que requiere entrenamiento con formatos de documentos institucionales.

### CONTRA-ARGUMENTO 6.2: El entrenamiento de IA requiere datos institucionales que la OTIC debe cargar

> "En ausencia de dicho adiestramiento, la herramienta no alcanza los niveles de precisión y confiabilidad requeridos para su uso en el ámbito jurídico institucional, razón por la cual su utilización se encontraba condicionada a la incorporación de las bases de datos y parámetros jurídicos por parte de la Oficina de Tecnologías de la Información y las Comunicaciones (OTIC), área técnicamente responsable de dicha operación."

*(Oficio 20265000234971 — Respuesta OAJ)*

**La OAJ entregó la información. La OTIC debió cargarla en el modelo.** Si esto no ocurrió, es una cuestión de coordinación interna entre OAJ y OTIC, NO de "falta de gestión" del contrato 362-2024.

### CONTRA-ARGUMENTO 6.3: El entrenamiento de IA NO es parte del desarrollo inicial

En un contrato de desarrollo de software:
- **Fase 1 (alcance del 362-2024):** Desarrollar el modelo de IA, la arquitectura, las interfaces.
- **Fase 2 (apropiación institucional):** Entrenar el modelo con datos reales, ajustar parámetros, validar precisión.

**La Fase 2 excede la vigencia contractual de 9.5 meses.** Es responsabilidad institucional post-contractual.

---

## 🎯 REBUTAL CENTRAL A LA CONCLUSIÓN CGR

### Conclusión CGR:
> "Ninguno de los argumentos indicados por las áreas presenta una excusa legalmente justificada, sino que evidencian una falta de gestión por parte de la Entidad, para la socialización, entrega, y uso del sistema adquirido, además de evidenciar que existen posibles fallas en la construcción de algunos módulos o falta de parametrización en otros, lo que implicaría que el sistema (módulos) no están al 100% operativos."

### CONTRA-ARGUMENTO CENTRAL 1: La CGR confunde "gestión contractual" con "gestión institucional post-contractual"

| Gestión contractual (responsabilidad del Supervisor / Comité Técnico) | Gestión institucional post-contractual (responsabilidad de la Entidad como institución) |
|---|---|
| Seguimiento de desarrollo | Parametrización con datos reales |
| Revisión de entregables | Integración con sistemas legados |
| Certificación de pagos | Entrenamiento de modelos de IA |
| Emisión de requerimientos | Autorizaciones de gobierno TI |
| Evaluación técnica | Socialización a escala nacional |
| Cierre contractual | Apropiación por delegaturas |

**El Contrato 362-2024 cubrió la gestión contractual.** La CGR le está atribuyendo responsabilidad por la gestión institucional post-contractual, que es un proceso más amplio que involucra a toda la entidad y excede la vigencia del contrato.

### CONTRA-ARGUMENTO CENTRAL 2: La CGR cita como "causa" las deficiencias en planeación contractual

> "La situación se originó por deficiencias en la planeación contractual y en la elaboración de los estudios previos, particularmente en la identificación de necesidades reales y en la definición del alcance de los módulos requeridos."

**FALSO. Evidencia de planeación exhaustiva:**

| Documento de planeación | Fecha | Contenido |
|---|---|---|
| PETI V.2.0 | 17/09/2024 | Plan Estratégico de TI con OE-01: VIC como motor de cambio tecnológico |
| Estudio Previo (Anexo Técnico) | 2024 | Definición detallada de 15 productos, plazos, metodología PMV |
| Matriz de Riesgo | Febrero 2024 | Identificación de riesgos del Proceso 528 |
| CDP 50424 | 28/02/2024 | Certificación financiera por $4.100M |
| RP 62924 | 15/03/2024 | Reserva presupuestal por $4.100M |
| Acta de Inicio | 02/04/2024 | Aprobación del plan operativo y cronograma |
| Comunicado No. 001 | 02/08/2024 | Constitución Comité Técnico con 10+ miembros |

**La CGR MISMO cita el estudio de necesidad** que justificó el contrato. Si el estudio de necesidad existía, ¿dónde está la deficiencia en planeación?

### CONTRA-ARGUMENTO CENTRAL 3: La CGR cita como "causa" debilidades en la supervisión

> "Asimismo, se evidencian debilidades en la supervisión del contrato, lo que impidió garantizar la utilización total del software adquirido."

**FALSO. Evidencia de supervisión exigente:**

| Evidencia de supervisión | Descripción |
|---|---|
| 4 pagos certificados | $4.100M certificados con "recibido a satisfacción" |
| Requerimiento Supervisor | 19 observaciones técnicas específicas por módulo |
| Comunicado No. 001 | Evaluación detallada: 7 productos aceptados, 9 rechazados |
| Grabaciones octubre 2024 | Sesiones de seguimiento de módulos por módulo |
| Requerimiento Cumplimiento | Exigencia formal de correcciones a UTP |

**La supervisión NO garantiza la "utilización total" post-contractual.** El Supervisor certifica la EJECUCIÓN contractual, no la APROPIACIÓN institucional posterior.

### CONTRA-ARGUMENTO CENTRAL 4: La CGR cuantifica el detrimento por el VALOR TOTAL del contrato

> "...dado que la cuantificación del valor del contrato no se estableció por productos o entregables, sino un valor total, se cuantifica el daño por el total de la contratación ($ 4.100.000.000), que se constituye en un detrimento patrimonial."

**ERROR DE BASE EN LA CUANTIFICACIÓN:**

El contrato incluyó:
- **10 módulos de software** (desarrollo)
- **Modelo de Gestión y Gobierno TI** (consultoría estratégica)
- **Estrategia de Gobierno Digital** (consultoría estratégica)
- **Plan Estratégico de TI (PETI)** (consultoría estratégica)
- **30 indicadores de supervisión** (consultoría analítica)
- **10 reportes del Observatorio** (consultoría analítica)

**Los productos de consultoría estratégica (ítems 11-15) fueron entregados y aceptados.** Su valor debe ser descontado de cualquier cuantificación de detrimento.

**Además:**
- 2 módulos (Universo de Vigilados y Financiero) están OPERATIVOS.
- Los otros 8 módulos fueron DESARROLLADOS e IMPLEMENTADOS técnicamente (la CGR lo verificó).
- El "no uso operativo" responde a fases técnicas posteriores (parametrización, integración, entrenamiento IA).

**Cuantificar $4.100M como detrimento es jurídicamente incorrecto.** El detrimento, en caso de existir, debería calcularse proporcionalmente sobre el valor de los servicios NO ejecutados, NO sobre el valor total del contrato.

---

## 📋 RESUMEN EJECUTIVO DE CONTRA-ARGUMENTACIÓN

| Punto CGR | Conclusión CGR | Nuestra Contra-Argumentación | Evidencia |
|---|---|---|---|
| 1. Direcciones no recibieron módulos | Falta de gestión | Las áreas funcionales NO son receptoras técnicas; la OTIC sí. Las áreas SÍ suministraron información. | Acta Inicio Cap. 9; Oficio 20265000234971 (OAJ) |
| 2. No entrega formal | Falta de gestión | "Implementados" ≠ "en producción". La entrega formal en software es un proceso técnico, no un acta simple. | Verificación CGR visitas técnicas |
| 3. Fallas reportadas | Fallas en construcción | Las fallas se identificaron, se reportaron y se requirieron correcciones (19 observaciones Supervisor). | Requerimiento Supervisor 19 observaciones |
| 4. Falta parametrización | Falta de gestión | La parametrización requiere datos institucionales que la OTIC debe cargar. Las áreas SÍ aportaron información. | Oficio 20265000234971 (OAJ, áreas) |
| 5. Falta integración | Falta de gestión | La integración con VIGIA NO era parte del objeto contractual. Es un proyecto mayor. | Anexo Técnico — objeto contractual |
| 6. Falta adiestramiento | Falta de gestión | El "adiestramiento" es entrenamiento de IA que requiere cargar datos en modelos. Es fase post-contractual. | Oficio 20265000234971 (OAJ) |
| Causa: Deficiencia planeación | CGR concluye | FALSO. Existen PETI, Estudio Previo, Matriz Riesgo, CDP, RP, Comité Técnico. | PETI V.2.0; Matriz Riesgo; CDP 50424; RP 62924 |
| Causa: Debilidad supervisión | CGR concluye | FALSO. 4 pagos certificados, 19 observaciones, Comunicado No. 001 evaluativo. | Soportes de pago; Requerimiento Supervisor |
| Efecto: Detrimento $4.100M | CGR cuantifica | INCORRECTO. El contrato incluyó consultoría estratégica entregada. Los módulos fueron desarrollados. | Anexo Técnico ítems 11-15 |

---

**Documento preparado por:** ZEUS — INNOVADATACO  
**Fecha:** 19 de mayo de 2026  
**Clasificación:** Análisis forense para defensa institucional — Confidencial

---

> ⚡ **"La CGR aplica una lógica de compra de bienes a un contrato de servicios de transformación digital. Concluye 'falta de gestión' pero no distingue entre gestión contractual (que fue exigente y documentada) y gestión institucional post-contractual (que excede la vigencia del contrato y depende de la estructura de gobierno TI de la Entidad)."** — ZEUS
