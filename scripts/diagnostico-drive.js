const { google } = require('googleapis');
const fs = require('fs');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['https://www.googleapis.com/auth/drive'],
  subject: 'gerencia@innovadataco.com'
});

async function diagnosticar() {
  const drive = google.drive({ version: 'v3', auth });
  
  const CARPETA_PADRE_ID = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  
  console.log('🔍 DIAGNÓSTICO DE ESTRUCTURA\n');
  
  try {
    // Buscar TODAS las carpetas dentro de la carpeta principal
    const carpetas = await drive.files.list({
      q: `'${CARPETA_PADRE_ID}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
      fields: 'files(id, name, createdTime)',
      orderBy: 'name'
    });
    
    console.log(`Carpetas encontradas: ${carpetas.data.files.length}\n`);
    
    carpetas.data.files.forEach((c, i) => {
      console.log(`${i+1}. "${c.name}"`);
      console.log(`   ID: ${c.id}`);
      console.log(`   Creada: ${c.createdTime}`);
      console.log('');
    });
    
    // Buscar si hay alguna con nombre similar a IDC_2026_01
    const similares = carpetas.data.files.filter(c => 
      c.name.toLowerCase().includes('idc') || 
      c.name.toLowerCase().includes('2026')
    );
    
    if (similares.length > 0) {
      console.log('\n⚠️  Carpetas con IDC o 2026 en el nombre:');
      similares.forEach(c => console.log(`   - ${c.name} (${c.id})`));
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

diagnosticar();
