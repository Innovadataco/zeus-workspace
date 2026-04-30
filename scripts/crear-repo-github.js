const { execSync } = require('child_process');

const TOKEN = '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';
const REPO_NAME = 'IDC_2026_01';
const DESCRIPTION = 'APP Chía-Girardot ITS - Primer contrato 2026 - TransConsult - $112M';

// Crear repositorio usando curl
const createRepoCommand = `curl -s -X POST \\
  -H "Authorization: token ${TOKEN}" \\
  -H "Accept: application/vnd.github.v3+json" \\
  https://api.github.com/user/repos \\
  -d '{"name":"${REPO_NAME}","description":"${DESCRIPTION}","private":true,"auto_init":true}'`;

try {
  console.log('🚀 Creando repositorio IDC_2026_01...\n');
  
  const result = execSync(createRepoCommand, { encoding: 'utf8' });
  const response = JSON.parse(result);
  
  console.log('✅ REPOSITORIO CREADO EXITOSAMENTE');
  console.log('');
  console.log('📁 Nombre:', response.name);
  console.log('🔗 URL:', response.html_url);
  console.log('📄 Clone URL:', response.clone_url);
  console.log('🔒 Privado:', response.private ? 'Sí' : 'No');
  console.log('');
  console.log('✅ Listo para subir contenido PM2');
  
} catch (error) {
  console.error('❌ Error creando repositorio:');
  console.error(error.message);
  
  if (error.stdout) {
    try {
      const response = JSON.parse(error.stdout);
      if (response.message) {
        console.error('Mensaje:', response.message);
      }
      if (response.errors) {
        console.error('Errores:', response.errors);
      }
    } catch (e) {
      console.error('Respuesta:', error.stdout);
    }
  }
}
