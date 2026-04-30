const { google } = require('googleapis');
const fs = require('fs');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['https://www.googleapis.com/auth/drive'],
  subject: 'gerencia@innovadataco.com'
});

async function listarCarpeta() {
  const drive = google.drive({ version: 'v3', auth });
  
  const folderId = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  
  console.log('📂 CARPETA: IDC_2026_01');
  console.log('═══════════════════════════════════════════════════\n');
  
  try {
    // Obtener info de la carpeta
    const folderInfo = await drive.files.get({
      fileId: folderId,
      fields: 'name, createdTime, modifiedTime'
    });
    
    console.log('📁 Nombre:', folderInfo.data.name);
    console.log('📅 Creada:', new Date(folderInfo.data.createdTime).toLocaleString('es-CO'));
    console.log('🕐 Modificada:', new Date(folderInfo.data.modifiedTime).toLocaleString('es-CO'));
    console.log('');
    
    // Listar contenido
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType, size, modifiedTime, webViewLink)',
      orderBy: 'folder, name'
    });
    
    const archivos = response.data.files;
    
    if (archivos.length === 0) {
      console.log('⚠️ La carpeta está VACÍA');
    } else {
      console.log(`📄 Contenido (${archivos.length} elementos):`);
      console.log('───────────────────────────────────────────────────');
      
      archivos.forEach((archivo, index) => {
        const esCarpeta = archivo.mimeType === 'application/vnd.google-apps.folder';
        const icono = esCarpeta ? '📁' : '📄';
        const tipo = esCarpeta ? 'Carpeta' : archivo.mimeType.split('/').pop();
        const size = archivo.size ? `(${(archivo.size / 1024).toFixed(1)} KB)` : '';
        
        console.log(`${index + 1}. ${icono} ${archivo.name}`);
        console.log(`   Tipo: ${tipo} ${size}`);
        console.log(`   ID: ${archivo.id}`);
        console.log('');
      });
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

listarCarpeta();
