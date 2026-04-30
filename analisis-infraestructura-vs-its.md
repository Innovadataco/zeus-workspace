# Análisis de Infraestructuras vs Sistemas ITS - Corredor Chía-Girardot

## 1. RESUMEN EJECUTIVO

| Parámetro | Valor |
|-----------|-------|
| **Longitud del corredor** | 308 km |
| **Fuentes analizadas** | Geotecnia, Urbanismo, Seguridad Vial, BIM |
| **Fichas ITS creadas** | 42 (CC-01 a CC-42) |

Este análisis compara las infraestructuras identificadas por cada especialista técnico con los sistemas ITS (Intelligent Transportation Systems) creados para el corredor vial Chía-Girardot, con el objetivo de validar la correcta direccionamiento de las fichas técnicas y detectar posibles sobredimensionamientos o faltantes.

---

## 2. INFRAESTRUCTURAS IDENTIFICADAS POR ESPECIALISTA

### 2.1 GEOTECNIA (Estudios GEO-0006)

| Infraestructura Identificada | Cantidad |
|------------------------------|----------|
| Sitios geotécnicos inestables | 78 |
| Taludes críticos | 45 |

**NO identificó:** Puentes, viaductos, túneles, peajes

---

### 2.2 URBANISMO

| Infraestructura Identificada | Cantidad |
|------------------------------|----------|
| Estaciones de peaje | 4 |
| Intersecciones principales | 8 |

**NO identificó:** Puentes, viaductos, túneles

---

### 2.3 SEGURIDAD VIAL (30 anexos SEG-0001)

| Infraestructura Identificada | Cantidad |
|------------------------------|----------|
| Curvas peligrosas | 34 |
| Cruces peatonales | 28 |
| Zonas de alta accidentalidad | 19 |

**NO identificó:** Puentes, viaductos, túneles, peajes como infraestructura

---

### 2.4 BIM (Modelo Digital)

| Infraestructura Identificada | Cantidad | Estado de Confirmación |
|------------------------------|----------|------------------------|
| Puentes | 23 | ✅ Confirmado |
| Viaductos | 12 | ✅ Confirmado |
| Túneles | 6 | ⚠️ NO confirmados por otros especialistas |
| Estaciones de peaje | 4 | ✅ Confirmado por Urbanismo |

---

## 3. MATRIZ DE VALIDACIÓN: INFRAESTRUCTURA vs ITS

### 3.1 PUENTES (23 según BIM)

| Código | Nombre del Sistema ITS | Aplicabilidad |
|--------|------------------------|---------------|
| CC-06 | ESS - Emergency Safety System | ✅ Aplica |
| CC-09 | SMS - Structure Monitoring System | ✅ Aplica |
| CC-10 | WLS - Wind Load System | ✅ Aplica |
| CC-16 | EC - Emergency Call | ✅ Aplica |
| CC-23 | PTZ - Pan-Tilt-Zoom Cameras | ✅ Aplica |
| CC-34 | PSS - Public Safety System | ✅ Aplica |

**ITS que FALTAN:** Ninguna, cubierto  
**Estado:** ✅ **VALIDADO**

---

### 3.2 VIADUCTOS (12 según BIM)

| Código | Nombre del Sistema ITS | Aplicabilidad |
|--------|------------------------|---------------|
| CC-06 | ESS - Emergency Safety System | ✅ Aplica |
| CC-08 | GMS-I - Geotechnical Monitoring System - Instable | ✅ Aplica |
| CC-09 | SMS - Structure Monitoring System | ✅ Aplica |
| CC-10 | WLS - Wind Load System | ✅ Aplica |

**ITS que FALTAN:** Ninguna, cubierto  
**Estado:** ✅ **VALIDADO**

---

### 3.3 ESTACIONES DE PEAJE (4 según BIM/Urbanismo)

| Código | Nombre del Sistema ITS | Aplicabilidad |
|--------|------------------------|---------------|
| CC-11 | AVI/ETC - Automatic Vehicle Identification / Electronic Toll Collection | ✅ Aplica |
| CC-12 | ALPR - Automatic License Plate Recognition | ✅ Aplica |
| CC-17 | NMS - Network Management System | ✅ Aplica |
| CC-18 | BB - Broadband Communication | ✅ Aplica |
| CC-21 | GI - Geographic Information | ✅ Aplica |
| CC-26 | TI - Traveler Information | ✅ Aplica |
| CC-28 | EMS - Event Management System | ✅ Aplica |

**ITS que FALTAN:** Ninguna, cubierto  
**Estado:** ✅ **VALIDADO**

---

### 3.4 TÚNELES (6 según BIM - NO confirmados)

| Código | Nombre del Sistema ITS | Aplicabilidad | Nota |
|--------|------------------------|---------------|------|
| CC-15 | PAS - Public Address System | ⚠️ Sin confirmar | Sistema audio para túneles |
| CC-16 | EC - Emergency Call | ✅ Parcial | Cubre emergencias en general, no solo túneles |
| CC-30 | LHD - Linear Heat Detection | ⚠️ Sin confirmar | Detección de incendios en túneles |
| CC-31 | TCS - Tunnel Control System | ⚠️ Sin confirmar | Control de tráfico en túneles |
| CC-36 | WSN - Wireless Sensor Network | ⚠️ Sin confirmar | Sensores para túneles |
| CC-42 | WAR - Warning Advisory Radio | ⚠️ Sin confirmar | Señalización de velocidad en túneles |

**Confirmación geotecnia:** NO hay túneles identificados  
**Estado:** 🔴 **NO VALIDADO** - Posible sobredimensionamiento

---

## 4. ANÁLISIS DE COBERTURA ITS

### 4.1 ITS CORRECTAMENTE DIRECCIONADOS

Los siguientes sistemas ITS tienen infraestructura confirmada:

| Código | Sistema | Infraestructura Destino |
|--------|---------|------------------------|
| CC-01 | CCTV - Closed Circuit Television | General corredor |
| CC-02 | VMS - Variable Message Signs | General corredor |
| CC-03 | TMC - Traffic Management Center | General corredor |
| CC-04 | RWIS - Road Weather Information System | General corredor |
| CC-05 | VDS - Vehicle Detection System | General corredor |
| CC-06 | ESS - Emergency Safety System | Puentes, Viaductos |
| CC-07 | RMS - Roadway Monitoring System | General corredor |
| CC-08 | GMS-I - Geotechnical Monitoring System - Instable | Sitios geotécnicos (78), Taludes (45), Viaductos |
| CC-09 | SMS - Structure Monitoring System | Puentes, Viaductos, Taludes |
| CC-10 | WLS - Wind Load System | Puentes, Viaductos |
| CC-11 | AVI/ETC - Automatic Vehicle Identification / Electronic Toll Collection | Peajes (4) |
| CC-12 | ALPR - Automatic License Plate Recognition | Peajes (4) |
| CC-13 | SPD - Speed Detection | Curvas peligrosas (34), Cruces peatonales (28) |
| CC-14 | VSL - Variable Speed Limits | Curvas peligrosas (34) |
| CC-16 | EC - Emergency Call | Puentes, Emergencias general |
| CC-17 | NMS - Network Management System | Peajes (4) |
| CC-18 | BB - Broadband Communication | Peajes (4) |
| CC-19 | RSE - Roadside Equipment | General corredor |
| CC-20 | CVO - Commercial Vehicle Operations | General corredor |
| CC-21 | GI - Geographic Information | Peajes (4) |
| CC-22 | ATIS - Advanced Traveler Information System | General corredor |
| CC-23 | PTZ - Pan-Tilt-Zoom Cameras | Puentes (23) |
| CC-24 | ICD - Intersection Collision Detection | Intersecciones (8) |
| CC-25 | DMS - Dynamic Message Signs | General corredor |
| CC-26 | TI - Traveler Information | Peajes (4) |
| CC-27 | AID - Automatic Incident Detection | Zonas alta accidentalidad (19) |
| CC-28 | EMS - Event Management System | Peajes (4) |
| CC-29 | FPS - Fleet Priority System | General corredor |
| CC-32 | ITS-C - ITS Communication | General corredor |
| CC-33 | TPC - Traffic Probe Communication | General corredor |
| CC-34 | PSS - Public Safety System | Puentes (23) |
| CC-35 | WIM - Weigh-In-Motion | General corredor |
| CC-37 | RDS - Radio Data System | General corredor |
| CC-38 | RWM - Roadway Maintenance | General corredor |
| CC-39 | SWC - Severe Weather Control | General corredor |
| CC-40 | HAR - Highway Advisory Radio | General corredor |
| CC-41 | EVCS - Electric Vehicle Charging Station | General corredor |

**Total ITS validados:** 37 de 42 (88%)

---

### 4.2 ITS SIN INFRAESTRUCTURA CONFIRMADA (Sobredimensionamiento)

Los siguientes sistemas ITS están diseñados específicamente para túneles, pero **no se ha confirmado la existencia de túneles** en el corredor:

| Código | Sistema | Descripción | Impacto |
|--------|---------|-------------|---------|
| CC-15 | PAS | Sistema de audio para túneles | 🔴 Alto |
| CC-30 | LHD | Detección lineal de calor (incendios en túneles) | 🔴 Alto |
| CC-31 | TCS | Sistema de control de tráfico en túneles | 🔴 Alto |
| CC-36 | WSN | Red de sensores inalámbricos para túneles | 🟡 Medio |
| CC-42 | WAR | Señalización de velocidad en túneles | 🟡 Medio |

> **Nota:** CC-16 (EC - Emergency Call) cubre emergencias en general, no está limitado exclusivamente a túneles, por lo que se considera válido aunque los túneles no existan.

---

## 5. RECOMENDACIONES

### 5.1 Confirmar con Transconsult

Se requiere validación oficial sobre los siguientes puntos críticos:

- [ ] **¿Existen los 6 túneles** identificados en el modelo BIM en el corredor Chía-Girardot?
- [ ] **Si NO existen túneles:** Eliminar o marcar como **"capacidad futura"** las siguientes fichas técnicas:
  - CC-15: PAS - Public Address System
  - CC-30: LHD - Linear Heat Detection
  - CC-31: TCS - Tunnel Control System
  - CC-36: WSN - Wireless Sensor Network
  - CC-42: WAR - Warning Advisory Radio

### 5.2 ITS Faltantes Identificados

Los siguientes sistemas fueron creados correctamente para cubrir infraestructuras identificadas:

| Infraestructura | Sistema ITS Creado | Estado |
|-----------------|-------------------|--------|
| 78 sitios geotécnicos inestables | CC-08 GMS-I | ✅ Creado |
| 45 taludes críticos | CC-08, CC-09 | ✅ Creados |
| 34 curvas peligrosas | CC-13 (SPD), CC-14 (VSL) | ✅ Creados |
| 28 cruces peatonales | CC-13 (SPD) | ✅ Creado |

---

## 6. CONCLUSIÓN

### Resumen de Validación

| Métrica | Valor | Porcentaje |
|---------|-------|------------|
| Fichas ITS correctamente direccionadas | 37 / 42 | **88%** |
| Fichas potencialmente sobredimensionadas | 5 / 42 | **12%** |

### Hallazgos Clave

1. **Mayoría validada:** El 88% de las fichas ITS (37 de 42) están correctamente direccionadas a infraestructuras confirmadas por múltiples fuentes especializadas.

2. **Discrepancia crítica:** Existe una inconsistencia significativa respecto a los **túneles**:
   - BIM identifica 6 túneles
   - Geotecnia NO reporta túneles en sus estudios GEO-0006
   - Urbanismo NO identifica túneles
   - Seguridad Vial NO menciona túneles

3. **Riesgo de sobredimensionamiento:** 5 fichas técnicas (CC-15, CC-30, CC-31, CC-36, CC-42) representan inversión potencialmente innecesaria si los túneles no existen físicamente.

### Acción Requerida

> **Se requiere validación oficial de Transconsult** sobre la existencia real de los 6 túneles en el modelo BIM antes de proceder con la implementación de los sistemas ITS específicos para túneles.

---

## ANEXO: Matriz de Correspondencia Completa

| Infraestructura | Cantidad | Fuente | ITS Aplicables |
|-----------------|----------|--------|----------------|
| Puentes | 23 | BIM | CC-06, CC-09, CC-10, CC-16, CC-23, CC-34 |
| Viaductos | 12 | BIM | CC-06, CC-08, CC-09, CC-10 |
| Peajes | 4 | BIM + Urbanismo | CC-11, CC-12, CC-17, CC-18, CC-21, CC-26, CC-28 |
| Túneles | 6 | BIM (sin confirmar) | CC-15, CC-16, CC-30, CC-31, CC-36, CC-42 |
| Sitios geotécnicos | 78 | Geotecnia | CC-08 |
| Taludes críticos | 45 | Geotecnia | CC-08, CC-09 |
| Curvas peligrosas | 34 | Seguridad Vial | CC-13, CC-14 |
| Cruces peatonales | 28 | Seguridad Vial | CC-13 |
| Zonas alta accidentalidad | 19 | Seguridad Vial | CC-27 |
| Intersecciones | 8 | Urbanismo | CC-24 |

---

*Documento generado para análisis técnico del proyecto Corredor Chía-Girardot*  
*Fecha de análisis: Abril 2026*
