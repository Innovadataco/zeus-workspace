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

async function downloadFile(drive, fileId, fileName) {
  try {
    const destPath = `/tmp/${fileName}`;
    const dest = fs.createWriteStream(destPath);
    
    const response = await drive.files.get({
      fileId: fileId,
      alt: 'media'
    }, { responseType: 'stream' });
    
    response.data.pipe(dest);
    
    return new Promise((resolve, reject) => {
      dest.on('finish', () => resolve(destPath));
      dest.on('error', reject);
    });
  } catch (error) {
    console.error('Error descargando:', error.message);
    return null;
  }
}

async function findContractFile(drive, folderId) {
  try {
    // Buscar en Base Documental
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false and name contains 'PS_05_917'`,
      fields: 'files(id, name, mimeType)',
    });
    
    return response.data.files[0];
  } catch (error) {
    console.error('Error buscando:', error.message);
    return null;
  }
}

async function main() {
  const folderId = '19jiZpP4SoWiXEVAD4FWEgmrz9ZCRggnM'; // Base Documental
  
  console.log('🔍 Buscando contrato firmado...\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const contractFile = await findContractFile(drive, folderId);
  
  if (contractFile) {
    console.log(`✅ Contrato encontrado: ${contractFile.name}`);
    console.log(`   ID: ${contractFile.id}`);
    console.log(`   Tipo: ${contractFile.mimeType}`);
    console.log(`\n📥 Descargando para análisis...`);
    
    const downloadedPath = await downloadFile(drive, contractFile.id, 'contrato_firmado.pdf');
    
    if (downloadedPath) {
      console.log(`✅ Descargado en: ${downloadedPath}`);
      console.log(`\n📄 Listo para análisis con PDF tool`);
    }
  } else {
    console.log('❌ Contrato no encontrado en Base Documental');
  }
}

main().catch(console.error);
