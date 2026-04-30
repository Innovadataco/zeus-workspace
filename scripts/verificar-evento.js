const fs = require('fs');
const { google } = require('googleapis');

const credentials = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/oauth-client-secret.json'));
const tokens = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/google-oauth-token.json'));

const { client_id, client_secret } = credentials.installed;

const oauth2Client = new google.auth.OAuth2(client_id, client_secret, 'http://localhost:3000/oauth2callback');
oauth2Client.setCredentials(tokens);

const calendar = google.calendar({ version: 'v3', auth: oauth2Client });

async function verificarEvento() {
  try {
    // Buscar eventos del día
    const response = await calendar.events.list({
      calendarId: 'primary',
      timeMin: '2026-04-29T00:00:00-05:00',
      timeMax: '2026-04-29T23:59:59-05:00',
      singleEvents: true,
      orderBy: 'startTime',
    });

    console.log('═══════════════════════════════════════════════════');
    console.log('📅 EVENTOS ENCONTRADOS PARA MAÑANA 29 ABRIL');
    console.log('═══════════════════════════════════════════════════');
    
    if (response.data.items.length === 0) {
      console.log('No hay eventos programados.');
    } else {
      response.data.items.forEach(event => {
        console.log('');
        console.log(`📝 ${event.summary}`);
        console.log(`   📅 ${event.start.dateTime || event.start.date}`);
        console.log(`   🔗 ${event.htmlLink}`);
        
        if (event.attendees) {
          console.log(`   👥 Invitados:`);
          event.attendees.forEach(att => {
            console.log(`      • ${att.email} — Estado: ${att.responseStatus}`);
          });
        }
      });
    }
    
    console.log('');
    console.log('═══════════════════════════════════════════════════');
    console.log('Nota: Las invitaciones pueden tardar unos minutos en llegar.');
    console.log('También revisar carpeta de spam/correo no deseado.');
    console.log('═══════════════════════════════════════════════════');
    
  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

verificarEvento();
