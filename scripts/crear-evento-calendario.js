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

async function createEvent(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  // Fecha: mañana 29 abril 2026, 10:00 AM Colombia (GMT-5)
  // 2026-04-29T10:00:00-05:00
  const startDateTime = '2026-04-29T10:00:00-05:00';
  const endDateTime = '2026-04-29T12:00:00-05:00';
  
  const event = {
    summary: '🎨 Diseñar Manual de Identidad Innovadataco',
    location: 'Oficina Innovadataco',
    description: `TAREA CRÍTICA - Reunión de Seguimiento Corporativo

Contenido a diseñar:
✓ Logo y variantes de Innovadataco
✓ Paleta de colores corporativos  
✓ Tipografía oficial
✓ Aplicaciones (papelería, presentaciones, Word)
✓ Manual de uso de marca

Entregable: Documento guía de identidad corporativa
Prioridad: ALTA

Recordatorio: Programado por ZEUS`,
    start: {
      dateTime: startDateTime,
      timeZone: 'America/Bogota',
    },
    end: {
      dateTime: endDateTime,
      timeZone: 'America/Bogota',
    },
    reminders: {
      useDefault: false,
      overrides: [
        { method: 'email', minutes: 1440 }, // 1 día antes
        { method: 'popup', minutes: 60 },   // 1 hora antes
      ],
    },
  };
  
  try {
    const response = await calendar.events.insert({
      calendarId: 'primary',
      requestBody: event,
    });
    
    console.log('✅ Evento creado exitosamente');
    console.log('ID:', response.data.id);
    console.log('Link:', response.data.htmlLink);
    return response.data;
  } catch (error) {
    console.error('❌ Error creando evento:', error.message);
    return null;
  }
}

async function main() {
  console.log('📅 Creando evento en Google Calendar...\n');
  const auth = await authenticate();
  const event = await createEvent(auth);
  
  if (event) {
    console.log('\n✅ TAREA AGREGADA AL CALENDARIO');
  } else {
    console.log('\n❌ No se pudo crear el evento');
  }
}

main().catch(console.error);
