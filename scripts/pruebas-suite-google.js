const { google } = require('googleapis');
const fs = require('fs');

const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const credentials = JSON.parse(fs.readFileSync(KEYFILEPATH));

// Autenticar con impersonación
const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: [
    'https://www.googleapis.com/auth/gmail.readonly',
    'https://www.googleapis.com/auth/gmail.send',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/calendar.events'
  ],
  subject: 'gerencia@innovadataco.com'
});

async function testSuite() {
  console.log('🚀 INICIANDO PRUEBAS COMPLETAS\n');
  
  // PRUEBA 1: Leer emails de henrro tatis
  console.log('📧 PRUEBA 1: Buscando emails de henrro tatis...');
  try {
    const gmail = google.gmail({ version: 'v1', auth });
    
    // Buscar emails de henrro tatis
    const response = await gmail.users.messages.list({
      userId: 'me',
      q: 'from:henrro.tatis OR from:henrro tatis',
      maxResults: 5
    });
    
    if (response.data.messages && response.data.messages.length > 0) {
      console.log(`✅ Encontrados ${response.data.messages.length} emails`);
      
      // Obtener el último email
      const lastMsg = await gmail.users.messages.get({
        userId: 'me',
        id: response.data.messages[0].id,
        format: 'metadata',
        metadataHeaders: ['Subject', 'From', 'Date']
      });
      
      const headers = lastMsg.data.payload.headers;
      const subject = headers.find(h => h.name === 'Subject')?.value || 'Sin asunto';
      const from = headers.find(h => h.name === 'From')?.value || 'Desconocido';
      const date = headers.find(h => h.name === 'Date')?.value || 'Sin fecha';
      
      console.log('\n📨 ÚLTIMO EMAIL DE HENRRO TATIS:');
      console.log('De:', from);
      console.log('Asunto:', subject);
      console.log('Fecha:', date);
    } else {
      console.log('⚠️ No se encontraron emails de henrro tatis');
    }
  } catch (error) {
    console.error('❌ Error Gmail:', error.message);
  }
  
  console.log('\n' + '='.repeat(50) + '\n');
  
  // PRUEBA 2: Crear reunión
  console.log('📅 PRUEBA 2: Creando reunión de prueba...');
  try {
    const calendar = google.calendar({ version: 'v3', auth });
    
    const event = {
      summary: '🧪 PRUEBA - Reunión de Test ZEUS',
      description: 'Esta es una reunión de prueba para verificar que ZEUS puede gestionar tu calendario.\n\nAgenda:\n1. Verificar acceso\n2. Confirmar funcionalidad\n3. Próximos pasos',
      start: {
        dateTime: '2026-04-29T14:00:00-05:00', // Mañana 2 PM
        timeZone: 'America/Bogota',
      },
      end: {
        dateTime: '2026-04-29T15:00:00-05:00',
        timeZone: 'America/Bogota',
      },
      attendees: [
        { email: 'carrillo_franco@hotmail.com', displayName: 'Jelkin Carrillo' }
      ],
      conferenceData: {
        createRequest: {
          requestId: 'test-meeting-' + Date.now(),
          conferenceSolutionKey: { type: 'hangoutsMeet' },
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
    
    const response = await calendar.events.insert({
      calendarId: 'primary',
      requestBody: event,
      conferenceDataVersion: 1,
      sendUpdates: 'all',
    });
    
    console.log('✅ REUNIÓN CREADA:');
    console.log('Título:', response.data.summary);
    console.log('Fecha: 29 Abril 2026, 2:00 PM Colombia');
    console.log('Meet:', response.data.hangoutLink);
    console.log('Invitado: carrillo_franco@hotmail.com');
    
  } catch (error) {
    console.error('❌ Error Calendar:', error.message);
  }
  
  console.log('\n' + '='.repeat(50) + '\n');
  
  // PRUEBA 3: Enviar email de prueba
  console.log('📤 PRUEBA 3: Enviando email de prueba...');
  try {
    const gmail = google.gmail({ version: 'v1', auth });
    
    const emailContent = [
      'From: "ZEUS - Innovadataco" <gerencia@innovadataco.com>',
      'To: carrillo_franco@hotmail.com',
      'Subject: 🧪 PRUEBA - ZEUS puede enviar emails',
      'Content-Type: text/plain; charset=utf-8',
      '',
      'Hola Jelkin,',
      '',
      'Este es un email de prueba enviado automáticamente por ZEUS.',
      '',
      '✅ Si recibiste este email, significa que ZEUS tiene acceso completo a tu Gmail.',
      '',
      '📅 También deberías ver una invitación de reunión para mañana a las 2 PM.',
      '',
      'Todo está funcionando correctamente.',
      '',
      '--',
      'ZEUS - Sistema Operativo Empresarial',
      'Innovadataco',
      'Fecha: ' + new Date().toLocaleString('es-CO', { timeZone: 'America/Bogota' })
    ].join('\r\n');
    
    const encodedEmail = Buffer.from(emailContent)
      .toString('base64')
      .replace(/\+/g, '-')
      .replace(/\//g, '_')
      .replace(/=+$/, '');
    
    await gmail.users.messages.send({
      userId: 'me',
      requestBody: { raw: encodedEmail }
    });
    
    console.log('✅ EMAIL ENVIADO a carrillo_franco@hotmail.com');
    
  } catch (error) {
    console.error('❌ Error enviando email:', error.message);
    console.log('⚠️ Nota: Para enviar emails, Gmail requiere verificación adicional');
  }
  
  console.log('\n' + '='.repeat(50));
  console.log('✅ PRUEBAS COMPLETADAS');
  console.log('='.repeat(50));
}

testSuite().catch(console.error);
