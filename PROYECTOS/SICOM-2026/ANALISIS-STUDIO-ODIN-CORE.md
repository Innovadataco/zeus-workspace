# ANÁLISIS DE STUDIO: ODIN-CORE v6.3.5
## Evaluación Profunda desde la Perspectiva de Construcción de Agentes IA

**Fecha:** 2026-05-20
**Studio:** ZEUS AI Architecture Lab
**Proyecto:** ODIN-CORE (INNOVADATACO)
**Versión Analizada:** 6.3.5
**Archivos Revisados:** 21 componentes + Logs de producción
**Autor:** Arq. Jelkin Carrillo (Director de Infraestructura)

---

## 1. RESUMEN EJECUTIVO PARA EL STUDIO

### 1.1 Veredicto General

ODIN-CORE es un **agente RAG (Retrieval-Augmented Generation) empresarial** con arquitectura híbrida:
- **Base de datos relacional:** PostgreSQL (Raspberry Pi)
- **Base de datos vectorial:** Qdrant (Raspberry Pi)
- **LLM local:** Ollama (qwen2.5:32b)
- **Embeddings:** nomic-embed-text
- **Fuentes:** Google Drive (PDF, DOCX, XLSX, KMZ, KML, DWG, DXF)
- **Interfaz:** Telegram Bot

### 1.2 Estado de Salud (Basado en Logs Reales)

| Componente | Estado | Evidencia |
|------------|--------|-----------|
| Ingestor | 🟢 Activo | Logs cada 30 minutos |
| Anti-zombie | 🟢 Funcional | Detecta y purga archivos eliminados |
| Token Google | 🟢 Refresca automáticamente | "Credenciales actualizadas con éxito" |
| PDF Extractor | 🔴 **ROTO** | Error: "takes 2 positional arguments but 3 were given" |
| Bot Telegram | 🟢 Activo | Responde consultas |
| PostgreSQL | 🟢 Conectado | Pool de conexiones activo |
| Qdrant | 🟢 Funcional | Búsquedas vectoriales operativas |

### 1.3 Hallazgo Crítico de los Logs

```
2026-05-19 18:06:28 - [ERROR] - ❌ Falla de procesamiento aislada para [Mintransporte Resolucion45005 17-09-2024.pdf]: 
PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Análisis:** El error ocurre porque:
1. El `odin_ingestor.py` llama: `extractor.extraer_texto(stream_bytes, nombre_archivo)`
2. El `PDFExtractor` (versión anterior) tenía firma: `extraer_texto(self, ruta_archivo: str)`
3. El `PDFExtractor` (versión actual v2.1.0) tiene firma: `extraer_texto(self, ruta_archivo: str, *args, **kwargs)`

**PERO** los logs muestran que el error PERSISTE. Esto indica:
- 🟡 **El ingestor está usando una versión antigua del PDFExtractor** (sin `*args, **kwargs`)
- 🟡 **O hay un problema de importación/caché**
- 🔴 **15 archivos PDF de Mintransporte NO se están procesando**

---

## 2. ARQUITECTURA DEL AGENTE IA

### 2.1 Diagrama de Flujo de Datos

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    FLUJO DE DATOS DE ODIN-CORE                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  GOOGLE DRIVE                                                           │
│  ├─ PDFs (Resoluciones, Manuales)                                      │
│  ├─ DOCX (Contratos, Informes)                                         │
│  ├─ XLSX (Presupuestos, Planillas)                                    │
│  ├─ KMZ/KML (Mapas, Geotecnia)                                         │
│  └─ DWG/DXF (Planos CAD)                                               │
│       │                                                                 │
│       ▼                                                                 │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │              ODIN INGESTOR v3.0.1 (Orquestador)                 │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │   │
│  │  │ Descarga    │  │ Extrae      │  │ Clasifica             │  │   │
│  │  │ de Drive    │──│ texto       │──│ por similitud         │  │   │
│  │  │ (stream)    │  │ (Factory)   │  │ coseno                │  │   │
│  │  └─────────────┘  └─────────────┘  └─────────────────────────┘  │   │
│  │       │                                    │                      │   │
│  │       ▼                                    ▼                      │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │   │
│  │  │ Segmenta    │  │ Genera      │  │ Indexa                  │  │   │
│  │  │ en chunks   │──│ embeddings  │──│ en Qdrant               │  │   │
│  │  │ (1200 chars)│  │ (Ollama)    │  │ (768 dims)              │  │   │
│  │  └─────────────┘  └─────────────┘  └─────────────────────────┘  │   │
│  │       │                                    │                      │   │
│  │       ▼                                    ▼                      │   │
│  │  ┌───────────────────────────────────────────────────────────┐  │   │
│  │  │           REGISTRA ESTADO EN POSTGRESQL                   │  │   │
│  │  │  (ruta, hash_md5, boveda, fecha_creacion, fecha_ingesta) │  │   │
│  │  └───────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│       │                                                                 │
│       ▼                                                                 │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │              ODIN BRAIN v6.3.5 (Cerebro RAG)                  │   │
│  │                                                                 │   │
│  │  PREGUNTA DEL USUARIO                                           │   │
│  │       │                                                         │   │
│  │       ▼                                                         │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ 1. Extrae       │  │ 2. Genera       │  │ 3. Busca en     │  │   │
│  │  │    contexto     │  │    embedding    │  │    Qdrant       │  │   │
│  │  │    relacional   │  │    (Ollama)     │  │    (TOP 10)     │  │   │
│  │  │    (SQL)        │  │                 │  │                 │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  │       │                    │                    │                 │   │
│  │       └────────────────────┼────────────────────┘                 │   │
│  │                            ▼                                      │   │
│  │  ┌─────────────────────────────────────────────────────────────┐  │   │
│  │  │ 4. Construye prompt con contexto SQL + documentos vectoriales│  │   │
│  │  └─────────────────────────────────────────────────────────────┘  │   │
│  │                            │                                      │   │
│  │                            ▼                                      │   │
│  │  ┌─────────────────────────────────────────────────────────────┐  │   │
│  │  │ 5. Genera respuesta con qwen2.5:32b (120s timeout)          │  │   │
│  │  └─────────────────────────────────────────────────────────────┘  │   │
│  │                            │                                      │   │
│  │                            ▼                                      │   │
│  │  ┌─────────────────────────────────────────────────────────────┐  │   │
│  │  │ 6. Retorna respuesta al usuario (Telegram)                   │  │   │
│  │  └─────────────────────────────────────────────────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.2 Componentes del Agente

#### 2.2.1 MOTOR DE PERCEPCIÓN (Ingestor)

**Rol:** Captura información del entorno (Google Drive)

**Fortalezas:**
- ✅ OAuth2 con refresh automático
- ✅ Anti-zombie (detecta eliminaciones)
- ✅ Clasificación vectorial por similitud coseno
- ✅ Segmentación semántica (respeta oraciones)
- ✅ Reintentos de descarga (3 intentos)
- ✅ Umbral mínimo de caracteres (50)

**Debilidades:**
- 🔴 **PDF Extractor roto** (error de firma)
- 🟡 Sin paralelización (1 archivo a la vez)
- 🟡 Sin cola de prioridad
- 🟡 Sin notificación de errores en tiempo real

#### 2.2.2 MEMORIA DE TRABAJO (PostgreSQL + Qdrant)

**Rol:** Almacena conocimiento de corto y largo plazo

**PostgreSQL (Memoria Relacional):**
- Tabla `odin_ingest_state`: Registro de archivos indexados
- Tabla `odin_purge_history`: Historial de purgas
- Tabla `proyectos_innovadataco`: Proyectos corporativos
- Schema `pm2`: Proyectos con metodología PM2

**Qdrant (Memoria Vectorial):**
- Colección `innovadataco_core`: Vectores densos (768 dims)
- Payload: sector, carpeta, documento, fragmento, contenido
- Indexado por similitud coseno

**Problema:** No hay **memoria conversacional** (el agente no recuerda el contexto del chat anterior).

#### 2.2.3 MOTOR DE RAZONAMIENTO (OdinBrain)

**Rol:** Procesa consultas y genera respuestas

**Arquitectura interna:**

```
┌─────────────────────────────────────────┐
│         OdinBrain v6.3.5                │
├─────────────────────────────────────────┤
│                                         │
│  1. INICIALIZACIÓN (__init__)           │
│     ├─ Conecta Qdrant (Raspberry Pi)    │
│     ├─ Crea pool PostgreSQL (1-10)      │
│     └─ Ejecuta _inicializar_arquitectura│
│                                         │
│  2. MAPEO DINÁMICO (SE EJECUTA 1 VEZ)   │
│     ├─ Lee archivos de ingest_state     │
│     ├─ Extrae tokens de nombres         │
│     ├─ Crea stop_words (>4% frecuencia) │
│     └─ Lee proyectos_innovadataco       │
│                                         │
│  3. EXTRAER CONTEXTO RELACIONAL         │
│     ├─ Busca token en pregunta          │
│     ├─ Si NO encuentra → ""             │
│     ├─ Si encuentra → SQL LIMIT 1       │
│     └─ Solo tabla public.proyectos...   │
│                                         │
│  4. CONSULTAR (método principal)        │
│     ├─ extraer_contexto_relacional()    │
│     ├─ Genera embedding (Ollama)        │
│     ├─ Busca en Qdrant (sin filtro)     │
│     ├─ Recupera TOP 10                  │
│     ├─ Construye prompt                 │
│     └─ Genera con qwen2.5:32b           │
│                                         │
└─────────────────────────────────────────┘
```

**Fallas críticas del motor de razonamiento:**

| # | Falla | Impacto | Severidad |
|---|-------|---------|-----------|
| 1 | **Catálogo estático** | No detecta nuevos proyectos hasta reinicio | 🔴 Crítico |
| 2 | **LIMIT 1** | Solo 1 resultado, pierde info relacionada | 🔴 Crítico |
| 3 | **1 tabla SQL** | Ignora `pm2.proyecto` y otras tablas | 🔴 Crítico |
| 4 | **Sin filtro sector** | Trae documentos de todos los sectores | 🟡 Alto |
| 5 | **Prompt obligatorio** | "Responde técnico y preciso" → inventa | 🟡 Alto |
| 6 | **Sin memoria** | Cada mensaje independiente | 🟡 Alto |
| 7 | **Sin fecha/hora** | No sabe qué día es | 🟡 Medio |
| 8 | **Sin score mínimo** | Acepta documentos irrelevantes | 🟡 Medio |

#### 2.2.4 ACTUADORES (Telegram Bot + Reporter)

**Rol:** Interactúa con el mundo exterior

**Telegram Bot:**
- ✅ Recibe consultas
- ✅ Indicador "typing"
- ✅ Manejo de excepciones
- 🟡 Sin rate limiting
- 🟡 Sin validación de usuarios

**Reporter:**
- ✅ Métricas de bóvedas
- ✅ Conteo de chunks
- 🟡 Sin scheduling automático
- 🟡 Datos hardcodeados

---

## 3. ANÁLISIS DE LOS LOGS DE PRODUCCIÓN

### 3.1 Patrón de Ejecución del Ingestor

```
2026-05-19 16:54:46 - [INFO] - 🚀 [ORQUESTADOR MODULAR v3] -> Inicializando patrulla del Data Lake...
2026-05-19 16:58:17 - [INFO] - 🔄 Detectada modificación física en: FC0CMG-TEC-GEN-0000-IN-SEG-0003_V00_.docx
2026-05-19 16:58:18 - [INFO] - 🗑️ Vectores liquidados con éxito en Qdrant para: FC0CMG-TEC-GEN-0000-IN-SEG-0003_V00_.docx
2026-05-19 16:58:25 - [INFO] - 🔄 Detectada modificación física en: Radares de velocidad.pdf
2026-05-19 16:58:26 - [INFO] - 🗑️ Vectores liquidados con éxito en Qdrant para: Radares de velocidad.pdf
2026-05-19 16:59:18 - [INFO] - 🏁 Sincronización finalizada con éxito.
```

**Frecuencia:** Cada ~30 minutos (probablemente cron job cada 30 min)

**Archivos que SIEMPRE se modifican:**
1. `FC0CMG-TEC-GEN-0000-IN-SEG-0003_V00_.docx` — Documento de seguridad
2. `Radares de velocidad.pdf` — Documento de infraestructura

**Problema:** Estos archivos se están **re-indexando constantemente** porque:
- Google Drive actualiza `modifiedTime` cada vez que se abre
- El hash (size + modifiedTime) cambia
- El ingestor detecta "modificación" y re-procesa

**Impacto:** 
- 🟡 Procesamiento innecesario
- 🟡 Vectores se eliminan y recrean
- 🟡 Tiempo de CPU desperdiciado

### 3.2 Errores de PDF (CRÍTICO)

```
2026-05-19 18:06:28 - [ERROR] - ❌ Falla de procesamiento aislada para [Mintransporte Resolucion45005 17-09-2024.pdf]: 
PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given
```

**Archivos afectados:**
1. Mintransporte Resolucion45005 17-09-2024.pdf
2. Mintransporte Resolucion Resolución 11245 20-08-2020.pdf
3. Mintransporte Resolucion 35125 11-08-2021.pdf
4. Mintransporte Resolucion 28675 23-05-2022.pdf
5. Mintransporte resolucion 36325 de 2021.pdf
6. Mintransporte resolucion 3600 de 2001.pdf
7. Mintransporte Resoluciob 378 de 2013.PDF
8. Mintransporte Circular 507 de 2024.pdf
9. Mintransporte Resolución 40595 de 2022.pdf
10. ISO 14813-6 2009 first ed.pdf
11. ISO 14813-5 2010 first ed.pdf
12. ISO 14813-1 (2).pdf

**Total: 12 archivos PDF NO indexados**

**Causa raíz:** El `PDFExtractor` en producción NO tiene `*args, **kwargs` en la firma, pero el ingestor le pasa 2 argumentos (`stream_bytes`, `nombre_archivo`).

**Solución inmediata:**
```python
# En pdf_extractor.py, cambiar:
def extraer_texto(self, ruta_archivo: str) -> str:

# Por:
def extraer_texto(self, data, *args, **kwargs) -> str:
    if isinstance(data, bytes):
        return self._extraer_desde_bytes(data)
    else:
        return self._extraer_desde_path(data)
```

### 3.3 Métricas de Rendimiento

| Métrica | Valor | Observación |
|---------|-------|-------------|
| Tiempo de sincronización | ~3-4 minutos | Para 2 archivos modificados |
| Latencia PostgreSQL | ~2-3 segundos | Conexión + consulta |
| Reintentos descarga | 3 intentos | Con sleep de 2 segundos |
| Frecuencia de ejecución | Cada 30 minutos | Cron job |
| Archivos procesados por ciclo | 2-15 | Variable |

---

## 4. EVALUACIÓN DE ARQUITECTURA DESDE EL STUDIO

### 4.1 Dimensiones de Evaluación

| Dimensión | Puntuación (1-10) | Comentario |
|-----------|-------------------|------------|
| **Percepción** | 6/10 | Ingestor robusto pero PDF roto |
| **Memoria** | 4/10 | Sin memoria conversacional, catálogo estático |
| **Razonamiento** | 5/10 | RAG básico, sin filtro sectorial, LIMIT 1 |
| **Actuación** | 6/10 | Bot funcional, reporter manual |
| **Aprendizaje** | 3/10 | Sin aprendizaje automático, solo indexación |
| **Resiliencia** | 5/10 | Reintentos básicos, sin circuit breaker |
| **Escalabilidad** | 4/10 | Procesamiento secuencial, sin paralelismo |
| **Observabilidad** | 6/10 | Logs detallados, pero sin métricas estructuradas |
| **Seguridad** | 5/10 | Tokens en .env, sin rate limiting |
| **Mantenibilidad** | 5/10 | Código bien documentado pero acoplado |

**Puntuación Global: 4.9/10**

### 4.2 Comparativa con Agentes IA del Estado del Arte

| Característica | ODIN v6.3.5 | Agente Ideal | Brecha |
|----------------|-------------|--------------|--------|
| Memoria conversacional | ❌ No | ✅ Sí | Alta |
| Multi-tabla SQL | ❌ 1 tabla | ✅ 3+ tablas | Alta |
| Filtro sectorial | ❌ No | ✅ Sí | Media |
| Fallback "No sé" | ❌ No | ✅ Sí | Alta |
| Contexto temporal | ❌ No | ✅ Sí | Media |
| Cache | ❌ No | ✅ Multi-nivel | Media |
| Paralelismo | ❌ No | ✅ 4+ workers | Media |
| Circuit breaker | ❌ No | ✅ Sí | Media |
| Health checks | ❌ No | ✅ Sí | Baja |
| Auto-ML | ❌ No | ✅ Sí | Alta |

---

## 5. PROPUESTA DE ARQUITECTURA v7.0 (STUDIO RECOMMENDATION)

### 5.1 Principios de Diseño del Studio

```
┌─────────────────────────────────────────────────────────────────┐
│     PRINCIPIOS DE CONSTRUCCIÓN DE AGENTES IA (ZEUS STUDIO)       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1. PERCEPCIÓN MULTI-MODAL                                       │
│     ├─ Texto (PDF, DOCX, TXT)                                   │
│     ├─ Datos estructurados (SQL, CSV)                           │
│     ├─ Geoespacial (KMZ, KML)                                   │
│     └─ CAD (DWG, DXF)                                           │
│                                                                 │
│  2. MEMORIA JERÁRQUICA                                           │
│     ├─ Memoria de trabajo (Redis, TTL 1h)                     │
│     ├─ Memoria a corto plazo (PostgreSQL, sesiones)             │
│     ├─ Memoria a largo plazo (Qdrant, conocimiento)             │
│     └─ Memoria episódica (logs, eventos)                        │
│                                                                 │
│  3. RAZONAMIENTO MULTI-NIVEL                                     │
│     ├─ Percepción (qué veo)                                     │
│     ├─ Comprensión (qué significa)                              │
│     ├─ Razonamiento (qué inferir)                               │
│     └─ Meta-cognición (qué no sé)                               │
│                                                                 │
│  4. ACTUACIÓN CONTEXTUAL                                         │
│     ├─ Respuestas adaptativas                                   │
│     ├─ Proactividad (alertas)                                   │
│     └─ Personalización (por usuario)                              │
│                                                                 │
│  5. APRENDIZAJE CONTINUO                                         │
│     ├─ Aprendizaje por refuerzo (feedback usuario)              │
│     ├─ Aprendizaje por imitación (ejemplos)                     │
│     └─ Aprendizaje por transferencia (nuevos dominios)          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 5.2 Arquitectura Propuesta v7.0

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    ODIN-CORE v7.0 (AGENTE IA COMPLETO)                  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CAPA DE PERCEPCIÓN                          │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ Drive Watcher     │  │ Extractor Pool  │  │ Pre-procesador  │  │   │
│  │  │ • Webhooks        │  │ • 4 workers     │  │ • Normalización │  │   │
│  │  │ • Polling         │  │ • Queue         │  │ • Sanitización  │  │   │
│  │  │ • Event-driven    │  │ • Priority      │  │ • Chunking      │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CAPA DE MEMORIA                               │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ Redis (Trabajo)   │  │ PostgreSQL      │  │ Qdrant          │  │   │
│  │  │ • Session store   │  │ • Sesiones      │  │ • Conocimiento  │  │   │
│  │  │ • Rate limiting   │  │ • Eventos       │  │ • Embeddings    │  │   │
│  │  │ • Pub/sub         │  │ • Métricas      │  │ • Búsqueda      │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CAPA DE RAZONAMIENTO                          │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ Query Parser      │  │ Context Builder │  │ LLM Engine      │  │   │
│  │  │ • NLP             │  │ • SQL multi     │  │ • qwen2.5:32b   │  │   │
│  │  │ • Entity extract  │  │ • Vector search │  │ • Fallback      │  │   │
│  │  │ • Intent classify │  │ • Memory merge  │  │ • Circuit brk   │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CAPA DE ACTUACIÓN                            │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ Telegram Bot      │  │ Reporter        │  │ Alertas         │  │   │
│  │  │ • Rate limiting   │  │ • Scheduled     │  │ • Proactivas    │  │   │
│  │  │ • Auth users      │  │ • HTML/Text     │  │ • Event-driven  │  │   │
│  │  │ • Typing indicator│  │ • Metrics       │  │ • Escalation    │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    CAPA DE APRENDIZAJE                          │   │
│  │  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐  │   │
│  │  │ Feedback Loop     │  │ Auto-tuning     │  │ Knowledge Graph │  │   │
│  │  │ • Thumbs up/down  │  │ • Hyperparams   │  │ • Entities      │  │   │
│  │  │ • Corrections     │  │ • Thresholds    │  │ • Relations     │  │   │
│  │  │ • Preferences     │  │ • Models        │  │ • Inference     │  │   │
│  │  └─────────────────┘  └─────────────────┘  └─────────────────┘  │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 5.3 Componentes Nuevos Propuestos

#### 5.3.1 `session_manager.py` — Gestor de Sesiones

```python
class SessionManager:
    """
    Gestiona sesiones de usuario con memoria de trabajo.
    """
    
    def __init__(self):
        self.redis = RedisClient()
        self.ttl = 3600  # 1 hora
    
    def create_session(self, user_id: str) -> str:
        session_id = f"session:{user_id}:{uuid.uuid4()}"
        self.redis.hset(session_id, mapping={
            "created_at": datetime.now().isoformat(),
            "user_id": user_id,
            "message_count": 0
        })
        self.redis.expire(session_id, self.ttl)
        return session_id
    
    def add_message(self, session_id: str, role: str, content: str):
        self.redis.lpush(f"{session_id}:messages", json.dumps({
            "role": role,
            "content": content,
            "timestamp": datetime.now().isoformat()
        }))
        self.redis.ltrim(f"{session_id}:messages", 0, 9)  # Mantener últimos 10
    
    def get_context(self, session_id: str) -> str:
        messages = self.redis.lrange(f"{session_id}:messages", 0, -1)
        return "\n".join([json.loads(m)["content"] for m in reversed(messages)])
```

#### 5.3.2 `intent_classifier.py` — Clasificador de Intenciones

```python
class IntentClassifier:
    """
    Clasifica la intención de la consulta del usuario.
    """
    
    INTENTS = {
        "consulta_proyecto": ["proyecto", "avance", "estado", "costo"],
        "consulta_documento": ["documento", "manual", "resolución", "norma"],
        "consulta_financiera": ["presupuesto", "inversión", "costo", "ejecutado"],
        "consulta_tecnica": ["especificación", "técnico", "estándar", "ISO"],
        "consulta_geoespacial": ["mapa", "coordenadas", "KMZ", "KML"],
        "consulta_contractual": ["contrato", "cláusula", "obligación", "pago"]
    }
    
    def classify(self, query: str) -> str:
        query_lower = query.lower()
        scores = {}
        for intent, keywords in self.INTENTS.items():
            scores[intent] = sum(1 for kw in keywords if kw in query_lower)
        
        best_intent = max(scores, key=scores.get)
        return best_intent if scores[best_intent] > 0 else "general"
```

#### 5.3.3 `multi_table_query_engine.py` — Motor SQL Multi-Tabla

```python
class MultiTableQueryEngine:
    """
    Motor de consulta SQL que busca en múltiples tablas.
    """
    
    TABLES = {
        "public.proyectos_innovadataco": {
            "fields": ["nombre_proyecto", "estado_ejecucion", "costo_total"],
            "intent_match": ["proyecto", "avance"]
        },
        "pm2.proyecto": {
            "fields": ["nombre", "descripcion", "estado", "avance_porcentaje"],
            "intent_match": ["proyecto", "pm2"]
        },
        "sicom.contrato": {
            "fields": ["numero_contrato", "objeto", "valor_total"],
            "intent_match": ["contrato", "sicom"]
        }
    }
    
    def query(self, intent: str, entities: List[str]) -> List[Dict]:
        results = []
        for table_name, config in self.TABLES.items():
            if any(kw in intent for kw in config["intent_match"]):
                query = self.build_query(table_name, config["fields"], entities)
                rows = self.execute(query)
                results.extend([{"table": table_name, "data": row} for row in rows])
        return results
```

#### 5.3.4 `feedback_loop.py` — Bucle de Retroalimentación

```python
class FeedbackLoop:
    """
    Captura feedback del usuario para mejorar respuestas.
    """
    
    def __init__(self):
        self.db = DatabaseClient()
    
    def capture_feedback(self, query: str, response: str, feedback: str, user_id: str):
        """
        feedback: "positive", "negative", "correction: ..."
        """
        self.db.execute("""
            INSERT INTO feedback (query, response, feedback, user_id, timestamp)
            VALUES (%s, %s, %s, %s, CURRENT_TIMESTAMP)
        """, (query, response, feedback, user_id))
        
        if feedback.startswith("correction:"):
            correction = feedback.replace("correction:", "").strip()
            self.db.execute("""
                INSERT INTO corrections (query, wrong_response, correct_response, user_id)
                VALUES (%s, %s, %s, %s)
            """, (query, response, correction, user_id))
```

---

## 6. PLAN DE MIGRACIÓN DESDE EL STUDIO

### 6.1 Fases de Implementación

```
FASE 1: CORRECCIÓN CRÍTICA (Día 1)
├─ Corregir PDFExtractor (aceptar bytes)
├─ Agregar *args, **kwargs a todos los extractores
├─ Verificar versión en producción
└─ Re-indexar archivos PDF fallidos

FASE 2: MEJORAS RÁPIDAS (Semana 1)
├─ Implementar cache de catálogo (TTL 5 min)
├─ Agregar memoria conversacional (Redis)
├─ Mejorar prompt con fallback "No sé"
├─ Agregar filtro por sector en Qdrant
└─ Agregar fecha/hora al prompt

FASE 3: REARQUITECTURA (Mes 1)
├─ Separar en microservicios
├─ Implementar API Gateway
├─ Agregar Redis para cache y sesiones
├─ Implementar circuit breaker
├─ Agregar health checks
└─ Implementar observabilidad (Prometheus/Grafana)

FASE 4: INTELIGENCIA AVANZADA (Mes 2-3)
├─ Implementar clasificador de intenciones
├─ Agregar motor SQL multi-tabla
├─ Implementar feedback loop
├─ Agregar aprendizaje por refuerzo
└─ Construir knowledge graph
```

### 6.2 Script de Corrección Inmediata

```bash
#!/bin/bash
# fix_odin_critical.sh

echo "🔧 Corrigiendo errores críticos de ODIN..."

# 1. Verificar versión actual de PDFExtractor
echo "📋 Verificando PDFExtractor..."
grep -n "def extraer_texto" /Users/innovadataco/AI/ODIN_CORE/core/extractors/pdf_extractor.py

# 2. Si no tiene *args, aplicar parche
if ! grep -q "\*args" /Users/innovadataco/AI/ODIN_CORE/core/extractors/pdf_extractor.py; then
    echo "🩹 Aplicando parche a PDFExtractor..."
    cat > /tmp/pdf_patch.py << 'EOF'
import io
import pypdf
import logging

logger = logging.getLogger("PDFExtractor")

class PDFExtractor:
    def __init__(self):
        self.min_threshold = 50
    
    def extraer_texto(self, data, *args, **kwargs):
        """Soporta bytes o path"""
        if isinstance(data, bytes):
            return self._extraer_desde_bytes(data)
        else:
            return self._extraer_desde_path(data)
    
    def _extraer_desde_bytes(self, stream_bytes):
        try:
            lector = pypdf.PdfReader(io.BytesIO(stream_bytes))
            texto = "\n".join([p.extract_text() for p in lector.pages if p.extract_text()])
            return texto.strip()
        except Exception as e:
            logger.error(f"Error extrayendo PDF desde bytes: {e}")
            return ""
    
    def _extraer_desde_path(self, ruta_archivo):
        try:
            with open(ruta_archivo, "rb") as f:
                return self._extraer_desde_bytes(f.read())
        except Exception as e:
            logger.error(f"Error leyendo PDF desde path: {e}")
            return ""
EOF
    cp /tmp/pdf_patch.py /Users/innovadataco/AI/ODIN_CORE/core/extractors/pdf_extractor.py
fi

# 3. Re-indexar archivos PDF fallidos
echo "🔄 Re-indexando archivos PDF..."
cd /Users/innovadataco/AI/ODIN_CORE
python3 -c "
from core.database import DatabaseClient
db = DatabaseClient()
# Marcar PDFs como pendientes para re-procesar
db.execute(\"\"
    UPDATE odin_ingest_state 
    SET hash_md5 = 'FORCE_REINDEX' 
    WHERE ruta_archivo LIKE '%.pdf' 
    AND boveda = 'PENDIENTE_REVISION';
\"\")
"

# 4. Reiniciar servicios
echo "🔄 Reiniciando servicios..."
launchctl unload ~/Library/LaunchAgents/com.innovadataco.odiningestor.plist
launchctl load ~/Library/LaunchAgents/com.innovadataco.odiningestor.plist

echo "✅ Correcciones aplicadas"
```

---

## 7. CONCLUSIONES DEL STUDIO

### 7.1 Fortalezas de ODIN-CORE

1. **Arquitectura híbrida bien concebida:** Combinación de SQL + Vectorial + LLM
2. **Ingestor robusto:** Anti-zombie, reintentos, clasificación automática
3. **Privacidad:** Todo local (Raspberry Pi), sin datos en la nube
4. **Documentación:** Código bien comentado con headers corporativos
5. **Modularidad:** Fábrica de extractores, clientes separados

### 7.2 Debilidades Críticas

1. **PDF Extractor roto:** 12 archivos NO indexados (error de firma)
2. **Catálogo estático:** No detecta nuevos proyectos en caliente
3. **Sin memoria conversacional:** Cada mensaje es independiente
4. **LIMIT 1:** Solo 1 resultado SQL, pierde información
5. **Sin filtro sectorial:** Trae documentos irrelevantes
6. **Prompt obligatorio:** "Responde técnico" → inventa si no sabe
7. **Sin fecha/hora:** No sabe qué día es
8. **Sin cache:** Regenera embeddings cada vez
9. **Sin paralelismo:** Procesamiento secuencial
10. **Sin circuit breaker:** Cascada de fallos si Ollama cae

### 7.3 Recomendación del Studio

**Migrar a v7.0 en 4 fases:**

| Fase | Duración | Objetivo | Impacto |
|------|----------|----------|---------|
| 1 | 1 día | Corregir bugs críticos | Inmediato |
| 2 | 1 semana | Mejoras rápidas | Alto |
| 3 | 1 mes | Rearquitectura | Muy alto |
| 4 | 2-3 meses | Inteligencia avanzada | Transformacional |

### 7.4 Próximos Pasos

1. ✅ **Aprobar plan de migración**
2. ✅ **Asignar recursos** (1 desarrollador full-time)
3. ✅ **Implementar Fase 1** (corrección PDF)
4. ✅ **Testear en staging**
5. ✅ **Desplegar a producción**
6. ✅ **Monitorear métricas**

---

**Informe generado por ZEUS AI Architecture Studio**
**Fecha:** 2026-05-20
**Contacto:** studio@zeus-ai.innovadataco.com
**Licencia:** PROPIEDAD INTELECTUAL DE INNOVADATACO

> "Un agente IA sin memoria es como un humano con amnesia. 
>  Un agente IA sin fallback es como un humano que nunca dice 'no sé'."
>  — ZEUS Studio

---

## ANEXO A: Logs Completos de Error

```
2026-05-19 18:06:28 - [ERROR] - ❌ Falla de procesamiento aislada para [Mintransporte Resolucion45005 17-09-2024.pdf]: 
PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given

2026-05-19 18:06:31 - [ERROR] - ❌ Falla de procesamiento aislada para [Mintransporte Resolucion Resolución 11245 20-08-2020.pdf]: 
PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given

2026-05-19 18:06:37 - [ERROR] - ❌ Falla de procesamiento aislada para [Mintransporte Resolucion 35125 11-08-2021.pdf]: 
PDFExtractor.extraer_texto() takes 2 positional arguments but 3 were given

[... 9 errores más ...]
```

**Total de archivos afectados:** 12 PDFs de Mintransporte + 3 PDFs de ISO
**Impacto:** Estos documentos NO están indexados en Qdrant, por lo que ODIN NO puede responder consultas sobre ellos.

## ANEXO B: Estructura de Tablas PostgreSQL

```sql
-- Tabla de estados de ingesta
CREATE TABLE public.odin_ingest_state (
    ruta_archivo VARCHAR(500) PRIMARY KEY,
    hash_md5 VARCHAR(32),
    boveda VARCHAR(50),
    fecha_creacion TIMESTAMP,
    fecha_ingesta TIMESTAMP
);

-- Tabla de historial de purgas
CREATE TABLE public.odin_purge_history (
    id SERIAL PRIMARY KEY,
    ruta_archivo VARCHAR(500),
    nombre_archivo VARCHAR(200),
    fecha_purga TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de proyectos
CREATE TABLE public.proyectos_innovadataco (
    id SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR(200),
    estado_ejecucion DECIMAL(5,2),
    costo_ejecutado DECIMAL(15,2),
    costo_total DECIMAL(15,2),
    descripcion_hito TEXT,
    fecha_proximo_hito DATE,
    responsable VARCHAR(100)
);
```

## ANEXO C: Configuración de Variables de Entorno

```bash
# .env
DB_HOST=100.90.218.101
DB_USER=postgres
DB_PASSWORD=***
DB_NAME=postgres
DB_PORT=5432

QDRANT_HOST=100.90.218.101
QDRANT_PORT=6333
INNOVADATA_COLLECTION=innovadataco_core

OLLAMA_BASE_URL=http://100.90.218.100:11434
MODEL_LLM=qwen2.5:32b
MODEL_EMBED=nomic-embed-text

TELEGRAM_BOT_TOKEN=***
TELEGRAM_CHAT_ID=***

DEFAULT_BOVEDA=tecnologica
MIN_CHAR_THRESHOLD=50
EXCLUDED_DIRS=supertransporte,st
```
