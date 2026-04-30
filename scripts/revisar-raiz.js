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

async function revisarCarpetaRaiz() {
  const drive = google.drive({ version: 'v3', auth });
  
  const CARPETA_RAIZ_ID = '17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5';
  
  console.log('🔍 REVISANDO CARPETA RAÍZ DEL PROYECTO\n');
  console.log('ID: 17VByIuyNfaI4ZU96sozqUcrgNm1QBBa5\n');
  console.log('═══════════════════════════════════════════════════\n');
  
  try {
    // Listar TODO el contenido
    const contenido = await drive.files.list({
      q: `'${CARPETA_RAIZ_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType, createdTime)',
      orderBy: 'name'
    });
    
    console.log(`Total elementos: ${contenido.data.files.length}\n`);
    
    // Separar carpetas y archivos
    const carpetas = contenido.data.files.filter(f => f.mimeType === 'application/vnd.google-apps.folder');
    const archivos = contenido.data.files.filter(f => f.mimeType !== 'application/vnd.google-apps.folder');
    
    console.log('📁 CARPETAS:');
    console.log('───────────────────────────────────────────────────');
    carpetas.forEach((c, i) => {
      console.log(`${i+1}. ${c.name}`);
      console.log(`   ID: ${c.id}`);
      console.log('');
    });
    
    // Buscar nombres duplicados
    const nombres = carpetas.map(c => c.name);
    const duplicados = nombres.filter((item, index) => nombres.indexOf(item) !== index);
    
    if (duplicados.length > 0) {
      console.log('\n⚠️  NOMBRES DUPLICADOS ENCONTRADOS:');
      duplicados.forEach(nombre => {
        const carpetasDup = carpetas.filter(c => c.name === nombre);
        console.log(`\n🔴 "${nombre}" aparece ${carpetasDup.length} veces:`);
        carpetasDup.forEach(c => console.log(`   - ID: ${c.id}`));
      });
    } else {
      console.log('\n✅ No hay nombres duplicados en carpetas');
    }
    
    // Buscar carpetas con nombres similares a IDC_2026_01
    const similares = carpetas.filter(c => 
      c.name.toLowerCase().includes('idc_2026') || 
      c.name.toLowerCase().includes('chia') ||
      c.name.toLowerCase().includes('app')
    );
    
    if (similares.length > 0) {
      console.log('\n📂 Carpetas relacionadas con el proyecto:');
      similares.forEach(c => console.log(`   - ${c.name}`));
    }
    
    // Listar archivos si hay
    if (archivos.length > 0) {
      console.log('\n📄 ARCHIVOS:');
      console.log('───────────────────────────────────────────────────');
      archivos.forEach((a, i) => {
        console.log(`${i+1}. ${a.name}`);
      });
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

revisarCarpetaRaiz();
