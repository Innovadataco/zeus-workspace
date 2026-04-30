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

async function searchInFolder(drive, folderId, namePattern, depth = 0) {
  const indent = '  '.repeat(depth);
  
  try {
    const response = await drive.files.list({
      q: `'${folderId}' in parents and trashed = false`,
      fields: 'files(id, name, mimeType)',
    });
    
    const files = response.data.files;
    const matches = [];
    
    for (const file of files) {
      if (file.name.toLowerCase().includes(namePattern.toLowerCase())) {
        matches.push({
          id: file.id,
          name: file.name,
          mimeType: file.mimeType,
          folderId: folderId
        });
      }
      
      if (file.mimeType === 'application/vnd.google-apps.folder') {
        const subMatches = await searchInFolder(drive, file.id, namePattern, depth + 1);
        matches.push(...subMatches);
      }
    }
    
    return matches;
  } catch (error) {
    return [];
  }
}

async function main() {
  const folderId = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';
  
  console.log('🔍 Buscando en todas las subcarpetas...\n');
  
  const auth = await authenticate();
  const drive = google.drive({ version: 'v3', auth });
  
  const matches = await searchInFolder(drive, folderId, 'Entregable ITS');
  
  if (matches.length > 0) {
    console.log(`✅ ${matches.length} archivo(s) encontrado(s):\n`);
    matches.forEach(f => {
      console.log(`📝 ${f.name}`);
      console.log(`   ID: ${f.id}`);
      console.log(`   Carpeta: ${f.folderId}`);
      console.log('');
    });
  } else {
    console.log('❌ No encontrado');
  }
}

main().catch(console.error);
