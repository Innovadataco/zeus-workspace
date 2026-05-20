# ANÁLISIS PROFUNDO DE ODIN-CORE v6.3.5 (ACTUALIZADO)
## Código Fuente Real - Arquitectura Completa

**Fecha de análisis:** 2026-05-20
**Analista:** ZEUS (OpenClaw)
**Fuente:** Scripts reales proporcionados por CEO Jelkin Zair Carrillo Franco
**Ubicación:** Mac Studio local + Raspberry Pi (Qdrant/Postgres)

---

## 1. ARQUITECTURA REAL DE ODIN-CORE

```
┌─────────────────────────────────────────────────────────────────────┐
│  CAPA DE PRESENTACIÓN                                               │
│  ├─ odin_telegram_bot.py (v3.0.3) - Bot de Telegram                │
│  ├─ Maneja mensajes de texto                                       │
│  ├─ Comandos: /start, /help                                        │
│  └─ Template de bienvenida fijo                                    │
└──────────────────────┬──────────────────────────────────────────────┘
                       │ HTTP Requests (localhost)
┌──────────────────────▼──────────────────────────────────────────────┐
│  CAPA DE ORQUESTACIÓN - Mac Studio                                  │
│  ├─ odin_brain.py (v6.3.5) - Núcleo analítico                     │
│  ├─ odin_ingestor.py (v3.0.1) - Orquestador de ingesta            │
│  ├─ suite_auditoria_god.py - Diagnóstico completo                   │
│  └─ test_operativo_real.py - Validación en caliente               │
└──────────────────────┬──────────────────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
┌───────▼──────┐ ┌────▼─────┐ ┌──────▼──────┐
│  QDRANT      │ │POSTGRES  │ │  OLLAMA     │
│  Vector DB   │ │Relacional│ │  LLM Local  │
│  (Raspberry) │ │(Raspberry)│ │ (Mac)      │
│  Puerto 6333 │ │Puerto 5432│ │ Puerto 11434│
└──────────────┘ └──────────┘ └─────────────┘
```

**Infraestructura física:**
- **Mac Studio:** Ollama (LLM) + Python Backend
- **Raspberry Pi:** Qdrant (puerto 6333) + PostgreSQL (puerto 5432)
- **Conexión:** Tailscale/VPN (IP: 100.90.218.101)

---

## 2. COMPONENTES IDENTIFICADOS (CÓDIGO REAL)

### 2.1 Bot de Telegram (`odin_telegram_bot.py` v3.0.3)

**Framework:** `telebot` (pyTelegramBotAPI), NO python-telegram-bot
**Versión:** 3.0.3 (ENTERPRISE - STRICTION ANTI-409 ENGINE)

**Características:**
- ✅ Usa `TeleBot` (clase legacy de telebot)
- ✅ Polling con `infinity_polling(none_stop=True)`
- ✅ Limpieza de webhooks al inicio
- ✅ Template de bienvenida FIJO con información precargada

**Template de bienvenida:**
```python
saludo = (
    "🏛️ ODIN-CORE v3.0.3 — NÚCLEO ÚNICO DE INTELLIGENCE\n"
    "=========================================\n"
    "Bienvenido, Director Jelkin Carrillo.\n\n"
    "El sistema opera bajo el Esquema Dinámico Semántico sin filtros rígidos.\n\n"
    "🚀 Sistemas Activos:\n"
    "• Infraestructura & APP Chía-Girardot\n"
    "• Software SICOM & Planes de Empalme\n"
    "• Geotecnia & Marcos Contractuales de Minas\n"
    "=========================================\n"
    "💡 Formule su consulta técnica directamente..."
)
```

**Problema:** El template menciona "Software SICOM & Planes de Empalme" pero esto es **HARDCODEADO**, no viene de la base de datos.

---

### 2.2 Cerebro Semántico (`odin_brain.py` v6.3.5)

**Versión:** 6.3.5 (PRODUCTION ENTERPRISE - PURE DYNAMIC SEMANTIC RAG v2)
**Modelo LLM:** `qwen2.5:32b` (default, configurable vía .env)
**Modelo Embeddings:** `nomic-embed-text`

**Flujo de procesamiento REAL:**

```
1. Recibe pregunta del usuario
        ↓
2. EXTRAER CONTEXTO RELACIONAL (PostgreSQL)
   - Busca en `public.proyectos_innovadataco`
   - Mapea tokens de proyectos dinámicamente
   - Solo busca si encuentra token en la pregunta
        ↓
3. BÚSQUEDA VECTORIAL (Qdrant)
   - Genera embedding de la pregunta
   - Busca en colección `innovadataco_core`
   - Recupera TOP 10 documentos (antes era 4)
   - Incluye "Precisión Geométrica" (score de similitud)
        ↓
4. Construye prompt con contexto
   - Datos SQL (si hay)
   - Documentos recuperados con metadatos
   - System prompt corporativo
        ↓
5. Envía a Ollama (LLM local)
   - Endpoint: `/api/generate`
   - Timeout: 120 segundos
   - Modelo: qwen2.5:32b
        ↓
6. Retorna respuesta al bot
```

**System prompt actual:**
```python
prompt = f"""Eres ODIN-CORE, el asistente ejecutivo supremo y núcleo único de intelligence de InnovaDataCo.
Responde con un tono corporativo, autoritario, sumamente técnico y preciso. Utiliza los datos exactos adjuntos.

{contexto_sql}

INFORMACIÓN DOCUMENTAL RECUPERADA (VECTORES QDRANT - EXCEL, DWG, KMZ, PDF):
{contexto_docs}

PREGUNTA PLANTEADA POR LA DIRECCIÓN:
{pregunta}

RESPUESTA EJECUTIVA INTEGRADA (DATOS + DOCUMENTOS):"""
```

**Problema:** El prompt obliga a responder "corporativo, autoritario, sumamente técnico" aunque no haya datos.

---

### 2.3 Ingestor de Documentos (`odin_ingestor.py` v3.0.1)

**Función:** Sincroniza Google Drive → Qdrant/PostgreSQL
**Frecuencia:** Ejecución periódica (patrulla automática)

**Flujo REAL:**
```
1. Autentica con Google Drive API (OAuth2)
        ↓
2. Escanea carpeta "Innovadataco" en Drive
   - Excluye: "supertransporte", "st"
        ↓
3. Descarga archivos soportados:
   - .pdf, .docx, .xlsx, .kmz, .kml, .dwg, .dxf
        ↓
4. Extrae texto usando ExtractorFactory
   - PDF: pypdf + OCR fallback (tesseract)
   - DOCX: python-docx
   - Excel: openpyxl/pandas
   - CAD: ezdxf
        ↓
5. Clasifica por similitud vectorial
   - Compara embedding del documento vs taxonomía
   - Asigna a bóveda: transporte | minas | tecnologica
        ↓
6. Segmenta en chunks semánticos (1200 chars)
        ↓
7. Indexa en Qdrant con metadatos:
   - origen: "GoogleDrive_API_Cloud"
   - sector: <bóveda>
   - carpeta: ruta virtual
   - documento: nombre archivo
   - fragmento: índice chunk
        ↓
8. Registra estado en PostgreSQL
   - Tabla: public.odin_ingest_state
   - Campos: ruta_archivo, hash_md5, boveda, fecha_ingesta
```

**Tablas de control en PostgreSQL:**
- `public.odin_ingest_state` - Estado de indexación
- `public.odin_purge_history` - Historial de purgas

---

### 2.4 Extractor de PDFs (`pdf_extractor.py` v2.1.0)

**Características:**
- ✅ Extracción nativa con `pypdf`
- ✅ Fallback OCR con `pytesseract` + `pdf2image`
- ✅ Tolerancia a firmas dinámicas (`*args, **kwargs`)
- ✅ Umbral mínimo: 50 caracteres

**Método:**
```python
def extraer_texto(self, ruta_archivo: str, *args, **kwargs) -> str:
    """Soporta parámetros adicionales (*args) inyectados por la factoría"""
```

**Problema detectado en logs:**
```
ERROR: PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Causa:** El orquestador llama:
```python
texto = extractor.extraer_texto(stream_bytes, nombre_archivo)
```

Pero el método espera:
```python
def extraer_texto(self, ruta_archivo: str, *args, **kwargs)
```

El `stream_bytes` es un objeto `bytes`, no una ruta de archivo. El extractor intenta hacer `os.path.exists(ruta_archivo)` con bytes y falla.

**Solución:** El extractor necesita manejar tanto rutas de archivo como streams de bytes.

---

### 2.5 Suite de Auditoría (`suite_auditoria_god.py`)

**Propósito:** Diagnóstico completo de 5 capas

**Capas auditadas:**
1. **Red y Túnel (Tailscale)** - Conectividad a Qdrant
2. **PostgreSQL** - Esquemas PUBLIC y PM2
3. **Qdrant** - Estado de colección
4. **Ollama** - Embeddings e inferencia
5. **Tokens y Credenciales** - Google Drive, Telegram

**Ejemplo de ejecución:**
```bash
python suite_auditoria_god.py
```

**Salida esperada:**
```
🟢 [RED] Variables del .env -> EXITOSO
🟢 [RED] Túnel hacia Qdrant -> EXITOSO
🟢 [DB] Conexión PostgreSQL -> EXITOSO (45.23 ms)
🟢 [DB] Esquema PUBLIC (Proyectos) -> EXITOSO (3 registros vivos)
🟢 [DB] Esquema Estructural PM² -> EXITOSO
🟢 [VECTOR] Colección Core -> EXITOSO (Estado: green)
🟢 [IA] Embeddings (nomic-embed-text) -> EXITOSO (Dimensión: 768)
🟢 [IA] Inferencia LLM (qwen2.5:32b) -> EXITOSO
🟢 [AUTH] Google API Token -> EXITOSO
🟢 [AUTH] Telegram Bot Secret -> EXITOSO
🏆 RESULTADO GLOBAL: SISTEMA TOTALMENTE OPERATIVO
```

---

## 3. BASES DE DATOS REALES

### 3.1 PostgreSQL (Raspberry Pi)

**Tablas de control de ODIN:**
```sql
-- Estado de ingestión
CREATE TABLE public.odin_ingest_state (
    ruta_archivo TEXT PRIMARY KEY,
    hash_md5 TEXT,
    boveda TEXT,
    fecha_creacion TIMESTAMP,
    fecha_ingesta TIMESTAMP
);

-- Historial de purgas
CREATE TABLE public.odin_purge_history (
    id SERIAL PRIMARY KEY,
    ruta_archivo TEXT,
    nombre_archivo TEXT,
    fecha_purga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Proyectos (datos reales)
CREATE TABLE public.proyectos_innovadataco (
    id INTEGER PRIMARY KEY,
    nombre_proyecto VARCHAR,
    estado_ejecucion INTEGER,
    costo_total NUMERIC,
    costo_ejecutado NUMERIC,
    fecha_proximo_hito DATE,
    descripcion_hito TEXT,
    responsable VARCHAR,
    ultima_actualizacion TIMESTAMP
);
```

**Esquema PM2 (metodología de proyectos):**
- `pm2.proyecto` - Proyectos
- `pm2.tarea` - Tareas WBS
- `pm2.riesgo` - Registro de riesgos
- `pm2.stakeholder` - Interesados
- `pm2.entregable` - Entregables
- `pm2.reunion` - Actas de reunión
- `pm2.hito` - Hitos
- `pm2.presupuesto_*` - Presupuesto
- `pm2.v_*` - Vistas/dashboards

### 3.2 Qdrant (Raspberry Pi)

**Colección:** `innovadataco_core`
**Vectores:** 78,197 chunks (según código)
**Dimensión:** 768 (nomic-embed-text)

**Payload de cada punto:**
```json
{
  "origen": "GoogleDrive_API_Cloud",
  "sector": "transporte|minas|tecnologica",
  "carpeta": "Innovadataco/...",
  "documento": "nombre_archivo.pdf",
  "fragmento": 0,
  "contenido": "texto del chunk..."
}
```

---

## 4. ANÁLISIS DE COMPORTAMIENTO (Basado en Código Real)

### 4.1 Por qué ODIN "Inventa" Información

**Causa raíz #1: Prompt obliga a responder**
```python
"Responde con un tono corporativo, autoritario, sumamente técnico y preciso. 
Utiliza los datos exactos adjuntos."
```

Cuando no hay datos SQL ni documentos relevantes, el LLM (qwen2.5:32b) **debe** generar algo "técnico y preciso". Resultado: alucinación.

**Causa raíz #2: Sin fallback explícito**
No hay instrucción del tipo:
```python
"Si no tienes información específica, di 'No tengo datos sobre eso'"
```

**Causa raíz #3: Contexto vectorial irrelevante**
Cuando se pregunta por SICOM:
1. Embedding de "SICOM" es similar a documentos de infraestructura
2. Recupera documentos de transporte/postes/BIM
3. El LLM intenta "integrar" estos documentos con la pregunta
4. Resultado: respuesta mezclada e incoherente

### 4.2 Por qué ODIN no Responde a ZEUS (API)

**Causa:** ODIN usa `telebot` con `infinity_polling()` en la Mac Studio. Solo hay UNA instancia real del bot.

Cuando ZEUS envía mensajes por API de Telegram:
- El mensaje llega a la API de Telegram
- Telegram intenta entregarlo al bot que está haciendo polling
- Pero hay un contenedor Docker en el servidor cloud que también usa el mismo token
- Resultado: Conflicto 409 (dos instancias compitiendo por updates)

**Solución:** El bot de la Mac Studio usa `none_stop=True`, lo que ignora errores y sigue intentando. Pero el contenedor en cloud interfiere.

---

## 5. FALLAS CRÍTICAS IDENTIFICADAS (CÓDIGO REAL)

### 5.1 Falla #1: Conflicto de Instancias (409 Conflict)

**Severidad:** 🔴 CRÍTICA
**Impacto:** Bot caído o respuestas intermitentes

**Evidencia en logs:**
```
Error code: 409
Description: Conflict: terminated by other getUpdates request
make sure that only one bot instance is running
```

**Causa:** Hay DOS instancias:
1. **Mac Studio** (odin_telegram_bot.py) - La real
2. **Servidor cloud** (contenedor Docker) - La duplicada

**Solución:** Detener contenedor Docker en servidor cloud.

---

### 5.2 Falla #2: Error en Re-indexación de PDFs

**Severidad:** 🟡 MEDIA
**Impacto:** Documentos modificados no se actualizan

**Evidencia:**
```
ERROR: PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Causa en código:**
```python
# En odin_ingestor.py (línea ~320):
extractor = ExtractorFactory.obtener_extractor(ext)
texto = extractor.extraer_texto(stream_bytes, nombre_archivo)  # 2 args

# En pdf_extractor.py (línea ~35):
def extraer_texto(self, ruta_archivo: str, *args, **kwargs)  # 1 arg + args
```

El problema: `stream_bytes` es `bytes`, no `str`. El método hace:
```python
if not os.path.exists(ruta_archivo):  # ruta_archivo es bytes!
    return "CRITICAL_ERROR_FILE_NOT_FOUND"
```

`os.path.exists()` con `bytes` funciona en Python 3, pero luego:
```python
with open(ruta_archivo, "rb") as f:  # Abre bytes como archivo?
```

Esto puede fallar silenciosamente.

**Solución:** El extractor debe detectar si recibe bytes o ruta:
```python
def extraer_texto(self, data, nombre_archivo="", *args, **kwargs):
    if isinstance(data, bytes):
        # Procesar desde bytes
        from io import BytesIO
        lector = pypdf.PdfReader(BytesIO(data))
    else:
        # Procesar desde archivo
        with open(data, "rb") as f:
            lector = pypdf.PdfReader(f)
```

---

### 5.3 Falla #3: Tabla SQL Incorrecta pero EXISTE

**Severidad:** 🟡 MEDIA (corregido parcialmente)
**Impacto:** Datos de proyectos limitados

**Código actual:**
```python
sql_proyectos = "SELECT id, nombre_proyecto FROM public.proyectos_innovadataco;"
```

**La tabla EXISTE** (según suite_auditoria_god.py):
```python
cur.execute("SELECT COUNT(*) FROM public.proyectos_innovadataco;")
cnt_public = cur.fetchone()[0]
```

**Pero:** Según el diccionario de datos anterior, la tabla debería llamarse `pm2.proyecto` o `public.pm2_proyectos`. Hay INCONSISTENCIA de esquemas.

**Posible explicación:**
- `public.proyectos_innovadataco` - Tabla manual para proyectos específicos
- `pm2.proyecto` - Tabla estructural de la metodología PM2
- `public.pm2_proyectos` - Vista o tabla alternativa

**Problema:** ODIN solo consulta `public.proyectos_innovadataco`, que puede tener pocos registros.

---

### 5.4 Falla #4: Sin Memoria de Conversación

**Severidad:** 🟡 MEDIA
**Impacto:** Cada mensaje independiente

**Evidencia en código:**
```python
def consultar(self, pregunta: str) -> str:
    contexto_sql = self.extraer_contexto_relacional(pregunta)
    # ... búsqueda vectorial ...
    # ... genera respuesta ...
    return response.json()['response']
```

No hay persistencia de conversación. Cada llamada a `consultar()` es STATELESS.

---

### 5.5 Falla #5: Recuperación Vectorial Imprecisa

**Severidad:** 🟡 MEDIA
**Impacto:** Trae documentos irrelevantes

**Configuración actual:**
```python
res_qdrant = self.client_vector.query_points(
    collection_name=self.collection,
    query=vector,
    limit=10  # Top 10 documentos
)
```

**Problema:** Recupera 10 documentos sin filtrar por sector. Si se pregunta por SICOM (tecnología), puede traer documentos de transporte o minas si sus embeddings son similares.

**Taxonomía actual:**
```json
{
  "transporte": "Licitaciones públicas de SECOP...",
  "minas": "Títulos mineros, extracción de carbón...",
  "tecnologica": "Metodología de proyectos PM2 pura..."
}
```

**NO hay categoría "sicom" o "empalme".**

---

### 5.6 Falla #6: Template de Bienvenida con Info Falsa

**Severidad:** 🟡 MEDIA
**Impacto:** Genera expectativas incorrectas

**Template:**
```python
"🚀 Sistemas Activos:\n"
"• Infraestructura & APP Chía-Girardot\n"
"• Software SICOM & Planes de Empalme\n"
"• Geotecnia & Marcos Contractuales de Minas\n"
```

**Problema:** Esto es HARDCODEADO. No verifica si realmente hay datos de SICOM en Qdrant. El usuario cree que ODIN sabe de SICOM, pero en realidad:
- No hay documentos SICOM indexados (según logs)
- La tabla `public.proyectos_innovadataco` no tiene proyecto SICOM
- La búsqueda vectorial no tiene categoría "sicom"

---

## 6. INVENTARIO DE DOCUMENTOS INDEXADOS (Según Logs)

### 6.1 Documentos de Transporte
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

### 6.2 Documentos Normativos/ISO
- `ISO 14813-6 2009 first ed.pdf`
- `ISO 14813-5 2010 first ed.pdf`
- `ISO 14813-1 (2).pdf`

### 6.3 Documentos de Proyecto (Plantillas PM2)
- `ES (OPM2-*.P.TPL.v3.0.1).*.(NombreProyecto).*.(dd-mm-aaaa).docx`
- `M-132 _MANUAL_ARQUITECTURA_GENERAL_SICOM_BI.pdf`
- `M-25_MANUAL INGRESO CREACIÓN Y CONSULTA DE CASOS PORTAL WEB AUTOGESTIÓN SICOM.docx`

### 6.4 Observación CRÍTICA

**NO hay documentos del contrato SICOM actual (2026):**
- ❌ `ANEXO_Mayo_8_ContratoSICOM_REV_ULTIMO.docx`
- ❌ `Preguntas_Adicionales_SICOM__15_05_2026.pdf`
- ❌ `Plan_empalme_SICOM_AJUSTADO_COMPLETO__15_05_2026.pdf`

**Esto explica por qué ODIN no puede responder sobre el empalme SICOM actual.**

---

## 7. COMPARATIVA: ODIN vs ZEUS

| Capacidad | ODIN | ZEUS |
|-----------|------|------|
| **Ubicación** | Mac Studio local | Servidor cloud |
| **LLM** | Ollama (qwen2.5:32b) | Kimi K2.5 (cloud) |
| **Embeddings** | nomic-embed-text (local) | No usa embeddings |
| **Vector DB** | Qdrant (Raspberry) | No usa vector DB |
| **SQL DB** | PostgreSQL (Raspberry) | No usa SQL |
| **Google Drive** | ✅ Sí (con auth) | ✅ Sí (con auth) |
| **Memoria conversación** | ❌ No | ✅ Contexto completo |
| **Acceso a fecha/hora** | ❌ No | ✅ Sí |
| **Generación documentos** | ❌ No | ✅ Markdown + Word |
| **GitHub** | ❌ No | ✅ Sí |
| **Análisis PDF** | ✅ PyMuPDF + OCR | ✅ PDF tool |
| **Precisión SICOM** | ❌ Baja (sin docs) | ✅ Alta (docs cargados) |
| **Velocidad respuesta** | 🟡 50-120 segundos | ✅ 5-15 segundos |
| **Disponibilidad 24/7** | ❌ Depende de Mac | ✅ Sí |
| **Auditoría integrada** | ✅ suite_auditoria_god.py | ❌ No |
| **Extracción CAD** | ✅ ezdxf | ❌ No |
| **Visión artificial** | ✅ llama3.2-vision | ❌ No |

---

## 8. RECOMENDACIONES PARA MEJORAR ODIN

### 8.1 Inmediatas (Alta Prioridad)

#### R1.1: Detener instancia duplicada del bot
**Acción:** En servidor cloud, ejecutar:
```bash
docker stop odin-telegram-bot
docker rm odin-telegram-bot
```
**Impacto:** Elimina conflictos 409.

#### R1.2: Corregir extractor de PDFs
**Archivo:** `core/extractors/pdf_extractor.py`
**Cambio:**
```python
def extraer_texto(self, data, nombre_archivo="", *args, **kwargs):
    """Soporta tanto rutas de archivo como streams de bytes."""
    texto_extraido = ""
    
    if isinstance(data, bytes):
        # Procesar desde bytes (stream de Google Drive)
        from io import BytesIO
        try:
            lector = pypdf.PdfReader(BytesIO(data))
            paginas_texto = []
            for pagina in lector.pages:
                txt = pagina.extract_text()
                if txt:
                    paginas_texto.append(txt)
            texto_extraido = "\n".join(paginas_texto).strip()
        except Exception as e:
            logger.error(f"Error leyendo PDF desde bytes: {e}")
            return "CRITICAL_ERROR_TEXT_CORRUPT"
    elif isinstance(data, str) and os.path.exists(data):
        # Procesar desde archivo local
        try:
            with open(data, "rb") as f:
                lector = pypdf.PdfReader(f)
                paginas_texto = []
                for pagina in lector.pages:
                    txt = pagina.extract_text()
                    if txt:
                        paginas_texto.append(txt)
                texto_extraido = "\n".join(paginas_texto).strip()
        except Exception as e:
            logger.error(f"Error leyendo PDF desde archivo: {e}")
            return "CRITICAL_ERROR_TEXT_CORRUPT"
    else:
        return "CRITICAL_ERROR_FILE_NOT_FOUND"
    
    # Resto del método (umbral, OCR fallback)...
```

#### R1.3: Indexar documentos SICOM
**Acción:** Subir a Google Drive en carpeta "Innovadataco/SICOM/":
- `ANEXO_Mayo_8_ContratoSICOM_REV_ULTIMO.docx`
- `Preguntas_Adicionales_SICOM__15_05_2026.pdf`
- `Plan_empalme_SICOM_AJUSTADO_COMPLETO__15_05_2026.pdf`

**Luego ejecutar:** `python odin_ingestor.py`

#### R1.4: Agregar categoría "sicom" a taxonomía
**Archivo:** `config/taxonomy.json`
**Agregar:**
```json
{
  "transporte": "Licitaciones públicas de SECOP...",
  "minas": "Títulos mineros...",
  "tecnologica": "Metodología de proyectos PM2 pura...",
  "sicom": "Contrato SICOM, empalme operativo, infraestructura tecnológica Ministerio de Minas y Energía, ANS, continuidad de servicio"
}
```

---

### 8.2 Corto Plazo (Media Prioridad)

#### R2.1: Agregar memoria de conversación
**Archivo:** `agents/odin_brain.py`
**Implementación:**
```python
class OdinBrain:
    def __init__(self):
        # ... existing code ...
        self.memoria: List[Dict[str, str]] = []
        self.max_memoria = 10
    
    def consultar(self, pregunta: str) -> str:
        # Agregar pregunta a memoria
        self.memoria.append({"role": "user", "content": pregunta})
        if len(self.memoria) > self.max_memoria:
            self.memoria.pop(0)
        
        # ... procesar ...
        
        # Agregar respuesta a memoria
        self.memoria.append({"role": "assistant", "content": respuesta})
        return respuesta
```

#### R2.2: Agregar acceso a fecha/hora
**Implementación:**
```python
from datetime import datetime

# En el método consultar():
fecha_actual = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
contexto_extra = f"\n[FECHA ACTUAL DEL SISTEMA]: {fecha_actual}\n"
```

#### R2.3: Mejorar system prompt con fallback
**Actual:**
```python
"Responde con un tono corporativo, autoritario, sumamente técnico y preciso."
```

**Mejorado:**
```python
"Eres ODIN, asistente técnico de InnovaDataCo.\n"
"Reglas:\n"
"1. Si no tienes información específica, di 'No tengo datos sobre eso en mi base de conocimiento'\n"
"2. No inventes números, fechas o documentos\n"
"3. Responde de forma directa y concisa\n"
"4. Si la pregunta es sobre fecha/hora, usa la fecha actual del sistema\n"
"5. Basa tus respuestas ÚNICAMENTE en los datos y documentos proporcionados arriba"
```

#### R2.4: Filtrar por sector en búsqueda vectorial
**Implementación:**
```python
# Detectar sector de la pregunta
sector_detectado = self.detectar_sector(pregunta)

# Filtrar resultados
if sector_detectado:
    documentos_encontrados = [
        doc for doc in documentos_encontrados 
        if doc.payload.get('sector') == sector_detectado
    ]
```

---

### 8.3 Largo Plazo (Baja Prioridad)

#### R3.1: Implementar RAG híbrido
- SQL (datos estructurados)
- Vector (búsqueda semántica)
- Keyword (BM25 para precisión)

#### R3.2: Fine-tuning del modelo
Entrenar qwen2.5:32b con conversaciones reales de proyectos InnovaDataCo.

#### R3.3: Dashboard de monitoreo
Crear panel para visualizar:
- Documentos indexados por sector
- Consultas frecuentes
- Tasa de satisfacción
- Errores del sistema

---

## 9. CONCLUSIONES

### 9.1 Estado Actual de ODIN

| Aspecto | Evaluación |
|---------|------------|
| **Infraestructura** | ✅ Sólida (Mac + Raspberry + Qdrant + Postgres) |
| **Arquitectura** | ✅ Bien diseñada (RAG con SQL + Vector) |
| **Código** | ✅ Profesional, modular, con logging |
| **Datos** | 🔴 Incompletos (faltan docs SICOM) |
| **Respuestas** | 🔴 Imprecisas (alucinaciones, contexto irrelevante) |
| **Disponibilidad** | 🔴 Afectada (conflicto de instancias) |
| **Auditoría** | ✅ Excelente (suite_auditoria_god.py) |
| **Extracción** | ✅ Avanzada (OCR, CAD, Excel) |

### 9.2 Por qué ODIN "No Contesta lo que Debe"

1. **No tiene los documentos:** El contrato SICOM y plan de empalme NO están indexados
2. **Prompt obliga a responder:** "Responde con tono corporativo, autoritario, técnico" → alucina si no hay datos
3. **Sin fallback:** No está programado para decir "No sé"
4. **Recuperación vectorial imprecisa:** Trae documentos de transporte/minas en lugar de SICOM
5. **Sin memoria:** No mantiene contexto entre mensajes
6. **Sin fecha/hora:** No puede responder preguntas temporales básicas
7. **Template engañoso:** Dice "Software SICOM activo" pero no hay datos de SICOM

### 9.3 Comparativa con ZEUS

ZEUS (OpenClaw en servidor cloud) es más efectivo actualmente porque:
- ✅ Tiene acceso a documentos SICOM (subidos por CEO)
- ✅ Usa Kimi K2.5 (modelo más potente que qwen2.5:32b local)
- ✅ Mantiene contexto de conversación completo
- ✅ Puede generar documentos (Markdown, Word)
- ✅ Acceso a GitHub, Google Drive, herramientas externas

**ODIN tiene potencial superior** con:
- ✅ Infraestructura local (privacidad, latencia)
- ✅ OCR integrado (pytesseract)
- ✅ Visión artificial (llama3.2-vision)
- ✅ Extracción CAD (ezdxf)
- ✅ Auditoría completa (suite_auditoria_god.py)

**Pero necesita:**
1. Corregir bugs (PDF extractor, conflicto de instancias)
2. Indexar documentos actuales
3. Mejorar prompts y memoria
4. Agregar categoría SICOM a taxonomía

---

## 10. PLAN DE ACCIÓN RECOMENDADO

### Fase 1: Correcciones Críticas (1-2 días)
- [ ] Detener contenedor Docker duplicado en servidor cloud
- [ ] Corregir `pdf_extractor.py` para manejar bytes
- [ ] Indexar documentos SICOM en Google Drive
- [ ] Agregar categoría "sicom" a `taxonomy.json`
- [ ] Ejecutar `suite_auditoria_god.py` para validar

### Fase 2: Mejoras Funcionales (1 semana)
- [ ] Agregar memoria de conversación
- [ ] Agregar fecha/hora al contexto
- [ ] Mejorar system prompt con fallback
- [ ] Filtrar por sector en búsqueda vectorial
- [ ] Actualizar template de bienvenida (dinámico)

### Fase 3: Optimización (2-4 semanas)
- [ ] Implementar RAG híbrido (SQL + Vector + Keyword)
- [ ] Dashboard de monitoreo
- [ ] Automatización de ingestión (webhook de Google Drive)
- [ ] Pruebas de carga y precisión

---

## 11. SCRIPTS DE CORRECCIÓN PROPUESTOS

### 11.1 Script de corrección rápida

```bash
#!/bin/bash
# fix_odin_critical.sh

echo "🔧 Correcciones críticas para ODIN-CORE"

# 1. Verificar que no hay instancia duplicada
echo "1. Verificando instancias del bot..."
ps aux | grep "odin_telegram_bot" | grep -v grep

# 2. Corregir pdf_extractor.py
echo "2. Corrigiendo pdf_extractor.py..."
cat > /tmp/pdf_fix.py << 'EOF'
import os
import sys
from pathlib import Path
import pypdf

BASE_DIR = Path(__file__).resolve().parent.parent.parent

class PDFExtractor:
    def __init__(self):
        self.min_threshold = 50

    def extraer_texto(self, data, nombre_archivo="", *args, **kwargs):
        texto_extraido = ""
        
        if isinstance(data, bytes):
            from io import BytesIO
            try:
                lector = pypdf.PdfReader(BytesIO(data))
                paginas_texto = []
                for pagina in lector.pages:
                    txt = pagina.extract_text()
                    if txt:
                        paginas_texto.append(txt)
                texto_extraido = "\n".join(paginas_texto).strip()
            except Exception as e:
                return "CRITICAL_ERROR_TEXT_CORRUPT"
        elif isinstance(data, str) and os.path.exists(data):
            try:
                with open(data, "rb") as f:
                    lector = pypdf.PdfReader(f)
                    paginas_texto = []
                    for pagina in lector.pages:
                        txt = pagina.extract_text()
                        if txt:
                            paginas_texto.append(txt)
                    texto_extraido = "\n".join(paginas_texto).strip()
            except Exception as e:
                return "CRITICAL_ERROR_TEXT_CORRUPT"
        else:
            return "CRITICAL_ERROR_FILE_NOT_FOUND"
        
        return texto_extraido
EOF

# 3. Actualizar taxonomía
echo "3. Actualizando taxonomy.json..."
cat > /tmp/taxonomy_update.json << 'EOF'
{
  "transporte": "Licitaciones públicas de SECOP, procesos de contratación estatal, pliegos de condiciones de infraestructura civil, apéndices técnicos, gestión predial, adquisición de terrenos, condiciones para la operación y mantenimiento de vías, tránsito, movilidad urbana, peajes y proyectos viales como Chía y Girardot.",
  "minas": "Títulos mineros, extracción de carbón, recursos naturales, geología, contratos energéticos, explotación de suelo y licencias ambientales mineras.",
  "tecnologica": "Metodología de proyectos PM2 pura, actas de reuniones internas de desarrollo, planes de gestión de requisitos de software, código, plantillas institucionales de la empresa.",
  "sicom": "Contrato SICOM, empalme operativo, infraestructura tecnológica Ministerio de Minas y Energía, ANS niveles de servicio, continuidad de servicio, plan de corte, transferencia operativa, arrendamiento solución tecnológica en nube privada."
}
EOF

echo "✅ Correcciones listas. Aplicar manualmente en Mac Studio."
```

---

**Informe generado por ZEUS**
**Fecha:** 2026-05-20
**Versión:** 2.0 (con código fuente real)
**Clasificación:** Uso interno InnovaDataCo

**Nota:** Este análisis se basa en el código fuente REAL proporcionado por el CEO. Se recomienda validar las correcciones en ambiente de prueba antes de aplicar en producción.
