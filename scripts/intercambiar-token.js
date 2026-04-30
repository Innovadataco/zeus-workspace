const fs = require('fs');
const { google } = require('googleapis');

// Cargar credenciales
const credentials = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/oauth-client-secret.json'));
const { client_id, client_secret } = credentials.installed;

const oauth2Client = new google.auth.OAuth2(
  client_id,
  client_secret,
  'http://localhost:3000/oauth2callback'
);

// Código de autorización (reemplazar con el recibido)
const code = '4/0AeoWuM_nU0TVA3pRofAt3lQ1wYJF8ZowgX0N1X6rn76ZkkYLGtVn3s0kJpYqdsNQTgGqrw';

async function getTokens() {
  try {
    const { tokens } = await oauth2Client.getToken(code);
    console.log('═══════════════════════════════════════════════════');
    console.log('✅ TOKENS OBTENIDOS EXITOSAMENTE');
    console.log('═══════════════════════════════════════════════════');
    console.log('');
    console.log('Access Token:', tokens.access_token.substring(0, 20) + '...');
    console.log('Refresh Token:', tokens.refresh_token ? tokens.refresh_token.substring(0, 20) + '...' : 'No disponible');
    console.log('Expiry Date:', new Date(tokens.expiry_date).toLocaleString());
    console.log('');
    console.log('Guardando tokens...');
    
    // Guardar tokens
    fs.writeFileSync('/root/.openclaw/.secrets/google-oauth-token.json', JSON.stringify(tokens, null, 2));
    
    console.log('✅ Tokens guardados en /root/.openclaw/.secrets/google-oauth-token.json');
    console.log('');
    console.log('═══════════════════════════════════════════════════');
    
    // Probar el acceso
    oauth2Client.setCredentials(tokens);
    const calendar = google.calendar({ version: 'v3', auth: oauth2Client });
    
    const response = await calendar.calendarList.list();
    console.log('📅 Calendarios disponibles:');
    response.data.items.forEach(cal => {
      console.log(`  • ${cal.summary}`);
    });
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

getTokens();
