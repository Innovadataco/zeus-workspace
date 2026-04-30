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

async function revisarEstructura() {
  const drive = google.drive({ version: 'v3', auth });
  
  const folderId = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1';
  
  console.log('🔍 REVISANDO ESTRUCTURA ANIDADA\n');
  console.log('═══════════════════════════════════════════════════');
  
  try {
    // Buscar carpetas dentro de la carpeta principal
    const response = await drive.files.list({
      q: `'${folderId}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
      fields: 'files(id, name, modifiedTime)'
    });
    
    const carpetas = response.data.files;
    
    for (const carpeta of carpetas) {
      console.log(`\n📁 ${carpeta.name}`);
      console.log(`   ID: ${carpeta.id}`);
      
      // Buscar si hay otra carpeta con el mismo nombre dentro
      const subResponse = await drive.files.list({
        q: `'${carpeta.id}' in parents and name='${carpeta.name}' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
        fields: 'files(id, name)'
      });
      
      if (subResponse.data.files.length > 0) {
        console.log(`   ⚠️  ¡CARPETA DUPLICADA ANIDADA!`);
        console.log(`   📂 Sub-carpeta: ${subResponse.data.files[0].name}`);
        console.log(`   ID sub-carpeta: ${subResponse.data.files[0].id}`);
        
        // Mover contenido de la sub-carpeta a la carpeta padre
        await consolidarCarpeta(drive, subResponse.data.files[0].id, carpeta.id);
        
        // Eliminar sub-carpeta vacía
        console.log(`   🗑️  Eliminando sub-carpeta duplicada...`);
        await drive.files.delete({ fileId: subResponse.data.files[0].id });
        console.log(`   ✅ Sub-carpeta eliminada`);
      }
    }
    
    console.log('\n═══════════════════════════════════════════════════');
    console.log('✅ Estructura corregida');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

async function consolidarCarpeta(drive, subFolderId, parentFolderId) {
  console.log(`\n   🔄 Consolidando contenido...`);
  
  try {
    // Listar archivos en sub-carpeta
    const response = await drive.files.list({
      q: `'${subFolderId}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType)'
    });
    
    for (const archivo of response.data.files) {
      console.log(`      ➡️ Moviendo: ${archivo.name}`);
      
      // Mover archivo a carpeta padre
      await drive.files.update({
        fileId: archivo.id,
        addParents: parentFolderId,
        removeParents: subFolderId,
        fields: 'id, parents'
      });
    }
    
    console.log(`   ✅ ${response.data.files.length} elementos movidos`);
    
  } catch (error) {
    console.error(`   ❌ Error al consolidar: ${error.message}`);
  }
}

revisarEstructura();
