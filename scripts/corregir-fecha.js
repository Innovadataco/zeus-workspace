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

async function updateEventDate(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  const eventId = 'oap36uif6iahackc903gg949s0';
  
  // CORRECCIÓN: Mañana es 28 abril, no 29
  // 28 Abril 2026, 8:30 AM - 8:45 AM Colombia
  const startDateTime = '2026-04-28T08:30:00-05:00';
  const endDateTime = '2026-04-28T08:45:00-05:00';
  
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
    
    console.log('✅ Fecha corregida exitosamente');
    console.log('Nueva fecha: 28 Abril 2026');
    console.log('Hora: 8:30 AM - 8:45 AM (15 minutos)');
    console.log('Link:', response.data.htmlLink);
    return response.data;
  } catch (error) {
    console.error('❌ Error:', error.message);
    return null;
  }
}

async function main() {
  console.log('📅 Corrigiendo fecha del evento...\n');
  const auth = await authenticate();
  const event = await updateEventDate(auth);
  
  if (event) {
    console.log('\n✅ FECHA CORREGIDA: 28 ABRIL 2026');
  } else {
    console.log('\n❌ Error al corregir');
  }
}

main().catch(console.error);
