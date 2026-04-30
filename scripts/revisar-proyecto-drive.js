const { google } = require('googleapis');
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function listFolderContents(folderId) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType, modifiedTime)',
      orderBy: 'modifiedTime desc',
    });
    return { success: true, files: response.data.files };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

// ID de la carpeta proporcionada: 17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5
const folderId = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';

async function main() {
  console.log('🔍 Revisando carpeta del Proyecto APP Chía-Girardot...\n');
  const result = await listFolderContents(folderId);
  
  if (result.success) {
    if (result.files.length === 0) {
      console.log('La carpeta está vacía.');
    } else {
      console.log(`📁 Encontrados ${result.files.length} elementos:\n`);
      
      // Separar carpetas y archivos
      const folders = result.files.filter(f => f.mimeType === 'application/vnd.google-apps.folder');
      const documents = result.files.filter(f => f.mimeType !== 'application/vnd.google-apps.folder');
      
      if (folders.length > 0) {
        console.log('📂 CARPETAS:');
        folders.forEach(folder => {
          console.log(`   📁 ${folder.name}`);
          console.log(`      ID: ${folder.id}`);
          console.log('');
        });
      }
      
      if (documents.length > 0) {
        console.log('📄 DOCUMENTOS:');
        documents.forEach(doc => {
          const icon = doc.mimeType.includes('document') ? '📝' : 
                       doc.mimeType.includes('spreadsheet') ? '📊' :
                       doc.mimeType.includes('pdf') ? '📑' : '📎';
          console.log(`   ${icon} ${doc.name}`);
          console.log(`      ID: ${doc.id} | Modificado: ${doc.modifiedTime.substring(0, 10)}`);
          console.log('');
        });
      }
    }
  } else {
    console.log('❌ Error:', result.error);
  }
}

main().catch(console.error);
