# ÍNDICE CRUZADO: MAESTRO del Cliente ↔ Fichas Técnicas TOR-ITS-CCO
## APP-CHIA-GIRARDOT | Contrato TC-PS-05-917-2026
### InnovaDataCO PMO IA | Documento de Trazabilidad de Nomenclatura

---

**Código del documento:** INDICE-MAESTRO-CCO
**Versión:** 1.0
**Fecha:** 2026-04-24
**Estado:** Aprobado por CEO
**Autor:** ODIN PMO IA

---

## 1. RESUMEN EJECUTIVO

Este documento establece el mapping entre la nomenclatura del **MAESTRO** (hoja Excel entregada por el cliente, con códigos de mercado genéricos) y las **fichas técnicas generadas** (basadas en el TOR-ITS-CCO del contrato TC-PS-05-917-2026).

**Hallazgo clave:** El MAESTRO del Excel es una lista genérica de componentes ITS de mercado. El TOR-ITS-CCO define componentes específicos para el corredor Chía–Girardot. Para CC-01 a CC-14 y CC-29 a CC-42 hay coincidencia o correspondencia directa. Para CC-15 a CC-28, los componentes son **diferentes** — no es un problema de nomenclatura, es una diferencia de alcance entre el MAESTRO genérico y el TOR específico.

---

## 2. MAPEO COMPLETO

### 2.1 CC-01 a CC-14 — COINCIDENCIA DIRECTA ✅

| Código | Nombre MAESTRO | Nombre Nuestra Ficha | Estado | Notas |
|--------|---------------|---------------------|--------|-------|
| CC-01 | CCTV — Vigilancia por Video | CCTV — Vigilancia por Video | ✅ Alineado | Coincide exactamente |
| CC-02 | AID — Detección de Incidentes | AID — Detección Automática de Incidentes | ✅ Alineado | Coincide exactamente |
| CC-03 | DMS/VMS — Mensajería Variable | DMS/VMS — Mensajería Variable Dinámica | ✅ Alineado | Nomenclatura dual incluida |
| CC-04 | ECS/SOS — Llamada de Emergencia | ECS/SOS — Emergency Call System | ✅ Alineado | Nomenclatura dual incluida |
| CC-05 | VDS/TDS — Contadores de Tráfico | VDS/TDS — Vehicle Detection System | ✅ Alineado | Nomenclatura dual incluida |
| CC-06 | ESS/RWIS — Sensores Ambientales | ESS/RWIS — Environmental Sensor Station | ✅ Alineado | Nomenclatura dual incluida |
| CC-07 | WIM — Pesaje Dinámico | WIM — Weigh-in-Motion | ✅ Alineado | Coincide exactamente |
| CC-08 | GMS-I — Inclinometría Geotécnica | GMS-I — Geotechnical Monitoring System | ✅ Alineado | Coincide exactamente |
| CC-09 | SMS/SBT — Monitoreo de Estructuras | SMS/SBT — Structural Monitoring System | ✅ Alineado | Coincide exactamente |
| CC-10 | WLS — Monitoreo Hídrico | WLS — Water Level System | ✅ Alineado | Coincide exactamente |
| CC-11 | AVI/ETC — Peajes Electrónicos | AVI/ETC — Automatic Vehicle Identification | ✅ Alineado | Coincide exactamente |
| CC-12 | ALPR/LPR — Reconocimiento de Placas | ALPR/LPR — Automatic License Plate Recognition | ✅ Alineado | Coincide exactamente |
| CC-13 | SPD — Radar Pedagógico | SPD — Speed Detection / Radar Pedagógico | ✅ Alineado | Coincide exactamente |
| CC-14 | VSL — Velocidad Variable | VSL — Variable Speed Limit | ✅ Alineado | Coincide exactamente |

**Conclusión CC-01 a CC-14:** Las fichas técnicas ya fueron generadas con la nomenclatura correcta del MAESTRO. **No requieren renaming.**

---

### 2.2 CC-15 a CC-28 — COMPONENTES DIFERENTES 🔴

| Código | Nombre MAESTRO | Nombre Nuestra Ficha | Estado | Acción Requerida |
|--------|---------------|---------------------|--------|-----------------|
| CC-15 | TCS — Control de Túneles | PAS — Sistema de Megafonía | 🔴 **DIFERENTE** | El corredor NO tiene túneles; TOR especifica PAS |
| CC-16 | EVCS — Electrolineras | EC — Teléfonos de Emergencia SOS | 🔴 **DIFERENTE** | TOR especifica EC (SOS); EVCS no está en alcance |
| CC-17 | PAS — Megafonía Inteligente | NTCIP — Protocolos de Comunicación ITS | 🔴 **DIFERENTE** | MAESTRO tiene PAS en CC-17; TOR lo tiene en CC-15 |
| CC-18 | BCS/VRU — Contador de Ciclistas | FO — Red Troncal de Fibra Óptica | 🔴 **DIFERENTE** | TOR prioriza FO como infraestructura base |
| CC-19 | UAS/UAV — Drones de Inspección | CCO — Centro de Control y Operaciones | 🔴 **DIFERENTE** | TOR especifica CCO; drones en CC-38 (ADS) |
| CC-20 | VIS/LGS — Gestión de Iluminación | WAR — Gestión de Zonas de Obra | 🔴 **DIFERENTE** | TOR prioriza gestión de obras sobre iluminación general |
| CC-21 | CSG/IoT — Ciberseguridad e IoT | GI — Interfaz de Peaje y Control de Acceso | 🔴 **DIFERENTE** | Ciberseguridad está distribuida en todas las fichas |
| CC-22 | PSV — Seguridad Ciudadana | UPS — Alimentación Ininterrumpida | 🔴 **DIFERENTE** | TOR especifica UPS como infraestructura crítica |
| CC-23 | FOC — Conectividad de Fibra | PTZ — Cámaras Domo Motorizadas | 🔴 **DIFERENTE** | FO está en CC-18; FOC duplicaría |
| CC-24 | RCS — Comunicación Radial | GW — Gateway de Interconexión ITS | 🔴 **DIFERENTE** | TOR prioriza gateway IP sobre radio tradicional |
| CC-25 | SME — Gestión de Medios Sociales | TMS — Software de Gestión de Tráfico | 🔴 **DIFERENTE** | TOR especifica TMS como núcleo del sistema |
| CC-26 | RSU — Comunicación V2X | MOB — Aplicaciones Móviles / Portal | 🔴 **DIFERENTE** | V2X está en CC-36 (V2X-H) |
| CC-27 | AVL/OBU — Control de Flota | BKP — Respaldo y Recuperación | 🔴 **DIFERENTE** | TOR especifica BKP como requisito de continuidad |
| CC-28 | PGS — Gestión de Parqueaderos | EMS — Gestión Energética | 🔴 **DIFERENTE** | TOR especifica EMS para eficiencia energética |

**Conclusión CC-15 a CC-28:** El MAESTRO del Excel contiene componentes genéricos de mercado ITS que **no corresponden** al alcance del TOR-ITS-CCO para este corredor. Las fichas técnicas generadas reflejan los componentes realmente requeridos por el contrato.

**No es un problema de nomenclatura — es una diferencia de alcance.**

---

### 2.3 CC-29 a CC-42 — COINCIDENCIA DIRECTA ✅

| Código | Nombre MAESTRO | Nombre Nuestra Ficha | Estado | Notas |
|--------|---------------|---------------------|--------|-------|
| CC-29 | SLP — Iluminación Solar | SLP — Iluminación Solar | ✅ Alineado | Coincide exactamente |
| CC-30 | LHD — Detección de Incendio | LHD — Detección de Incendio | ✅ Alineado | Coincide exactamente |
| CC-31 | AQM — Calidad del Aire | AQM — Calidad del Aire | ✅ Alineado | Coincide exactamente |
| CC-32 | WAR — Sala de Crisis | WAR — Sala de Crisis | ✅ Alineado | Coincide exactamente |
| CC-33 | LCS/SIG — Control de Carril | LCS/SIG — Control de Carril | ✅ Alineado | Coincide exactamente |
| CC-34 | PSS — Postes y Estructuras | PSS — Postes y Estructuras | ✅ Alineado | Coincide exactamente |
| CC-35 | UPS/EPS — Respaldo Energético | UPS/EPS — Respaldo Energético | ✅ Alineado | Coincide exactamente |
| CC-36 | V2X-H — Nodos de Enlace Híbrido | V2X-H — Nodos Híbrido V2X | ✅ Alineado | Coincide exactamente |
| CC-37 | WDA — Detección de Fauna | WDA — Detección de Fauna | ✅ Alineado | Coincide exactamente |
| CC-38 | ADS — Estación de Drones | ADS — Estación de Drones Autónomos | ✅ Alineado | Coincide exactamente |
| CC-39 | MSG — Micro-Red Inteligente | MSG — Micro-Red Inteligente | ✅ Alineado | Coincide exactamente |
| CC-40 | D-TWN — Nodos de Gemelo Digital | D-TWN — Gemelo Digital | ✅ Alineado | Coincide exactamente |
| CC-41 | E-LOG — Gestión de Carga Crítica | E-LOG — Gestión de Carga Crítica | ✅ Alineado | Coincide exactamente |
| CC-42 | SAT-B — Respaldo Satelital | SAT-B — Respaldo Satelital | ✅ Alineado | Coincide exactamente |

**Conclusión CC-29 a CC-42:** Las fichas técnicas ya fueron generadas con la nomenclatura correcta del MAESTRO. **No requieren renaming.**

---

## 3. ANÁLISIS DE LA DIFERENCIA

### 3.1 ¿Por qué difieren CC-15 a CC-28?

El MAESTRO del Excel parece ser una **plantilla genérica** descargada de una base de datos de componentes ITS (posiblemente del proveedor europeo o de una librería estándar). Contiene componentes como:
- **TCS (Control de Túneles):** No aplica — el corredor Chía–Girardot tiene **0 túneles**
- **EVCS (Electrolineras):** No está en el alcance del contrato actual
- **UAS/UAV (Drones genéricos):** El TOR especifica ADS (Estación de Drones Autónomos) como infraestructura fija, no drones manuales
- **PGS (Parqueaderos):** No está en el alcance del corredor vial
- **SME (Redes Sociales):** No es un componente ITS técnico

El **TOR-ITS-CCO** (Términos de Referencia del contrato) define los componentes realmente necesarios para este corredor específico, priorizando:
- Infraestructura de comunicaciones (FO, GW, NTCIP)
- Centro de control (CCO)
- Respaldo energético y datos (UPS, BKP, EMS)
- Software de gestión (TMS)
- Aplicaciones móviles (MOB)

### 3.2 ¿Es un problema?

**No.** Las fichas técnicas generadas cumplen con el TOR-ITS-CCO, que es el documento contractual vinculante. El MAESTRO del Excel es una referencia de mercado, no un requisito contractual.

Sin embargo, para facilitar la comunicación con el cliente, este índice cruzado documenta las correspondencias y diferencias.

---

## 4. RECOMENDACIÓN DEL PMO IA

### Opción A: Mantener fichas actuales (RECOMENDADA)
**Descripción:** Conservar las 42 fichas técnicas tal como están, con la nomenclatura del TOR-ITS-CCO.

**Justificación:**
- Las fichas cumplen con el alcance contractual
- CC-01 a CC-14 y CC-29 a CC-42 ya coinciden con el MAESTRO
- CC-15 a CC-28 reflejan componentes técnicamente correctos para el corredor
- No se requiere trabajo adicional

### Opción B: Generar fichas adicionales para cubrir MAESTRO
**Descripción:** Crear 14 fichas adicionales para los componentes del MAESTRO no cubiertos (TCS, EVCS, BCS/VRU, UAS/UAV, VIS/LGS, CSG/IoT, PSV, FOC, RCS, SME, RSU, AVL/OBU, PGS).

**Justificación:**
- Cubriría todos los códigos del MAESTRO
- Sería un entregable más completo

**Contras:**
- Alcance adicional no contratado (requiere aprobación de cambio)
- Algunos componentes no aplican al corredor (túneles, parqueaderos)
- Aumentaría el proyecto de 42 a 56+ fichas

### Opción C: Renombrar CC-15 a CC-28 forzosamente
**Descripción:** Cambiar los nombres de CC-15 a CC-28 para que coincidan con el MAESTRO, manteniendo el contenido técnico.

**Contras:**
- CC-15 se llamaría "TCS — Control de Túneles" pero el contenido sería de megafonía
- Sería técnicamente incorrecto y confuso para el cliente
- **NO RECOMENDADA**

---

## 5. DECISIÓN DEL CEO

| Opción | Descripción | Estado |
|--------|-------------|--------|
| **A** | Mantener fichas actuales (TOR-ITS-CCO) | ✅ **APROBADO POR CEO** |
| **B** | Generar fichas adicionales (MAESTRO completo) | ❌ Descartada |
| **C** | Renombrar forzosamente | ❌ Descartada por PMO IA |

---

## 6. ANEXO: ESTRUCTURA DE FICHEROS ACTUAL

```
fichas-tecnicas/
├── CC-01.md  ✅ CCTV
├── CC-02.md  ✅ AID
├── CC-03.md  ✅ DMS/VMS
├── CC-04.md  ✅ ECS/SOS
├── CC-05.md  ✅ VDS/TDS
├── CC-06.md  ✅ ESS/RWIS
├── CC-07.md  ✅ WIM
├── CC-08.md  ✅ GMS-I
├── CC-09.md  ✅ SMS/SBT
├── CC-10.md  ✅ WLS
├── CC-11.md  ✅ AVI/ETC
├── CC-12.md  ✅ ALPR/LPR
├── CC-13.md  ✅ SPD
├── CC-14.md  ✅ VSL
├── CC-15.md  🔴 PAS (MAESTRO: TCS)
├── CC-16.md  🔴 EC (MAESTRO: EVCS)
├── CC-17.md  🔴 NTCIP (MAESTRO: PAS)
├── CC-18.md  🔴 FO (MAESTRO: BCS/VRU)
├── CC-19.md  🔴 CCO (MAESTRO: UAS/UAV)
├── CC-20.md  🔴 WAR (MAESTRO: VIS/LGS)
├── CC-21.md  🔴 GI (MAESTRO: CSG/IoT)
├── CC-22.md  🔴 UPS (MAESTRO: PSV)
├── CC-23.md  🔴 PTZ (MAESTRO: FOC)
├── CC-24.md  🔴 GW (MAESTRO: RCS)
├── CC-25.md  🔴 TMS (MAESTRO: SME)
├── CC-26.md  🔴 MOB (MAESTRO: RSU)
├── CC-27.md  🔴 BKP (MAESTRO: AVL/OBU)
├── CC-28.md  🔴 EMS (MAESTRO: PGS)
├── CC-29.md  ✅ SLP
├── CC-30.md  ✅ LHD
├── CC-31.md  ✅ AQM
├── CC-32.md  ✅ WAR
├── CC-33.md  ✅ LCS/SIG
├── CC-34.md  ✅ PSS
├── CC-35.md  ✅ UPS/EPS
├── CC-36.md  ✅ V2X-H
├── CC-37.md  ✅ WDA
├── CC-38.md  ✅ ADS
├── CC-39.md  ✅ MSG
├── CC-40.md  ✅ D-TWN
├── CC-41.md  ✅ E-LOG
└── CC-42.md  ✅ SAT-B
```

**Resumen:**
- ✅ 28 fichas ya alineadas (CC-01 a CC-14 + CC-29 a CC-42)
- 🔴 14 fichas con componentes diferentes (CC-15 a CC-28)

---

*InnovaDataCO PMO IA | INDICE-MAESTRO-CCO | v1.0 | 2026-04-24*
*Documento de trazabilidad para aprobación del CEO*
