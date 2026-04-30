const { google } = require('googleapis');
const fs = require('fs');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['https://www.googleapis.com/auth/gmail.readonly'],
  subject: 'gerencia@innovadataco.com'
});

async function buscarEmailsTARConsultores() {
  const gmail = google.gmail({ version: 'v1', auth });
  
  console.log('📧 Buscando emails de TARConsultores...\n');
  
  // Buscar por diferentes variaciones
  const queries = [
    'from:tarconsultores.com',
    'from:tarconsultores',
    'from:transconsult',
    'from:daniel.duarte',
    'from:maria.constanza'
  ];
  
  for (const query of queries) {
    try {
      const response = await gmail.users.messages.list({
        userId: 'me',
        q: query,
        maxResults: 10
      });
      
      if (response.data.messages && response.data.messages.length > 0) {
        console.log(`✅ Query "${query}": ${response.data.messages.length} emails encontrados`);
        
        // Obtener el más reciente
        const lastMsg = await gmail.users.messages.get({
          userId: 'me',
          id: response.data.messages[0].id,
          format: 'metadata',
          metadataHeaders: ['Subject', 'From', 'Date', 'To']
        });
        
        const headers = lastMsg.data.payload.headers;
        const subject = headers.find(h => h.name === 'Subject')?.value || 'Sin asunto';
        const from = headers.find(h => h.name === 'From')?.value || 'Desconocido';
        const date = headers.find(h => h.name === 'Date')?.value || 'Sin fecha';
        
        console.log('\n📨 ÚLTIMO EMAIL:');
        console.log('De:', from);
        console.log('Asunto:', subject);
        console.log('Fecha:', date);
        console.log('ID:', lastMsg.data.id);
        console.log('');
        return; // Solo mostramos el primero que encuentre
      }
    } catch (error) {
      console.log(`⚠️ Query "${query}": ${error.message}`);
    }
  }
  
  console.log('⚠️ No se encontraron emails de TARConsultores con las búsquedas realizadas');
}

buscarEmailsTARConsultores().catch(console.error);
