const mammoth = require('mammoth');
const fs = require('fs');

const inputFile = '/root/.openclaw/media/inbound/REQUERIMIENTOS_FUNCIONALES_Y_NO_FUNCIONALES---67b3ce54-6955-4755-9060-2341a9827171.docx';
const outputFile = '/tmp/capitulo8_1.md';

console.log('📄 Extrayendo Capítulo 8.1...\n');

mammoth.extractRawText({ path: inputFile })
  .then(result => {
    const text = result.value;
    console.log('✅ Texto extraído');
    console.log(`📊 Longitud: ${text.length} caracteres\n`);
    
    fs.writeFileSync(outputFile, text);
    
    // Buscar CC- menciones
    const ccMatches = text.match(/CC-\d{2}/g);
    if (ccMatches) {
      const uniqueCC = [...new Set(ccMatches)].sort();
      console.log('═══════════════════════════════════════════════════');
      console.log('COMPONENTES CC ENCONTRADOS:');
      console.log('═══════════════════════════════════════════════════');
      uniqueCC.forEach(cc => console.log(`  ${cc}`));
      console.log(`\nTotal: ${uniqueCC.length} componentes`);
    }
    
    // Mostrar primeros 2000 caracteres
    console.log('\n═══════════════════════════════════════════════════');
    console.log('VISTA PREVIA:');
    console.log('═══════════════════════════════════════════════════\n');
    console.log(text.substring(0, 2000));
    
    // Guardar análisis
    fs.writeFileSync('/tmp/analisis-cc.txt', `Total CC: ${ccMatches ? [...new Set(ccMatches)].length : 0}\n\n${text.substring(0, 5000)}`);
    console.log('\n\n✅ Análisis guardado en /tmp/analisis-cc.txt');
  })
  .catch(err => {
    console.error('❌ Error:', err.message);
  });
