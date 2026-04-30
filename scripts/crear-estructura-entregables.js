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

async function crearEstructura() {
  const drive = google.drive({ version: 'v3', auth });
  
  // IDs de carpetas existentes
  const EJECUCION_ID = '1UxEGKdKBFUEBnWeXVOXamGURSGLRVaVC';
  
  console.log('📂 CREANDO ESTRUCTURA EN 03-EJECUCION\n');
  
  const carpetas = [
    { name: 'E1-Diagnostico-ITS', id: null },
    { name: 'E2-Analisis-Brechas', id: null },
    { name: 'E3-Concepto-Operacion', id: null },
    { name: 'E4-Fichas-Componentes', id: null },
    { name: 'E5-Requerimientos', id: null },
    { name: 'E6-Analisis-Tecnologias', id: null },
    { name: 'E7-Plan-Indicativo', id: null },
    { name: 'E8-Modelo-Costos', id: null }
  ];
  
  for (const carpeta of carpetas) {
    try {
      // Verificar si ya existe
      const existente = await drive.files.list({
        q: `name='${carpeta.name}' and '${EJECUCION_ID}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
        fields: 'files(id, name)'
      });
      
      if (existente.data.files.length > 0) {
        console.log(`📁 ${carpeta.name}: ✅ Ya existe (ID: ${existente.data.files[0].id})`);
      } else {
        // Crear carpeta
        const response = await drive.files.create({
          requestBody: {
            name: carpeta.name,
            mimeType: 'application/vnd.google-apps.folder',
            parents: [EJECUCION_ID]
          }
        });
        console.log(`📁 ${carpeta.name}: ✅ Creada (ID: ${response.data.id})`);
      }
    } catch (error) {
      console.error(`❌ ${carpeta.name}: ${error.message}`);
    }
  }
  
  console.log('\n═══════════════════════════════════════════════════');
  console.log('✅ Estructura de entregables creada en Drive');
}

crearEstructura();
