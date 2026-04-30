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

async function corregirCarpetaDuplicada() {
  const drive = google.drive({ version: 'v3', auth });
  
  // IDs conocidos
  const CARPETA_PADRE_ID = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  
  console.log('🔧 CORRIGIENDO CARPETA DUPLICADA\n');
  console.log('═══════════════════════════════════════════════════\n');
  
  try {
    // Buscar la carpeta hija duplicada (IDC_2026_01 dentro de IDC_2026_01)
    const subCarpetas = await drive.files.list({
      q: `'${CARPETA_PADRE_ID}' in parents and name='IDC_2026_01' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
      fields: 'files(id, name)'
    });
    
    if (subCarpetas.data.files.length === 0) {
      console.log('✅ No se encontró carpeta duplicada');
      return;
    }
    
    const CARPETA_HIJA_ID = subCarpetas.data.files[0].id;
    console.log(`📁 Carpeta hija encontrada: ${CARPETA_HIJA_ID}\n`);
    
    // Listar todo el contenido de la carpeta hija
    const contenido = await drive.files.list({
      q: `'${CARPETA_HIJA_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType)'
    });
    
    console.log(`📄 Elementos a mover: ${contenido.data.files.length}\n`);
    
    // Mover cada elemento a la carpeta padre
    for (const item of contenido.data.files) {
      console.log(`➡️  Moviendo: ${item.name}`);
      
      await drive.files.update({
        fileId: item.id,
        addParents: CARPETA_PADRE_ID,
        removeParents: CARPETA_HIJA_ID,
        fields: 'id, parents'
      });
      
      console.log(`   ✅ Movido`);
    }
    
    // Verificar si la carpeta hija quedó vacía
    const contenidoRestante = await drive.files.list({
      q: `'${CARPETA_HIJA_ID}' in parents and trashed=false`,
      fields: 'files(id)'
    });
    
    if (contenidoRestante.data.files.length === 0) {
      console.log(`\n🗑️  Eliminando carpeta duplicada vacía...`);
      await drive.files.delete({ fileId: CARPETA_HIJA_ID });
      console.log(`   ✅ Carpeta eliminada`);
    } else {
      console.log(`\n⚠️  Carpeta hija no está vacía, no se elimina`);
    }
    
    console.log('\n═══════════════════════════════════════════════════');
    console.log('✅ Estructura corregida');
    console.log('\nAhora la estructura es:');
    console.log('IDC_2026_01/');
    console.log('├── 01-GOBERNANZA/');
    console.log('├── 02-PLANIFICACION/');
    console.log('├── 03-EJECUCION/');
    console.log('├── 04-SEGUIMIENTO/');
    console.log('├── 05-CIERRE/');
    console.log('└── 06-DOCUMENTACION-PM2/');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

corregirCarpetaDuplicada();
