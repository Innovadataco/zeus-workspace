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

> **Stats**: 2 sessions, 10 messages | 2026-05-07 02:25 ~ 2026-05-09 05:55 UTC
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

> last_update: 2026-05-11 03:41

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": null, "work_method": "Opera un sistema \"openclaw\" configurando proveedores e infraestructura. Exige continuidad de sesión y se frustra cuando se pierde contexto extenso, especialmente mensajes intermedios en sesiones abortadas. Prefiere reanudar sin repetir configuración. Solicita correcciones \"una por una\", rechazando modificaciones innecesarias con \"No hagas cambio\". Necesita que el sistema identifique qué corregir en documentos adjuntos sin que se le indique qué buscar. Pide análisis de documentos seguido de propuestas estructuradas (formato a,b,c,d) e integración directa con GitHub — emite comandos explícitos de subida (\"sube al gitbu !\", \"Subir al repo\"). Quiere análisis comparativo entre documentos actuales y materiales de referencia previos, consolidados en salidas unificadas. Solicita resúmenes ejecutivos concisos extrayendo lo más relevante de documentos oficiales extensos.", "communication": "Hispanohablante predominante con estilo directo e imperativo — mensajes cortos, exclamaciones (\"espalo !\", \"Ok, !\", \"odin estas !\") y saludos repetidos al reconectar tras fallos. Expresa frustración mediante meta-comentarios sobre fallos del sistema más que quejas explícitas. Reenganche persistente pese a sesiones abortadas indica paciencia pero baja tolerancia a trabajo redundante. Usa fraseo informal, algo distorsionado bajo presión pero descifrable. Emite órdenes directas (\"dime que debo corregir\", \"presenta aca todas las intrucicones\", \"sube al gitbu !\"). Al solicitar propuestas, bloquea comparaciones no deseadas (\"no la compares, son las mismas\"). Propenso a errores tipográficos cuando apurado. Envía adjuntos de audio, indicando comunicación multimodal cuando le resulta conveniente. Exige síntesis ejecutiva de documentos oficiales extensos.", "temporal": "Revisando respuesta a derecho de petición vinculado a proyecto de maestría en gestión pública, solicitando resumen ejecutivo enfocado en aspectos más relevantes y preguntas desarrolladas en el informe. Integración directa con GitHub activa mediante comandos explícitos de subida al repositorio. El análisis comparativo de la Resolución No. 15956 del 16 de octubre de 2025 con manual de cartera anterior no aparece en mensajes recientes — posiblemente completado o abandonado tras múltiples sesiones abortadas.", "taste": "Valora claridad visual y presentación profesional en documentos — insiste en diseño limpio, diagramas gráficos para ideas complejas y contención textual (máximo 6 líneas por diapositiva). Aprecia marcos analíticos estructurados: diagnóstico multidimensional de factores, identificación de patrones, articulación teoría-práctica. Prefiere operaciones recuperables sobre destructivas. Enfoque metódico orientado a verificación. Favorece estructuras enumeradas explícitas (a,b,c,d) para propuestas e integración directa con sistemas de control de versiones. Quiere análisis que trate documentos como material unificado antes que objetos comparativos. Interés en consolidar información fragmentada en documentos coherentes individuales. Trabaja con documentos regulatorios oficiales colombianos (resoluciones Supertransporte), sugiriendo enfoque en política pública o derecho administrativo."}

## Short-Term Memory (STM)

> last_update: 2026-05-11 03:42

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
2. 23945e42-991f-485b-88f1-a53f96dea588 0508T1755 odin estas !||||System:  System: --- System:  System: **1. GOOGLE WORKSPACE** 🔴 System: Estado: NO CONFIGURADO System: Error: `credentialsPath` requerido. El plugin no tiene credenciales válidas. System: Impacto: Sin acceso a Gmail, Calendar, Drive. System: Acción r[TL;DR]m: 2. Revisar si zeus-workspace necesja sincronización (2 días quieto) System: 3. ODIN tuvo actividad reciente — validar si hay PRs pendientes de revisión System:  System: --- System:  System: ZEUS informe generado. Próximo: 10 de mayo 7:00 CST. ⚡  3
</IMPORTANT_REMINDER>
