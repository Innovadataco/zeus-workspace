const mammoth = require('mammoth');
const fs = require('fs');

const inputFile = '/root/.openclaw/media/inbound/8.---513d879d-9d3b-45ed-9d21-059c999950c7.docx';
const outputFile = '/tmp/capitulo8.md';

console.log('📄 Extrayendo contenido del Capítulo 8...\n');

mammoth.extractRawText({ path: inputFile })
  .then(result => {
    const text = result.value;
    console.log('✅ Texto extraído exitosamente');
    console.log(`📊 Longitud: ${text.length} caracteres\n`);
    
    fs.writeFileSync(outputFile, text);
    console.log(`💾 Guardado en: ${outputFile}\n`);
    
    // Mostrar primeras 3000 caracteres
    console.log('═══════════════════════════════════════════════════');
    console.log('VISTA PREVIA (primeros 3000 caracteres):');
    console.log('═══════════════════════════════════════════════════\n');
    console.log(text.substring(0, 3000));
    console.log('\n... (continúa) ...');
    
    // Buscar CC- menciones
    const ccMatches = text.match(/CC-\d+/g);
    if (ccMatches) {
      const uniqueCC = [...new Set(ccMatches)].sort();
      console.log('\n═══════════════════════════════════════════════════');
      console.log('COMPONENTES CC ENCONTRADOS:');
      console.log('═══════════════════════════════════════════════════');
      console.log(uniqueCC.join(', '));
      console.log(`\nTotal: ${uniqueCC.length} componentes`);
    }
  })
  .catch(err => {
    console.error('❌ Error:', err.message);
  });
