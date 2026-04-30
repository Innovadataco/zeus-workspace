const { google } = require('googleapis');
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/calendar'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function createMeeting(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  // Crear reunión para mañana 28 abril 2026, 8:00 AM Colombia
  const startDateTime = '2026-04-28T08:00:00-05:00';
  const endDateTime = '2026-04-28T09:00:00-05:00';
  
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
      dateTime: startDateTime,
      timeZone: 'America/Bogota',
    },
    end: {
      dateTime: endDateTime,
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
      sendUpdates: 'all', // Enviar invitaciones
    });
    
    console.log('✅ Reunión creada exitosamente');
    console.log('Título:', response.data.summary);
    console.log('Fecha:', response.data.start.dateTime);
    console.log('Meet:', response.data.hangoutLink || 'Generando...');
    console.log('Link:', response.data.htmlLink);
    console.log('Invitado:', 'carrillo_franco@hotmail.com');
    return response.data;
  } catch (error) {
    console.error('❌ Error:', error.message);
    if (error.code === 403) {
      console.log('\n⚠️ Sin permisos suficientes');
      console.log('Necesitas compartir el calendario con permisos de edición');
    }
    return null;
  }
}

async function main() {
  console.log('📅 Creando reunión de seguimiento...\n');
  const auth = await authenticate();
  const event = await createMeeting(auth);
  
  if (event) {
    console.log('\n✅ REUNIÓN CREADA');
    console.log('Se envió invitación a carrillo_franco@hotmail.com');
  } else {
    console.log('\n❌ No se pudo crear');
    console.log('\n💡 SOLUCIÓN:');
    console.log('Comparte tu calendario con:');
    console.log('odin-bot@citric-shine-494005-f2.iam.gserviceaccount.com');
    console.log('Permiso: Realizar cambios EN LOS EVENTOS');
  }
}

main().catch(console.error);
