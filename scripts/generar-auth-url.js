const fs = require('fs');
const { google } = require('googleapis');

// Cargar credenciales
const credentials = JSON.parse(fs.readFileSync('/root/.openclaw/.secrets/oauth-client-secret.json'));
const { client_id, client_secret } = credentials.installed;

const oauth2Client = new google.auth.OAuth2(
  client_id,
  client_secret,
  'http://localhost:3000/oauth2callback' // Redirect URI
);

// Alcance necesario para Calendar
const scopes = [
  'https://www.googleapis.com/auth/calendar',
  'https://www.googleapis.com/auth/calendar.events'
];

// Generar URL de autorización
const authUrl = oauth2Client.generateAuthUrl({
  access_type: 'offline',
  scope: scopes,
  prompt: 'consent', // Forzar consentimiento para obtener refresh token
});

console.log('═══════════════════════════════════════════════════');
console.log('🔗 LINK DE AUTORIZACIÓN GOOGLE CALENDAR');
console.log('═══════════════════════════════════════════════════');
console.log('');
console.log('PASO 1: Abre este link en tu navegador');
console.log('');
console.log(authUrl);
console.log('');
console.log('═══════════════════════════════════════════════════');
console.log('');
console.log('PASO 2: Inicia sesión con gerencia@innovadataco.com');
console.log('');
console.log('PASO 3: Acepta los permisos para ZEUS');
console.log('   ✅ Ver tu calendario');
console.log('   ✅ Crear y editar eventos');
console.log('');
console.log('PASO 4: Te redirigirá a localhost (error esperado)');
console.log('   Copia TODO el URL de la barra de direcciones');
console.log('   (incluye ?code=...)');
console.log('');
console.log('PASO 5: Pégamelo aquí');
console.log('');
console.log('═══════════════════════════════════════════════════');
console.log('⚠️  Este link es personal y de un solo uso');
console.log('═══════════════════════════════════════════════════');
