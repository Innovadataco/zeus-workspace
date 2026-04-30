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

async function listFolderContents(folderId, indent = '') {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType)',
      orderBy: 'name',
    });
    return response.data.files;
  } catch (error) {
    console.error('Error:', error.message);
    return [];
  }
}

async function exploreRecursive(folderId, name, depth = 0) {
  const indent = '  '.repeat(depth);
  console.log(`${indent}📂 ${name}`);
  
  const files = await listFolderContents(folderId, indent);
  
  for (const file of files) {
    if (file.mimeType.includes('folder')) {
      await exploreRecursive(file.id, file.name, depth + 1);
    } else {
      const icon = file.mimeType.includes('pdf') ? '📑' :
                   file.mimeType.includes('document') ? '📄' :
                   file.mimeType.includes('spreadsheet') ? '📊' : '📎';
      console.log(`${indent}  ${icon} ${file.name}`);
    }
  }
}

const rootFolders = [
  { id: '1ksX8TFJm7J8O-Hou0tWAmFF6DWV9Zis_', name: 'Geotecnia' },
  { id: '1Cd3FqyVefIBnpUydMW4fyupTtHoA9h5x', name: 'Seguridad Vial' },
  { id: '1xXwCjTo1h2FuvanCuieMNtRi6D2PeTTp', name: 'Siniestralidad' },
  { id: '1rfMkQgZmLG-mwSdqUqAOKOGYqFXLc8Op', name: 'Indicadores' },
  { id: '1KrT9J3wdD2_JyDMgPh5jeBjL5GYtaSg9', name: 'BIM' },
];

async function main() {
  for (const folder of rootFolders) {
    await exploreRecursive(folder.id, folder.name);
    console.log('');
  }
}

main().catch(console.error);
