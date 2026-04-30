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

async function searchFile(drive, folderId, namePattern) {
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false and name contains '${namePattern}'`,
      fields: 'files(id, name, mimeType)',
    });
    return response.data.files;
  } catch (error) {
    console.log(`❌ Error buscando: ${error.message}`);
    return [];
  }
}

async function main() {
  const folderId = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';
  
  console.log('🔍 Buscando Entregable ITS V1.docx...\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const files = await searchFile(drive, folderId, 'Entregable ITS');
  
  if (files.length > 0) {
    console.log(`✅ Documento encontrado:`);
    files.forEach(f => {
      console.log(`   📝 ${f.name}`);
      console.log(`      ID: ${f.id}`);
      console.log('');
    });
  } else {
    console.log('❌ No encontrado en carpeta raíz');
    console.log('   Buscando en subcarpetas...');
  }
}

main().catch(console.error);
