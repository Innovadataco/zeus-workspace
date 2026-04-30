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

async function checkFolderAccess(folderId) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    // Intentar obtener información de la carpeta
    const response = await drive.files.get({
      fileId: folderId,
      fields: 'id, name, mimeType, modifiedTime, webViewLink'
    });
    return { success: true, data: response.data };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

// ID de la carpeta del enlace: 1RT8qzxb4meBw3WnTlGGR9XcDhmrnkJ6J
const folderId = '1RT8qzxb4meBw3WnTlGGR9XcDhmrnkJ6J';

async function main() {
  console.log('Verificando acceso a carpeta...\n');
  const result = await checkFolderAccess(folderId);
  
  if (result.success) {
    console.log('✅ ACCESO EXITOSO\n');
    console.log(`📂 Nombre: ${result.data.name}`);
    console.log(`   ID: ${result.data.id}`);
    console.log(`   Tipo: ${result.data.mimeType}`);
    console.log(`   Modificado: ${result.data.modifiedTime}`);
    console.log(`   Link: ${result.data.webViewLink}`);
  } else {
    console.log('❌ SIN ACCESO\n');
    console.log(`Error: ${result.error}`);
    console.log('\nPosibles causas:');
    console.log('- La carpeta no existe');
    console.log('- No tengo permisos (service account no autorizado)');
    console.log('- La carpeta es privada y no está compartida con el service account');
  }
}

main().catch(console.error);
