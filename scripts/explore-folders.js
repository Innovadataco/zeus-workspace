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

async function listFolderContents(folderId, name) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType, modifiedTime)',
      orderBy: 'name',
    });
    return response.data.files;
  } catch (error) {
    console.error(`Error en ${name}:`, error.message);
    return [];
  }
}

const folders = [
  { id: '1ksX8TFJm7J8O-Hou0tWAmFF6DWV9Zis_', name: 'Geotecnia' },
  { id: '1Cd3FqyVefIBnpUydMW4fyupTtHoA9h5x', name: 'Seguridad Vial' },
  { id: '1xXwCjTo1h2FuvanCuieMNtRi6D2PeTTp', name: 'Siniestralidad' },
  { id: '1rfMkQgZmLG-mwSdqUqAOKOGYqFXLc8Op', name: 'Indicadores' },
];

async function main() {
  for (const folder of folders) {
    console.log(`\n📁 ${folder.name}:`);
    console.log('='.repeat(40));
    const files = await listFolderContents(folder.id, folder.name);
    
    if (files.length === 0) {
      console.log('  (vacío)');
    } else {
      files.forEach(file => {
        const icon = file.mimeType.includes('folder') ? '📂' : 
                     file.mimeType.includes('pdf') ? '📑' :
                     file.mimeType.includes('document') ? '📄' :
                     file.mimeType.includes('spreadsheet') ? '📊' : '📎';
        console.log(`  ${icon} ${file.name}`);
      });
    }
  }
}

main().catch(console.error);
