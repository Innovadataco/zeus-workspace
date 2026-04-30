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

async function searchFolderByName(name) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `mimeType='application/vnd.google-apps.folder' and name contains '${name}' and trashed = false`,
      fields: 'files(id, name, modifiedTime, webViewLink)',
      orderBy: 'name',
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

async function main() {
  console.log('Buscando carpeta "transconsult"...\n');
  const files = await searchFolderByName('transconsult');
  
  if (files.length === 0) {
    console.log('No se encontraron carpetas con ese nombre.');
    
    // Intentar búsqueda más amplia
    console.log('\nBuscando "oferta"...\n');
    const files2 = await searchFolderByName('oferta');
    if (files2.length > 0) {
      files2.forEach(file => {
        console.log(`📂 ${file.name}`);
        console.log(`   ID: ${file.id}`);
        console.log(`   Link: ${file.webViewLink}`);
        console.log('');
      });
    }
  } else {
    console.log(`📁 Encontradas ${files.length} carpetas:\n`);
    files.forEach(file => {
      console.log(`📂 ${file.name}`);
      console.log(`   ID: ${file.id}`);
      console.log(`   Link: ${file.webViewLink}`);
      console.log('');
    });
  }
}

main().catch(console.error);
