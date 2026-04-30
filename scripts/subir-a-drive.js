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

async function uploadFile(drive, filePath, folderId) {
  const fileName = path.basename(filePath);
  
  try {
    // Crear readable stream del archivo
    const fileStream = fs.createReadStream(filePath);
    
    const response = await drive.files.create({
      requestBody: {
        name: fileName,
        parents: [folderId],
        mimeType: 'text/markdown',
      },
      media: {
        mimeType: 'text/markdown',
        body: fileStream,  // Usar stream en lugar de buffer
      },
    });
    return { success: true, id: response.data.id, name: fileName };
  } catch (error) {
    return { success: false, name: fileName, error: error.message };
  }
}

async function uploadFolder(drive, localPath, parentFolderId, basePath = '') {
  const results = [];
  const items = fs.readdirSync(localPath);
  
  for (const item of items) {
    const itemPath = path.join(localPath, item);
    const stat = fs.statSync(itemPath);
    
    if (stat.isDirectory()) {
      if (item === '.git') continue;
      
      try {
        const folderResponse = await drive.files.create({
          requestBody: {
            name: item,
            mimeType: 'application/vnd.google-apps.folder',
            parents: [parentFolderId],
          },
        });
        const newFolderId = folderResponse.data.id;
        console.log(`📁 ${path.join(basePath, item)}/`);
        
        const subResults = await uploadFolder(drive, itemPath, newFolderId, path.join(basePath, item));
        results.push(...subResults);
      } catch (error) {
        console.log(`❌ Error carpeta ${item}: ${error.message}`);
      }
    } else if (item.endsWith('.md')) {
      const result = await uploadFile(drive, itemPath, parentFolderId);
      if (result.success) {
        console.log(`✅ ${path.join(basePath, item)}`);
        results.push({ folder: basePath, ...result });
      } else {
        console.log(`❌ ${path.join(basePath, item)}: ${result.error}`);
        results.push({ folder: basePath, ...result });
      }
    }
  }
  
  return results;
}

async function main() {
  const folderId = '1RT8qzxb4meBw3WnTlGGR9XcDhmrnkJ6J';
  const localFolder = '/root/.openclaw/workspace/ZEUS-CONFIG';
  
  console.log('🚀 Subiendo ZEUS-CONFIG a Google Drive...\n');
  console.log(`📂 Destino: ODIN (${folderId})\n`);
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const results = await uploadFolder(drive, localFolder, folderId);
  
  console.log('\n---\n');
  const exitosos = results.filter(r => r.success).length;
  const errores = results.filter(r => !r.success).length;
  console.log(`✅ Archivos subidos: ${exitosos}`);
  console.log(`❌ Errores: ${errores}`);
}

main().catch(console.error);
