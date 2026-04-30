const { google } = require('googleapis');
const fs = require('fs');
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/drive'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function downloadFile(drive, fileId, destPath) {
  try {
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
    console.error('Error:', error.message);
    return null;
  }
}

async function main() {
  const fileId = '1rws7nLugR3nTNNk_vd9xnOtp3EiISYEw';
  const destPath = '/root/.openclaw/workspace/Entregable_ITS_V1.docx';
  
  console.log('📥 Descargando Entregable ITS V1...');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const result = await downloadFile(drive, fileId, destPath);
  
  if (result) {
    console.log(`✅ Descargado: ${result}`);
    const stats = fs.statSync(result);
    console.log(`📊 Tamaño: ${(stats.size / 1024 / 1024).toFixed(2)} MB`);
  } else {
    console.log('❌ Error al descargar');
  }
}

main().catch(console.error);
