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
      pageSize: 20,
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

async function main() {
  console.log('Buscando archivos con "Entregable"...\n');
  const files = await searchFilesByName('Entregable');
  
  if (files.length === 0) {
    console.log('No se encontraron archivos.');
  } else {
    console.log(`📁 Encontrados ${files.length} archivos:\n`);
    files.forEach(file => {
      const icon = file.mimeType.includes('folder') ? '📂' : 
                   file.mimeType.includes('document') ? '📄' :
                   file.mimeType.includes('spreadsheet') ? '📊' :
                   file.mimeType.includes('pdf') ? '📑' : '📎';
      console.log(`${icon} ${file.name}`);
      console.log(`   ID: ${file.id}`);
      console.log(`   Modificado: ${file.modifiedTime}`);
      console.log(`   Link: ${file.webViewLink}`);
      console.log('');
    });
  }
}

main().catch(console.error);
