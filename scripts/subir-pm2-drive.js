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

async function createFolder(drive, name, parentId) {
  try {
    const response = await drive.files.create({
      requestBody: {
        name: name,
        mimeType: 'application/vnd.google-apps.folder',
        parents: [parentId],
      },
    });
    return response.data.id;
  } catch (error) {
    console.error('Error creando carpeta:', error.message);
    return null;
  }
}

async function uploadFile(drive, filePath, folderId) {
  const fileName = path.basename(filePath);
  const fileContent = fs.readFileSync(filePath);
  
  try {
    const response = await drive.files.create({
      requestBody: {
        name: fileName,
        parents: [folderId],
        mimeType: 'text/markdown',
      },
      media: {
        mimeType: 'text/markdown',
        body: fileContent,
      },
    });
    return { success: true, id: response.data.id, name: fileName };
  } catch (error) {
    return { success: false, name: fileName, error: error.message };
  }
}

async function main() {
  // ID de IDC_2026_01
  const parentFolderId = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  const localFolder = '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS';
  
  console.log('🚀 Subiendo documentación PM2 a Google Drive...\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  // Crear subcarpeta 06-DOCUMENTACION-PM2
  const pm2FolderId = await createFolder(drive, '06-DOCUMENTACION-PM2', parentFolderId);
  
  if (!pm2FolderId) {
    console.log('❌ Error creando carpeta');
    return;
  }
  
  console.log('📁 Carpeta creada: 06-DOCUMENTACION-PM2\n');
  
  // Subir archivos
  const files = fs.readdirSync(localFolder).filter(f => f.endsWith('.md'));
  
  console.log(`📄 Subiendo ${files.length} archivos...\n`);
  
  for (const file of files) {
    const filePath = path.join(localFolder, file);
    const result = await uploadFile(drive, filePath, pm2FolderId);
    
    if (result.success) {
      console.log(`✅ ${result.name}`);
    } else {
      console.log(`❌ ${result.name}: ${result.error}`);
    }
  }
  
  console.log('\n✅ Proceso completado');
  console.log(`📂 Ubicación: IDC_2026_01/06-DOCUMENTACION-PM2/`);
}

main().catch(console.error);
