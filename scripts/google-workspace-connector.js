const { google } = require('googleapis');
const path = require('path');
const fs = require('fs');

// Cargar credenciales de service account
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = [
  'https://www.googleapis.com/auth/drive',
  'https://www.googleapis.com/auth/drive.file',
  'https://www.googleapis.com/auth/gmail.readonly',
  'https://www.googleapis.com/auth/calendar.readonly',
  'https://www.googleapis.com/auth/documents.readonly',
  'https://www.googleapis.com/auth/spreadsheets.readonly'
];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function listDriveFiles(folderId) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType, modifiedTime, webViewLink)',
      orderBy: 'name',
    });
    return response.data.files;
  } catch (error) {
    console.error('Error listing files:', error.message);
    throw error;
  }
}

async function getFileContent(fileId) {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.get({
      fileId: fileId,
      alt: 'media'
    }, { responseType: 'text' });
    return response.data;
  } catch (error) {
    console.error('Error getting file content:', error.message);
    throw error;
  }
}

async function exportDocument(fileId, mimeType = 'text/plain') {
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  try {
    const response = await drive.files.export({
      fileId: fileId,
      mimeType: mimeType
    }, { responseType: 'text' });
    return response.data;
  } catch (error) {
    console.error('Error exporting document:', error.message);
    throw error;
  }
}

// Carpetas del proyecto
const FOLDERS = {
  metodologia: '1zW7VVp_EFPeaw9fFRtghK4inSap12JFJ',
  proyecto: '1vldjd7fLArf4s9-__1drwT68nP_7El8r',
  externos: '1-G-zG0EQA8zwJjTwHTETHI0AfmiS7aRA',
  oferta: '1IiPJcEUoNw_qlR-dR9t6F-OUjXQXIQnD'
};

async function main() {
  console.log('ZEUS Google Workspace Connector');
  console.log('================================');
  
  for (const [name, folderId] of Object.entries(FOLDERS)) {
    console.log(`\n📁 ${name.toUpperCase()}:`);
    try {
      const files = await listDriveFiles(folderId);
      if (files.length === 0) {
        console.log('  (vacío o sin acceso)');
      } else {
        files.forEach(file => {
          const icon = file.mimeType.includes('folder') ? '📂' : 
                      file.mimeType.includes('document') ? '📄' :
                      file.mimeType.includes('spreadsheet') ? '📊' :
                      file.mimeType.includes('presentation') ? '📽️' : '📎';
          console.log(`  ${icon} ${file.name} (${file.id})`);
        });
      }
    } catch (err) {
      console.log(`  ❌ Error: ${err.message}`);
    }
  }
}

// Ejecutar si se llama directamente
if (require.main === module) {
  main().catch(console.error);
}

module.exports = { listDriveFiles, getFileContent, exportDocument, FOLDERS };
