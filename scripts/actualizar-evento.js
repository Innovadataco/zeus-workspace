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

async function updateEvent(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  // ID del evento creado anteriormente
  const eventId = 'oap36uif6iahackc903gg949s0';
  
  // Nueva hora: 8:30 AM - 8:45 AM Colombia (15 minutos)
  const startDateTime = '2026-04-29T08:30:00-05:00';
  const endDateTime = '2026-04-29T08:45:00-05:00';
  
  const eventUpdate = {
    start: {
      dateTime: startDateTime,
      timeZone: 'America/Bogota',
    },
    end: {
      dateTime: endDateTime,
      timeZone: 'America/Bogota',
    },
  };
  
  try {
    const response = await calendar.events.patch({
      calendarId: 'primary',
      eventId: eventId,
      requestBody: eventUpdate,
    });
    
    console.log('✅ Evento actualizado exitosamente');
    console.log('Nueva hora: 8:30 AM - 8:45 AM (15 minutos)');
    console.log('Link:', response.data.htmlLink);
    return response.data;
  } catch (error) {
    console.error('❌ Error actualizando evento:', error.message);
    return null;
  }
}

async function main() {
  console.log('📅 Actualizando hora del evento...\n');
  const auth = await authenticate();
  const event = await updateEvent(auth);
  
  if (event) {
    console.log('\n✅ HORA ACTUALIZADA EN CALENDARIO');
  } else {
    console.log('\n❌ No se pudo actualizar');
  }
}

main().catch(console.error);
