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

async function listFolderContents(drive, folderId, depth = 0) {
  const indent = '  '.repeat(depth);
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType, modifiedTime)',
      orderBy: 'name',
    });
    
    const files = response.data.files;
    
    for (const file of files) {
      if (file.mimeType === 'application/vnd.google-apps.folder') {
        console.log(`${indent}📁 ${file.name}/`);
        // Recursivamente listar contenido
        await listFolderContents(drive, file.id, depth + 1);
      } else {
        const icon = file.mimeType.includes('document') ? '📝' : 
                     file.mimeType.includes('spreadsheet') ? '📊' :
                     file.mimeType.includes('pdf') ? '📑' : 
                     file.mimeType.includes('presentation') ? '📽️' : '📎';
        console.log(`${indent}  ${icon} ${file.name}`);
      }
    }
  } catch (error) {
    console.log(`${indent}❌ Error: ${error.message}`);
  }
}

async function main() {
  const folderId = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';
  
  console.log('🔍 Estructura completa del Proyecto APP Chía-Girardot:\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  console.log('📁 RAÍZ:');
  await listFolderContents(drive, folderId, 0);
}

main().catch(console.error);
