const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['https://www.googleapis.com/auth/drive'],
  subject: 'gerencia@innovadataco.com'
});

async function descargarEntregable() {
  const drive = google.drive({ version: 'v3', auth });
  
  console.log('📄 BUSCANDO ENTREGABLE ITS V1.docx\n');
  
  // Buscar en la carpeta E1-E5-ENTREGABLE-MAESTRO
  const E1E5_FOLDER = '1GEv-GINv_Wac2ahk1GE805BoCjH2E4wj';
  
  // Primero buscar la subcarpeta
  const subcarpetas = await drive.files.list({
    q: `'${E1E5_FOLDER}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id, name)'
  });
  
  let entregableFolder = subcarpetas.data.files.find(f => f.name.includes('E1-E5') || f.name.includes('ENTREGABLE'));
  
  if (!entregableFolder) {
    console.log('❌ No se encontró subcarpeta de entregables');
    return;
  }
  
  console.log(`📁 Carpeta encontrada: ${entregableFolder.name}`);
  
  // Buscar el archivo Entregable ITS V1.docx
  const archivos = await drive.files.list({
    q: `'${entregableFolder.id}' in parents and name contains 'Entregable' and trashed=false`,
    fields: 'files(id, name, mimeType, size)'
  });
  
  if (archivos.data.files.length === 0) {
    console.log('❌ No se encontró el archivo Entregable ITS');
    return;
  }
  
  const archivo = archivos.data.files[0];
  console.log(`\n📄 Archivo: ${archivo.name}`);
  console.log(`   ID: ${archivo.id}`);
  console.log(`   Tipo: ${archivo.mimeType}`);
  
  // Descargar el archivo
  const destPath = '/tmp/entregable-its-v1.docx';
  
  console.log('\n⬇️  Descargando archivo...');
  
  const response = await drive.files.get(
    { fileId: archivo.id, alt: 'media' },
    { responseType: 'stream' }
  );
  
  const dest = fs.createWriteStream(destPath);
  
  await new Promise((resolve, reject) => {
    response.data
      .on('end', () => {
        console.log('✅ Archivo descargado');
        resolve();
      })
      .on('error', reject)
      .pipe(dest);
  });
  
  console.log(`\n📂 Guardado en: ${destPath}`);
  console.log(`📊 Tamaño: ${(fs.statSync(destPath).size / 1024 / 1024).toFixed(2)} MB`);
  
  // Intentar extraer texto (usando un método simple)
  console.log('\n📖 Nota: El archivo es .docx binario.');
  console.log('Para extraer el contenido del Capítulo 8 necesito:');
  console.log('1. Herramienta de parsing de DOCX, o');
  console.log('2. Que me compartas el contenido del Capítulo 8');
}

descargarEntregable().catch(console.error);
