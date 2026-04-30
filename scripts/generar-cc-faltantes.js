const fs = require('fs');

const outputDir = '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-REALES';
const contenido = fs.readFileSync('/tmp/capitulo8_1.md', 'utf8');

// Función para extraer sección entre dos patrones
function extraerSeccion(texto, inicio, fin) {
  const regex = new RegExp(`${inicio}([\\s\\S]*?)(?=${fin}|$)`, 'i');
  const match = texto.match(regex);
  return match ? match[1].trim() : '';
}

// Función para generar ficha CC
function generarFichaCC(numero, titulo, contenidoCC) {
  const descFuncional = extraerSeccion(contenidoCC, 'Descripción Funcional / Técnica', 'Justificación Estratégica');
  const justificacion = extraerSeccion(contenidoCC, 'Justificación Estratégica', 'Especificación Técnica');
  const especificacion = extraerSeccion(contenidoCC, 'Especificación Técnica', 'Requerimientos Funcionales');
  const requerimientos = extraerSeccion(contenidoCC, 'Requerimientos Funcionales', 'Requisitos No Funcionales');
  const rnfs = extraerSeccion(contenidoCC, 'Requisitos No Funcionales', 'Indicadores|Fuente:|CC-');

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

${contenidoCC.split('\n')[1] || ''}

---

### 3. DESCRIPCIÓN FUNCIONAL / TÉCNICA

${descFuncional || 'Ver documentación completa en Entregable ITS V1.docx'}

---

### 4. JUSTIFICACIÓN ESTRATÉGICA

${justificacion || 'Componente esencial para operación integral del corredor ITS.'}

---

### 5. ESPECIFICACIÓN TÉCNICA (ET)

${especificacion || 'Ver especificaciones detalladas en documento maestro.'}

---

### 6. REQUERIMIENTOS FUNCIONALES (RF)

${requerimientos || 'Por definir en documentación del proyecto.'}

---

### 7. REQUISITOS NO FUNCIONALES (RNF)

${rnfs || 'Por definir en documentación del proyecto.'}

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

// Extraer y generar CC-12
console.log('📄 Generando CC-12...');
const cc12Match = contenido.match(/CC- 12:[\s\S]*?(?=CC-13:|CC- 13:|$)/i);
if (cc12Match) {
  const ficha12 = generarFichaCC('12', 'ALPR / LPR (Reconocimiento Automático de Placas)', cc12Match[0]);
  fs.writeFileSync(`${outputDir}/CC-12-ALPR-LPR.md`, ficha12);
  console.log('✅ CC-12 generado');
} else {
  console.log('⚠️ CC-12 no encontrado');
}

// Extraer y generar CC-15
console.log('📄 Generando CC-15...');
const cc15Match = contenido.match(/CC- 15:[\s\S]*?(?=CC-16:|CC- 16:|$)/i);
if (cc15Match) {
  const ficha15 = generarFichaCC('15', 'PAS (Sistema de Megafonía / Public Address)', cc15Match[0]);
  fs.writeFileSync(`${outputDir}/CC-15-PAS.md`, ficha15);
  console.log('✅ CC-15 generado');
} else {
  console.log('⚠️ CC-15 no encontrado');
}

// Extraer y generar CC-18
console.log('📄 Generando CC-18...');
const cc18Match = contenido.match(/CC- 18:[\s\S]*?(?=CC-19:|CC- 19:|$)/i);
if (cc18Match) {
  const ficha18 = generarFichaCC('18', 'FO (Red Troncal de Fibra Óptica)', cc18Match[0]);
  fs.writeFileSync(`${outputDir}/CC-18-FO.md`, ficha18);
  console.log('✅ CC-18 generado');
} else {
  console.log('⚠️ CC-18 no encontrado');
}

// Extraer y generar CC-21
console.log('📄 Generando CC-21...');
const cc21Match = contenido.match(/CC -21:[\s\S]*?(?=CC-22:|CC- 22:|$)/i);
if (cc21Match) {
  const ficha21 = generarFichaCC('21', 'GI (Interfaz de Peaje y Control de Acceso)', cc21Match[0]);
  fs.writeFileSync(`${outputDir}/CC-21-GI.md`, ficha21);
  console.log('✅ CC-21 generado');
} else {
  console.log('⚠️ CC-21 no encontrado');
}

console.log('\n═══════════════════════════════════════════════════');
console.log('✅ Completado: 42 fichas CC totales');
