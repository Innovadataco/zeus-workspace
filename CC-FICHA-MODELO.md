# CC-07-MODELO: WIM - Sistema de Pesaje en Movimiento

> **VERSIÓN MODELO** — Estructura validada para migración de las 42 fichas CC

---

## 1. CÓDIGO Y NOMBRE

| Campo | Valor |
|-------|-------|
| **Código** | CC-07 |
| **Sigla** | WIM |
| **Nombre Completo** | Sistema de Pesaje en Movimiento (Weigh-in-Motion) |
| **Capacidad Principal** | Control de Carga en Movimiento: Monitorear pesos vehiculares por eje sin interrumpir la fluidez del tránsito |

---

## 2. REQUERIMIENTOS FUNCIONALES (RF)

| ID | Requerimiento | Prioridad |
|----|---------------|-----------|
| RF-01 | Pesaje de ejes individuales en movimiento | Crítica |
| RF-02 | Cálculo automático de peso bruto vehicular | Crítica |
| RF-03 | Medición de velocidad del vehículo | Crítica |
| RF-04 | Clasificación por configuración de ejes | Crítica |
| RF-05 | Detección de sobrecarga con alertas | Crítica |
| RF-06 | Corrección de peso por velocidad | Alta |
| RF-07 | Registro de datos con timestamp | Alta |
| RF-08 | Integración con sistemas de peaje/ALPR | Alta |
| RF-09 | Calibración remota | Media |
| RF-10 | Reportes estadísticos de tráfico | Media |

---

## 3. REQUERIMIENTOS NO FUNCIONALES (RNF)

| ID | Requisito | Métrica |
|----|-----------|---------|
| RNF-01 | Precisión de pesaje | Clase A (±5% PBV) |
| RNF-02 | Disponibilidad del sistema | ≥ 99% |
| RNF-03 | Latencia de datos | ≤ 3 segundos |
| RNF-04 | Resistencia ambiental | IP68, -20°C a +70°C |
| RNF-05 | Resistencia mecánica | Hasta 12 ton/ele |
| RNF-06 | Seguridad cibernética | Cifrado AES-256 |
| RNF-07 | Mantenibilidad | MTTR ≤ 4 horas |

---

## 4. ESPECIFICACIONES TÉCNICAS

| Parámetro | Especificación |
|-----------|----------------|
| Rango de peso por eje | 0 - 25,000 kg |
| Precisión eje individual | Clase A: ±7%, Clase B: ±10% |
| Precisión peso bruto | Clase A: ±5%, Clase B: ±10% |
| Rango de velocidad | 5 - 120 km/h |
| Resolución de peso | 10 kg |
| Distancia entre ejes | 1.0 - 24.0 metros |
| Temperatura operación | -20°C a +70°C |
| Capacidad de tráfico | Hasta 2,000 veh/hora |
| Vida útil estimada | 10-15 años |

---

## 5. FICHAS DE FABRICANTES INTERNACIONALES (3)

### FABRICANTE 1: Kistler
| Campo | Información |
|-------|-------------|
| **País** | Suiza 🇨🇭 |
| **Modelo Referencia** | Lineasens C |
| **Tecnología** | Sensores piezoeléctricos de alta precisión |
| **Características** | Precisión Clase A, estabilidad a largo plazo, integración completa con sistemas de peaje |
| **Rango de precios** | $80,000 - $150,000 USD por estación |
| **Casos de referencia** | Autopistas europeas, sistema viario suizo, proyectos en Alemania y Austria |
| **Contacto** | https://www.kistler.com |

### FABRICANTE 2: International Road Dynamics (IRD)
| Campo | Información |
|-------|-------------|
| **País** | Canadá 🇨🇦 |
| **Modelo Referencia** | IRD WIM / iSINC |
| **Tecnología** | Sistemas completos integrados con software de gestión |
| **Características** | Amplia experiencia en Norteamérica, integración con sistemas de fiscalización, soporte local en Canadá y USA |
| **Rango de precios** | $60,000 - $120,000 USD por estación |
| **Casos de referencia** | Carreteras de Saskatchewan, proyectos en Ontario, sistemas fronterizos USA-Canadá |
| **Contacto** | https://www.irdinc.com |

### FABRICANTE 3: METTLER TOLEDO
| Campo | Información |
|-------|-------------|
| **País** | Suiza 🇨🇭 |
| **Modelo Referencia** | WIM Systems |
| **Tecnología** | Células de carga de alta precisión |
| **Características** | Tecnología de pesaje industrial adaptada a tráfico, precisión Clase A, servicio global |
| **Rango de precios** | $70,000 - $130,000 USD por estación |
| **Casos de referencia** | Puertos europeos, terminales de carga, proyectos en Asia y Europa |
| **Contacto** | https://www.mt.com |

---

## 6. FICHAS DE FABRICANTES AMÉRICA (2)

### FABRICANTE AMÉRICA 1: Balanzas del Sur
| Campo | Información |
|-------|-------------|
| **País** | Colombia 🇨🇴 |
| **Ciudad** | Bogotá |
| **Modelo Referencia** | Soluciones WIM integradas Kistler |
| **Tecnología** | Distribución e integración de sensores piezoeléctricos |
| **Características** | Distribuidor oficial de Kistler, experiencia en pesaje industrial y vial, soporte técnico local en Colombia |
| **Rango de precios** | $90,000 - $160,000 USD (incluye instalación) |
| **Casos de referencia** | Proyectos de pesaje en concesiones viales colombianas, terminales de transporte, peajes |
| **Contacto** | https://www.balanzasdelsur.com |

### FABRICANTE AMÉRICA 2: ITS Colombia
| Campo | Información |
|-------|-------------|
| **País** | Colombia 🇨🇴 |
| **Ciudad** | Bogotá |
| **Modelo Referencia** | Integración WIM con infraestructura de peaje |
| **Tecnología** | Integración de sistemas Wavetronix y Sensys con peajes existentes |
| **Características** | Especialistas en integración ITS con infraestructura de peaje, experiencia en proyectos de concesiones |
| **Rango de precios** | $85,000 - $140,000 USD (paquete completo) |
| **Casos de referencia** | Concesiones viales en Colombia, integración de sistemas de peaje electrónico, proyectos con INVIAS |
| **Contacto** | https://www.itscolombia.com |

---

## 7. PROVEEDORES EN COLOMBIA (3)

### PROVEEDOR 1: Balanzas del Sur
| Campo | Información |
|-------|-------------|
| **Ciudad** | Bogotá |
| **Experiencia** | Distribuidor de Kistler, experiencia en pesaje industrial y vial |
| **Servicios** | Venta, instalación, calibración, mantenimiento preventivo y correctivo |
| **Tiempo de respuesta** | 24-48 horas en Bogotá, 48-72 horas en otras ciudades |
| **Contacto** | https://www.balanzasdelsur.com |

### PROVEEDOR 2: ITS Colombia
| Campo | Información |
|-------|-------------|
| **Ciudad** | Bogotá |
| **Experiencia** | Integración de sistemas WIM con infraestructura de peaje |
| **Servicios** | Diseño, integración, implementación, soporte técnico especializado |
| **Tiempo de respuesta** | 48 horas en principales ciudades |
| **Contacto** | https://www.itscolombia.com |

### PROVEEDOR 3: Innovadataco
| Campo | Información |
|-------|-------------|
| **Ciudad** | Girardot |
| **Experiencia** | Consultoría e integración de sistemas WIM para concesiones |
| **Servicios** | Consultoría técnica, integración de sistemas, capacitación, soporte especializado |
| **Tiempo de respuesta** | 24-72 horas según ubicación |
| **Contacto** | https://innovadataco.com |

---

## 8. NOTAS DE ESTRUCTURA MODELO

### Formato validado para migración:
- ✅ Código + Nombre consolidado
- ✅ RF simplificados (10 items)
- ✅ RNF simplificados (7 items)
- ✅ Especificaciones técnicas en tabla única
- ✅ 3 fabricantes internacionales con ficha detallada
- ✅ 2 fabricantes de América (LATAM) con ficha detallada
- ✅ 3 proveedores Colombia con ficha detallada

### Próximo paso:
Si esta estructura es aprobada, se replica para las 42 fichas CC restantes.

---

**Fecha de elaboración:** 28 Abril 2026  
**Elaborado por:** ZEUS — Gerente de Proyecto  
**Versión:** 1.0 MODELO
