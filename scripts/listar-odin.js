const { google } = require('googleapis');
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];

async function authenticate() {
  const auth = await google.auth.GoogleAuth({
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

// ID de la carpeta ODIN
const folderId = '1RT8qzxb4meBw3WnTlGGR9XcDhmrnkJ6J';

async function main() {
  console.log('Listando contenido de carpeta "ODIN"...\n');
  const result = await listFolderContents(folderId);
  
  if (result.success) {
    if (result.files.length === 0) {
      console.log('La carpeta está vacía.');
    } else {
      console.log(`📁 Encontrados ${result.files.length} elementos:\n`);
      result.files.forEach(file => {
        const icon = file.mimeType.includes('folder') ? '📂' : 
                     file.mimeType.includes('document') ? '📄' :
                     file.mimeType.includes('spreadsheet') ? '📊' :
                     file.mimeType.includes('pdf') ? '📑' : '📎';
        console.log(`${icon} ${file.name}`);
        console.log(`   ID: ${file.id}`);
        console.log(`   Modificado: ${file.modifiedTime}`);
        console.log('');
      });
    }
  } else {
    console.log('❌ Error:', result.error);
  }
}

main().catch(console.error);
