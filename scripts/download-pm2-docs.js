const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function downloadFile(fileId, fileName, destPath) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.get({
      fileId: fileId,
      alt: 'media'
    }, { responseType: 'stream' });
    
    const dest = fs.createWriteStream(path.join(destPath, fileName));
    response.data.pipe(dest);
    
    return new Promise((resolve, reject) => {
      dest.on('finish', () => resolve(`Downloaded: ${fileName}`));
      dest.on('error', reject);
    });
  } catch (error) {
    console.error(`Error downloading ${fileName}:`, error.message);
    throw error;
  }
}

async function exportDocument(fileId, fileName, mimeType, destPath) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.export({
      fileId: fileId,
      mimeType: mimeType
    }, { responseType: 'stream' });
    
    const dest = fs.createWriteStream(path.join(destPath, fileName));
    response.data.pipe(dest);
    
    return new Promise((resolve, reject) => {
      dest.on('finish', () => resolve(`Exported: ${fileName}`));
      dest.on('error', reject);
    });
  } catch (error) {
    console.error(`Error exporting ${fileName}:`, error.message);
    throw error;
  }
}

async function listFolderContents(folderId) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const response = await drive.files.list({
    q: `'${folderId}' in parents and trashed = false`,
    fields: 'files(id, name, mimeType)',
  });
  return response.data.files;
}

async function main() {
  const downloadPath = '/tmp/pm2_docs';
  if (!fs.existsSync(downloadPath)) fs.mkdirSync(downloadPath, { recursive: true });
  
  // Carpetas de metodología
  const folders = {
    metodologia: '1zW7VVp_EFPeaw9fFRtghK4inSap12JFJ',
    doc2: '1FUVTxQmty4-1NrTUc-LSeCttA1TakU2r',
    pm2_artifacts: '1mBdKN0IUiYBeVLC7y2y5SZARDNaABoFv'
  };
  
  console.log('Descargando documentos PM² para análisis...\n');
  
  // Descargar archivos principales de metodología
  const mainFiles = [
    { id: '1tBXtKvikO4ILqN-ie9crUBrNeiu5dD67', name: 'PM2_Overview_ES_2019.pdf' },
    { id: '1cR9XjKECyBelgNLtc6bUM1O_FgIrLWyS', name: 'Guia_PM2_Agil_3_0_1.pdf' }
  ];
  
  for (const file of mainFiles) {
    try {
      console.log(`Descargando: ${file.name}`);
      await downloadFile(file.id, file.name, downloadPath);
      console.log(`✅ ${file.name}\n`);
    } catch (err) {
      console.log(`❌ Error con ${file.name}: ${err.message}\n`);
    }
  }
  
  // Listar contenido de carpetas
  console.log('\n📁 Contenido de DOC_2:');
  const doc2Files = await listFolderContents(folders.doc2);
  doc2Files.forEach(f => console.log(`  - ${f.name} (${f.mimeType})`));
  
  console.log('\n📁 Contenido de PM² Artefacts:');
  const artifactsFiles = await listFolderContents(folders.pm2_artifacts);
  artifactsFiles.forEach(f => console.log(`  - ${f.name} (${f.mimeType})`));
  
  console.log(`\n✅ Documentos descargados en: ${downloadPath}`);
}

main().catch(console.error);
