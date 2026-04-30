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

async function createFolder(drive, name, parentId) {
  try {
    const response = await drive.files.create({
      requestBody: {
        name: name,
        mimeType: 'application/vnd.google-apps.folder',
        parents: [parentId],
      },
    });
    console.log(`📁 Creada: ${name} (ID: ${response.data.id})`);
    return response.data.id;
  } catch (error) {
    console.log(`❌ Error creando ${name}: ${error.message}`);
    return null;
  }
}

async function main() {
  const parentFolderId = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';
  
  console.log('🚀 Creando estructura PM2 en IDC_2026_01...\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  // Crear carpeta raíz IDC_2026_01
  const rootId = await createFolder(drive, 'IDC_2026_01', parentFolderId);
  if (!rootId) return;
  
  // Crear estructura PM2
  const folders = [
    '01-GOBERNANZA',
    '02-PLANIFICACION',
    '03-EJECUCION',
    '04-SEGUIMIENTO',
    '05-CIERRE',
  ];
  
  for (const folder of folders) {
    await createFolder(drive, folder, rootId);
  }
  
  console.log('\n✅ Estructura PM2 creada correctamente');
  console.log(`📂 Raíz: IDC_2026_01 (${rootId})`);
}

main().catch(console.error);
