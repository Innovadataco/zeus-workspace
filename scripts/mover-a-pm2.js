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

async function moverABasePM2() {
  const drive = google.drive({ version: 'v3', auth });
  
  // IDs de carpetas
  const BASE_DOCUMENTAL_ID = '19jiZpP4SoWiXEVAD4FWEgmrz9ZCRggnM';
  const CARPETA_PM2_ID = '16CcCPS4YGgme0Fam4iiIs_77m2S-tjw1'; // IDC_2026_01 principal
  
  console.log('📂 MIGRANDO BASE DOCUMENTAL A ESTRUCTURA PM2\n');
  
  // Obtener subcarpetas de IDC_2026_01 (estructura PM2)
  const subcarpetasPM2 = await drive.files.list({
    q: `'${CARPETA_PM2_ID}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id, name)'
  });
  
  const carpetasPM2 = {};
  subcarpetasPM2.data.files.forEach(c => {
    carpetasPM2[c.name] = c.id;
  });
  
  console.log('Carpetas PM2 disponibles:');
  Object.keys(carpetasPM2).forEach(n => console.log(`  • ${n}`));
  console.log('');
  
  // 1. Mover contenido de 01-MARCO-CONTRACTUAL a 01-GOBERNANZA
  console.log('📄 1. Marco Contractual → 01-GOBERNANZA\n');
  
  const marcoContractual = await drive.files.list({
    q: `'${carpetasPM2['01-MARCO-CONTRACTUAL'] || carpetasPM2['01-GOBERNANZA']}' in parents and trashed=false`,
    fields: 'files(id, name)'
  });
  
  // Si existe la subcarpeta 01-MARCO-CONTRACTUAL dentro de Base Documental
  const baseMarco = await drive.files.list({
    q: `'${BASE_DOCUMENTAL_ID}' in parents and name='01-MARCO-CONTRACTUAL' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id)'
  });
  
  if (baseMarco.data.files.length > 0) {
    const marcoId = baseMarco.data.files[0].id;
    const docsMarco = await drive.files.list({
      q: `'${marcoId}' in parents and trashed=false`,
      fields: 'files(id, name)'
    });
    
    for (const doc of docsMarco.data.files) {
      console.log(`   ➡️ ${doc.name}`);
      await drive.files.update({
        fileId: doc.id,
        addParents: carpetasPM2['01-GOBERNANZA'],
        removeParents: marcoId,
        fields: 'id'
      });
    }
  }
  
  // 2. Mover contenido de 04-AVANCES-OTROS-CONSULTORES a 04-SEGUIMIENTO
  console.log('\n📄 2. Avances Otros Consultores → 04-SEGUIMIENTO\n');
  
  const baseOtros = await drive.files.list({
    q: `'${BASE_DOCUMENTAL_ID}' in parents and name='04-AVANCES-OTROS-CONSULTORES' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id)'
  });
  
  if (baseOtros.data.files.length > 0) {
    const otrosId = baseOtros.data.files[0].id;
    const docsOtros = await drive.files.list({
      q: `'${otrosId}' in parents and trashed=false`,
      fields: 'files(id, name)'
    });
    
    // Crear subcarpeta en 04-SEGUIMIENTO para otros consultores
    const otrosEnSeguimiento = await drive.files.list({
      q: `name='AVANCES-OTROS-CONSULTORES' and '${carpetasPM2['04-SEGUIMIENTO']}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
      fields: 'files(id)'
    });
    
    let destinoOtrosId;
    if (otrosEnSeguimiento.data.files.length > 0) {
      destinoOtrosId = otrosEnSeguimiento.data.files[0].id;
    } else {
      const creada = await drive.files.create({
        requestBody: {
          name: 'AVANCES-OTROS-CONSULTORES',
          mimeType: 'application/vnd.google-apps.folder',
          parents: [carpetasPM2['04-SEGUIMIENTO']]
        }
      });
      destinoOtrosId = creada.data.id;
      console.log('   ✅ Creada subcarpeta AVANCES-OTROS-CONSULTORES en 04-SEGUIMIENTO');
    }
    
    for (const doc of docsOtros.data.files) {
      console.log(`   ➡️ ${doc.name}`);
      await drive.files.update({
        fileId: doc.id,
        addParents: destinoOtrosId,
        removeParents: otrosId,
        fields: 'id'
      });
    }
  }
  
  // 3. Crear subcarpetas en 02-PLANIFICACION para normativa y referencias
  console.log('\n📄 3. Creando estructura en 02-PLANIFICACION\n');
  
  // Normativa ITS
  const baseNormativa = await drive.files.list({
    q: `'${BASE_DOCUMENTAL_ID}' in parents and name='02-NORMATIVA-ITS' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id)'
  });
  
  if (baseNormativa.data.files.length > 0) {
    const normativaId = baseNormativa.data.files[0].id;
    const docsNormativa = await drive.files.list({
      q: `'${normativaId}' in parents and trashed=false`,
      fields: 'files(id, name)'
    });
    
    if (docsNormativa.data.files.length > 0) {
      // Crear subcarpeta en 02-PLANIFICACION
      const normativaEnPlan = await drive.files.list({
        q: `name='NORMATIVA-ITS' and '${carpetasPM2['02-PLANIFICACION']}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
        fields: 'files(id)'
      });
      
      let destinoNormativaId;
      if (normativaEnPlan.data.files.length > 0) {
        destinoNormativaId = normativaEnPlan.data.files[0].id;
      } else {
        const creada = await drive.files.create({
          requestBody: {
            name: 'NORMATIVA-ITS',
            mimeType: 'application/vnd.google-apps.folder',
            parents: [carpetasPM2['02-PLANIFICACION']]
          }
        });
        destinoNormativaId = creada.data.id;
        console.log('   ✅ Creada subcarpeta NORMATIVA-ITS en 02-PLANIFICACION');
      }
      
      for (const doc of docsNormativa.data.files) {
        console.log(`   ➡️ ${doc.name}`);
        await drive.files.update({
          fileId: doc.id,
          addParents: destinoNormativaId,
          removeParents: normativaId,
          fields: 'id'
        });
      }
    }
  }
  
  // Referencias
  const baseRef = await drive.files.list({
    q: `'${BASE_DOCUMENTAL_ID}' in parents and name='03-REFERENCIAS-PROYECTOS' and mimeType='application/vnd.google-apps.folder' and trashed=false`,
    fields: 'files(id)'
  });
  
  if (baseRef.data.files.length > 0) {
    const refId = baseRef.data.files[0].id;
    const docsRef = await drive.files.list({
      q: `'${refId}' in parents and trashed=false`,
      fields: 'files(id, name)'
    });
    
    if (docsRef.data.files.length > 0) {
      const refEnPlan = await drive.files.list({
        q: `name='REFERENCIAS-PROYECTOS' and '${carpetasPM2['02-PLANIFICACION']}' in parents and mimeType='application/vnd.google-apps.folder' and trashed=false`,
        fields: 'files(id)'
      });
      
      let destinoRefId;
      if (refEnPlan.data.files.length > 0) {
        destinoRefId = refEnPlan.data.files[0].id;
      } else {
        const creada = await drive.files.create({
          requestBody: {
            name: 'REFERENCIAS-PROYECTOS',
            mimeType: 'application/vnd.google-apps.folder',
            parents: [carpetasPM2['02-PLANIFICACION']]
          }
        });
        destinoRefId = creada.data.id;
        console.log('   ✅ Creada subcarpeta REFERENCIAS-PROYECTOS en 02-PLANIFICACION');
      }
      
      for (const doc of docsRef.data.files) {
        console.log(`   ➡️ ${doc.name}`);
        await drive.files.update({
          fileId: doc.id,
          addParents: destinoRefId,
          removeParents: refId,
          fields: 'id'
        });
      }
    }
  }
  
  console.log('\n═══════════════════════════════════════════════════');
  console.log('✅ Migración completada');
  console.log('\n📂 Estructura PM2 ahora contiene:');
  console.log('01-GOBERNANZA/ ← Marco contractual (TOR, contrato)');
  console.log('02-PLANIFICACION/ ← Normativa ITS + Referencias');
  console.log('04-SEGUIMIENTO/ ← Avances otros consultores');
}

moverABasePM2();
