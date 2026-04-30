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

async function addAttendee(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  const eventId = 'oap36uif6iahackc903gg949s0';
  
  // Agregar al usuario como asistente para que aparezca en su calendario
  const eventUpdate = {
    attendees: [
      {
        email: 'gerencia@innovadataco.com',
        displayName: 'Jelkin Carrillo - CEO Innovadataco',
        responseStatus: 'accepted',
      }
    ],
    // Enviar notificación por email
    sendUpdates: 'all',
  };
  
  try {
    const response = await calendar.events.patch({
      calendarId: 'primary',
      eventId: eventId,
      requestBody: eventUpdate,
      sendUpdates: 'all', // Notificar a los asistentes
    });
    
    console.log('✅ Asistente agregado exitosamente');
    console.log('Email agregado: gerencia@innovadataco.com');
    console.log('Se envió notificación por email');
    console.log('El evento debería aparecer en tu calendario en minutos');
    return response.data;
  } catch (error) {
    console.error('❌ Error:', error.message);
    return null;
  }
}

async function main() {
  console.log('📧 Agregándote como asistente al evento...\n');
  const auth = await authenticate();
  const event = await addAttendee(auth);
  
  if (event) {
    console.log('\n✅ LISTO - Revisa tu calendario');
    console.log('También revisa tu email por la invitación');
  } else {
    console.log('\n❌ No se pudo agregar');
  }
}

main().catch(console.error);
