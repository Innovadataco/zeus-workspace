const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function downloadFile(fileId, destPath) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.get({
      fileId: fileId,
      alt: 'media'
    }, { responseType: 'stream' });
    
    const dest = fs.createWriteStream(destPath);
    response.data.pipe(dest);
    
    return new Promise((resolve, reject) => {
      dest.on('finish', () => resolve(`✅ Descargado: ${path.basename(destPath)}`));
      dest.on('error', reject);
    });
  } catch (error) {
    console.error(`❌ Error: ${error.message}`);
    throw error;
  }
}

// Documentos clave a descargar
const docsToDownload = [
  // Geotecnia - Estudio principal
  { id: '1FC0CMG-TEC-GEN-0000-IN-GEO-0006_VBB', name: 'GEO-0006_Estudio_Geotecnico.docx' },
  // Seguridad Vial
  { id: '1FC0CMG-TEC-GEN-0000-IN-SEG-0001_A01_VBB', name: 'SEG-0001_A01_SeguridadVial.pdf' },
  // Indicadores
  { id: '1Indicadores_vias_puentes', name: 'Indicadores_Vias_Puentes.docx' },
];

async function main() {
  const downloadPath = '/root/.openclaw/workspace/docs-referencia';
  if (!fs.existsSync(downloadPath)) fs.mkdirSync(downloadPath, { recursive: true });
  
  console.log('Descargando documentos de referencia...\n');
  
  for (const doc of docsToDownload) {
    console.log(`⏳ ${doc.name}...`);
    try {
      // Nota: Necesito los IDs reales de los archivos
      console.log(`   (Pendiente - necesito IDs específicos)`);
    } catch (err) {
      console.log(`   ❌ Error: ${err.message}`);
    }
  }
  
  console.log(`\n📁 Los documentos se guardarán en: ${downloadPath}`);
}

main().catch(console.error);
