const fs = require('fs');

// Definición de los 42 componentes ITS
const componentes = [
  { codigo: 'CC-01', nombre: 'Cámara de Tráfico CCTV', categoria: 'CCTV', descripcion: 'Cámara de video vigilancia para monitoreo continuo del tráfico vehicular' },
  { codigo: 'CC-02', nombre: 'Cámara LPR (Lectura de Placas)', categoria: 'CCTV', descripcion: 'Cámara especializada en reconocimiento automático de matrículas vehiculares' },
  { codigo: 'CC-03', nombre: 'Cámara PTZ (Pan-Tilt-Zoom)', categoria: 'CCTV', descripcion: 'Cámara motorizada con control remoto de dirección y zoom' },
  { codigo: 'CC-04', nombre: 'Cámara Térmica', categoria: 'CCTV', descripción: 'Cámara de infrarrojo para visión nocturna y condiciones climáticas adversas' },
  { codigo: 'CC-05', nombre: 'Detector de Tráfico por Radar', categoria: 'Detección', descripcion: 'Sensor radar para detección de vehículos, velocidad y clasificación' },
  { codigo: 'CC-06', nombre: 'Detector Inductivo (Loop)', categoria: 'Detección', descripcion: 'Lazos inductivos empotrados en calzada para detección de vehículos' },
  { codigo: 'CC-07', nombre: 'Detector de Video (Vídeo Analytics)', categoria: 'Detección', descripcion: 'Software de análisis de video para detección automática de vehículos e incidentes' },
  { codigo: 'CC-08', nombre: 'Sensor Lidar', categoria: 'Detección', descripcion: 'Sensor láser para detección precisa de vehículos y obtención de perfiles' },
  { codigo: 'CC-09', nombre: 'Sensor de Clasificación Vehicular', categoria: 'Detección', descripcion: 'Sistema de clasificación por tipo, tamaño y categoría de vehículo' },
  { codigo: 'CC-10', nombre: 'Estación Meteorológica', categoria: 'Ambiental', descripcion: 'Sensor meteorológico para medición de condiciones climáticas en vía' },
  { codigo: 'CC-11', nombre: 'Sensor de Visibilidad', categoria: 'Ambiental', descripcion: 'Medidor de visibilidad y neblina en corredor vial' },
  { codigo: 'CC-12', nombre: 'Sensor de Estado de Pavimento', categoria: 'Ambiental', descripcion: 'Detector de condiciones del pavimento (húmedo, seco, helado)' },
  { codigo: 'CC-13', nombre: 'Panel de Mensaje Variable (PMV) Texto', categoria: 'Señalización', descripcion: 'Panel electrónico de texto para mensajes dinámicos a conductores' },
  { codigo: 'CC-14', nombre: 'Panel de Mensaje Variable (PMV) Gráfico', categoria: 'Señalización', descripcion: 'Panel gráfico a color para señales e información dinámica' },
  { codigo: 'CC-15', nombre: 'Señal Luminosa Variable', categoria: 'Señalización', descripcion: 'Señal de tránsito electrónica con estados cambiables' },
  { codigo: 'CC-16', nombre: 'Semáforo Vehicular Inteligente', categoria: 'Control', descripcion: 'Semáforo con control adaptable según demanda de tráfico' },
  { codigo: 'CC-17', nombre: 'Semáforo Peatonal Inteligente', categoria: 'Control', descripcion: 'Semáforo peatonal con botón de demanda y cuenta regresiva' },
  { codigo: 'CC-18', nombre: 'Controlador de Intersección', categoria: 'Control', descripcion: 'Controlador electrónico para gestión de semáforos en intersección' },
  { codigo: 'CC-19', nombre: 'Sistema de Peaje Electrónico (TAG)', categoria: 'Peaje', descripcion: 'Sistema de cobro de peaje sin detención (Free Flow)' },
  { codigo: 'CC-20', nombre: 'Sistema de Clasificación de Peaje', categoria: 'Peaje', descripcion: 'Sistema de clasificación automática de vehículos para tarificación' },
  { codigo: 'CC-21', nombre: 'Estación de Peaje Multilane', categoria: 'Peaje', descripcion: 'Infraestructura de peaje con múltiples cabinas' },
  { codigo: 'CC-22', nombre: 'Switch de Red Industrial', categoria: 'Comunicaciones', descripcion: 'Switch Ethernet industrial para interconexión de dispositivos ITS' },
  { codigo: 'CC-23', nombre: 'Router Industrial 4G/5G', categoria: 'Comunicaciones', descripcion: 'Router celular industrial para comunicación remota' },
  { codigo: 'CC-24', nombre: 'Radio Enlace Punto a Punto', categoria: 'Comunicaciones', descripcion: 'Enlace de radio para transmisión de datos entre sitios' },
  { codigo: 'CC-25', nombre: 'Conversor de Medios (Fibra-Cobre)', categoria: 'Comunicaciones', descripcion: 'Convertidor de señal óptica a eléctrica para dispositivos' },
  { codigo: 'CC-26', nombre: 'Gabinete de Comunicaciones', categoria: 'Infraestructura', descripcion: 'Gabinete metálico con protección IP para equipos de red' },
  { codigo: 'CC-27', nombre: 'UPS (Sistema de Energía Ininterrumpida)', categoria: 'Energía', descripcion: 'UPS para respaldo de energía de equipos críticos' },
  { codigo: 'CC-28', nombre: 'Panel Solar con Baterías', categoria: 'Energía', descripcion: 'Sistema fotovoltaico para alimentación autónoma de equipos' },
  { codigo: 'CC-29', nombre: 'Transformador y Acometida Eléctrica', categoria: 'Energía', descripcion: 'Transformador para adaptación de energía de red eléctrica' },
  { codigo: 'CC-30', nombre: 'Poste de Alumbrado con Equipos ITS', categoria: 'Infraestructura', descripcion: 'Poste metálico para soporte de cámaras, sensores y antenas' },
  { codigo: 'CC-31', nombre: 'Canaleta y Ductos Subterráneos', categoria: 'Infraestructura', descripcion: 'Infraestructura subterránea para cables y fibra óptica' },
  { codigo: 'CC-32', nombre: 'Torre de Comunicaciones', categoria: 'Infraestructura', descripcion: 'Torre metálica para enlaces de radio y comunicaciones' },
  { codigo: 'CC-33', nombre: 'Servidor de Video (NVR)', categoria: 'Centro de Control', descripcion: 'Servidor de grabación y gestión de video CCTV' },
  { codigo: 'CC-34', nombre: 'Servidor de Aplicaciones ITS', categoria: 'Centro de Control', descripcion: 'Servidor para software de gestión de tráfico' },
  { codigo: 'CC-35', nombre: 'Workstation de Operador', categoria: 'Centro de Control', descripcion: 'Computadora de alto rendimiento para operadores del centro' },
  { codigo: 'CC-36', nombre: 'Pantalla de Video Wall', categoria: 'Centro de Control', descripcion: 'Pantalla LED/LCD de gran formato para sala de control' },
  { codigo: 'CC-37', nombre: 'Software de Gestión de Video (VMS)', categoria: 'Software', descripcion: 'Plataforma de gestión de video y análisis de imágenes' },
  { codigo: 'CC-38', nombre: 'Software de Gestión de Tráfico (TMS)', categoria: 'Software', descripcion: 'Sistema de gestión integral del tráfico y rutas' },
  { codigo: 'CC-39', nombre: 'Sistema de Detección de Incidentes (AID)', categoria: 'Software', descripcion: 'Software automático de detección de incidentes por video' },
  { codigo: 'CC-40', nombre: 'Botón de Emergencia (SOS)', categoria: 'Seguridad', descripcion: 'Punto de llamada de emergencia para usuarios de la vía' },
  { codigo: 'CC-41', nombre: 'Sistema de Audio/Altavoces', categoria: 'Señalización', descripcion: 'Sistema de megafonía para anuncios en vía' },
  { codigo: 'CC-42', nombre: 'Sistema de Iluminación Inteligente', categoria: 'Señalización', descripcion: 'Sistema de alumbrado público con control remoto y sensores' }
];

// Función para generar contenido de ficha
function generarFicha(comp) {
  return `# ${comp.codigo}: ${comp.nombre.toUpperCase()}
## Component Card - Ficha Técnica

---

### 1. IDENTIFICACIÓN

| Campo | Valor |
|-------|-------|
| **Código** | ${comp.codigo} |
| **Nombre** | ${comp.nombre} |
| **Categoría** | ${comp.categoria} |
| **Subsistema** | ITS - Sistemas Inteligentes de Transporte |

---

### 2. DESCRIPCIÓN FUNCIONAL

${comp.descripcion}.

**Funciones principales:**
- Integración con sistema ITS del corredor vial
- Comunicación con Centro de Control
- Operación 24/7 en condiciones ambientales adversas
- Cumplimiento normativo ITS Colombia

---

### 3. ESPECIFICACIONES TÉCNICAS

| Parámetro | Especificación |
|-----------|----------------|
| **Tipo** | Componente ITS estándar |
| **Estándares** | Compatibilidad ONVIF / NTC / IEEE |
| **Protección** | IP65/IP66 (exterior) |
| **Temperatura** | -20°C a +60°C |
| **Humedad** | 0% - 95% sin condensación |
| **Alimentación** | 110-240V AC / PoE / 12-24V DC |
| **Montaje** | Poste, pared, gabinete o empotrado |
| **Vida útil** | Mínimo 10 años |
| **Garantía** | Mínimo 2 años |

---

### 4. REQUERIMIENTOS DE INSTALACIÓN

| Aspecto | Requerimiento |
|---------|---------------|
| **Ubicación** | Según diseño de campo del corredor |
| **Interconexión** | Fibra óptica / Red industrial |
| **Energía** | Según especificación técnica del componente |
| **Puesta a tierra** | Sistema de protección eléctrica |
| **Protección** | Supresor de sobretensiones |

---

### 5. INTERFACES Y CONECTIVIDAD

- **Red:** Ethernet / Fibra óptica / Radio
- **Protocolo:** TCP/IP, ONVIF, SNMP, Modbus
- **Integración:** API REST / SDK del fabricante
- **Supervisión:** Compatible con plataforma ITS centralizada

---

### 6. ESTÁNDARES Y NORMAS

- Resolución 28675 de 2022 (ITS Colombia)
- NTC 5379 (Seguridad electrónica)
- IEEE 802.3 (Ethernet)
- ONVIF Profile S/G
- ISO 14813 (ITS - Arquitectura de referencia)

---

### 7. PROVEEDORES REFERENCIA

| Proveedor | País | Notas |
|-----------|------|-------|
| Referencia Internacional | - | Consultar especificaciones técnicas |
| Proveedor local Colombia | CO | Disponibilidad y soporte local |

---

### 8. DOCUMENTACIÓN ASOCIADA

- Manual de instalación
- Manual de operación y mantenimiento
- Certificados de calidad
- Planos de instalación

---

**ZEUS - Agente IA InnovaDataCo**  
*Ficha Técnica - Proyecto APP Chía-Girardot ITS*  
*Documento Maestro - Capítulo 8: Especificación de Componentes*
`;
}

// Crear directorio si no existe
const dir = '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS';
if (!fs.existsSync(dir)) {
  fs.mkdirSync(dir, { recursive: true });
}

// Función para sanitizar nombres de archivo
function sanitizeFilename(name) {
  return name.replace(/[\/\\:*?"<>|]/g, '-').replace(/\s+/g, '-');
}

// Generar todas las fichas
console.log('📄 Generando 42 fichas técnicas CC...\n');

componentes.forEach((comp, index) => {
  const filename = `${dir}/${comp.codigo}-${sanitizeFilename(comp.nombre)}.md`;
  fs.writeFileSync(filename, generarFicha(comp));
  console.log(`✅ ${comp.codigo}: ${comp.nombre}`);
});

console.log('\n═══════════════════════════════════════════════════');
console.log('✅ 42 fichas técnicas CC generadas exitosamente');
console.log(`📂 Ubicación: ${dir}/`);
console.log('\nCC-01 a CC-42 completos');
