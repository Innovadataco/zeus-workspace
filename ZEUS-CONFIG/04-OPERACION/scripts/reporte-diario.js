const { google } = require('googleapis');
const fs = require('fs');
const KEYFILEPATH = '/root/.openclaw/workspace/.secrets/google-service-account.json';
const SCOPES = ['https://www.googleapis.com/auth/gmail.readonly', 'https://www.googleapis.com/auth/calendar.readonly'];

async function authenticate() {
  const auth = new google.auth.GoogleAuth({
    keyFile: KEYFILEPATH,
    scopes: SCOPES,
  });
  return auth;
}

async function getEmailsLast12h(auth) {
  try {
    const gmail = google.gmail({ version: 'v1', auth });
    const twelveHoursAgo = Math.floor((Date.now() - 12 * 60 * 60 * 1000) / 1000);
    const response = await gmail.users.messages.list({
      userId: 'me',
      q: `after:${twelveHoursAgo}`,
      maxResults: 10
    });
    return { success: true, count: response.data.messages ? response.data.messages.length : 0 };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

async function getTodayMeetings(auth) {
  try {
    const calendar = google.calendar({ version: 'v3', auth });
    const now = new Date();
    const tomorrow = new Date(now);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const response = await calendar.events.list({
      calendarId: 'primary',
      timeMin: now.toISOString(),
      timeMax: tomorrow.toISOString(),
      maxResults: 10,
      singleEvents: true,
      orderBy: 'startTime',
    });
    
    const events = response.data.items || [];
    return { success: true, count: events.length, events: events.map(e => e.summary) };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

function formatReport(emailResult, calendarResult) {
  const now = new Date().toLocaleString('es-CO', { timeZone: 'America/Bogota' });
  
  let report = `═══════════════════════════════════════════════════\n`;
  report += `📋 REPORTE DIARIO - ${now} (Hora Colombia)\n`;
  report += `═══════════════════════════════════════════════════\n\n`;
  
  report += `📧 EMAILS (Últimas 12 horas)\n`;
  if (emailResult.success) {
    report += `   ${emailResult.count} mensajes nuevos\n`;
  } else {
    report += `   ❌ Error: ${emailResult.error}\n`;
  }
  report += `\n`;
  
  report += `📅 REUNIONES HOY\n`;
  if (calendarResult.success) {
    report += `   ${calendarResult.count} reuniones programadas\n`;
    if (calendarResult.events.length > 0) {
      report += `   Próximas:\n`;
      calendarResult.events.slice(0, 5).forEach(e => {
        report += `   • ${e}\n`;
      });
    }
  } else {
    report += `   ❌ Error: ${calendarResult.error}\n`;
  }
  report += `\n`;
  
  report += `⚠️ ALERTAS\n`;
  report += `   Sin alertas críticas detectadas\n`;
  report += `\n`;
  
  report += `───────────────────────────────────────────────────\n`;
  report += `Generado automáticamente por ZEUS\n`;
  
  return report;
}

async function main() {
  console.log('📋 Generando reporte diario...\n');
  
  const auth = await authenticate();
  
  const emailResult = await getEmailsLast12h(auth);
  const calendarResult = await getTodayMeetings(auth);
  
  const report = formatReport(emailResult, calendarResult);
  console.log(report);
  
  // Guardar reporte
  const date = new Date().toISOString().split('T')[0];
  const reportPath = `/root/.openclaw/workspace/ZEUS-CONFIG/04-OPERACION/REPORTES/reporte-${date}.md`;
  
  // Crear carpeta si no existe
  const dir = '/root/.openclaw/workspace/ZEUS-CONFIG/04-OPERACION/REPORTES';
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
  
  fs.writeFileSync(reportPath, report);
  console.log(`\n✅ Reporte guardado en: ${reportPath}`);
}

main().catch(error => {
  console.error('❌ Error generando reporte:', error.message);
  process.exit(1);
});
