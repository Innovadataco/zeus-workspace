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

async function reorganizar() {
  const drive = google.drive({ version: 'v3', auth });
  
  const BASE_DOCUMENTAL_ID = '19jiZpP4SoWiXEVAD4FWEgmrz9ZCRggnM';
  const ENTREGABLES_ID = '1GEv-GINv_Wac2ahk1GE805BoCjH2E4wj';
  
  console.log('🔧 REORGANIZANDO DOCUMENTOS\n');
  
  // 1. Crear subcarpetas en Base Documental
  console.log('📁 1. Creando estructura en Base Documental...\n');
  
  const carpetasBase = [
    '01-MARCO-CONTRACTUAL',
    '02-NORMATIVA-ITS',
    '03-REFERENCIAS-PROYECTOS',
    '04-AVANCES-OTROS-CONSULTORES' // ⭐ Importante
  ];
  
  const carpetasBaseIds = {};
  
  for (const nombre of carpetasBase) {
    try {
      const existente = await drive.files.list({
        q: `name='${nombre}' and '${BASE_DOCUMENTAL_ID}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
        fields: 'files(id)'
      });
      
      if (existente.data.files.length > 0) {
        carpetasBaseIds[nombre] = existente.data.files[0].id;
        console.log(`   ✅ ${nombre}: Ya existe`);
      } else {
        const creada = await drive.files.create({
          requestBody: {
            name: nombre,
            mimeType: 'application/vnd.google-apps.folder',
            parents: [BASE_DOCUMENTAL_ID]
          }
        });
        carpetasBaseIds[nombre] = creada.data.id;
        console.log(`   ✅ ${nombre}: Creada`);
      }
    } catch (error) {
      console.error(`   ❌ ${nombre}: ${error.message}`);
    }
  }
  
  // 2. Mover archivos de Base Documental a sus carpetas
  console.log('\n📄 2. Organizando archivos en Base Documental...\n');
  
  const archivosBase = await drive.files.list({
    q: `'${BASE_DOCUMENTAL_ID}' in parents and mimeType!='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id, name)'
  });
  
  for (const archivo of archivosBase.data.files) {
    const nombre = archivo.name.toLowerCase();
    let carpetaDestino = null;
    
    if (nombre.includes('contrato') || nombre.includes('ps_05') || nombre.includes('firma')) {
      carpetaDestino = '01-MARCO-CONTRACTUAL';
    } else if (nombre.includes('tor') || nombre.includes('lineamiento') || nombre.includes('terms')) {
      carpetaDestino = '01-MARCO-CONTRACTUAL';
    } else if (nombre.includes('transconsult') || nombre.includes('informacion requerida') || nombre.includes('consultor')) {
      carpetaDestino = '04-AVANCES-OTROS-CONSULTORES';
    } else if (nombre.includes('referencia')) {
      carpetaDestino = '03-REFERENCIAS-PROYECTOS';
    }
    
    if (carpetaDestino && carpetasBaseIds[carpetaDestino]) {
      try {
        await drive.files.update({
          fileId: archivo.id,
          addParents: carpetasBaseIds[carpetaDestino],
          removeParents: BASE_DOCUMENTAL_ID,
          fields: 'id'
        });
        console.log(`   ➡️  ${archivo.name} → ${carpetaDestino}`);
      } catch (error) {
        console.error(`   ❌ Error moviendo ${archivo.name}: ${error.message}`);
      }
    }
  }
  
  // 3. Crear subcarpeta en Entregables para E1-E5
  console.log('\n📁 3. Organizando Entregables...\n');
  
  const ENTREGABLE_E1E5 = 'E1-E5-ENTREGABLE-MAESTRO';
  
  const existenteE1E5 = await drive.files.list({
    q: `name='${ENTREGABLE_E1E5}' and '${ENTREGABLES_ID}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id)'
  });
  
  let e1e5Id;
  if (existenteE1E5.data.files.length > 0) {
    e1e5Id = existenteE1E5.data.files[0].id;
    console.log(`   ✅ ${ENTREGABLE_E1E5}: Ya existe`);
  } else {
    const creada = await drive.files.create({
      requestBody: {
        name: ENTREGABLE_E1E5,
        mimeType: 'application/vnd.google-apps.folder',
        parents: [ENTREGABLES_ID]
      }
    });
    e1e5Id = creada.data.id;
    console.log(`   ✅ ${ENTREGABLE_E1E5}: Creada`);
  }
  
  // 4. Mover entregables a la carpeta
  const archivosEntregables = await drive.files.list({
    q: `'${ENTREGABLES_ID}' in parents and trashed=false`,
    fields: 'files(id, name, mimeType)'
  });
  
  for (const archivo of archivosEntregables.data.files) {
    if (archivo.mimeType !== 'application/vnd.google-apps.folder') {
      try {
        await drive.files.update({
          fileId: archivo.id,
          addParents: e1e5Id,
          removeParents: ENTREGABLES_ID,
          fields: 'id'
        });
        console.log(`   ➡️  ${archivo.name} → E1-E5-ENTREGABLE-MAESTRO`);
      } catch (error) {
        console.error(`   ❌ Error: ${error.message}`);
      }
    }
  }
  
  console.log('\n═══════════════════════════════════════════════════');
  console.log('✅ Reorganización completada');
  console.log('\n📂 Estructura final:');
  console.log('\nBase Documental/');
  console.log('├── 01-MARCO-CONTRACTUAL/');
  console.log('├── 02-NORMATIVA-ITS/');
  console.log('├── 03-REFERENCIAS-PROYECTOS/');
  console.log('└── 04-AVANCES-OTROS-CONSULTORES/ ⭐');
  console.log('\nEntregables/');
  console.log('└── E1-E5-ENTREGABLE-MAESTRO/');
  console.log('    ├── Entregable ITS V1.docx');
  console.log('    ├── Fichas_Tecnicas_ITS.xlsx');
  console.log('    └── EVO_TOTAL_V0.xlsx');
}

reorganizar();
