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

async function verificarAnidacion() {
  const drive = google.drive({ version: 'v3', auth });
  
  // La carpeta IDC_2026_01 que encontramos
  const CARPETA_01_ID = '1mCzwyJoosrQEWSjSoZExO0MAGAjJ7wDa';
  
  console.log('🔍 REVISANDO DENTRO DE: IDC_2026_01\n');
  console.log('ID: 1mCzwyJoosrQEWSjSoZExO0MAGAjJ7wDa\n');
  
  try {
    const contenido = await drive.files.list({
      q: `'${CARPETA_01_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType)'
    });
    
    console.log(`Elementos encontrados: ${contenido.data.files.length}\n`);
    
    contenido.data.files.forEach((item, i) => {
      const tipo = item.mimeType === 'application/vnd.google-apps.folder' ? '📁' : '📄';
      console.log(`${i+1}. ${tipo} ${item.name}`);
      console.log(`   ID: ${item.id}`);
      console.log(`   Tipo: ${item.mimeType}`);
      console.log('');
    });
    
    // Buscar si hay otra carpeta IDC_2026_01 dentro
    const duplicada = contenido.data.files.find(f => 
      f.name === 'IDC_2026_01' && f.mimeType === 'application/vnd.google-apps.folder'
    );
    
    if (duplicada) {
      console.log('⚠️  ¡CARPETA DUPLICADA ENCONTRADA!');
      console.log(`Nombre: ${duplicada.name}`);
      console.log(`ID: ${duplicada.id}`);
    } else {
      console.log('✅ No hay carpeta duplicada dentro');
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

verificarAnidacion();
