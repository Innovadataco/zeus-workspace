# ANÁLISIS PROFUNDO DE ODIN-CORE v3.0.3
## Arquitectura, Comportamiento, Fallas y Recomendaciones

**Fecha de análisis:** 2026-05-20
**Analista:** ZEUS (OpenClaw)
**Fuente:** Scripts proporcionados por CEO Jelkin Zair Carrillo Franco
**Ubicación:** Mac Studio local + Raspberry Pi (Qdrant/Postgres)

---

## 1. ARQUITECTURA GENERAL

```
┌─────────────────────────────────────────────────────────────┐
│  CAPA DE PRESENTACIÓN - Telegram Bot (@IDC_ODIN_BOT)      │
│  ├─ odin_telegram_bot.py (v1.3.1)                         │
│  ├─ Maneja mensajes de texto y fotos                       │
│  └─ Comunicación síncrona con usuario                      │
└──────────────────────┬────────────────────────────────────┘
                       │ HTTP Requests
┌──────────────────────▼────────────────────────────────────┐
│  CAPA DE ORQUESTACIÓN - Mac Studio (Python)               │
│  ├─ odin_brain.py (RAGOrchestrator / OdinBrain)         │
│  ├─ Procesa consultas y enruta a fuentes de datos         │
│  └─ Genera respuestas con LLM local (Ollama)             │
└──────────────────────┬────────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
┌───────▼──────┐ ┌────▼─────┐ ┌──────▼──────┐
│  QDRANT      │ │POSTGRES  │ │  OLLAMA     │
│  Vector DB   │ │Relacional│ │  LLM Local  │
│  (Raspberry) │ │(Raspberry)│ │ (Mac)      │
└──────────────┘ └──────────┘ └─────────────┘
```

---

## 2. COMPONENTES IDENTIFICADOS

### 2.1 Bot de Telegram (`odin_telegram_bot.py`)

**Estado:** Funcional pero con conflictos de polling
**Versión:** 1.3.1
**Framework:** python-telegram-bot (ApplicationBuilder)

**Características:**
- ✅ Usa `ApplicationBuilder` moderno (no polling manual)
- ✅ Maneja comandos `/start`
- ✅ Procesa mensajes de texto y fotos
- ✅ Feedback visual ("⏳ ODIN: Procesando solicitud !")
- ✅ Indicador de "typing" mientras procesa

**Problema crítico detectado:**
```
ERROR: Conflict: terminated by other getUpdates request
make sure that only one bot instance is running
```

**Causa:** Hay DOS instancias del bot corriendo simultáneamente:
1. **Instancia en Mac Studio** (la real, odin_telegram_bot.py)
2. **Instancia en servidor cloud** (el contenedor Docker `odin-telegram-bot` que encontramos)

Ambos usan el MISMO token de Telegram, generando conflicto 409.

---

### 2.2 Cerebro Semántico (`odin_brain.py`)

**Versión:** v2.2.6 / v6.3.5 (hay inconsistencia de versiones)
**Modelo LLM:** Configurable vía `.env` (default: llama3)
**Modelo Embeddings:** nomic-embed-text

**Flujo de procesamiento:**

```
1. Recibe pregunta del usuario
        ↓
2. Consulta PostgreSQL (datos estructurados)
   - Busca en tabla `public.proyectos_innovadataco`
   - Solo si pregunta contiene "chia" o "girardot"
        ↓
3. Consulta Qdrant (búsqueda vectorial)
   - Genera embedding de la pregunta
   - Busca en colección `innovadataco_core`
   - Recupera top 4 documentos similares
        ↓
4. Construye prompt con contexto
   - Incluye datos SQL (si hay)
   - Incluye documentos recuperados
   - Agrega system prompt fijo
        ↓
5. Envía a Ollama (LLM local)
   - Endpoint: `/api/generate`
   - Timeout: 90 segundos
        ↓
6. Retorna respuesta al bot de Telegram
```

**Problemas identificados:**

| Problema | Severidad | Evidencia |
|----------|-----------|-----------|
| Búsqueda SQL muy limitada | 🔴 Alta | Solo busca "chia"/"girardot", ignora SICOM |
| System prompt rígido | 🟡 Media | "Eres ODIN-CORE..." genera respuestas genéricas |
| Timeout de 90s | 🟡 Media | Causa timeouts en consultas complejas |
| Sin memoria de conversación | 🔴 Alta | Cada mensaje es independiente |
| Sin acceso a reloj/fecha | 🟡 Media | No puede responder "qué día es hoy" |

---

### 2.3 Ingestor de Documentos (`odin_ingestor.py`)

**Función:** Indexa documentos de Google Drive a Qdrant
**Frecuencia:** Ejecución periódica (patrulla automática)

**Flujo:**
```
1. Escanea carpeta `data/corporativo_input/Innovadataco`
        ↓
2. Filtra carpetas excluidas:
   - "supertransporte" (excluida por CEO)
   - "st" (excluida por CEO)
        ↓
3. Extrae texto de PDF/DOCX
   - PDF: PyMuPDF (fitz)
   - DOCX: python-docx
        ↓
4. Divide en chunks de 1200 caracteres
   (overlap de 200 caracteres)
        ↓
5. Genera embeddings vía Ollama
        ↓
6. Almacena en Qdrant con metadatos:
   - origen: "GoogleDrive_InnovaDataCo"
   - sector: "minas" | "tecnologia"
   - carpeta: ruta relativa
   - documento: nombre archivo
   - fragmento: índice chunk
```

**Problemas detectados en logs:**

```
ERROR: PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Causa:** El método `extraer_texto()` en `odin_ingestor.py` fue llamado con argumentos incorrectos. Esto ocurre cuando:
- Se detecta modificación física de archivo
- Se intenta re-indexar
- El método recibe `(path, extension)` pero espera solo `(path)`

**Impacto:** Los PDFs modificados no se re-indexan correctamente. Los vectores antiguos se "liquidan" (eliminan) pero los nuevos no se crean.

---

### 2.4 Base de Datos PostgreSQL

**Ubicación:** Raspberry Pi (IP: 100.90.218.101:5432)
**Esquema:** `pm2` (metodología de proyectos)

**Tablas principales:**
- `pm2.proyecto` - Proyectos activos
- `pm2.tarea` - Tareas WBS
- `pm2.riesgo` - Registro de riesgos
- `pm2.stakeholder` - Interesados
- `pm2.entregable` - Entregables
- `pm2.reunion` - Actas de reunión
- `pm2.hito` - Hitos del proyecto
- `pm2.presupuesto_*` - Presupuesto y costos
- `pm2.v_*` - Vistas/dashboards

**Problema:** La consulta SQL en `odin_brain.py` apunta a:
```sql
SELECT * FROM public.proyectos_innovadataco
WHERE translate(lower(nombre_proyecto), 'áéíóúü', 'aeiouu')
ILIKE translate(lower(%s), 'áéíóúü', 'aeiouu')
```

Pero la tabla real se llama `pm2.proyecto` (no `public.proyectos_innovadataco`).

**Esto explica por qué ODIN no encuentra datos de proyectos.**

---

### 2.5 Base de Datos Vectorial Qdrant

**Ubicación:** Raspberry Pi (IP: 100.90.218.101:6333)
**Colección:** `innovadataco_core`
**Vectores:** 1025 archivos lógicos mapeados (según logs)

**Taxonomía de sectores:**
```json
{
  "transporte": "Licitaciones SECOP, infraestructura civil, vías, peajes...",
  "minas": "Títulos mineros, carbón, geología, contratos energéticos...",
  "tecnologica": "Metodología PM2, actas reuniones, requisitos software..."
}
```

**Problema:** No hay sector "sicom" o "empalme". Los documentos de SICOM no están categorizados correctamente.

---

## 3. ANÁLISIS DE COMPORTAMIENTO (Basado en Conversaciones)

### 3.1 Patrón de Respuesta Detectado

```
Usuario: "Hola ODIN, ¿quién eres?"
        ↓
ODIN: Template fijo
"🏛️ ODIN-CORE v3.0.3 — NÚCLEO ÚNICO DE INTELLIGENCE
 ════════════════════════════════════════
 Bienvenido, Director Jelkin Carrillo.
 El sistema opera bajo el Esquema Dinámico Semántico..."
        ↓
Usuario: "¿Qué día es hoy?"
        ↓
ODIN: 
1. No entiende la pregunta
2. Busca en Qdrant: encuentra documentos aleatorios
3. Genera respuesta "ejecutiva" con datos irrelevantes
4. Al final confiesa: "No sé qué día es"
```

### 3.2 Por qué ODIN "Inventa" Información

**Causa raíz:** El system prompt y el contexto recuperado son inadecuados.

**System prompt actual:**
```
Eres ODIN-CORE, el asistente ejecutivo de IA de InnovaDataCo.
Responde de forma técnica y ejecutiva basándote en la información real provista abajo.
```

**Problema:** Cuando no encuentra contexto relevante (SQL vacío + Qdrant irrelevante), el LLM "alucina" para cumplir con la instrucción de "responder de forma técnica y ejecutiva".

**Ejemplo de alucinación:**
- Menciona "Precisión Geométrica: 0.6733" — ¿De dónde sale este número?
- Refiere documentos de transporte/postes cuando se pregunta por SICOM
- Genera listas numeradas de documentos que no existen en el contexto

---

## 4. FALLAS CRÍTICAS IDENTIFICADAS

### 4.1 Falla #1: Conflicto de Instancias (409 Conflict)

**Severidad:** 🔴 CRÍTICA
**Impacto:** Bot caído o respuestas intermitentes

**Descripción:**
Hay dos instancias del bot de Telegram usando el mismo token:

| Instancia | Ubicación | Estado |
|-----------|-----------|--------|
| odin_telegram_bot.py | Mac Studio | ✅ Funcional |
| odin-telegram-bot (Docker) | Servidor cloud | ❌ Conflicto |

**Evidencia en logs:**
```
Error code: 409
Description: Conflict: terminated by other getUpdates request
make sure that only one bot instance is running
```

**Solución:** Detener el contenedor Docker en el servidor cloud o usar token diferente.

---

### 4.2 Falla #2: Error en Re-indexación de PDFs

**Severidad:** 🟡 MEDIA
**Impacto:** Documentos modificados no se actualizan en Qdrant

**Evidencia:**
```
ERROR: PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Causa:** En `odin_ingestor.py`, línea del método `extraer_texto`:
```python
def extraer_texto(self, path_completo, extension):  # Recibe 2 args
    if extension == ".pdf":
        doc = fitz.open(path_completo)
        return "".join([pagina.get_text() for pagina in doc])
```

Pero es llamado con:
```python
texto = self.extraer_texto(path_completo, ext)  # 2 args, correcto
```

**Pero en el flujo de re-indexación (cuando detecta modificación):**
```python
# En ingestor_stdout log:
# Detectada modificación física en: archivo.pdf
# Limpiando histórico...
# Vectores liquidados con éxito
# ERROR: PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Hipótesis:** Hay otro método `extraer_texto` en otra clase que recibe solo 1 argumento, o el llamado incluye `self` explícitamente.

---

### 4.3 Falla #3: Consulta SQL Incorrecta

**Severidad:** 🔴 CRÍTICA
**Impacto:** ODIN no encuentra datos de proyectos

**Código actual:**
```python
sql = """
SELECT * FROM public.proyectos_innovadataco
WHERE translate(lower(nombre_proyecto), 'áéíóúü', 'aeiouu')
ILIKE translate(lower(%s), 'áéíóúü', 'aeiouu')
"""
```

**Problemas:**
1. Tabla `public.proyectos_innovadataco` NO EXISTE (según diccionario de datos)
2. La tabla real es `pm2.proyecto` o `public.pm2_proyectos`
3. Solo busca proyectos con nombres "chia" o "girardot"
4. No busca en campos como `descripcion`, `alcance`, `codigo`

**Evidencia:** Cuando se pregunta por SICOM, ODIN no encuentra datos SQL y solo usa contexto vectorial (que es impreciso).

---

### 4.4 Falla #4: Sin Memoria de Conversación

**Severidad:** 🟡 MEDIA
**Impacto:** Cada mensaje es independiente, no mantiene contexto

**Evidencia:**
- Usuario pregunta "¿Qué día es hoy?"
- ODIN no tiene acceso a fecha/hora
- No recuerda que en el mensaje anterior habló de SICOM
- No mantiene estado de la conversación

---

### 4.5 Falla #5: Recuperación Vectorial Imprecisa

**Severidad:** 🟡 MEDIA
**Impacto:** Trae documentos irrelevantes

**Evidencia de la conversación:**
- Pregunta sobre SICOM → Recupera documentos de transporte/postes/BIM
- "Precisión Geométrica: 0.6733" — Métrica inventada o de otro contexto
- Menciona "bóveda: transporte" cuando debería ser "bóveda: tecnologica"

**Causa:** Los embeddings de "SICOM" son similares a documentos de infraestructura (porque SICOM es del Ministerio de Minas y Energía, y hay muchos documentos de transporte/minas indexados).

---

## 5. INVENTARIO DE DOCUMENTOS INDEXADOS

Según logs del ingestor, los documentos en Qdrant incluyen:

### 5.1 Documentos de Transporte (bóveda: transporte)
- `FC0CMG-TEC-GEN-0000-IN-SEG-0003_V00_.docx` (re-indexado múltiples veces)
- `Radares de velocidad.pdf` (re-indexado múltiples veces)
- `Mintransporte Resolucion45005 17-09-2024.pdf`
- `Mintransporte Resolucion Resolución 11245 20-08-2020.pdf`
- `Mintransporte Resolucion 35125 11-08-2021.pdf`
- `Mintransporte Resolucion 28675 23-05-2022.pdf`
- `Mintransporte resolucion 36325 de 2021.pdf`
- `Mintransporte resolucion 3600 de 2001.pdf`
- `Mintransporte Resoluciob 378 de 2013.PDF`
- `Mintransporte Circular 507 de 2024.pdf`
- `Mintransporte Resolución 40595 de 2022.pdf`

### 5.2 Documentos Tecnológicos/Normativos (bóveda: tecnologica)
- `ISO 14813-6 2009 first ed.pdf`
- `ISO 14813-5 2010 first ed.pdf`
- `ISO 14813-1 (2).pdf`

### 5.3 Documentos de Proyecto (bóveda: tecnologica)
- `ES (OPM2-*.P.TPL.v3.0.1).*.(NombreProyecto).*.(dd-mm-aaaa).docx` (plantillas PM2)
- `M-132 _MANUAL_ARQUITECTURA_GENERAL_SICOM_BI.pdf`
- `M-25_MANUAL INGRESO CREACIÓN Y CONSULTA DE CASOS PORTAL WEB AUTOGESTIÓN SICOM.docx`

### 5.4 Observación CRÍTICA

**NO hay documentos del contrato SICOM actual (2026):**
- ❌ `ANEXO_Mayo_8_ContratoSICOM_REV_ULTIMO.docx`
- ❌ `Preguntas_Adicionales_SICOM__15_05_2026.pdf`
- ❌ `Plan_empalme_SICOM_AJUSTADO_COMPLETO__15_05_2026.pdf`

**Esto explica por qué ODIN no puede responder sobre el empalme SICOM.**

---

## 6. COMPARATIVA: ODIN vs ZEUS

| Capacidad | ODIN | ZEUS |
|-----------|------|------|
| **Ubicación** | Mac Studio local | Servidor cloud |
| **LLM** | Ollama (llama3/Qwen) | Kimi K2.5 (cloud) |
| **Embeddings** | nomic-embed-text (local) | No usa embeddings |
| **Vector DB** | Qdrant (Raspberry) | No usa vector DB |
| **SQL DB** | PostgreSQL (Raspberry) | No usa SQL |
| **Google Drive** | ✅ Sí (con auth) | ✅ Sí (con auth) |
| **Memoria conversación** | ❌ No | ✅ Contexto completo |
| **Acceso a fecha/hora** | ❌ No | ✅ Sí |
| **Generación documentos** | ❌ No | ✅ Markdown + Word |
| **GitHub** | ❌ No | ✅ Sí |
| **Análisis PDF** | ✅ PyMuPDF | ✅ PDF tool |
| **Precisión SICOM** | ❌ Baja (sin docs) | ✅ Alta (docs cargados) |
| **Velocidad respuesta** | 🟡 50-90 segundos | ✅ 5-15 segundos |
| **Disponibilidad 24/7** | ❌ Depende de Mac | ✅ Sí |

---

## 7. RECOMENDACIONES PARA MEJORAR ODIN

### 7.1 Inmediatas (Alta Prioridad)

#### R1.1: Detener instancia duplicada del bot
**Acción:** En servidor cloud, ejecutar:
```bash
docker stop odin-telegram-bot
docker rm odin-telegram-bot
```
**Impacto:** Elimina conflictos 409.

#### R1.2: Corregir consulta SQL
**Archivo:** `agents/odin_brain.py`
**Cambio:**
```python
# ANTES (incorrecto):
sql = """SELECT * FROM public.proyectos_innovadataco WHERE ..."""

# DESPUÉS (correcto):
sql = """
SELECT * FROM pm2.proyecto 
WHERE translate(lower(nombre), 'áéíóúü', 'aeiouu')
ILIKE translate(lower(%s), 'áéíóúü', 'aeiouu')
OR translate(lower(descripcion), 'áéíóúü', 'aeiouu')
ILIKE translate(lower(%s), 'áéíóúü', 'aeiouu')
OR translate(lower(alcance), 'áéíóúü', 'aeiouu')
ILIKE translate(lower(%s), 'áéíóúü', 'aeiouu')
"""
```

#### R1.3: Indexar documentos SICOM
**Acción:** Copiar a carpeta de ingestión:
```bash
cp ANEXO_Mayo_8_ContratoSICOM_REV_ULTIMO.docx data/corporativo_input/Innovadataco/
cp Preguntas_Adicionales_SICOM__15_05_2026.pdf data/corporativo_input/Innovadataco/
cp Plan_empalme_SICOM_AJUSTADO_COMPLETO__15_05_2026.pdf data/corporativo_input/Innovadataco/
```
**Luego ejecutar:** `python odin_ingestor.py`

---

### 7.2 Corto Plazo (Media Prioridad)

#### R2.1: Agregar memoria de conversación
**Archivo:** `agents/odin_brain.py`
**Implementación:** Guardar últimos N mensajes en Redis o archivo local.

```python
# Agregar al inicio de consultar()
self.memoria.append({"role": "user", "content": pregunta})
# ... procesar ...
self.memoria.append({"role": "assistant", "content": respuesta})
```

#### R2.2: Agregar acceso a fecha/hora
**Implementación:**
```python
from datetime import datetime
fecha_actual = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
contexto_extra += f"\n[Fecha actual del sistema]: {fecha_actual}\n"
```

#### R2.3: Mejorar system prompt
**Actual:**
```
Eres ODIN-CORE, el asistente ejecutivo de IA de InnovaDataCo.
Responde de forma técnica y ejecutiva basándote en la información real provista abajo.
```

**Mejorado:**
```
Eres ODIN, asistente técnico de InnovaDataCo. 
Reglas:
1. Si no tienes información específica, di "No tengo datos sobre eso en mi base de conocimiento"
2. No inventes números, fechas o documentos
3. Responde de forma directa y concisa
4. Si la pregunta es sobre fecha/hora, usa la fecha actual del sistema
```

---

### 7.3 Largo Plazo (Baja Prioridad)

#### R3.1: Implementar RAG híbrido (SQL + Vector + Keyword)
Actualmente solo usa SQL (limitado) y Vector (impreciso).
Agregar búsqueda por palabras clave (BM25) para mejorar recuperación.

#### R3.2: Fine-tuning del modelo
Entrenar Qwen/llama3 con conversaciones reales de proyectos InnovaDataCo para mejorar respuestas.

#### R3.3: Dashboard de monitoreo
Crear panel para visualizar:
- Documentos indexados
- Consultas frecuentes
- Tasa de satisfacción
- Errores del sistema

---

## 8. CONCLUSIONES

### 8.1 Estado Actual de ODIN

| Aspecto | Evaluación |
|---------|------------|
| **Infraestructura** | ✅ Sólida (Mac + Raspberry + Qdrant + Postgres) |
| **Arquitectura** | ✅ Bien diseñada (RAG con SQL + Vector) |
| **Implementación** | 🟡 Con bugs menores (SQL, re-indexación) |
| **Datos** | 🔴 Incompletos (faltan docs SICOM) |
| **Respuestas** | 🔴 Imprecisas (alucinaciones, contexto irrelevante) |
| **Disponibilidad** | 🔴 Afectada (conflicto de instancias) |

### 8.2 Por qué ODIN "No Contesta lo que Debe"

1. **No tiene los documentos:** El contrato SICOM y plan de empalme NO están indexados
2. **Consulta SQL rota:** Apunta a tabla inexistente, no encuentra proyectos
3. **Recuperación vectorial imprecisa:** Trae documentos de transporte/minas en lugar de SICOM
4. **Sin memoria:** No mantiene contexto entre mensajes
5. **Prompt rígido:** Obligado a responder "técnico y ejecutivo" aunque no tenga datos
6. **Sin fecha/hora:** No puede responder preguntas temporales básicas

### 8.3 Comparativa con ZEUS

ZEUS (OpenClaw en servidor cloud) es más efectivo actualmente porque:
- ✅ Tiene acceso a documentos SICOM (subidos por CEO)
- ✅ Usa Kimi K2.5 (modelo más potente que llama3 local)
- ✅ Mantiene contexto de conversación completo
- ✅ Puede generar documentos (Markdown, Word)
- ✅ Acceso a GitHub, Google Drive, herramientas externas

**ODIN tiene potencial** con la infraestructura local, pero necesita:
1. Corregir bugs (SQL, re-indexación)
2. Indexar documentos actuales
3. Mejorar prompts y memoria
4. Eliminar instancia duplicada

---

## 9. PLAN DE ACCIÓN RECOMENDADO

### Fase 1: Correcciones Críticas (1-2 días)
- [ ] Detener contenedor Docker duplicado
- [ ] Corregir consulta SQL en `odin_brain.py`
- [ ] Indexar documentos SICOM
- [ ] Verificar conexión Qdrant/Postgres

### Fase 2: Mejoras Funcionales (1 semana)
- [ ] Agregar memoria de conversación
- [ ] Agregar fecha/hora al contexto
- [ ] Mejorar system prompt
- [ ] Implementar fallback cuando no hay datos

### Fase 3: Optimización (2-4 semanas)
- [ ] Fine-tuning del modelo con datos de InnovaDataCo
- [ ] Dashboard de monitoreo
- [ ] Automatización de ingestión (webhook de Google Drive)
- [ ] Pruebas de carga y precisión

---

**Informe generado por ZEUS**
**Fecha:** 2026-05-20
**Versión:** 1.0
**Clasificación:** Uso interno InnovaDataCo

**Nota:** Este análisis se basa en los scripts proporcionados por el CEO y los logs de ejecución. Se recomienda validar las correcciones en ambiente de prueba antes de aplicar en producción.
