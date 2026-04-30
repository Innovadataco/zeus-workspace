# FICHA TÉCNICA ITS — CC-01: CCTV (Vigilancia por Video)

---

## 1. RESUMEN EJECUTIVO

El componente **CC-01 CCTV** constituye el sistema de percepción visual del corredor vial Chía–Girardot, proporcionando capacidad de observación continua, verificación de incidentes y generación de evidencia operativa. Este subsistema habilita la gestión proactiva de la seguridad vial mediante monitoreo en tiempo real de las condiciones de la infraestructura, el flujo vehicular y la ocurrencia de eventos anómalos a lo largo de los 308 km del corredor.

La vigilancia por video representa una capa crítica de validación para los sistemas de detección automática, permitiendo a los operadores del Centro de Control y Operaciones (CCO) confirmar alertas, evaluar situaciones de emergencia y coordinar respuestas sin depender exclusivamente de desplazamiento de personal de campo. La integración de tecnologías como resolución 4K, visión nocturna infrarroja, analítica de video con inteligencia artificial y resistencia ambiental garantiza operatividad continua en las condiciones climáticas y geográficas del corredor.

---

## 2. IDENTIFICACIÓN DEL COMPONENTE DE CAMPO

| Campo | Valor |
|-------|-------|
| **COD** | CC-01 |
| **Sigla (Estándar Internacional)** | CCTV |
| **Nombre del Componente** | Sistema de Videovigilancia |
| **Capacidad Operativa Generada** | Percepción visual continua del corredor vial con capacidad de detección, verificación y documentación de incidentes en tiempo real. |

---

## 3. DESCRIPCIÓN FUNCIONAL / TÉCNICA

### Alcance de la Solución

El sistema CCTV comprende un conjunto de cámaras de red IP desplegadas estratégicamente a lo largo del corredor, operando bajo una arquitectura de comunicaciones que transmite video comprimido hacia el Centro de Control y Operaciones. La solución integra cámaras de diferentes capacidades: fijas de cobertura amplia para vigilancia general, y cámaras PTZ (Pan-Tilt-Zoom) de seguimiento dinámico para zonas que requieren atención focalizada.

El subsistema opera las 24 horas del día, los 7 días de la semana, capturando video en resolución 4K con capacidad de visión nocturna mediante iluminación infrarroja. La transmisión utiliza compresión H.265 para optimizar el uso del ancho de banda de la red troncal de fibra óptica, mientras que el almacenamiento garantiza retención histórica para investigaciones y auditorías.

### Justificación Estratégica

La implementación de un sistema de videovigilancia robusto responde a la necesidad de mantener visibilidad permanente sobre un corredor de 308 km que atraviesa zonas con diversas condiciones operativas. La capacidad de verificación visual reduce los tiempos de respuesta ante incidentes, optimiza la asignación de recursos de emergencia y genera evidencia objetiva para análisis post-evento.

La integración de analítica de video con procesamiento en el borde (edge computing) permite la detección automática de situaciones críticas como vehículos detenidos, peatones en la vía, tránsito en contravía y formación de congestiones, generando alertas tempranas que complementan la percepción humana del operador. Esta capacidad de detección proactiva transforma al sistema de reactivo a preventivo, reduciendo la probabilidad de escalamiento de incidentes.

La resistencia ambiental del equipo garantiza operatividad en el rango térmico del corredor, que abarca desde zonas de altiplano con temperaturas que pueden presentar heladas ocasionales, hasta zonas de valle con temperaturas elevadas y alta humedad. La protección IP66/IP67 e IK10 asegura continuidad de servicio ante condiciones climáticas adversas y posibles impactos.

---

## 4. ESPECIFICACIÓN TÉCNICA

| Parámetro | Especificación Mínima |
|-----------|----------------------|
| **Resolución** | Mínimo 4K (8 megapíxeles) @ 30 fps |
| **Visión nocturna** | Iluminación IR integrada, alcance ≥ 150 metros |
| **Zoom óptico** | Mínimo 30x para cámaras PTZ |
| **Protección ambiental** | IP66/IP67, resistencia a impacto IK10 |
| **Rango térmico** | Operación continua -30°C a +60°C |
| **Compresión** | H.265 / H.265+ para optimización de ancho de banda |
| **Protocolos de comunicación** | ONVIF Profile S/G, RTSP, TCP/IP |
| **Alimentación** | PoE++ (802.3bt, 90W) o fuente AC 24V con respaldo UPS |
| **Consumo energético** | ≤ 150W (cámaras PTZ), ≤ 30W (cámaras fijas) |
| **Ancho de banda por cámara** | ≤ 8 Mbps en operación normal 4K H.265 |
| **Ciberseguridad** | Cifrado TLS 1.3 en tránsito, AES-256 en almacenamiento, autenticación multifactor |
| **Analítica integrada** | Detección de vehículos detenidos, peatones, contravía, colas, objetos |
| **Tiempo de alerta** | Generación de alertas en menos de 2 segundos |
| **Retención de video** | Mínimo 30 días de almacenamiento histórico con fácil acceso; posterior archivo en disco cumpliendo normativa del Archivo General de la Nación y política de retención documental |
| **Redundancia** | Enlace primario fibra óptica, enlace respaldo radiofrecuencia, almacenamiento local edge |

---

## 5. REQUERIMIENTOS FUNCIONALES (RF)

### RF-01 — Captura Continua 24/7
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe capturar video de forma ininterrumpida las 24 horas del día, los 7 días de la semana, sin ventanas de mantenimiento programado que interrumpan la operación. La grabación debe ser continua y no por eventos, garantizando histórico completo de la operación del corredor. |
| **Justificación Estratégica** | Los incidentes viales no ocurren en horarios predecibles. La interrupción del video, aunque sea por mantenimiento, deja al Centro de Control ciego ante eventos críticos. La continuidad operativa es mandatoria para garantizar la seguridad vial integral del corredor. |

### RF-02 — Resolución 4K (8 MP)
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras deben capturar video con resolución mínima de 3840 × 2160 píxeles (4K / 8 megapíxeles) a 30 cuadros por segundo. Esta resolución debe mantenerse tanto en modo diurno como nocturno, sin degradación por condiciones de baja iluminación. |
| **Justificación Estratégica** | La identificación visual de detalles críticos como placas vehiculares, señales de tránsito, condiciones de la vía y comportamiento de conductores requiere alta definición. Resoluciones inferiores limitan la capacidad de verificación forense y la integración con sistemas de reconocimiento automático. |

### RF-03 — Control PTZ Remoto desde CCO
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras PTZ deben permitir control remoto de Pan (360° continuo), Tilt (±90°) y Zoom óptico mínimo 30x desde la consola del Centro de Control. El control debe tener latencia menor a 500 milisegundos y permitir posiciones preprogramadas para puntos críticos. |
| **Justificación Estratégica** | En situaciones dinámicas que requieren atención inmediata, el operador necesita reorientar la cámara hacia la zona de interés sin depender de personal en campo. El zoom óptico permite acercamiento sin pérdida de resolución para evaluar condiciones a distancia. |

### RF-04 — Visión Nocturna con IR Integrado
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe operar en condiciones de iluminación cero (0 lux) mediante iluminación infrarroja integrada con alcance mínimo de 150 metros. Con iluminador supletorio, el alcance debe extenderse a 200 metros. La transición día/noche debe ser automática y sin interrupción. |
| **Justificación Estratégica** | Una porción significativa del corredor atraviesa zonas rurales sin iluminación pública. Los incidentes nocturnos representan un porcentaje elevado de siniestros fatales en corredores viales. La operación nocturna sin interrupción es esencial para la seguridad integral. |

### RF-05 — Analítica de Video con IA Edge
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | La cámara debe incluir capacidad de procesamiento de video en el borde para detección automática de: vehículos detenidos, tránsito en contravía, peatones en calzada, formación de colas, caída de objetos y comportamiento anómalo. Las alertas deben transmitirse al CCO en menos de 2 segundos. |
| **Justificación Estratégica** | La detección automática reduce drásticamente el tiempo entre la ocurrencia de un evento y su notificación al operador. Sin analítica integrada, el sistema depende exclusivamente de la atención visual humana, introduciendo tiempos de reacción de varios minutos versus segundos con inteligencia artificial. |

### RF-06 — Integración con Plataforma CCO
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe exponer streams de video mediante protocolos estándar (ONVIF Profile S/G, RTSP sobre TCP/UDP) para integración con la plataforma de gestión de video del CCO. Debe soportar APIs REST para consulta de estado, configuración remota y extracción de metadatos. |
| **Justificación Estratégica** | La interoperabilidad basada en estándares abiertos es requisito fundamental para sistemas de infraestructura crítica. El Centro de Control opera como integrador de múltiples subsistemas; la dependencia de protocolos propietarios genera costos de integración imprevistos y riesgo de obsolescencia tecnológica. |

### RF-07 — Resistencia Ambiental IP66/IP67
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Las cámaras de campo deben cumplir grado de protección IP66 (polvo total y chorros de agua) o IP67 (inmersión temporal). Deben operar en rango térmico de -30°C a +60°C, con resistencia a vibración, impacto de granizo (IK10) y corrosión atmosférica. |
| **Justificación Estratégica** | El corredor atraviesa zonas climáticas diversas: altiplano con presencia de heladas ocasionales y granizo; valle con temperaturas elevadas, polvo y humedad. Los fallos por condición ambiental generan costos de mantenimiento no planificado y crean puntos ciegos en la cobertura de vigilancia. |

### RF-08 — Grabación con Retención 30 Días y Archivo AGN
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe almacenar video histórico con retención mínima de 30 días calendario en resolución 4K con fácil acceso para consulta. Posteriormente, el material debe archivarse en disco o dispositivos de almacenamiento masivo, cumpliendo las normas del Archivo General de la Nación y la política de retención documental aplicable. |
| **Justificación Estratégica** | La investigación de incidentes, reclamaciones de seguros y auditorías de cumplimiento normativo requieren acceso inmediato a video histórico reciente. El archivo posterior garantiza preservación de evidencia conforme a regulación colombiana, facilitando procesos legales y auditorías de largo plazo. |

### RF-09 — Generación de Alertas Multi-Canal
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe generar alertas configurables por tipo de evento y distribuirlas por múltiples canales: dashboard del CCO, notificación push al operador de turno, integración con sistemas de megafonía, y registro en log de incidentes centralizado. |
| **Justificación Estratégica** | La detección de un evento sin acción correctiva carece de valor operativo. La multiplicidad de canales de alerta asegura que el operador reciba la notificación independientemente de su ubicación o actividad actual, habilitando respuesta inmediata. |

### RF-10 — Redundancia de Enlace y Respaldo Local
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe contar con redundancia de enlace de red (fibra óptica primaria + radiofrecuencia como respaldo) y almacenamiento local en borde que continúe grabando ante pérdida de conectividad con el CCO, con sincronización automática al restablecerse el enlace. |
| **Justificación Estratégica** | Los cortes de fibra óptica por terceros, derrumbes o mantenimiento son eventos que pueden ocurrir en corredores viales. Sin redundancia de enlace y almacenamiento local, el Centro de Control queda ciego ante incidentes durante la interrupción, con consecuencias potencialmente graves. |

---

## 6. REQUERIMIENTOS NO FUNCIONALES (RNF)

### RNF-01 — Disponibilidad ≥ 99.9%
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema CCTV en su conjunto (cámaras, enlaces, almacenamiento, plataforma de gestión) debe mantener disponibilidad operativa igual o superior al 99.9% medido mensualmente, equivalente a máximo 43 minutos de indisponibilidad por mes. |
| **Justificación Estratégica** | La disponibilidad del sistema de video impacta directamente la capacidad de respuesta del Centro de Control. El 99.9% representa el estándar mínimo aceptable para sistemas de misión crítica en infraestructura vial de esta magnitud. |

### RNF-02 — Latencia de Video ≤ 2 Segundos
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El tiempo entre la captura de un fotograma en campo y su visualización en la consola del CCO debe ser menor o igual a 2 segundos, inclusive en condiciones de red congestionada o con pérdida de paquetes hasta 1%. |
| **Justificación Estratégica** | En situaciones dinámicas que evolucionan rápidamente, cada segundo cuenta. Una latencia superior desfasa la toma de decisiones del operador respecto a la realidad de campo, generando respuestas tardías o basadas en información obsoleta. |

### RNF-03 — Ciclo de Vida ≥ 10 Años
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Los componentes de campo deben tener vida útil proyectada mínima de 10 años bajo condiciones ambientales del corredor, con soporte técnico, repuestos y actualizaciones de firmware garantizados por el fabricante durante ese período. |
| **Justificación Estratégica** | Los proyectos de infraestructura vial operan en horizontes de 25-30 años. Reemplazos frecuentes generan costos de capital recurrentes no previstos, interrupciones de servicio y obsolescencia tecnológica prematura que comprometen la inversión. |

### RNF-04 — Consumo Energético Optimizado
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El consumo eléctrico debe ser ≤ 150W para cámaras PTZ con IR activado y ≤ 30W para cámaras fijas. El sistema debe soportar alimentación PoE++ (802.3bt, 90W) o fuente local con respaldo UPS. |
| **Justificación Estratégica** | La arquitectura debe contar con la capacidad de alimentación que permita operación continua mediante PoE++ o fuentes locales con respaldo UPS, facilitando la prestación del servicio sin interrupciones ante variaciones en el suministro eléctrico. |

### RNF-05 — Ancho de Banda ≤ 8 Mbps por Cámara
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El stream de video 4K comprimido en H.265 debe consumir ancho de banda máximo de 8 Mbps por cámara en operación normal, con picos no mayores a 12 Mbps en escenas de alta complejidad, soportando VBR controlado. |
| **Justificación Estratégica** | La red troncal transporta video de múltiples cámaras más datos de sensores, voz y control. Un consumo desmedido satura la red, genera latencia en servicios críticos y obliga a sobredimensionar infraestructura, elevando costos de capital. |

### RNF-06 — Ciberseguridad End-to-End
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | Los streams de video deben cifrarse mediante TLS 1.3 en tránsito y AES-256 en almacenamiento. Las cámaras deben soportar autenticación multifactor, firmas de firmware, bloqueo de puertos no esenciales y registro de auditoría de accesos. |
| **Justificación Estratégica** | El sistema CCTV es vector de alto riesgo cibernético: acceso no autorizado permite vigilancia del CCO por actores maliciosos, manipulación de evidencia o extorsión. Un breach compromete la integridad operativa del corredor y expone información sensible. |

### RNF-07 — Escalabilidad sin Rediseño
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | La arquitectura debe tener la capacidad para escalar sin rediseño de la red troncal, la plataforma de gestión ni el almacenamiento, realizándose mediante configuración sin interrupción del servicio existente. |
| **Justificación Estratégica** | Una arquitectura con capacidad de escalabilidad garantiza que el sistema pueda adaptarse a necesidades futuras de cobertura sin requerir inversiones adicionales en infraestructura base, protegiendo la inversión inicial y facilitando la evolución tecnológica. |

### RNF-08 — Tolerancia a Fallos de Red
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe tolerar fallos transitorios de red hasta 30 segundos sin pérdida de video, mediante buffering local y reconexión automática, garantizando continuidad de grabación y alertas al CCO sobre degradación de conectividad. |
| **Justificación Estratégica** | Las redes de comunicación en corredores viales pueden experimentar intermitencias por interferencias, mantenimiento o condiciones atmosféricas. La tolerancia a fallos transitorios evita falsas alarmas y garantiza continuidad de evidencia. |

### RNF-09 — Recuperación ante Desastres
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | El sistema debe contar con procedimientos y capacidad técnica para recuperación completa de la plataforma de gestión en caso de fallo catastrófico, con tiempo de recuperación objetivo (RTO) máximo de 4 horas y punto de recuperación (RPO) máximo de 1 hora. |
| **Justificación Estratégica** | Un fallo catastrófico del sistema de gestión de video deja al Centro de Control ciego. La capacidad de recuperación rápida minimiza el período de vulnerabilidad y restablece la operación normal en tiempo aceptable. |

### RNF-10 — Usabilidad de Interfaz
| Campo | Valor |
|-------|-------|
| **Descripción Funcional / Técnica** | La interfaz de usuario del sistema de gestión debe ser intuitiva, con tiempo de aprendizaje menor a 8 horas para operadores nuevos, y debe cumplir estándares de usabilidad (ISO 9241) con accesibilidad para operadores con discapacidades visuales leves. |
| **Justificación Estratégica** | Operadores del Centro de Control trabajan en turnos rotativos y bajo presión durante incidentes. Una interfaz confusa o compleja aumenta el riesgo de errores operativos en momentos críticos y extiende el tiempo de capacitación de personal. |

---

## 7. INDICADORES

| KPI | Descripción | Meta Mínima |
|-----|-------------|-------------|
| **KPI-1: Disponibilidad** | Tiempo operativo del sistema mensual | ≥ 99.9% |
| **KPI-2: Latencia** | Tiempo desde captura hasta visualización en CCO | ≤ 2 segundos |
| **KPI-3: Precisión IA** | Detección correcta de incidentes por analítica | ≥ 95% |
| **KPI-4: Falsos Positivos** | Alertas generadas sin incidente real | ≤ 2% |
| **KPI-5: Retención** | Días de video histórico disponible | ≥ 30 días |
| **KPI-6: Cobertura** | Porcentaje del corredor con visibilidad | 100% puntos críticos |

---

## 8. REFERENCIA DEL MERCADO

### 8.1 EQUIPOS ITS A NIVEL INTERNACIONAL

| Equipo | Fabricante | Tipo | Proyecto de Referencia | País | URL Producto | URL Proyecto |
|--------|------------|------|------------------------|------|--------------|--------------|
| **DeepinView Series / Checkpoint** | Hikvision | CCTV IP PTZ / Bullet AI | Soluciones de tráfico en autopistas con detección de incidentes | China / Global | https://www.hikvision.com | https://www.hikvision.com/en/solutions/Traffic/ |
| **AVIOTEC 8000i IR** | Bosch Security Systems | CCTV IP Bullet / Térmica | Sistemas de monitoreo de tráfico y detección de incendios en túneles | Alemania / Europa | https://www.boschsecurity.com | https://www.boschsecurity.com/en/solutions/traffic |
| **XNP-C9310R / PNO-A9081RLP** | Hanwha Vision | CCTV IP PTZ / Bullet / Térmica AI | Sistemas de vigilancia en transporte (aeropuertos, puertos, ferrocarriles) | Corea del Sur / Global | https://www.hanwhavision.com | https://www.hanwhavision.com/en/solutions/transportation/ |

### 8.2 EQUIPOS ITS IMPLEMENTADOS EN COLOMBIA

| Equipo | Fabricante | Tipo | Proyecto de Referencia | Entidad | URL Producto | URL Proyecto |
|--------|------------|------|------------------------|---------|--------------|--------------|
| **XNP-C8303RW** | Hanwha Vision | CCTV IP PTZ | Concesiones Viales 4G | ANIH / Concesiones | https://www.hanwhavision.com/en/products/camera/network/ptz/xnp-c8303rw/ | https://www.hanwhavision.com/en/ |
| **Spectra Enhanced 8** | Pelco | CCTV IP PTZ | Sistemas ITS | INVIAS / IDU Bogotá | https://www.pelco.com/cameras/ptz/spectra-enhanced-8 | https://www.pelco.com |

---

## 9. CASOS DE USO

### Caso 1: Detección de Incidente Nocturno
Un vehículo se detiene en el corredor durante la madrugada. La cámara PTZ con visión nocturna IR detecta el vehículo detenido mediante analítica de IA, generando alerta al Centro de Control en menos de 2 segundos. El operador accede al video en tiempo real, verifica visualmente la situación sin necesidad de desplazar patrulla de campo, y determina si se trata de una emergencia que requiere asistencia o un evento menor. Esta capacidad reduce los tiempos de respuesta y optimiza la asignación de recursos de emergencia.

### Caso 2: Monitoreo en Condiciones Adversas
Durante período de lluvias intensas en zona de riesgo geotécnico, las cámaras con protección IP67 continúan operando normalmente. El operador del Centro de Control utiliza el zoom óptico 30x de una cámara PTZ para verificar en detalle la condición de la vía y los taludes adyacentes, detectando preventivamente cualquier signo de inestabilidad que pudiera afectar la seguridad del corredor. Esta capacidad de inspección remota complementa los sensores automáticos y reduce la exposición de personal de campo a condiciones peligrosas.

### Caso 3: Respuesta a Emergencia Múltiple
Se reporta colisión múltiple en el corredor. El operador del Centro de Control accede inmediatamente a las cámaras PTZ cercanas, reorienta la vista hacia el punto del incidente, y evalúa visualmente la gravedad de la situación, número de vehículos involucrados, presencia de heridos y condiciones de la vía. Con esta información en tiempo real, coordina la respuesta de servicios de emergencia (ambulancias, bomberos, grúas) con precisión, optimizando los recursos desplegados y reduciendo el tiempo de atención a los afectados.

### Caso 4: Verificación de Alerta Automática
El subsistema AID genera una alerta de vehículo detenido. El operador CCTV verifica visualmente que se trata de vehículo con fallo mecánico vs. accidente, asignando recursos apropiados. Esta capacidad de verificación humana del alertamiento automático evita falsas alarmas que podrían desviar recursos de emergencia, mientras que la disponibilidad del video permite evaluar con precisión la situación real.

### Caso 5: Investigación Post-Incidente
Accidente con disputa de responsabilidad. Se extrae video histórico con cadena de custodia, mostrando secuencia completa del evento para clarificación legal y seguros. Esta documentación visual resulta determinante en la reconstrucción del incidente y la determinación de responsabilidades, demostrando el valor del sistema CCTV no solo para la respuesta en tiempo real sino también como herramienta de análisis forense.

---

*InnovaDataCO SAS | Ficha Técnica ITS — CC-01 CCTV | 2026-04-25*
*Contrato de referencia: TC-PS-05-917-2026 | Corredor: Chía–Girardot (308 km)*
