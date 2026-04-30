# FICHA TÉCNICA PILOTO — CC-01: CCTV (Vigilancia por Video)
## APP-CHIA-GIRARDOT | Entregable #2 — Especificación de Componentes ITS

---

## 1. IDENTIFICACIÓN DEL COMPONENTE

| Campo | Valor |
|-------|-------|
| **COD** | CC-01 |
| **Sigla (Estándar Internacional)** | CCTV |
| **Nombre del Componente** | Vigilancia por Video |
| **Capacidad Operativa Generada** | Supervisión Visual Continua: Capacidad de observar y verificar el estado real de la infraestructura en tiempo real. |

---

## 2. DESCRIPCIÓN FUNCIONAL / TÉCNICA

### Descripción del Componente

El sistema de CCTV para el corredor Chía–Mondoñedo–Girardot constituye la capa de percepción visual del ecosistema ITS. Su función primaria es proporcionar visibilidad continua, en tiempo real y con resolución suficiente, del estado de la vía, el tráfico, las condiciones meteorológicas adversas y la ocurrencia de incidentes. El sistema se integra con el Centro de Control y Operaciones (CCO) como fuente de verificación visual para los 15 Escenarios Operativos de Validación (EOV) definidos en el Concepto de Operación.

### Alcance de la Solución

El componente CC-01 se despliega en puntos estratégicos del corredor identificados como críticos: zonas de convergencia de carriles, puentes y viaductos, intersecciones semaforizadas, zonas de peaje, tramos de alta sinuosidad, zonas con riesgo geotécnico identificado y sectores con historial de alta accidentalidad. La solución combina cámaras fijas de cobertura amplia con cámaras PTZ (Pan-Tilt-Zoom) de seguimiento dinámico, operando bajo una arquitectura de red IP que transmite video comprimido H.265 hacia el CCO a través de la red troncal de fibra óptica del corredor.

### Justificación Estratégica

La vigilancia por video es el pilar de verificación para el Sistema de Gestión de Incidentes (EOV-03, EOV-04, EOV-05) y el Sistema de Información al Usuario (EOV-09, EOV-10). Sin visibilidad visual confirmada, los operadores del CCO no pueden validar alertas generadas por sensores automáticos (CC-02 AID, CC-05 VDS), lo que incrementa los tiempos de respuesta y el riesgo de escalamiento de incidentes. La implementación de CCTV de alta definición reduce la dependencia de patrullaje físico, optimiza la asignación de recursos de emergencia y genera evidencia forense para análisis post-incidente.

### Referencia de Mercado (Genérica)

| Atributo | Valor |
|----------|-------|
| **Tipo de dispositivo** | Cámara de red IP PTZ de uso profesional para infraestructura vial |
| **Experiencia de implementación** | Concesiones viales de Colombia (Bogotá/Nacional) — Redes de vigilancia vial para concesiones de alta densidad |
| **Observación** | La selección final del fabricante se realizará en etapa de licitación de obra, garantizando cumplimiento de especificaciones técnicas sin restricción de marca |

---

## 3. REQUERIMIENTOS FUNCIONALES (RF)

### RF-1 — Captura continua 24/7
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe capturar video de forma ininterrumpida las 24 horas del día, los 7 días de la semana, sin pausas programadas ni ventanas de mantenimiento que interrumpan la operación. La grabación debe ser continua y no por eventos, garantizando histórico completo. |
| **Justificación Estratégica** | Los incidentes viales no ocurren en horarios predecibles. La interrupción del video, aunque sea por mantenimiento programado, deja al CCO ciego ante eventos críticos. La continuidad operativa es mandatoria para cumplir el EOV-03 (Respuesta a Incidentes). |

### RF-2 — Resolución mínima 4K (8 MP)
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras deben capturar video con resolución mínima de 3840 × 2160 píxeles (4K / 8 megapíxeles) a 30 fps. Esta resolución debe mantenerse tanto en modo diurno como nocturno, sin degradación por condiciones de iluminación baja. |
| **Justificación Estratégica** | A 308 km de corredor, la identificación visual de placas, señales, rostros de conductores y detalles de vehículos requiere alta definición. Resoluciones inferiores a 4K impiden la verificación forense y la integración con el sistema ALPR (CC-12). |

### RF-3 — Control PTZ remoto desde CCO
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras PTZ deben permitir control remoto de Pan (360°), Tilt (±90°) y Zoom óptico mínimo 30x desde la consola del CCO. El control debe tener latencia menor a 500 ms y permitir preset positions preprogramadas para puntos críticos. |
| **Justificación Estratégica** | En incidentes dinámicos (EOV-04: Incendio vehicular, EOV-05: Derrumbe), el operador del CCO necesita reorientar la cámara hacia la zona afectada sin depender de personal de campo. El zoom óptico permite acercamiento sin pérdida de resolución para verificar condiciones a distancia. |

### RF-4 — Visión nocturna con iluminación IR integrada
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe operar en condiciones de iluminación cero (0 lux) mediante iluminación infrarroja (IR) integrada con alcance mínimo de 150 metros. Con iluminador supletorio adicional, el alcance debe alcanzar mínimo 200 metros. La transición día/noche debe ser automática, sin interrupción del stream de video ni parpadeo. |
| **Justificación Estratégica** | El 40% del corredor atraviesa zonas rurales sin iluminación pública. Los incidentes nocturnos representan el 60% de los siniestros fatales en corredores viales colombianos (INVIAS, 2023). La operación nocturna sin interrupción es mandatoria para la seguridad vial integral. |

### RF-5 — Analítica de video integrada (IA Edge)
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | La cámara debe incluir capacidad de procesamiento de video en el borde (edge computing) para detección automática de: vehículos detenidos, tránsito en contravía, peatones en calzada, formación de colas, caída de objetos y comportamiento anómalo. Las alertas deben transmitirse al CCO en menos de 2 segundos. |
| **Justificación Estratégica** | La detección automática reduce la latencia entre ocurrencia del evento y notificación al operador. Sin analítica integrada, el CCO depende exclusivamente de la atención visual humana, lo que introduce tiempos de reacción de 3–5 minutos vs. <30 segundos con IA. Esto habilita el EOV-03 (Respuesta a Incidentes) y el EOV-11 (Gestión de Congestión). |

### RF-6 — Integración nativa con plataforma CCO
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe exponer streams de video mediante protocolos estándar (ONVIF Profile S/G, RTSP sobre TCP/UDP) para integración con la plataforma de video management (VMS) del CCO. Debe soportar APIs REST para consulta de estado, configuración remota y extracción de metadatos de analítica. |
| **Justificación Estratégica** | La interoperabilidad es un requisito del marco IFC (World Bank No. 7216694). El CCO opera como sistema integrador; los componentes que no hablen protocolos estándar generan costos de integración no previstos y riesgo de obsolescencia tecnológica. ONVIF asegura compatibilidad multi-marca y sustitución sin vendor lock-in. |

### RF-7 — Resistencia ambiental IP66/IP67
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras de campo deben cumplir grado de protección IP66 (polvo total y chorros de agua) o IP67 (inmersión temporal). Deben operar en rango de temperatura de -30°C a +60°C, con resistencia a vibración (ISO 16750-3), impacto de granizo (IK10) y corrosión atmosférica (prueba de niebla salina 500h). |
| **Justificación Estratégica** | El corredor atraviesa zonas climáticas diversas: altiplano cundiboyacense (Bogotá/Chía: frío, lluvia, granizo) y valle del Magdalena (Girardot: calor extremo, polvo, humedad). Los fallos por condición ambiental generan costos de mantenimiento no planificado y dejan puntos ciegos en la red de vigilancia. |

### RF-8 — Grabación con retención mínima 30 días
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe almacenar video histórico con retención mínima de 30 días calendario en resolución 4K, con compresión H.265 para optimización de ancho de banda y espacio de almacenamiento. Debe permitir exportación de clips de video con marca de tiempo sincronizada con NTP. |
| **Justificación Estratégica** | La investigación de incidentes, las reclamaciones de seguros y las auditorías de cumplimiento (Resolución 28675 de 2022) requieren acceso a video histórico. Un período de retención menor a 30 días deja expuesta a la concesión ante procesos legales y dificulta el análisis de patrones de tráfico para optimización operativa. |

### RF-9 — Generación de alertas multi-canal
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe generar alertas configurables por tipo de evento (detección, intrusión, fallo de cámara) y distribuirlas por múltiples canales: dashboard del CCO, notificación push al operador de turno, integración con sistema de megafonía (CC-17 PAS) y registrarse en log de incidentes del CCO. |
| **Justificación Estratégica** | La detección de un evento sin acción correctiva es inútil. La multiplicidad de canales de alerta asegura que el operador reciba la notificación independientemente de su ubicación o actividad actual. La integración con PAS permite activar mensajes de advertencia automáticos si se detecta peatón en calzada (EOV-08). |

### RF-10 — Redundancia de enlace y respaldo local
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe contar con redundancia de enlace de red (fibra óptica primaria + radiofrecuencia/CC-24 como respaldo) y almacenamiento local en edge (SD/microSD o NAS local) que continúe grabando incluso si se pierde conectividad con el CCO. Sincronización automática al restablecerse el enlace. |
| **Justificación Estratégica** | Los cortes de fibra óptica por terceros, derrumbes o mantenimiento son eventos frecuentes en corredores viales colombianos. Sin redundancia de enlace y almacenamiento local, el CCO queda ciego ante incidentes que ocurren durante la interrupción, con consecuencias potencialmente fatales. |

---

## 4. REQUERIMIENTOS NO FUNCIONALES (RNF)

### RNF-1 — Disponibilidad ≥ 99.9%
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema CCTV en su conjunto (cámaras, enlaces, almacenamiento, VMS) debe mantener una disponibilidad operativa igual o superior al 99.9% medido mensualmente, lo que equivale a un máximo de 43 minutos de indisponibilidad por mes. |
| **Justificación Estratégica** | La disponibilidad del CCTV impacta directamente la capacidad de respuesta del CCO. Un 99.9% es el estándar mínimo para sistemas de misión crítica en infraestructura vial. Disponibilidades inferiores generan periodos de ceguera operativa inaceptables para la seguridad de 308 km de corredor. |

### RNF-2 — Latencia de video en vivo ≤ 2 segundos
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El tiempo entre la captura de un fotograma en campo y su visualización en la consola del CCO debe ser menor o igual a 2 segundos, inclusive en condiciones de red congestionada o con pérdida de paquetes ≤ 1%. |
| **Justificación Estratégica** | En incidentes dinámicos (EOV-04: incendio, EOV-05: derrumbe), cada segundo cuenta. Una latencia superior a 2 segundos desfasa la toma de decisiones del operador con respecto a la realidad de campo, generando respuestas tardías o basadas en información obsoleta. |

### RNF-3 — Ciclo de vida mínimo 10 años
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Los componentes de campo (cámaras, gabinetes, fuentes de poder, conectores) deben tener una vida útil proyectada mínima de 10 años bajo condiciones ambientales del corredor, con soporte técnico y repuestos garantizados por el fabricante durante ese período. |
| **Justificación Estratégica** | El contrato de concesión del corredor opera en horizontes de 25–30 años. Reemplazar cámaras cada 3–5 años genera costos de CAPEX recurrentes no previstos, interrupciones de servicio y obsolescencia tecnológica prematura. Un ciclo de vida de 10 años alinea con la planificación financiera del proyecto. |

### RNF-4 — Consumo energético ≤ 150W por cámara PTZ
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El consumo eléctrico de cada cámara PTZ con IR activado, heater/ventilador y PTZ en movimiento continuo no debe exceder los 150W. Las cámaras fijas deben consumir ≤ 30W. El sistema debe soportar alimentación PoE++ (802.3bt, 90W) o fuente local con UPS. |
| **Justificación Estratégica** | El corredor atraviesa zonas donde la energía eléctrica es limitada o inestable. Un consumo excesivo multiplica el costo de infraestructura eléctrica (cableado, transformadores, paneles solares) y reduce la autonomía del sistema ante fallos de red eléctrica. El consumo controlado permite alimentación mediante micro-redes inteligentes (CC-39 MSG). |

### RNF-5 — Ancho de banda por cámara ≤ 8 Mbps (4K H.265)
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El stream de video 4K comprimido en H.265 debe consumir un ancho de banda máximo de 8 Mbps por cámara en operación normal. En caso de escena de alta complejidad (lluvia, niebla, movimiento masivo), el pico no debe exceder 12 Mbps. Debe soportar VBR (Variable Bit Rate) controlado. |
| **Justificación Estratégica** | La red troncal de fibra óptica del corredor debe transportar video de cientos de cámaras + datos de sensores + voz + control. Un consumo desmedido de ancho de banda por cámara satura la red, genera latencia en otros servicios críticos (comunicaciones emergencia CC-04) y obliga a sobredimensionar la infraestructura de comunicaciones, elevando CAPEX. |

### RNF-6 — Ciberseguridad: cifrado end-to-end y hardening
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Los streams de video deben cifrarse mediante TLS 1.3 en tránsito y AES-256 en almacenamiento. Las cámaras deben soportar autenticación multifactor (MFA) para acceso administrativo, firmas de firmware, bloqueo de puertos no esenciales y registro de auditoría de accesos (ISO 27001, NIST CSF). |
| **Justificación Estratégica** | El sistema CCTV es un vector de alto riesgo cibernético: acceso no autorizado permite vigilancia del CCO por actores maliciosos, manipulación de evidencia, o extorsión. Un breach de seguridad en el sistema de video compromete la integridad operativa del corredor y expone información sensible de usuarios (privacidad, protección de datos personales). |

### RNF-7 — Escalabilidad: capacidad de expansión ≥ 200%
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | La arquitectura de video debe permitir la adición de nuevas cámaras (hasta el 200% de la cantidad inicial) sin rediseño de la red troncal, el VMS ni el almacenamiento. La expansión debe realizarse mediante configuración, sin interrupción del servicio existente. |
| **Justificación Estratégica** | El corredor Chía–Girardot incluye vías colectoras, ramales y futuras ampliaciones (variante de Cota, Soacha). Una arquitectura rígida que requiera rediseño completo para cada ampliación genera costos de integración prohibidos y pone en riesgo la continuidad operativa durante las expansiones. |

---

## F. REFERENCIAS DE MERCADO VALIDADAS

Equipos reales consultados para elaboración de esta ficha técnica genérica. Las marcas se indican solo como referencia de investigación; la ficha permanece genérica y abierta para licitación.

| EQ | Tipo de Equipo Revisado | Características Clave Verificadas | Fuente |
|----|------------------------|-----------------------------------|--------|
| EQ-01 | Cámara IP PTZ para infraestructura vial | 4K, 30x zoom, IR 250m, IP66/67, ONVIF, analítica edge (detección vehículos/personas) | ONVIF Profile S/G conformance, ficha técnica de fabricante líder en videovigilancia industrial |
| EQ-02 | Cámara IP fija de borde para carreteras | 4K, H.265, WDR 140dB, IK10, -40°C a +60°C, PoE++ | Catálogo técnico de proveedor especializado en ITS de Latinoamérica |
| EQ-03 | Cámara PTZ con radar integrado (video+radar) | 4K, 360° PTZ, radar 250m, analítica IA (clasificación 8 clases), ONVIF | Documentación técnica de solución ITS implementada en concesiones viales de Chile y México |

### Documentación de Referencia Oficial

| Documento | Enlace / Referencia |
|-----------|---------------------|
| ONVIF Profile S (Video Streaming) | https://www.onvif.org/profiles/profile-s/ |
| ONVIF Profile G (Recording & Storage) | https://www.onvif.org/profiles/profile-g/ |
| Resolución 28675 de 2022 (Colombia) | Ministerio de Transporte de Colombia — Reglamento Técnico de Sistemas Inteligentes de Transporte |
| INVIAS — Guía de Seguridad Vial ITS | Instituto Nacional de Vías de Colombia |
| ISO 16750-3 — Pruebas ambientales vehiculares | International Organization for Standardization |
| NIST Cybersecurity Framework | National Institute of Standards and Technology — Ciberseguridad infraestructura crítica |

### Disclaimer

> La selección final del fabricante y modelo se realizará en etapa de licitación de obra, garantizando cumplimiento de las especificaciones técnicas definidas en esta ficha sin restricción de marca. Las referencias EQ-01, EQ-02, EQ-03 son ilustrativas y no constituyen recomendación de compra.

---

## 5. RESUMEN EJECUTIVO DEL COMPONENTE

| Atributo | Valor |
|----------|-------|
| **Dominio de Sistema** | D.1 — Percepción/Sensores |
| **Servicios Estratégicos** | ATMS (Gestión de Tráfico), IM (Gestión de Incidentes), Safety (Seguridad Vial), Management (Operación CCO) |
| **Funciones mínimas vinculadas** | F.1.1 (Detección de tráfico), F.1.3 (Identificación de incidentes), F.2.1 (Transmisión de video), F.4.2 (Control de cámaras), F.5.1 (Información visual al usuario) |
| **EOV habilitados** | EOV-01 (Monitoreo Normal), EOV-03 (Respuesta a Incidentes), EOV-04 (Incendio Vehicular), EOV-05 (Derrumbe), EOV-08 (Peatón en Calzada), EOV-11 (Congestión) |
| **TOR elementos cubiertos** | 5.2.1.22 — ítem 2 (CCTV puntos críticos) |
| **Interoperabilidad** | ONVIF Profile S/G, RTSP, REST API, integración con CCO-VMS, AID (CC-02), PAS (CC-17), ALPR (CC-12) |
| **Dependencias** | CC-23 (FOC) para red troncal, CC-35 (UPS) para respaldo energético, CC-21 (CSG/IoT) para ciberseguridad |

---

*InnovaDataCO PMO IA | Ficha Técnica Piloto — CC-01 CCTV | 2026-04-24*
*Elaborado para revisión del CEO antes de escalado a 42 componentes.*
