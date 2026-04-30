const { google } = require('googleapis');
const fs = require('fs');

// Cargar credenciales del service account
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

// Crear JWT client con impersonación del usuario
const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: [
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/calendar.events'
  ],
  subject: 'gerencia@innovadataco.com' // IMPERSONAR al usuario
});

async function createMeeting() {
  const calendar = google.calendar({ version: 'v3', auth });
  
  const event = {
    summary: '📊 Reunión de Seguimiento - APP Chía-Girardot',
    location: 'Google Meet',
    description: `Reunión de seguimiento semanal

Agenda:
1. Estado entregables E4-E5
2. Aprobación pendiente E1-E3
3. Próximos pasos con TransConsult
4. Gestión de riesgos

Organizado por: ZEUS - Innovadataco`,
    start: {
      dateTime: '2026-04-28T08:00:00-05:00', // Mañana 8 AM Colombia
      timeZone: 'America/Bogota',
    },
    end: {
      dateTime: '2026-04-28T09:00:00-05:00',
      timeZone: 'America/Bogota',
    },
    attendees: [
      {
        email: 'carrillo_franco@hotmail.com',
        displayName: 'Jelkin Carrillo',
      }
    ],
    conferenceData: {
      createRequest: {
        requestId: 'meeting-' + Date.now(),
        conferenceSolutionKey: {
          type: 'hangoutsMeet',
        },
      },
    },
    reminders: {
      useDefault: false,
      overrides: [
        { method: 'email', minutes: 60 },
        { method: 'popup', minutes: 15 },
      ],
    },
  };
  
  try {
    const response = await calendar.events.insert({
      calendarId: 'primary',
      requestBody: event,
      conferenceDataVersion: 1,
      sendUpdates: 'all',
    });
    
    console.log('✅ REUNIÓN CREADA EXITOSAMENTE');
    console.log('');
    console.log('📋 DETALLES:');
    console.log('Título:', response.data.summary);
    console.log('Fecha:', '28 Abril 2026');
    console.log('Hora:', '8:00 AM - 9:00 AM (Colombia)');
    console.log('Meet:', response.data.hangoutLink || response.data.conferenceData?.entryPoints?.[0]?.uri || 'Generado');
    console.log('Link:', response.data.htmlLink);
    console.log('');
    console.log('✉️ INVITACIÓN ENVIADA A:');
    console.log('  - carrillo_franco@hotmail.com');
    return response.data;
  } catch (error) {
    console.error('❌ Error:', error.message);
    console.error('Código:', error.code);
    if (error.response) {
      console.error('Detalles:', error.response.data);
    }
    return null;
  }
}

createMeeting();
