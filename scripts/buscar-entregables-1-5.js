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

async function searchFilesByName(name) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `name contains '${name}' and trashed = false`,
      fields: 'files(id, name, mimeType, modifiedTime, webViewLink)',
      orderBy: 'modifiedTime desc',
      pageSize: 10,
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

async function main() {
  // Buscar entregables 1-5
  for (let i = 1; i <= 5; i++) {
    console.log(`\n=== Buscando Entregable ${i} ===`);
    const files = await searchFilesByName(`Entregable ${i}`);
    
    if (files.length === 0) {
      console.log('No encontrado');
    } else {
      files.forEach(file => {
        const icon = file.mimeType.includes('folder') ? '📂' : 
                     file.mimeType.includes('document') ? '📄' :
                     file.mimeType.includes('spreadsheet') ? '📊' :
                     file.mimeType.includes('pdf') ? '📑' : '📎';
        console.log(`${icon} ${file.name}`);
        console.log(`   ID: ${file.id}`);
        console.log(`   Modificado: ${file.modifiedTime}`);
      });
    }
  }
  
  // Buscar también carpetas de entregables
  console.log(`\n=== Buscando carpetas de entregables ===`);
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  const response = await drive.files.list({
    q: `mimeType='application/vnd.google-apps.folder' and (name contains 'Entregable' or name contains 'ENTREGABLE') and trashed = false`,
    fields: 'files(id, name, modifiedTime)',
    orderBy: 'name',
  });
  
  console.log(`\nCarpetas encontradas: ${response.data.files.length}`);
  response.data.files.forEach(folder => {
    console.log(`📂 ${folder.name} (ID: ${folder.id})`);
  });
}

main().catch(console.error);
