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

async function searchFilesByDate(dateString) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    // Buscar archivos modificados después de la fecha especificada
    const response = await drive.files.list({
      q: `modifiedTime > '${dateString}' and mimeType='application/vnd.openxmlformats-officedocument.wordprocessingml.document' and trashed = false`,
      fields: 'files(id, name, modifiedTime, webViewLink)',
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
  // Buscar archivos modificados después del 27 de abril (ayer hasta las 4am)
  console.log('Buscando documentos Word modificados recientemente (después 2026-04-27)...\n');
  const files = await searchFilesByDate('2026-04-27T00:00:00');
  
  if (files.length === 0) {
    console.log('No se encontraron documentos.');
  } else {
    console.log(`📄 Encontrados ${files.length} documentos:\n`);
    files.forEach(file => {
      console.log(`📄 ${file.name}`);
      console.log(`   ID: ${file.id}`);
      console.log(`   Modificado: ${file.modifiedTime}`);
      console.log(`   Link: ${file.webViewLink}`);
      console.log('');
    });
  }
}

main().catch(console.error);
