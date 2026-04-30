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

async function createEventInUserCalendar(auth) {
  const calendar = google.calendar({ version: 'v3', auth });
  
  // Crear evento en el calendario del usuario
  const calendarId = 'gerencia@innovadataco.com';
  
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

Creado por ZEUS - Sistema Operativo Empresarial`,
    start: {
      dateTime: '2026-04-28T08:30:00-05:00',
      timeZone: 'America/Bogota',
    },
    end: {
      dateTime: '2026-04-28T08:45:00-05:00',
      timeZone: 'America/Bogota',
    },
    attendees: [
      {
        email: 'gerencia@innovadataco.com',
        displayName: 'Jelkin Carrillo Franco',
        organizer: true,
      },
      {
        email: 'odin-bot@citric-shine-494005-f2.iam.gserviceaccount.com',
        displayName: 'ZEUS - Asistente IA',
      }
    ],
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
      calendarId: calendarId,
      requestBody: event,
      sendUpdates: 'all',
    });
    
    console.log('✅ Evento creado en calendario del usuario');
    console.log('Calendario:', calendarId);
    console.log('ID:', response.data.id);
    console.log('Link:', response.data.htmlLink);
    return response.data;
  } catch (error) {
    console.error('❌ Error:', error.message);
    if (error.code === 404) {
      console.log('\n⚠️  El calendario no fue encontrado o no tengo acceso');
    }
    if (error.code === 403) {
      console.log('\n⚠️  Sin permisos para crear eventos en este calendario');
    }
    return null;
  }
}

async function main() {
  console.log('📅 Creando evento en calendario gerencia@innovadataco.com...\n');
  const auth = await authenticate();
  const event = await createEventInUserCalendar(auth);
  
  if (event) {
    console.log('\n✅ EVENTO CREADO - REVISA TU CALENDARIO');
  } else {
    console.log('\n❌ No se pudo crear');
    console.log('\n💡 SOLUCIÓN: Por favor crea el evento manualmente en');
    console.log('   tu calendario y compárteme el link');
  }
}

main().catch(console.error);
