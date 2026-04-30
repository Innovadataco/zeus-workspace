# 8.1 CC-01: CCTV (Sistema de Videovigilancia)

## 8.1.1 Resumen Ejecutivo

El componente **CC-01 CCTV** constituye el sistema de percepción visual del corredor vial Chía–Girardot, proporcionando cobertura videográfica continua de alta definición para monitoreo, detección y verificación de eventos en tiempo real. Este subsistema fundamental habilita la capacidad de observación remota del estado de la infraestructura vial, el comportamiento del tráfico y la ocurrencia de incidentes que requieren atención del Centro de Control y Operaciones (CCO).

La videovigilancia inteligente representa la capa base de percepción sobre la cual se construyen capacidades analíticas avanzadas, permitiendo a los operadores visualizar cualquier punto del corredor bajo demanda, verificar alertas generadas por otros subsistemas ITS, y recolectar evidencia objetiva para análisis forense y toma de decisiones.

El sistema CC-01 se despliega estratégicamente a lo largo de los 306 km del corredor, cubriendo zonas críticas como intersecciones, túneles, puentes, zonas de riesgo geotécnico y puntos de alta accidentalidad.

---

## 8.1.2 Identificación Del Componente De Campo

| Campo | Valor |
|-------|-------|
| **COD** | CC-01 |
| **Sigla (Estándar Internacional)** | CCTV |
| **Nombre del Componente** | Sistema de Videovigilancia (Closed Circuit Television) |
| **Capacidad Operativa Generada** | Percepción visual continua del corredor vial con capacidad de monitoreo remoto, verificación de eventos, recolección de evidencia y soporte a sistemas analíticos de inteligencia artificial. |

---

## 8.1.3 Descripción Funcional / Técnica

### Alcance de la Solución

El sistema CCTV comprende una red de cámaras de video desplegadas estratégicamente a lo largo del corredor, operando bajo una arquitectura de transmisión IP que transporta flujos de video hacia el Centro de Control y Operaciones. La solución integra diferentes tipologías de cámaras según los requerimientos específicos de cada ubicación: cámaras PTZ (Pan-Tilt-Zoom) para cobertura adaptable y seguimiento, cámaras fijas para vigilancia permanente de zonas específicas, y cámaras con capacidades analíticas integradas para detección inteligente.

El subsistema opera las 24 horas del día, los 7 días de la semana, capturando video en resolución 4K (3840×2160) a 30 fps con compresión eficiente (H.265/HEVC) que optimiza el uso del ancho de banda sin degradación perceptible de calidad.

---

## 8.1.4 Justificación Estratégica

La implementación de un sistema de videovigilancia robusto responde a la imposibilidad física de mantener presencia humana continua a lo largo de 306 km de corredor vial. La capacidad de observación remota permite que un número reducido de operadores en el CCO mantenga vigilancia visual sobre múltiples puntos simultáneamente, optimizando recursos humanos mientras maximiza la cobertura espacial.

La videovigilancia habilita respuestas informadas ante incidentes: cuando un subsistema automático genera una alerta, el operador puede verificar visualmente la situación antes de despachar recursos de emergencia, evitando despliegues innecesarios por falsas alarmas.

---

## 8.1.5 Especificación Técnica

| Parámetro | Especificación Mínima |
|-----------|----------------------|
| **Resolución de captura** | 4K UHD (3840×2160) @ 30 fps |
| **Resolución mínima aceptable** | 2K (2560×1440) @ 30 fps para cámaras secundarias |
| **Formato de compresión** | H.265/HEVC primario, H.264/AVC secundario |
| **Tasa de bits por cámara** | 8-25 Mbps según resolución y nivel de actividad |
| **Latencia de transmisión** | < 500 ms desde captura hasta visualización en CCO |
| **Rango dinámico** | HDR/WDR ≥ 120 dB para condiciones de contraluz extremo |
| **Visión nocturna** | IR inteligente con alcance ≥ 100 m para cámaras exteriores |
| **Protección ambiental** | IP66/67 para equipos de exterior, IP54 para interior |
| **Rango térmico operativo** | -30°C a +60°C con funcionamiento continuo garantizado |
| **Alimentación** | PoE++ (IEEE 802.3bt, 60W) o 24VAC/24VDC con respaldo UPS |
| **Capacidades PTZ** | Pan 360°, Tilt ±90°, Zoom óptico ≥ 30x para cámaras motorizadas |
| **Analítica integrada** | Detección de intrusión, cruce de línea, permanencia, dirección |
| **Protocolos de red** | ONVIF Profile S/G, RTSP, RTMP, SIP para integraciones |
| **Ciberseguridad** | Cifrado TLS 1.3, autenticación IEEE 802.1X, certificados X.509 |
| **Almacenamiento local** | Slot para microSD ≥ 256 GB como respaldo ante falla de red |
| **Gestión de VMS** | Compatible con plataformas Milestone, Genetec, Honeywell, o VMS propio |
| **Tasa de cuadros** | 30 fps configurable, con modo 60 fps para cámaras de alta velocidad |
| **Campo visual** | ≥ 90° horizontal para cámaras fijas de cobertura general |
| **Resistencia a impactos** | IK10 para zonas vulnerables a vandalismo |

---

## 8.1.6 Requerimientos Funcionales (RF)

### RF-01 — Captura y Transmisión de Video en Tiempo Real
**Descripción Funcional / Técnica:** El sistema debe capturar video continuo en resolución 4K a 30 fps y transmitirlo al CCO con latencia inferior a 500 ms. La transmisión debe mantenerse estable ante fluctuaciones de red mediante buffers adaptativos y recuperación de paquetes. Cada cámara debe generar múltiples streams simultáneos: uno principal en alta resolución para grabación, uno secundario en resolución reducida para visualización multi-pantalla, y uno terciario para transmisión móvil.

**Justificación Estratégica:** La captura en tiempo real es fundamental para operaciones de monitoreo y respuesta a incidentes. Las cámaras que operan con latencias superiores a 1 segundo dificultan la coordinación de respuestas en emergencias. La generación de múltiples streams optimiza el uso del ancho de banda permitiendo visualización eficiente sin sacrificar calidad de grabación.

### RF-02 — Visualización Remota en el CCO
**Descripción Funcional / Técnica:** Los operadores del CCO deben poder visualizar cualquier cámara del corredor bajo demanda mediante interfaz gráfica intuitiva. La interfaz debe permitir visualización individual, mosaicos configurables (1x1, 2x2, 3x3, 4x4), y modos de patrullaje automático que roten entre cámaras predefinidas. La selección de cámaras debe ser posible mediante mapa interactivo del corredor, lista jerárquica por segmento, o búsqueda por ID.

**Justificación Estratégica:** La capacidad de visualización flexible permite que los operadores adapten la interfaz a diferentes escenarios operativos: monitoreo general con múltiples cámaras simultáneas, o atención focalizada a un incidente específico con visualización full-screen.

### RF-03 — Control PTZ Remoto
**Descripción Funcional / Técnica:** Las cámaras PTZ deben ser controlables remotamente desde el CCO con precisión de 0.1° en movimientos pan/tilt. El control debe incluir funciones de zoom óptico, enfoque automático/manual, ajuste de iris, y activación de iluminación IR. El sistema debe soportar guarda-tours programables y funciones de presets.

**Justificación Estratégica:** El control PTZ remoto multiplica la efectividad de cada cámara al permitir cobertura adaptativa. Un operador puede seguir visualmente un vehículo sospechoso a lo largo del corredor saltando entre cámaras.

### RF-04 — Grabación Continua y por Evento
**Descripción Funcional / Técnica:** El sistema debe grabar video continuamente de todas las cámaras con retención mínima de 30 días. Adicionalmente, debe soportar grabación por evento con pre-alarm (5-10 segundos antes del evento) y post-alarm (tiempo configurable).

**Justificación Estratégica:** La grabación continua proporciona contexto histórico completo para investigaciones, mientras que la grabación por evento optimiza el almacenamiento y facilita la búsqueda de momentos críticos.

### RF-05 — Analítica de Video Integrada
**Descripción Funcional / Técnica:** Las cámaras o el VMS deben incluir capacidades analíticas de video para detección de intrusión en zonas delimitadas, cruce de líneas virtuales, detección de permanencia en áreas restringidas, detección de dirección de flujo contraria, y detección de objetos abandonados.

**Justificación Estratégica:** Las analíticas integradas proporcionan capacidad de detección básica sin requerir el subsistema AID completo, ofreciendo redundancia y permitiendo detección en ubicaciones donde el análisis mediante IA de edge no es viable económicamente.

### RF-06 — Integración con Subsistemas ITS
**Descripción Funcional / Técnica:** El sistema CCTV debe integrarse nativamente con los subsistemas AID (CC-02) para análisis inteligente, DMS/VMS (CC-03) para presentación unificada, y el CCO (CC-19) para gestión centralizada.

**Justificación Estratégica:** La operación del corredor como sistema integrado requiere que los subsistemas trabajen coordinadamente. Cuando AID detecta un incidente, CCTV debe presentar automáticamente la cámara correspondiente sin intervención manual.

### RF-07 — Acceso Remoto Seguro
**Descripción Funcional / Técnica:** El sistema debe proporcionar capacidad de acceso remoto seguro para usuarios autorizados fuera del CCO, incluyendo: aplicación móvil para personal de campo, portal web para autoridades de tránsito, y API para integración con sistemas de emergencia.

**Justificación Estratégica:** El acceso remoto habilita que personal de campo verifique situaciones en ubicaciones específicas antes de llegar físicamente, y permite que autoridades externas visualicen la escena durante despacho.

### RF-08 — Respaldo y Recuperación ante Fallas
**Descripción Funcional / Técnica:** El sistema debe implementar redundancia en todos los componentes críticos: almacenamiento RAID con hot-spare, rutas de red diversas (fibra primaria, radio/celular backup), y alimentación con respaldo UPS + generador.

**Justificación Estratégica:** La disponibilidad 24/7 es crítica para seguridad vial. Un sistema de videovigilancia fuera de servicio durante un incidente representa riesgo operativo y potencial responsabilidad legal.

### RF-09 — Gestión Centralizada del Sistema
**Descripción Funcional / Técnica:** El VMS debe proporcionar capacidades de gestión centralizada: inventario automático de cámaras, monitoreo de estado operativo (health monitoring), gestión remota de configuraciones, y generación de reportes de disponibilidad.

**Justificación Estratégica:** Un corredor de 306 km puede tener cientos de cámaras. La gestión individual de cada dispositivo sería inviable operativamente. La gestión centralizada reduce costos de mantenimiento.

### RF-10 — Cumplimiento Normativo y Forense
**Descripción Funcional / Técnica:** El sistema debe garantizar integridad de evidencia video mediante: timestamps certificados con fuente de tiempo segura (GNSS/NTP stratum 1), cadena de custodia digital para video exportado (hash criptográfico), y almacenamiento inmutable ante modificaciones.

**Justificación Estratégica:** El video de seguridad vial frecuentemente se requiere como evidencia en procesos judiciales. La cadena de custodia verificable y la integridad de timestamps son requisitos legales para que la evidencia sea admisible.

---

## 8.1.7 Requisitos No Funcionales (RNF)

### RNF-01 — Disponibilidad del Sistema
**Descripción:** El sistema CCTV debe mantener disponibilidad operativa ≥ 99.9% medida mensualmente, considerando indisponibilidad cualquier período donde más del 5% de las cámaras de un segmento crítico estén fuera de servicio simultáneamente.

**Justificación:** Una disponibilidad del 99.9% garantiza que el sistema esté operativo 8,760 horas al año con menos de 9 horas de indisponibilidad no planificada.

### RNF-02 — Ciclo de Vida y Obsolescencia
**Descripción:** Los componentes del sistema (cámaras, switches, VMS) deben tener ciclo de vida útil ≥ 10 años con soporte técnico y repuestos garantizados por el fabricante durante ese período.

**Justificación:** La infraestructura de videovigilancia representa inversión significativa que debe amortizarse adecuadamente. Un ciclo de 10 años permite recuperación de inversión.

### RNF-03 — Consumo Energético y Eficiencia
**Descripción:** Las cámaras deben operar con consumo ≤ 25W promedio en condiciones normales (sin IR), y ≤ 50W máximo con IR activado y PTZ en movimiento continuo.

**Justificación:** Un corredor con 200+ cámaras puede consumir 5-10 kW continuos solo en videovigilancia. La eficiencia energética reduce costos operativos significativamente.

### RNF-04 — Ciberseguridad End-to-End
**Descripción:** El sistema debe implementar defensa en profundidad: cámaras con firmware firmado digitalmente y verificación de integridad en boot, transmisión cifrada TLS 1.3, segmentación de red mediante VLANs y microsegmentación, autenticación 802.1X para dispositivos, y monitoreo continuo de anomalías de seguridad.

**Justificación:** Las cámaras IoT son objetivos frecuentes de ciberataques. Un compromiso del sistema CCTV puede exponer información sensible de infraestructura crítica.

### RNF-05 — Escalabilidad Horizontal
**Descripción:** La arquitectura debe permitir adición de nuevas cámaras sin degradación del sistema existente. El VMS debe soportar ≥ 500 cámaras en configuración final del corredor.

**Justificación:** El corredor puede expandirse o requerir mayor densidad de cobertura videográfica en el futuro. La escalabilidad horizontal garantiza que inversiones iniciales no requieran reemplazo ante crecimiento.

### RNF-06 — Tolerancia a Condiciones Ambientales
**Descripción:** Las cámaras de exterior deben operar en rango térmico -30°C a +60°C con humedad relativa hasta 95% sin condensación interna. Deben resistir vibraciones de tráfico pesado, vientos sostenidos de 150 km/h, y lluvia horizontal intensa.

**Justificación:** El corredor Chía–Girardot atraviesa zonas con condiciones climáticas diversas: altiplano con heladas, valles cálidos, y zonas de alta precipitación.

### RNF-07 — Cumplimiento Normativo Global
**Descripción:** El sistema debe cumplir: Resolución 1090 de 2020 (Colombia - Sistemas ITS), Ley 1581 de 2012 (Protección de datos personales en video), estándares IEEE 802.3 para redes, y normas eléctricas RETIE. Las cámaras deben contar con certificación FCC (USA) o CE (Europa).

**Justificación:** El cumplimiento normativo es obligatorio para operación legal en Colombia. La falta de certificaciones puede impedir la aprobación de proyectos por entidades controladoras.

---

## 8.1.8 Indicadores Clave De Rendimiento (KPIs)

| ID | Indicador | Meta | Frecuencia |
|----|-----------|------|------------|
| **KPI-01** | Disponibilidad del Sistema | ≥ 99.9% | Mensual |
| **KPI-02** | Latencia de Video | < 500 ms | Continua |
| **KPI-03** | Calidad de Imagen | ≥ 95% | Trimestral |
| **KPI-04** | Tasa de Falsos Positivos | < 5% | Mensual |
| **KPI-05** | Cobertura Operativa | ≥ 98% | Diaria |
| **KPI-06** | Tiempo de Recuperación (MTTR) | < 4 horas | Por incidente |
| **KPI-07** | Satisfacción de Usuario | ≥ 4.0/5.0 | Semestral |
| **KPI-08** | Eficiencia Energética | < 25W | Mensual |

---

## 8.1.9 Referencias De Mercado

### Fabricantes Internacionales

| Fabricante | País | Especialidad | Web |
|------------|------|--------------|-----|
| **Hikvision** | China | Videovigilancia completa | https://www.hikvision.com |
| **Dahua Technology** | China | Soluciones de seguridad | https://www.dahuasecurity.com |
| **Axis Communications** | Suecia | Cámaras de red IP | https://www.axis.com |
| **Bosch Security** | Alemania | Sistemas de seguridad premium | https://www.boschsecurity.com |
| **Pelco by Schneider** | USA | Videovigilancia profesional | https://www.pelco.com |
| **Hanwha Techwin** | Corea del Sur | Wisenet series | https://www.hanwhavision.com |

---

## 8.1.10 Proveedores Colombia

| Empresa | Ciudad | Especialidad | Web |
|---------|--------|--------------|-----|
| **Indra Colombia** | Bogotá | ITS Integrado, Smart Cities | https://www.indracompany.com |
| **ISV Colombia** | Bogotá | Seguridad electrónica | https://www.isvcolombia.com |
| **Seguridad Vial S.A.S.** | Medellín | Sistemas de control vial | https://www.seguridadvial.com.co |
| **CCTV Colombia** | Bogotá | Distribución CCTV | https://www.cctvcolombia.com.co |

---

## 8.1.11 Casos de Uso

### CU-01: Verificación de Alerta de Contravía
**Actor Principal:** Operador del CCO  
**Precondición:** Sistema AID genera alerta de vehículo en contravía  
**Flujo Principal:**
1. El AID detecta vector de movimiento anómalo y genera alerta crítica al CCO
2. El sistema CCTV automáticamente presenta la cámara más cercana al punto de alerta
3. El operador visualiza el vehículo circulando en sentido opuesto y confirma la emergencia
4. El operador toma control PTZ de la cámara y sigue visualmente el vehículo
5. El operador activa protocolo de emergencia: cierra tramo mediante DMS, despacha patrulla
6. La cámara continúa grabando hasta que la patrulla intercepta el vehículo

**Resultado:** Interceptación exitosa del vehículo en contravía sin colisión, con evidencia completa del incidente.

### CU-02: Respuesta a Emergencia por Botón SOS
**Actor Principal:** Conductor en emergencia / Operador CCO  
**Precondición:** Conductor presiona botón de emergencia en zona rural  
**Flujo Principal:**
1. El sistema ECS/SOS recibe la llamada de emergencia
2. La alerta llega al CCO con ubicación exacta GPS del punto de llamada
3. El operador del CCO activa visualización de la cámara CCTV más cercana
4. Mediante el video, el operador identifica vehículo detenido con problema mecánico
5. El operador establece comunicación bidireccional con el conductor vía ECS
6. El operador despacha grúa con información precisa del incidente

**Resultado:** Respuesta coordinada con información precisa, evitando escalamiento del incidente.

### CU-03: Detección y Seguimiento de Vehículo Sospechoso
**Actor Principal:** Policía de Carreteras / Analista de Seguridad CCO  
**Precondición:** Alerta de vehículo sospechoso ingresando al corredor  
**Flujo Principal:**
1. Se recibe notificación de vehículo con placa específica ingresando al corredor
2. El analista programa búsqueda en el sistema ALPR para detectar el vehículo
3. El ALPR detecta el vehículo en peaje del km 15
4. El analista activa cámaras PTZ a lo largo del corredor para seguimiento visual
5. Se coordina con patrulla de carreteras para interceptación segura

**Resultado:** Localización y aprehensión del vehículo con evidencia videográfica completa.

### CU-04: Monitoreo de Obra de Infraestructura
**Actor Principal:** Supervisor de Obra / Ingeniero de Conservación  
**Precondición:** Trabajos de mantenimiento en puente con cierre parcial de carriles  
**Flujo Principal:**
1. El supervisor accede remotamente al sistema CCTV desde oficina de campo
2. Visualiza cámaras orientadas hacia la zona de trabajo
3. Monitorea el flujo de tráfico desviado y el comportamiento de conductores
4. Detecta congestión inusual y activa señalización de velocidad variable
5. Coordina con equipo de campo para ajustar señalización temporal

**Resultado:** Gestión proactiva del tráfico durante obra, minimizando congestión.

### CU-05: Evidencia Forense Post-Incidente
**Actor Principal:** Investigador de Accidentes / Abogado  
**Precondición:** Colisión múltiple en intersección con lesionados  
**Flujo Principal:**
1. El investigador solicita acceso al video del incidente al CCO
2. El operador del CCO localiza el timestamp exacto del incidente
3. Se extraen videos de múltiples cámaras con ángulos diferentes
4. El video incluye metadata certificada: fecha/hora exacta, coordenadas GPS
5. Se genera hash criptográfico del archivo para garantizar integridad
6. El video se presenta como evidencia en proceso judicial

**Resultado:** Determinación objetiva de responsabilidades con evidencia forense irrefutable.

---

**InnovaDataCO SAS** | **Fecha:** Abril 2026 | Documento generado bajo estándares ITS_CC-01
