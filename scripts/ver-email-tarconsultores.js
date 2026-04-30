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

async function obtenerContenidoEmail() {
  const gmail = google.gmail({ version: 'v1', auth });
  
  console.log('📧 Obteniendo contenido del email de TARConsultores...\n');
  
  try {
    const message = await gmail.users.messages.get({
      userId: 'me',
      id: '19d9b079a4624847',
      format: 'full'
    });
    
    const headers = message.data.payload.headers;
    const subject = headers.find(h => h.name === 'Subject')?.value || 'Sin asunto';
    const from = headers.find(h => h.name === 'From')?.value || 'Desconocido';
    const to = headers.find(h => h.name === 'To')?.value || '';
    const date = headers.find(h => h.name === 'Date')?.value || 'Sin fecha';
    
    console.log('═══════════════════════════════════════════════════');
    console.log('📨 EMAIL DE TARCONSULTORES');
    console.log('═══════════════════════════════════════════════════');
    console.log('De:', from);
    console.log('Para:', to);
    console.log('Asunto:', subject);
    console.log('Fecha:', date);
    console.log('═══════════════════════════════════════════════════\n');
    
    // Extraer contenido
    let body = '';
    if (message.data.payload.parts) {
      const textPart = message.data.payload.parts.find(p => p.mimeType === 'text/plain');
      if (textPart && textPart.body && textPart.body.data) {
        body = Buffer.from(textPart.body.data, 'base64').toString('utf-8');
      }
    } else if (message.data.payload.body && message.data.payload.body.data) {
      body = Buffer.from(message.data.payload.body.data, 'base64').toString('utf-8');
    }
    
    console.log('📝 CONTENIDO:');
    console.log(body.substring(0, 2000)); // Primeros 2000 caracteres
    
    if (body.length > 2000) {
      console.log('\n... (contenido truncado, email muy largo)');
    }
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

obtenerContenidoEmail().catch(console.error);
