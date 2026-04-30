# Investigación de Mercado - CC-05: VDS/TDS (Vehicle Detection System)

## 1. Especificaciones Técnicas

### 1.1 Descripción del Equipo
| Campo | Especificación |
|-------|----------------|
| **Código** | CC-05 |
| **Nombre Completo** | Vehicle Detection System / Traffic Detection System |
| **Categoría** | Sistema de Detección Vehicular |
| **Aplicación Principal** | Detección de tráfico en intersecciones y carreteras para control de semáforos y monitoreo |

### 1.2 Especificaciones Funcionales
| Parámetro | Especificación |
|-----------|----------------|
| Tipo de detección | Radar Doppler, Video análisis, o Híbrido (Video + Radar) |
| Zonas de detección | Stop bar, Zona avanzada, Dilemma zone |
| Precisión de conteo | >95% |
| Precisión de velocidad | ±1.5 kph (Radar) |
| Clasificación vehicular | Livianos, pesados, motocicletas, bicicletas, peatones |
| Alcance detección | Hasta 183 m (600 ft) con radar |
| Ángulo de visión | 360° (Radar), configurable (Video) |
| Comunicaciones | RS-485, Ethernet, Modbus |
| Entradas/Salidas | Múltiples contactos secos o interfaz con controlador de tráfico |
| Alimentación | 12-24 VDC / 110-220 VAC |

### 1.3 Especificaciones Técnicas Detalladas (Basado en estándar industriales)
| Característica | Valor |
|----------------|-------|
| Frecuencia de radar | 24 GHz (banda K) |
| Tecnología de procesamiento | AI/Machine Learning para clasificación |
| Resolución de video | 1080p HD (sistemas híbridos modernos) |
| Temperatura operación | -37°C a +74°C |
| Humedad | 0-100% RH |
| Protección IP | IP65 o superior |

## 2. Fabricantes Internacionales

### 2.1 Wavetronix (USA)
| Aspecto | Información |
|---------|-------------|
| **Producto** | SmartSensor HD |
| **País** | Estados Unidos |
| **Web** | https://www.wavetronix.com |
| **Descripción** | Sistema de detección de tráfico por radar con tecnología HD |
| **Alcance** | Hasta 183 m |
| **Especificaciones Clave** | Múltiples zonas de detección, clasificación vehicular, velocidad, presencia |
| **Datasheet** | Disponible en web oficial |
| **Certificaciones** | NEMA, FCC |

### 2.2 Iteris (USA)
| Aspecto | Información |
|---------|-------------|
| **Producto** | Vantage Apex, Vantage Vector |
| **País** | Estados Unidos |
| **Web** | https://www.iteris.com |
| **Descripción** | Sistema híbrido de video + radar con AI integrada |
| **Alcance** | Hasta 183 m (600 ft) |
| **Especificaciones Clave** | Video 1080p HD, radar 4D/HD, sensor fusion, SmartCycle para bicicletas |
| **Datasheet** | Disponible en web oficial |
| **Certificaciones** | NEMA TS-2, FCC |

### 2.3 Kistler (Suiza)
| Aspecto | Información |
|---------|-------------|
| **Producto** | Lineasens C (para clasificación) |
| **País** | Suiza |
| **Web** | https://www.kistler.com |
| **Descripción** | Sistema de detección vehicular y clasificación |
| **Especificaciones Clave** | Precisión >95%, clasificación por esquema de ejes |
| **Datasheet** | Disponible en web oficial |
| **Certificaciones** | CE, NEMA |

### 2.4 Sensys (USA)
| Aspecto | Información |
|---------|-------------|
| **Producto** | Sensys VDS240 Wireless |
| **País** | Estados Unidos |
| **Web** | https://www.sensysnetworks.com |
| **Descripción** | Sistema de detección vehicular inalámbrico |
| **Especificaciones Clave** | Detección inalámbrica, instalación sin pavimentación |

## 3. Fabricantes en LATAM

### 3.1 ITS Colombia (Distribuidor)
| Aspecto | Información |
|---------|-------------|
| **Ubicación** | Colombia |
| **Productos** | Sistemas de detección de tráfico |
| **Marcas Distribuidas** | Wavetronix, otros fabricantes internacionales |
| **Servicios** | Instalación, mantenimiento, soporte local |
| **Observación** | Proveedor local con experiencia en proyectos de infraestructura vial |

### 3.2 Proveedores en México
| Aspecto | Información |
|---------|-------------|
| **Distribuidores Vaisala** | Orvhemet SA de CV (carreteras) |
| **Otros** | Haften (aplicaciones HVAC y control industrial) |

## 4. Proveedores en Colombia

### 4.1 ITS Colombia / Proveedores Locales de Infraestructura Vial
| Aspecto | Información |
|---------|-------------|
| **Ubicación** | Bogotá y principales ciudades |
| **Servicios** | Suministro e instalación de sistemas ITS |
| **Marcas** | Wavetronix, Iteris, y otras marcas internacionales |
| **Experiencia** | Proyectos de control de tráfico en carreteras nacionales |

### 4.2 Vías Colombia / Concesionarias
| Aspecto | Información |
|---------|-------------|
| **Observación** | Las concesionarias de carreteras en Colombia trabajan con proveedores internacionales certificados |
| **Proveedores Típicos** | Distribuidores autorizados de marcas como Wavetronix y Iteris |

## 5. Análisis Comparativo

### 5.1 Comparación Técnica
| Característica | Wavetronix | Iteris | Kistler |
|----------------|------------|--------|---------|
| Tecnología | Radar HD | Híbrido Video+Radar | Piezoeléctrico/Radar |
| Alcance | 183 m | 183 m | Variable |
| Clasificación | Avanzada | Avanzada (AI) | Por esquema de ejes |
| Interfaz | RS-485/Ethernet | Ethernet/Modbus | RS-485 |
| Precio Estimado | Medio-Alto | Alto | Medio-Alto |

### 5.2 Recomendación
Basado en las especificaciones del proyecto y disponibilidad en mercado local:

1. **Opción Primaria**: Wavetronix SmartSensor HD - Tecnología probada, disponibilidad en Colombia, buen soporte técnico
2. **Opción Alternativa**: Iteris Vantage Apex - Tecnología de punta con AI, mejor para proyectos de alta complejidad
3. **Opción Económica**: Sensys Wireless - Menor costo de instalación (sin zanjas)

## 6. Documentación y Referencias

### 6.1 Datasheets Consultados
- Wavetronix SmartSensor HD Datasheet
- Iteris Vantage Apex Specifications
- Kistler Lineasens C Product Information

### 6.2 Fuentes de Información
- Sitios web oficiales de fabricantes
- Catálogos técnicos disponibles públicamente
- Estándares NEMA TS-2 para detectores de tráfico

---
*Investigación generada: 2026-04-29*
*Para: Proyecto de Control de Carreteras - Innovadataco*
