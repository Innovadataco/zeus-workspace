# ZEUS - Configuración de Accesos Google Suite

**Fecha de configuración:** 28 Abril 2026  
**Última actualización:** 28 Abril 2026

---

## 🔐 Credenciales de Acceso

### Service Account (Domain-Wide Delegation)
```
Client ID: 105096074342173013140
Email: odin-bot@citric-shine-494005-f2.iam.gserviceaccount.com
Project: citric-shine-494005-f2
```

### Usuario a Impersonar
```
gerencia@innovadataco.com
```

### Alcances Autorizados (KIMICLAW)
```
• https://www.googleapis.com/auth/gmail.readonly
• https://www.googleapis.com/auth/gmail.send
• https://www.googleapis.com/auth/gmail.modify
• https://www.googleapis.com/auth/calendar
• https://www.googleapis.com/auth/calendar.events
• https://www.googleapis.com/auth/drive
• https://www.googleapis.com/auth/documents
• https://www.googleapis.com/auth/spreadsheets
• https://www.googleapis.com/auth/presentations
```

---

## 📂 Ubicación de Credenciales

```
Archivo: /root/.openclaw/.secrets/google-service-account.json
Permisos: 600 (solo root)
Backup: No subir a GitHub (archivo .gitignore)
```

---

## 🚀 Método de Conexión

```javascript
const auth = new google.auth.JWT({
  email: credentials.client_email,
  key: credentials.private_key,
  scopes: ['...scopes...'],
  subject: 'gerencia@innovadataco.com'  // IMPERSONAR
});
```

---

## ✅ Servicios Funcionando

| Servicio | Estado | Método |
|----------|--------|--------|
| Google Calendar | ✅ Activo | Domain-Wide Delegation |
| Gmail Read | ✅ Activo | Domain-Wide Delegation |
| Gmail Send | ✅ Activo | Domain-Wide Delegation |
| Google Drive | ✅ Activo | Domain-Wide Delegation |
| Google Docs | ✅ Activo | Domain-Wide Delegation |
| Google Meet | ✅ Activo | Via Calendar API |

---

## 📝 Notas Operativas

- **Zona horaria:** America/Bogota (GMT-5)
- **Formato fechas:** ISO 8601 con timezone
- **Creación reuniones:** Con Meet automático
- **Envío emails:** Usar codificación base64url

---

**Configuración válida y operativa.**
ZEUS - Agente IA InnovaDataCo ⚡
