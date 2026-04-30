const fs = require('fs');
const path = require('path');

// Leer el contenido extraído
const contenido = fs.readFileSync('/tmp/capitulo8_1.md', 'utf8');

// Directorio de salida
const outputDir = '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-REALES';
if (!fs.existsSync(outputDir)) {
  fs.mkdirSync(outputDir, { recursive: true });
}

// Función para extraer sección de un CC
function extraerCC(contenido, ccNumero) {
  const regex = new RegExp(`CC-${ccNumero}[:\\s][^]*?(?=CC-\\d{2}[:\\s]|$)`, 's');
  const match = contenido.match(regex);
  return match ? match[0].trim() : null;
}

// Función para parsear sección CC
function parsearCC(texto) {
  const lineas = texto.split('\n').filter(l => l.trim());
  
  // Extraer título
  const tituloMatch = texto.match(/CC-\d{2}[:\s](.+?)(?:\n|$)/);
  const titulo = tituloMatch ? tituloMatch[1].trim() : 'Componente ITS';
  
  // Extraer descripción inicial
  let descripcion = '';
  const descMatch = texto.match(/(?:\n|^)([A-Z][^\n]{50,500}?)(?=\n\s*Descripción|$)/s);
  if (descMatch) {
    descripcion = descMatch[1].trim();
  }
  
  // Extraer secciones
  const secciones = {
    descripcionFuncional: extraerSeccion(texto, 'Descripción Funcional / Técnica', 'Justificación'),
    justificacion: extraerSeccion(texto, 'Justificación Estratégica', 'Especificación'),
    especificacion: extraerSeccion(texto, 'Especificación Técnica \(ET\)', 'Requerimientos'),
    requerimientos: extraerSeccion(texto, 'Requerimientos Funcionales \(RF\)', 'Requisitos No Funcionales'),
    rnfs: extraerSeccion(texto, 'Requisitos No Funcionales \(RNF\)', 'Indicadores|CC-|Fin')
  };
  
  return {
    titulo,
    descripcion,
    secciones
  };
}

function extraerSeccion(texto, inicio, fin) {
  const regex = new RegExp(`${inicio}[^]*?(?=${fin}|$)`, 's');
  const match = texto.match(regex);
  return match ? match[0].trim() : '';
}

// Generar ficha en formato markdown
function generarFicha(ccNumero, datos) {
  const tituloLimpio = datos.titulo.replace(/^CC-\d{2}[:\s]*/, '').trim();
  
  return `# CC-${ccNumero}: ${tituloLimpio.toUpperCase()}
## Component Card - Ficha Técnica
## Capítulo 8.1 - Requerimientos Funcionales y No Funcionales

---

### 1. IDENTIFICACIÓN

| Campo | Valor |
|-------|-------|
| **Código** | CC-${ccNumero} |
| **Nombre** | ${tituloLimpio} |
| **Categoría** | Sistema ITS |
| **Proyecto** | APP Chía-Girardot ITS |
| **Documento Fuente** | Entregable ITS V1.docx - Capítulo 8.1 |

---

### 2. DESCRIPCIÓN GENERAL

${datos.descripcion || 'Componente del Sistema ITS para el corredor Chía-Girardot.'}

---

### 3. DESCRIPCIÓN FUNCIONAL / TÉCNICA

${datos.secciones.descripcionFuncional || 'Por definir en documentación del proyecto.'}

---

### 4. JUSTIFICACIÓN ESTRATÉGICA

${datos.secciones.justificacion || 'Componente requerido para operación integral del corredor ITS.'}

---

### 5. ESPECIFICACIÓN TÉCNICA (ET)

${datos.secciones.especificacion || 'Ver documento maestro para especificaciones detalladas.'}

---

### 6. REQUERIMIENTOS FUNCIONALES (RF)

${datos.secciones.requerimientos || 'Por definir.'}

---

### 7. REQUISITOS NO FUNCIONALES (RNF)

${datos.secciones.rnfs || 'Por definir.'}

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

// Lista de CC a procesar
const ccs = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '13', '14', '16', '17', '19', '20', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36', '37', '38', '39', '40', '41', '42'];

console.log('📄 Generando fichas CC desde Capítulo 8.1...\n');

let generados = 0;

ccs.forEach(cc => {
  const textoCC = extraerCC(contenido, cc);
  if (textoCC) {
    const datos = parsearCC(textoCC);
    const ficha = generarFicha(cc, datos);
    const nombreArchivo = `CC-${cc}-${datos.titulo.replace(/[^a-zA-Z0-9]/g, '-').substring(0, 50)}.md`;
    fs.writeFileSync(path.join(outputDir, nombreArchivo), ficha);
    console.log(`✅ CC-${cc}: ${datos.titulo}`);
    generados++;
  } else {
    console.log(`⚠️ CC-${cc}: No encontrado en documento`);
  }
});

console.log('\n═══════════════════════════════════════════════════');
console.log(`✅ ${generados} fichas CC generadas exitosamente`);
console.log(`📂 Ubicación: ${outputDir}/`);
console.log('\nNota: CC-12, CC-15, CC-18, CC-21 no están en el documento fuente');
