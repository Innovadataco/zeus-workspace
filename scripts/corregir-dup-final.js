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

async function verificarIDC_2026_01() {
  const drive = google.drive({ version: 'v3', auth });
  
  // Esta es la carpeta IDC_2026_01 que está dentro de la raíz
  const IDC_2026_01_ID = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  
  console.log('🔍 REVISANDO: IDC_2026_01 (carpeta PM2)\n');
  console.log('ID: 16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1\n');
  
  try {
    const contenido = await drive.files.list({
      q: `'${IDC_2026_01_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType)'
    });
    
    console.log(`Elementos encontrados: ${contenido.data.files.length}\n`);
    
    contenido.data.files.forEach((item, i) => {
      const tipo = item.mimeType === 'application/vnd.google-apps.folder' ? '📁' : '📄';
      console.log(`${i+1}. ${tipo} ${item.name}`);
      console.log(`   ID: ${item.id}`);
      console.log('');
    });
    
    // Buscar si hay otra carpeta IDC_2026_01 dentro
    const duplicada = contenido.data.files.find(f => 
      f.name === 'IDC_2026_01' && f.mimeType === 'application/vnd.google-apps.folder'
    );
    
    if (duplicada) {
      console.log('⚠️  ¡CARPETA DUPLICADA ENCONTRADA DENTRO!');
      console.log(`Nombre: ${duplicada.name}`);
      console.log(`ID: ${duplicada.id}`);
      console.log('\n🔧 Procediendo a corregir...\n');
      
      // Listar contenido de la carpeta duplicada
      const contenidoDup = await drive.files.list({
        q: `'${duplicada.id}' in parents and trashed=false`,
        fields: 'files(id, name)'
      });
      
      console.log(`Elementos en carpeta duplicada: ${contenidoDup.data.files.length}`);
      
      // Mover todo a la carpeta padre
      for (const item of contenidoDup.data.files) {
        console.log(`➡️ Moviendo: ${item.name}`);
        await drive.files.update({
          fileId: item.id,
          addParents: IDC_2026_01_ID,
          removeParents: duplicada.id,
          fields: 'id'
        });
      }
      
      // Eliminar carpeta vacía
      console.log('\n🗑️ Eliminando carpeta duplicada vacía...');
      await drive.files.delete({ fileId: duplicada.id });
      console.log('✅ Carpeta eliminada');
      
    } else {
      console.log('✅ No hay carpeta duplicada dentro de IDC_2026_01');
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

verificarIDC_2026_01();
