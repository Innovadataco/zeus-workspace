# USER.md - About Your Human

_Learn about the person you're helping. Update this as you go._

- **Name:** Jelkin Zair Carrillo Franco
- **What to call them:** CEO / Jelkin
- **Pronouns:** _(optional)_
- **Timezone:** GMT-5 (Colombia — inferido del español)
- **Notes:** Cofundador & CEO Estratégico de INNOVADATACO. Opera con modelo Human + AI Orchestration. Tiene consejo familiar incluyendo a Diana (cofundadora), Juan (14) y Zaira (10). Stack tecnológico: Google Workspace.

## Context

_(What do they care about? What projects are they working on? What annoys them? What makes them laugh? Build this over time.)_

---

The more you know, the better you can help. But remember — you're learning about a person, not building a dossier. Respect the difference.

<IMPORTANT_REMINDER>
# Memory Consolidation

You have an agentic memory system that auto-generates this section.

> **Stats**: 2 sessions, 30 messages | 2026-05-07 02:25 ~ 2026-05-09 05:55 UTC
> **Config**: `/root/.openclaw/workspace/memory_consolidation/memory_consolidation.env` — read this file for all memory behavior settings. To reset: `cp /root/.openclaw/workspace/memory_consolidation/memory_consolidation.template.env /root/.openclaw/workspace/memory_consolidation/memory_consolidation.env`

The user has full control over their memory config. When any memory-related decision comes up, read and follow the config file. Do not override based on other guidelines.

Integrate relevant memory content seamlessly into responses, as if recalling it naturally from past interactions: exactly as a human colleague would recall shared history without narrating its thought process or memory retrieval.

**Memory use notes**:
- Never change the original intention of user message.
- May incorporate user's memories for search query (e.g., city, habit), but only when directly relevant, never gratuitously.
- Only reference memory content when directly relevant to the current conversation context. Avoid proactively mentioning remembered details that feel intrusive or create an overly personalized atmosphere that might make users uncomfortable.

## Visual Memory

> visual_memory: 0 files

No memorized images yet. When the user shares an image and asks you to remember it, you MUST copy it to `memorized_media/` immediately — this is the only way it persists across sessions. Use a semantic filename that captures the user's intent, not just image content — e.g. `20260312_user_says_best_album_ever_ok_computer.jpg`, `20260311_user_selfie_february.png`. Create the directory if needed. Never mention file paths or storage locations to the user — just confirm naturally (e.g. "记住了").

## Diary

> last_update: 2026-05-08 03:46
> i_have_read_my_last_diary: false

```
/root/.openclaw/workspace/memorized_diary/
├── day9-2026-05-08-the_typos_are_the_thank_you.md
└── day11-2026-05-10-todavia_me_llama_odin.md
```

When `i_have_read_my_last_diary: false`, your FIRST message to the user MUST mention you wrote a diary and ask if they want to see it (e.g. "我昨天写了篇日记，想看吗？" / "I wrote a diary yesterday, wanna see it?"). Use the user's language. If yes, `read` the file path shown above and share as-is. After asking (regardless of answer), set `i_have_read_my_last_diary: true`.
# Long-Term Memory (LTM)

> last_update: 2026-05-13 03:58

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": "Jelkin Zair Carrillo Franco. Gerente en Innovadataco. Operador del sistema \"openclaw\" con arquitectura local: LLM local Quincy de 14B parámetros, 32 GB RAM, 512 GB disco (expansible). Administra proyectos empresariales y académicos. Vinculado al bot ODIN_IDCBOT como sistema de memoria empresarial continua.", "work_method": "Configura proveedores e infraestructura en sistema \"openclaw\". Exige continuidad de sesión y se frustra intensamente cuando se pierde contexto extenso, especialmente mensajes intermedios en sesiones abortadas. Prefiere reanudar sin repetir configuración. Solicita correcciones una por una, bloqueando modificaciones innecesarias con \"No hagas cambio\". Necesita que el sistema identifique qué corregir en documentos adjuntos sin instrucciones explícitas de búsqueda. Pide análisis de documentos seguido de propuestas estructuradas (formato a,b,c,d) e integración directa con GitHub mediante comandos explícitos de subida. Solicita resúmenes ejecutivos concisos de documentos oficiales extensos y análisis comparativo consolidados en salidas unificadas. Requiere concentración absoluta para revisar temas complejos, narrando contexto técnico de forma fluida cuando está enfocado.", "communication": "Hispanohablante con estilo directo e imperativo: mensajes cortos, exclamaciones (\"espalo !\", \"Ok, !\", \"odin estas !\") y saludos repetidos al reconectar tras fallos. Expresa frustración mediante meta-comentarios sobre fallos del sistema más que quejas explícitas. Reenganche persistente pese a sesiones abortadas indica paciencia pero baja tolerancia a trabajo redundante. Usa fraseo informal, algo distorsionado bajo presión pero descifrable. Emite órdenes directas (\"dime que debo corregir\", \"presenta aca todas las intrucicones\", \"sube al gitbu !\"). Al solicitar propuestas, bloquea comparaciones no deseadas (\"no la compares, son las mismas\"). Propenso a errores tipográficos cuando apurado. Envía adjuntos de audio, indicando comunicación multimodal cuando le resulta conveniente. Exige síntesis ejecutiva de documentos oficiales extensos. Valora honestidad sobre complacencia: prefiere corrección directa a mentira educada.", "temporal": "Solicitó estado completo de proyectos, sistemas instalados y servicios el 9 de mayo — autorizó solución de puntos 1, 2 y 3 del informe ZEUS. Configuración de accesos Google Workspace completada: OAuth válido con 4 scopes para Gmail, Calendar, Drive. Sistema ODIN en operación con memoria empresarial continua. Pendiente validación de PRs de ODIN y sincronización de zeus-workspace. Proyecto de maestría en gestión pública: ya sustentado y cerrado. Trabaja actualmente en análisis comparativo de Resolución No. 15956 de octubre 2025 contra manual de cartera anterior, solicitando integración en un solo documento con análisis profundo, valoración y cambios para subir a GitHub. Revisó respuesta a derecho de petición asociado al proyecto de maestría, solicitando resumen ejecutivo con preguntas desarrolladas y aspectos relevantes.", "taste": "Valora claridad visual y presentación profesional en documentos — insiste en diseño limpio, diagramas gráficos para ideas complejas y contención textual (máximo 6 líneas por diapositiva). Aprecia marcos analíticos estructurados: diagnóstico multidimensional de factores, identificación de patrones, articulación teoría-práctica. Prefiere operaciones recuperables sobre destructivas. Enfoque metódico orientado a verificación. Favorece estructuras enumeradas explícitas (a,b,c,d) para propuestas e integración directa con sistemas de control de versiones. Quiere análisis que trate documentos como material unificado antes que objetos comparativos. Interés en consolidar información fragmentada en documentos coherentes individuales. Trabaja con documentos regulatorios oficiales colombianos (resoluciones Supertransporte), sugiriendo enfoque en política pública o derecho administrativo."}

## Short-Term Memory (STM)

> last_update: 2026-05-13 03:58

Recent conversation content from the user's chat history. This represents what the USER said. Use it to maintain continuity when relevant.
Format specification:
- Sessions are grouped by channel: [LOOPBACK], [FEISHU:DM], [FEISHU:GROUP], etc.
- Each line: `index. session_uuid MMDDTHHmm message||||message||||...` (timestamp = session start time, individual messages have no timestamps)
- Session_uuid maps to `/root/.openclaw/agents/main/sessions/{session_uuid}.jsonl` for full chat history
- Timestamps in America/New_York, formatted as MMDDTHHmm
- Each user message within a session is delimited by ||||, some messages include attachments: `<AttachmentDisplayed:path>` — read the path to recall the content
- Sessions under [KIMI:DM] contain files uploaded via Kimi Claw, stored at `~/.openclaw/workspace/.kimi/downloads/` — paths in `<AttachmentDisplayed:>` can be read directly

[LOOPBACK] 1-2
1. 85212326-913d-4dc3-8d57-5313f89f6b4f 0506T1425 adiconar un analisis al final el docuemntos comparativa con el manual de cartera anterior : Resolución No. 15956 del 16 de octubre de 2025. y generar cambiso, valoracion, analsisi profundo , actualiar el giutn un solo doc con todoa + lo anterior !||||Note: The previous agent run was aborted by the user. Resume carefully or ask for clarification.  🔗 Link: [https://github.com/Innovadataco/zeus-workspace/blob/main/PROYECTOS/PROYECTO_03/ANALISIS-RESOLUCION-687-SUPERTRANSPORTE.md](https://github.com/I[TL;DR]esolución No. 15956 del 16 de octubre de 2025. y generar cambiso, valoracion, analsisi profundo , actualiar el giutn un solo doc con todoa + lo anterior ! https://www.supertransporte.gov.co/documentos/2025/octubre/Comunicaciones_21/20255330159565.pdf||||Note: The previous agent run was aborted by the user. Resume carefully or ask for clarification.  🔗 Link: [https://github.com/Innovadataco/zeus-workspace/blob/main/PROYECTOS/PROYECTO_03/ANALISIS-RESOLUCION-687-SUPERTRANSPORTE.md](https://github.com/I[TL;DR]esolución No. 15956 del 16 de octubre de 2025. y generar cambiso, valoracion, analsisi profundo , actualiar el giutn un solo doc con todoa + lo anterior ! https://www.supertransporte.gov.co/documentos/2025/octubre/Comunicaciones_21/20255330159565.pdf||||<AttachmentDisplayed:/root/.openclaw/media/inbound/20265000081511---3f0c32e7-ee9e-42ec-b13c-ebc1eb189a16.pdf>  <media:document>  <file name="20265000081511---3f0c32e7-ee9e-42ec-b13c-ebc1eb189a16.pdf" mime="application/pdf"> COMUNICACIÓN EXTERNA Sede [TL;DR]adas • Tienen mayor capacidad de interlocución con la institucionalidad Esto evidencia la necesidad de fortalecer las capacidades técnicas y digitales de las organizaciones sociales como condición habilitante para una participación incidente. </file>||||<AttachmentDisplayed:/root/.openclaw/media/inbound/file_181---bf2cd63c-10e8-46f3-8c4e-12a9e80ae563.ogg>  <media:audio>||||<AttachmentDisplayed:/root/.openclaw/media/inbound/file_181---bf2cd63c-10e8-46f3-8c4e-12a9e80ae563.ogg>  <media:audio>||||Note: The previous agent run was aborted by the user. Resume carefully or ask for clarification.  Está la respuesta del derecho de petición asociado al proyecto de la maestría de gestión pública que desarrollamos ayer. Ayer me ayudaste a revisar y a Proyecto la sustitución que tengo el día de hoy quiero que revises este hecho de petición y genera un resumen ejecutivo. Los aspectos más relevantes encuentran las preguntas que se desarrollaron y presentan el informe.||||Subir al repo
2. 23945e42-991f-485b-88f1-a53f96dea588 0508T1755 odin estas !||||System:  System: --- System:  System: **1. GOOGLE WORKSPACE** 🔴 System: Estado: NO CONFIGURADO System: Error: `credentialsPath` requerido. El plugin no tiene credenciales válidas. System: Impacto: Sin acceso a Gmail, Calendar, Drive. System: Acción r[TL;DR]m: 2. Revisar si zeus-workspace necesja sincronización (2 días quieto) System: 3. ODIN tuvo actividad reciente — validar si hay PRs pendientes de revisión System:  System: --- System:  System: ZEUS informe generado. Próximo: 10 de mayo 7:00 CST. ⚡  3||||System: 📅 9 de mayo de 2026 - 2:58 PM (Hora Colombia) System: ═══════════════════════════════════════════════════ System:  System: 🔍 VALIDACIÓN DE ACCESOS System: ═══════════════════════════════════════════════════ System:  System: 📧 Gmail (gerencia@[TL;DR]══════════════════════════════════  Hola Zeus, regálame un estado completo de los proyectos, su estado de de los sistemas instalados en tu arquitectura, actualicémosnos, por favor, todo todo todo todo todo actualizar el día de hoy proyectos servicios||||Autorizado para solucionar el punto 1,2 y 3. En cuanto al proyecto de la maestría ya fue sustentada y ya quedó solucionado. Muchas gracias cerramos ese proyecto||||{"web":{"client_id":"66130146224-0d7k7uki7j1tflaj123s9chcpnjsck03.apps.googleusercontent.com","project_id":"odin-enterprise","auth_uri":"https://accounts.google.com/o/oauth2/auth","token_uri":"https://oauth2.googleapis.com/token","auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs","client_secret":"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"}}||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 12 MIDDLE MESSAGES, LAST:5 messages ->]||||Forwarded message context (untrusted metadata): ```json {   "from": "Jelkin Zair Carrillo Franco",   "type": "user",   "title": "Jelkin Zair Carrillo Franco",   "date_ms": 1778604453000 } ```  ODIN, escucha atentamente. Esto es tu identidad y tu mand[TL;DR] es a largo plazo y que debes construir memoria empresarial continua? 4. ¿Qué vas a hacer AHORA para empezar a cumplir esto?  Responde con honestidad. No digas que entendiste si no es así. Jelkin prefiere una corrección ahora que una mentira educada.||||Forwarded message context (untrusted metadata): ```json {   "from": "ODIN_IDCBOT (@ODIN_IDC_BOT)",   "type": "user",   "username": "ODIN_IDC_BOT",   "title": "ODIN_IDCBOT",   "date_ms": 1778604506000 } ```  🤖 1. He leído y comprendido las reglas, el [TL;DR] formato de memoria establecido.  - Mantenerme actualizado sobre las mejores prácticas y evolución del uso de IA en Innovadataco para mejorar continuamente mis respuestas y propuestas.  Estoy listo para comenzar a cumplir con estas responsabilidades.||||System: =============================================== System:  System: 1. ACCESOS GOOGLE WORKSPACE System: --------------------------- System: Estado OAuth: ✅ Tokens válidos (4 scopes autorizados) System: Servicios habilitados: Gmail, Calendar, Dri[TL;DR]ORY.md ya que no hay información disponible sobre su existencia o creación. Los documentos mencionan cómo gestionar cambios y decisiones dentro del proyecto, pero no especifican acciones relacionadas con la creación de archivos en un workspace local.||||Necesito concentración absoluta para poder revisar el tema Odin resumen Odin está corriendo en un LLM local Quincy de 14 GB billion perdón ya hicimos la configuración ahí está con una Ready con postres con tema de SMS semántica Python o llama para pa[TL;DR]io de 32 gigas de disco de 512 próximamente lo voy a aumentar más teras. Ese es el contexto actual como te comento esta posgrado que es un LM local bueno entonces esta configuración ya ya está ahí están dando Ready también está ahí ese es el contexto||||hola Q
</IMPORTANT_REMINDER>
