const fs = require('fs');
const path = require('path');

const outputDir = '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-COMPLETAS';
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

const contenido = fs.readFileSync('/tmp/capitulo8_1.md', 'utf8');

// Lista de CC a procesar con sus patrones exactos
const componentes = [
  { num: '01', titulo: 'CCTV (Sistema de Videovigilancia)', patron: 'CC-01:' },
  { num: '02', titulo: 'AID (Detección de Incidentes)', patron: 'CC-02:' },
  { num: '03', titulo: 'DMS/VMS (Sistema de Mensajería Variable)', patron: 'CC-03:' },
  { num: '04', titulo: 'ECS/SOS (Sistema de Llamada de Emergencia)', patron: 'CC-04:' },
  { num: '05', titulo: 'VDS/TDS (Sistema de Detección de Tráfico)', patron: 'CC-05:' },
  { num: '06', titulo: 'ESS/RWIS (Sensores Ambientales)', patron: 'CC-06:' },
  { num: '07', titulo: 'WIM (Pesaje Dinámico)', patron: 'CC-07:' },
  { num: '08', titulo: 'GMS-I (Sistema de Monitoreo Geotécnico)', patron: 'CC-08:' },
  { num: '09', titulo: 'SMS/SBT (Sistema de Monitoreo de Estructuras)', patron: 'CC-09:' },
  { num: '10', titulo: 'WLS (Sistema de Monitoreo Hídrico)', patron: 'CC-10:' },
  { num: '11', titulo: 'AVI/ETC (Sistema de Peajes Electrónicos)', patron: 'CC-11' },
  { num: '12', titulo: 'ALPR/LPR (Reconocimiento Automático de Placas)', patron: 'CC- 12:' },
  { num: '13', titulo: 'SPD (Radar Pedagógico)', patron: 'CC-13:' },
  { num: '14', titulo: 'VSL (Velocidad Variable)', patron: 'CC-14:' },
  { num: '15', titulo: 'PAS (Sistema de Megafonía / Public Address)', patron: 'CC- 15:' },
  { num: '16', titulo: 'EC (Teléfonos de Emergencia SOS)', patron: 'CC-16:' },
  { num: '17', titulo: 'NTCIP (Protocolos de Comunicación ITS)', patron: 'CC-17:' },
  { num: '18', titulo: 'FO (Red Troncal de Fibra Óptica)', patron: 'CC- 18:' },
  { num: '19', titulo: 'CCO (Centro de Control y Operaciones)', patron: 'CC-19:' },
  { num: '20', titulo: 'WAR (Gestión de Zonas de Obra)', patron: 'CC-20:' },
  { num: '21', titulo: 'GI (Interfaz de Peaje y Control de Acceso)', patron: 'CC -21:' },
  { num: '22', titulo: 'UPS (Alimentación Ininterrumpida)', patron: 'CC-22:' },
  { num: '23', titulo: 'PTZ (Cámaras Domo Motorizadas)', patron: 'CC-23:' },
  { num: '24', titulo: 'GW (Gateway de Interconexión ITS)', patron: 'CC-24:' },
  { num: '25', titulo: 'TMS (Software de Gestión de Tráfico)', patron: 'CC-25:' },
  { num: '26', titulo: 'MOB (Sistemas Móviles y Portátiles)', patron: 'CC-26:' },
  { num: '27', titulo: 'BKP (Sistemas de Respaldo)', patron: 'CC-27:' },
  { num: '28', titulo: 'EMS (Sistema de Monitoreo Ambiental)', patron: 'CC-28:' },
  { num: '29', titulo: 'SLP (Alumbrado Público Inteligente)', patron: 'CC-29:' },
  { num: '30', titulo: 'LCS (Sistema de Control de Carriles)', patron: 'CC-30:' },
  { num: '31', titulo: 'AQM (Sistema de Monitoreo de Calidad del Aire)', patron: 'CC-31:' },
  { num: '32', titulo: 'WAR-2 (Gestión de Zonas de Obra Móvil)', patron: 'CC-32:' },
  { num: '33', titulo: 'LCS-2 (Señales de Control de Carril Adicionales)', patron: 'CC-33:' },
  { num: '34', titulo: 'PSS (Sistema de Protección Perimetral)', patron: 'CC-34:' },
  { num: '35', titulo: 'UPS/EPS (Sistema de Energía de Respaldo)', patron: 'CC-35:' },
  { num: '36', titulo: 'V2X-H (Comunicación Vehículo-Infraestructura)', patron: 'CC-36:' },
  { num: '37', titulo: 'WDA (Detección de Condiciones Atmosféricas)', patron: 'CC-37:' },
  { num: '38', titulo: 'ADS (Sistema de Detección de Amenazas)', patron: 'CC-38:' },
  { num: '39', titulo: 'MSG (Mensajería de Seguridad General)', patron: 'CC-39:' },
  { num: '40', titulo: 'D-TWN (Detección de Trabajadores en Zonas de Riesgo)', patron: 'CC-40:' },
  { num: '41', titulo: 'E-LOG (Sistema de Registro Electrónico)', patron: 'CC-41:' },
  { num: '42', titulo: 'SAT-B (Comunicación Satelital de Respaldo)', patron: 'CC-42:' }
];

function extraerSeccionCC(texto, patronInicio, patronesFin) {
  // Encontrar el índice de inicio
  const idxInicio = texto.indexOf(patronInicio);
  if (idxInicio === -1) return null;
  
  // Buscar el siguiente CC o el final del documento
  let idxFin = texto.length;
  for (const patronFin of patronesFin) {
    const idx = texto.indexOf(patronFin, idxInicio + patronInicio.length);
    if (idx !== -1 && idx < idxFin) {
      idxFin = idx;
    }
  }
  
  return texto.substring(idxInicio, idxFin).trim();
}

function generarFichaMarkdown(numero, titulo, contenidoCC) {
  // Extraer partes del contenido
  const lineas = contenidoCC.split('\n');
  
  // Extraer descripción general (primer párrafo después del título)
  let descripcionGeneral = '';
  for (let i = 1; i < lineas.length; i++) {
    if (lineas[i].trim() && !lineas[i].includes('Descripción Funcional')) {
      descripcionGeneral = lineas[i].trim();
      break;
    }
  }
  
  // Función para extraer sección completa
  function extraerSeccion(nombreSeccion, siguienteSeccion) {
    const regex = new RegExp(`${nombreSeccion}[\\s\\S]*?(?=${siguienteSeccion}|$)`, 'i');
    const match = contenidoCC.match(regex);
    return match ? match[0].trim() : '';
  }
  
  const descFuncional = extraerSeccion('Descripción Funcional / Técnica', 'Justificación Estratégica');
  const justificacion = extraerSeccion('Justificación Estratégica', 'Especificación Técnica');
  const especificacion = extraerSeccion('Especificación Técnica', 'Requerimientos Funcionales');
  const requerimientos = extraerSeccion('Requerimientos Funcionales', 'Requisitos No Funcionales');
  const rnfs = extraerSeccion('Requisitos No Funcionales', 'Indicadores|CC-\\d|Fin documento');
  
  return `# CC-${numero}: ${titulo.toUpperCase()}
## Component Card - Ficha Técnica
## Capítulo 8.1 - Requerimientos Funcionales y No Funcionales

---

### 1. IDENTIFICACIÓN

| Campo | Valor |
|-------|-------|
| **Código** | CC-${numero} |
| **Nombre** | ${titulo} |
| **Categoría** | Sistema ITS |
| **Proyecto** | APP Chía-Girardot ITS |
| **Documento Fuente** | Entregable ITS V1.docx - Capítulo 8.1 |

---

### 2. DESCRIPCIÓN GENERAL

${descripcionGeneral}

---

### 3. DESCRIPCIÓN FUNCIONAL / TÉCNICA

${descFuncional.replace('Descripción Funcional / Técnica', '').trim()}

---

### 4. JUSTIFICACIÓN ESTRATÉGICA

${justificacion.replace('Justificación Estratégica', '').trim()}

---

### 5. ESPECIFICACIÓN TÉCNICA (ET)

${especificacion.replace('Especificación Técnica', '').trim()}

---

### 6. REQUERIMIENTOS FUNCIONALES (RF)

${requerimientos.replace('Requerimientos Funcionales (RF)', '').trim()}

---

### 7. REQUISITOS NO FUNCIONALES (RNF)

${rnfs.replace('Requisitos No Funcionales (RNF)', '').trim()}

---

### 8. INTERFACES Y CONECTIVIDAD

- Integración con subsistemas ITS del corredor
- Comunicación con Centro de Control de Operaciones (CCO)
- Protocolos estándar de la industria
- Cumplimiento normativo ITS Colombia

---

### 9. ESTÁNDARES Y NORMAS

- Resolución 1090 de 2020 (ITS Colombia)
- Resolución 28675 de 2022 (Seguridad Vial)
- Estándares IEEE, ISO aplicables
- Normativa RETIE (instalaciones eléctricas)

---

**ZEUS - Agente IA InnovaDataCo**  
*Ficha Técnica generada desde Capítulo 8.1 - Entregable ITS V1*  
*Proyecto APP Chía-Girardot ITS*

---

*Fecha de generación: 28 Abril 2026*  
*Fuente: Documento Maestro - Innovadataco*
`;
}

console.log('📄 Generando 42 fichas CC COMPLETAS...\n');

let generados = 0;
let errores = [];

for (const comp of componentes) {
  // Generar patrones de fin (todos los posibles siguientes CC)
  const patronesFin = [];
  for (const otro of componentes) {
    if (otro.num !== comp.num) {
      patronesFin.push(otro.patron);
    }
  }
  
  const contenidoCC = extraerSeccionCC(contenido, comp.patron, patronesFin);
  
  if (contenidoCC) {
    const ficha = generarFichaMarkdown(comp.num, comp.titulo, contenidoCC);
    const nombreArchivo = `CC-${comp.num}-${comp.titulo.replace(/[^a-zA-Z0-9]/g, '-').substring(0, 40)}.md`;
    fs.writeFileSync(path.join(outputDir, nombreArchivo), ficha);
    console.log(`✅ CC-${comp.num}: ${comp.titulo}`);
    generados++;
  } else {
    console.log(`❌ CC-${comp.num}: No encontrado`);
    errores.push(comp.num);
  }
}

console.log('\n═══════════════════════════════════════════════════');
console.log(`✅ ${generados} fichas CC generadas`);
if (errores.length > 0) {
  console.log(`❌ Errores: ${errores.join(', ')}`);
}
console.log(`📂 Ubicación: ${outputDir}/`);
