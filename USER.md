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

> **Stats**: 1 sessions, 815 messages | 2026-04-25 16:56 ~ 2026-04-25 16:56 UTC
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

> diary: 0 entries


# Long-Term Memory (LTM)

> last_update: 2026-04-30 03:41

Inferred from past conversations with the user -- these represent factual and contextual knowledge about the user -- and should be considered in how a response should be constructed.

{"identity": null, "work_method": "The user appears to work with an \"openclaw\" system or tool, using commands like \"providers add\" — suggesting technical infrastructure or DevOps-style workflows. They expect continuity across sessions and become frustrated when context is lost (noting \"760 middle messages\" forgotten, aborted agent runs). They prefer resuming work without repeating setup, and explicitly reject unnecessary changes with \"No hagas cambio.\"", "communication": "Primarily Spanish-speaking with direct, imperative style — short messages, exclamations (\"espalo !\", \"Estado de proyectos !\"), and repeated greetings when reconnecting after failures. They express frustration through meta-commentary about system failures rather than explicit complaints. Pattern of persistent re-engagement despite aborted sessions suggests patience but low tolerance for redundant work.", "temporal": "Monitoring or managing \"proyectos\" (projects) — requested \"Estado de proyectos\" as a status check. Working with \"openclaw providers\" configuration. Session on 0425 was extremely long and productive before interruption, suggesting deep ongoing work that was lost.", "taste": null}
## Short-Term Memory (STM)

> last_update: 2026-04-30 16:24

Recent conversation content from the user's chat history. This represents what the USER said. Use it to maintain continuity when relevant.
Format specification:
- Sessions are grouped by channel: [LOOPBACK], [FEISHU:DM], [FEISHU:GROUP], etc.
- Each line: `index. session_uuid MMDDTHHmm message||||message||||...` (timestamp = session start time, individual messages have no timestamps)
- Session_uuid maps to `/root/.openclaw/agents/main/sessions/{session_uuid}.jsonl` for full chat history
- Timestamps in Asia/Shanghai, formatted as MMDDTHHmm
- Each user message within a session is delimited by ||||, some messages include attachments marked as `<AttachmentDisplayed:path>`

[LOOPBACK] 1-1
1. 0f385783-a51a-453f-8973-c7e30fd40682 0425T1656 hola||||hola||||openclaw providers add||||hola||||espalo !||||[<- FIRST:5 messages, EXTREMELY LONG SESSION, YOU KINDA FORGOT 805 MIDDLE MESSAGES, LAST:5 messages ->]||||patios, ambi¿ualncias ?||||?||||no eran 4 peajes ? en el docuemntos debes definir o gargefar las deficiicones: por ejemplo que son campamente ? Intersecciones / Glorietas  Variantes  Cuartos/Tercer Carril  Tramos O&M  Campamentos  Túneles  Peajes  Puentes / Obras  Paso Urbano. ? donde eta uncado el CCO y centor de mantenimiento o areas de sevicios ? aread admisntiratuvias ?||||gruas aptiso ambeilaicanis||||?
</IMPORTANT_REMINDER>
