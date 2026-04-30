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
      orderBy: 'modifiedTime desc',
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    throw error;
  }
}

// Carpeta "Editables"
const folderId = '1CYYcVXf846Mo4fR7aDdmxQiDvMtznDqi';

async function main() {
  console.log('Listando contenido de carpeta "Editables"...\n');
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
