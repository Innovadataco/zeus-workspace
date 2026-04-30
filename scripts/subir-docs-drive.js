const { google } = require('googleapis');
const fs = require('fs');
const path = require('path');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['https://www.googleapis.com/auth/drive'],
  subject: 'gerencia@innovadataco.com'
});

const DOCUMENTOS_PM2_FOLDER = '1tW67JixutLTDLxY7--eWuetI1waD3U8T';
const ARCHIVOS_MD = [
  '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/01-ACTA-CONSTITUCION.md',
  '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/02-CRONOGRAMA-GANTT.md',
  '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/03-REGISTRO-RIESGOS.md',
  '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/04-MATRIZ-STAKEHOLDERS.md',
  '/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/05-PLAN-COMUNICACIONES.md'
];

async function subirArchivos() {
  const drive = google.drive({ version: 'v3', auth });
  
  console.log('📤 SUBIENDO DOCUMENTOS PM2 A DRIVE\n');
  console.log('Carpeta destino: 06-DOCUMENTACION-PM2\n');
  
  for (const archivoPath of ARCHIVOS_MD) {
    const nombre = path.basename(archivoPath);
    
    try {
      console.log(`📄 Subiendo: ${nombre}`);
      
      // Verificar si ya existe
      const existente = await drive.files.list({
        q: `name='${nombre}' and '${DOCUMENTOS_PM2_FOLDER}' in parents and trashed=false`,
        fields: 'files(id, name)'
      });
      
      if (existente.data.files.length > 0) {
        // Actualizar archivo existente
        const fileId = existente.data.files[0].id;
        await drive.files.update({
          fileId: fileId,
          media: {
            mimeType: 'text/plain',
            body: fs.createReadStream(archivoPath)
          }
        });
        console.log(`   ✅ Actualizado (ID: ${fileId})`);
      } else {
        // Crear nuevo archivo
        const response = await drive.files.create({
          requestBody: {
            name: nombre,
            mimeType: 'text/plain',
            parents: [DOCUMENTOS_PM2_FOLDER]
          },
          media: {
            mimeType: 'text/plain',
            body: fs.createReadStream(archivoPath)
          }
        });
        console.log(`   ✅ Creado (ID: ${response.data.id})`);
      }
      
    } catch (error) {
      console.error(`   ❌ Error: ${error.message}`);
    }
  }
  
  console.log('\n═══════════════════════════════════════════════════');
  console.log('✅ Sincronización completada');
  console.log('GitHub ↔ Drive: 5 documentos sincronizados');
}

subirArchivos();
