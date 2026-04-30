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

async function listCalendars(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  try {
    const response = await calendar.calendarList.list();
    console.log('📅 Calendarios disponibles:\n');
    
    response.data.items.forEach((cal, i) => {
      console.log(`${i + 1}. ${cal.summary}`);
      console.log(`   ID: ${cal.id}`);
      console.log(`   Primario: ${cal.primary ? 'SÍ' : 'NO'}`);
      console.log(`   Acceso: ${cal.accessRole}`);
      console.log('');
    });
    
    return response.data.items;
  } catch (error) {
    console.error('❌ Error:', error.message);
    return [];
  }
}

async function findEvent(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  const eventId = 'oap36uif6iahackc903gg949s0';
  
  try {
    // Buscar en calendario primario
    const event = await calendar.events.get({
      calendarId: 'primary',
      eventId: eventId,
    });
    
    console.log('✅ Evento encontrado en calendario primario');
    console.log('Título:', event.data.summary);
    console.log('Inicio:', event.data.start.dateTime);
    console.log('Organizador:', event.data.organizer ? event.data.organizer.email : 'N/A');
    
    return event.data;
  } catch (error) {
    console.log('❌ Evento no encontrado en calendario primario');
    console.log('Error:', error.message);
    return null;
  }
}

async function main() {
  const auth = await authenticate();
  
  console.log('🔍 Verificando calendarios y evento...\n');
  
  await listCalendars(auth);
  console.log('---\n');
  await findEvent(auth);
}

main().catch(console.error);
