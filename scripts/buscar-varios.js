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

async function searchFiles(name) {
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
  // Buscar varios términos relacionados
  const terminos = ['consolidado', 'oferta', 'entregables', 'TOR', 'war'];
  
  for (const termino of terminos) {
    console.log(`\n=== Buscando "${termino}" ===\n`);
    const files = await searchFiles(termino);
    
    if (files.length > 0) {
      files.slice(0, 5).forEach(file => {
        const icon = file.mimeType.includes('folder') ? '📂' : 
                     file.mimeType.includes('document') ? '📄' :
                     file.mimeType.includes('spreadsheet') ? '📊' : '📎';
        console.log(`${icon} ${file.name}`);
        console.log(`   ID: ${file.id}`);
        console.log(`   Modificado: ${file.modifiedTime}`);
      });
    }
  }
}

main().catch(console.error);
