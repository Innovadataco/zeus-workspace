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
      fields: 'files(id, name, mimeType, modifiedTime, webViewLink)',
      orderBy: 'name',
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

// Carpeta "Entregables" general
const folderId = '1Hd9M4sb37267Ua8jj4ZwMQPZrkaeB7aq';

async function main() {
  console.log('Listando contenido de carpeta "Entregables"...\n');
  const files = await listFolderContents(folderId);
  
  if (files.length === 0) {
    console.log('La carpeta está vacía.');
  } else {
    console.log(`📁 Encontrados ${files.length} elementos:\n`);
    files.forEach(file => {
      const icon = file.mimeType.includes('folder') ? '📂' : 
                   file.mimeType.includes('document') ? '📄' :
                   file.mimeType.includes('spreadsheet') ? '📊' :
                   file.mimeType.includes('pdf') ? '📑' : '📎';
      console.log(`${icon} ${file.name}`);
      console.log(`   ID: ${file.id}`);
      console.log(`   Tipo: ${file.mimeType}`);
      console.log(`   Modificado: ${file.modifiedTime}`);
      console.log('');
    });
  }
}

main().catch(console.error);
