const fs = require('fs');
const { google } = require('googleapis');

// Cargar credenciales y tokens
const credentials = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/oauth-client-secret.json'));
const tokens = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/google-oauth-token.json'));

const { client_id, client_secret } = credentials.installed;

const oauth2Client = new google.auth.OAuth2(
  client_id,
  client_secret,
  'http://localhost:3000/oauth2callback'
);

oauth2Client.setCredentials(tokens);

const calendar = google.calendar({ version: 'v3', auth: oauth2Client });

// Crear evento de prueba
const event = {
  summary: '🧪 PRUEBA OAUTH — ZEUS Calendar Access',
  location: 'Virtual (Google Meet)',
  description: `Reunión de prueba para verificar acceso OAuth a calendario gerencia@innovadataco.com

Creado por: ZEUS Agente IA
Fecha: 28 Abril 2026
Hora: Colombia (GMT-5)

Si recibes esta invitación, el OAuth está funcionando correctamente.`,
  start: {
    dateTime: '2026-04-29T10:00:00-05:00',
    timeZone: 'America/Bogota',
  },
  end: {
    dateTime: '2026-04-29T10:30:00-05:00',
    timeZone: 'America/Bogota',
  },
  attendees: [
    { email: 'carrillo_franco@hotmail.com' },
  ],
  conferenceData: {
    createRequest: {
      requestId: 'zeus-test-' + Date.now(),
      conferenceSolutionKey: {
        type: 'hangoutsMeet',
      },
    },
  },
  reminders: {
    useDefault: false,
    overrides: [
      { method: 'email', minutes: 24 * 60 },
      { method: 'popup', minutes: 10 },
    ],
  },
};

async function createEvent() {
  try {
    const response = await calendar.events.insert({
      calendarId: 'primary',
      resource: event,
      sendUpdates: 'all', // Enviar invitaciones a los attendees
      conferenceDataVersion: 1,
    });

    console.log('═══════════════════════════════════════════════════');
    console.log('✅ REUNIÓN CREADA EXITOSAMENTE');
    console.log('═══════════════════════════════════════════════════');
    console.log('');
    console.log('📋 Detalles del evento:');
    console.log(`  Título: ${response.data.summary}`);
    console.log(`  Fecha: 29 Abril 2026`);
    console.log(`  Hora: 10:00 AM - 10:30 AM (Colombia)`);
    console.log(`  Ubicación: ${response.data.location}`);
    console.log('');
    console.log('👥 Invitados:');
    response.data.attendees.forEach(att => {
      console.log(`  • ${att.email} (${att.responseStatus})`);
    });
    console.log('');
    console.log('🔗 Links:');
    console.log(`  Evento: ${response.data.htmlLink}`);
    if (response.data.conferenceData) {
      console.log(`  Meet: ${response.data.conferenceData.entryPoints[0].uri}`);
    }
    console.log('');
    console.log('═══════════════════════════════════════════════════');
    console.log('📧 Invitación enviada a carrillo_franco@hotmail.com');
    console.log('═══════════════════════════════════════════════════');
    
  } catch (error) {
    console.error('❌ Error al crear evento:', error.message);
    console.error(error);
  }
}

createEvent();
