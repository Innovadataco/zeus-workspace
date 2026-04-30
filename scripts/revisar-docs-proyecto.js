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

async function revisarDocumentos() {
  const drive = google.drive({ version: 'v3', auth });
  
  const BASE_DOCUMENTAL_ID = '19jiZpP4SoWiXEVAD4FWEgmrz9ZCRggnM';
  const ENTREGABLES_ID = '1GEv-GINv_Wac2ahk1GE805BoCjH2E4wj';
  
  console.log('📂 REVISIÓN DE DOCUMENTOS DEL PROYECTO\n');
  console.log('═══════════════════════════════════════════════════\n');
  
  // Revisar Base Documental
  console.log('📁 1. BASE DOCUMENTAL\n');
  try {
    const baseDocs = await drive.files.list({
      q: `'${BASE_DOCUMENTAL_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType, modifiedTime)',
      orderBy: 'name'
    });
    
    console.log(`   Total documentos: ${baseDocs.data.files.length}\n`);
    
    // Categorizar
    const marcoJuridico = [];
    const investigacion = [];
    const referencias = [];
    const otrosConsultores = [];
    const otros = [];
    
    baseDocs.data.files.forEach(doc => {
      const nombre = doc.name.toLowerCase();
      
      if (nombre.includes('ley') || nombre.includes('decreto') || nombre.includes('resolucion') || nombre.includes('norma') || nombre.includes('juridico') || nombre.includes('legal') || nombre.includes('reglamento')) {
        marcoJuridico.push(doc);
      } else if (nombre.includes('investigacion') || nombre.includes('estudio') || nombre.includes('analisis') || nombre.includes('benchmark')) {
        investigacion.push(doc);
      } else if (nombre.includes('referencia') || nombre.includes('ejemplo') || nombre.includes('app') || nombre.includes('sistema')) {
        referencias.push(doc);
      } else if (nombre.includes('transconsult') || nombre.includes('ifc') || nombre.includes('consultor') || nombre.includes('especialista')) {
        otrosConsultores.push(doc);
      } else {
        otros.push(doc);
      }
    });
    
    console.log('   📋 CATEGORÍAS DETECTADAS:\n');
    
    if (marcoJuridico.length > 0) {
      console.log(`   ⚖️  Marco Jurídico (${marcoJuridico.length}):`);
      marcoJuridico.forEach(d => console.log(`      • ${d.name}`));
      console.log('');
    }
    
    if (investigacion.length > 0) {
      console.log(`   🔬 Investigación (${investigacion.length}):`);
      investigacion.forEach(d => console.log(`      • ${d.name}`));
      console.log('');
    }
    
    if (referencias.length > 0) {
      console.log(`   📚 Referencias (${referencias.length}):`);
      referencias.forEach(d => console.log(`      • ${d.name}`));
      console.log('');
    }
    
    if (otrosConsultores.length > 0) {
      console.log(`   👥 Otros Consultores (${otrosConsultores.length}):`);
      otrosConsultores.forEach(d => console.log(`      • ${d.name}`));
      console.log('');
    }
    
    if (otros.length > 0) {
      console.log(`   📄 Otros (${otros.length}):`);
      otros.forEach(d => console.log(`      • ${d.name}`));
      console.log('');
    }
    
  } catch (error) {
    console.error('   ❌ Error:', error.message);
  }
  
  console.log('═══════════════════════════════════════════════════\n');
  
  // Revisar Entregables
  console.log('📁 2. ENTREGABLES\n');
  try {
    const entregables = await drive.files.list({
      q: `'${ENTREGABLES_ID}' in parents and trashed=false`,
      fields: 'files(id, name, mimeType, modifiedTime)',
      orderBy: 'name'
    });
    
    console.log(`   Total archivos: ${entregables.data.files.length}\n`);
    
    entregables.data.files.forEach((doc, i) => {
      const icono = doc.mimeType === 'application/vnd.google-apps.folder' ? '📁' : '📄';
      console.log(`   ${i+1}. ${icono} ${doc.name}`);
    });
    
    // Detectar entregables E1-E8
    const e1 = entregables.data.files.filter(f => f.name.toLowerCase().includes('e1') || f.name.toLowerCase().includes('diagnostico'));
    const e2 = entregables.data.files.filter(f => f.name.toLowerCase().includes('e2') || f.name.toLowerCase().includes('brecha'));
    const e3 = entregables.data.files.filter(f => f.name.toLowerCase().includes('e3') || f.name.toLowerCase().includes('concepto'));
    const e4 = entregables.data.files.filter(f => f.name.toLowerCase().includes('e4') || f.name.toLowerCase().includes('ficha') || f.name.toLowerCase().includes('componente'));
    const e5 = entregables.data.files.filter(f => f.name.toLowerCase().includes('e5') || f.name.toLowerCase().includes('requerimiento'));
    
    console.log('\n   📋 ENTREGABLES DETECTADOS:\n');
    console.log(`   E1 (Diagnóstico): ${e1.length} archivos`);
    console.log(`   E2 (Brechas): ${e2.length} archivos`);
    console.log(`   E3 (Concepto): ${e3.length} archivos`);
    console.log(`   E4 (Componentes): ${e4.length} archivos`);
    console.log(`   E5 (Requerimientos): ${e5.length} archivos`);
    
  } catch (error) {
    console.error('   ❌ Error:', error.message);
  }
  
  console.log('\n═══════════════════════════════════════════════════');
  console.log('✅ Revisión completada');
}

revisarDocumentos();
