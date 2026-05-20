# ANÁLISIS PROFUNDO DE LA LÓGICA DE ODIN_BRAIN.PY
## Flujo de Extracción: Base de Datos + Vectorial

**Fecha:** 2026-05-20
**Analista:** ZEUS
**Archivo:** `odin_brain.py` v6.3.5

---

## 1. FLUJO COMPLETO DE UNA CONSULTA

```
Usuario pregunta: "¿Cuál es el estado del proyecto SICOM?"
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 1: INICIALIZACIÓN (constructor __init__)              │
│  ├─ Conecta a Qdrant (Raspberry Pi, puerto 6333)            │
│  ├─ Crea pool de conexiones PostgreSQL (puerto 5432)       │
│  └─ Ejecuta _inicializar_arquitectura_dinamica()           │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 2: MAPEO DINÁMICO (_inicializar_arquitectura_dinamica)│
│  ├─ Lee TODOS los archivos indexados en PostgreSQL          │
│  ├─ Extrae tokens de nombres de archivos (mayúsculas)      │
│  ├─ Crea "stop words" (palabras que aparecen >4% de veces) │
│  └─ Lee TODOS los proyectos de public.proyectos_innovadataco│
│     y crea catálogo de tokens → nombre_proyecto              │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 3: EXTRAER CONTEXTO RELACIONAL (extraer_contexto_)    │
│  ├─ Convierte pregunta a MAYÚSCULAS                         │
│  ├─ Busca tokens del catálogo en la pregunta               │
│  │   Ejemplo: "SICOM" → ¿Está en catalogo_proyectos_tokens?  │
│  ├─ Si encuentra token → Consulta PostgreSQL                 │
│  │   SELECT * FROM public.proyectos_innovadataco            │
│  │   WHERE nombre_proyecto ILIKE '%SICOM%'                  │
│  └─ Si NO encuentra → Retorna string vacío ""               │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 4: BÚSQUEDA VECTORIAL (Qdrant)                        │
│  ├─ Genera embedding de la pregunta vía Ollama             │
│  │   POST /api/embeddings {model: nomic-embed-text}         │
│  ├─ Busca en Qdrant colección "innovadataco_core"           │
│  │   query_points(limit=10)                                 │
│  ├─ Recupera TOP 10 documentos más similares                │
│  └─ Formatea con "Precisión Geométrica" (score)             │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 5: CONSTRUIR PROMPT FINAL                            │
│  ├─ Contexto SQL (si hay datos)                            │
│  ├─ Contexto Vectorial (10 documentos)                    │
│  ├─ System prompt corporativo fijo                         │
│  └─ Pregunta del usuario                                   │
└─────────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────────┐
│  PASO 6: GENERAR RESPUESTA (Ollama)                        │
│  ├─ POST /api/generate {model: qwen2.5:32b}               │
│  ├─ Timeout: 120 segundos                                  │
│  └─ Retorna respuesta al bot de Telegram                   │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. ANÁLISIS DETALLADO POR MÉTODO

### 2.1 `__init__()` — Constructor

```python
def __init__(self):
    # 1. Configuración de conexión Qdrant
    self.host = os.getenv("QDRANT_HOST", "100.90.218.101")
    self.qdrant_port = int(os.getenv("QDRANT_PORT", 6333))
    self.collection = os.getenv("INNOVADATA_COLLECTION", "innovadataco_core")
    
    # 2. Configuración de modelos LLM
    self.llm = os.getenv("MODEL_LLM", "qwen2.5:32b")  # Modelo principal
    self.embed = os.getenv("MODEL_EMBED", "nomic-embed-text")  # Embeddings
    self.url = os.getenv("OLLAMA_BASE_URL", "http://localhost:11434")
    
    # 3. Conexión a Qdrant
    self.client_vector = QdrantClient(host=self.host, port=self.qdrant_port, timeout=30.0)
    
    # 4. Pool de conexiones PostgreSQL (1-10 conexiones)
    self.db_pool = pool.SimpleConnectionPool(minconn=1, maxconn=10, ...)
    
    # 5. Inicialización dinámica
    self._inicializar_arquitectura_dinamica()
```

**Punto clave:** Crea un pool de conexiones a PostgreSQL para reutilizar conexiones.

---

### 2.2 `_inicializar_arquitectura_dinamica()` — Mapeo Inicial

**Propósito:** Lee la base de datos y crea un "diccionario" de tokens para enrutamiento rápido.

```python
def _inicializar_arquitectura_dinamica(self):
    # PASO A: Leer archivos indexados
    sql = "SELECT DISTINCT ruta_archivo FROM public.odin_ingest_state WHERE hash_md5 != 'CRITICAL_ERROR_TEXT_CORRUPT';"
    rows = self._ejecutar_query(sql, fetch_all=True)
    
    # Extrae nombres de archivos
    self.inventario_archivos = [os.path.basename(r[0]) for r in rows]
    
    # Crea "stop words" (palabras comunes que ignorar)
    # Ejemplo: "MANUAL", "RESOLUCION", "FORMATO" aparecen en muchos archivos
    for name in self.inventario_archivos:
        tokens = re.findall(r'\b[A-ZÁÉÍÓÚÑ]{4,}\b', name.upper())
        conteo_palabras.update(set(tokens))
    
    # Palabras que aparecen en >4% de archivos = stop words
    self.stop_words_dinamicas = [
        palabra for palabra, frecuencia in conteo_palabras.items()
        if (frecuencia / total_archivos) > 0.04
    ]
    
    # PASO B: Leer proyectos
    sql = "SELECT id, nombre_proyecto FROM public.proyectos_innovadataco;"
    rows = self._ejecutar_query(sql, fetch_all=True)
    
    # Crea catálogo: token → nombre_proyecto
    for p_id, p_nombre in rows:
        tokens = re.findall(r'\b[A-ZÁÉÍÓÚÑ]{3,}\b', p_nombre.upper())
        tokens_filtrados = [tk for tk in tokens if tk not in self.stop_words_dinamicas]
        for token in tokens_filtrados:
            self.catalogo_proyectos_tokens[token] = p_nombre
```

**Ejemplo de catálogo generado:**
```python
{
    "CHIA": "Proyecto APP Chía-Girardot",
    "GIRARDOT": "Proyecto APP Chía-Girardot",
    "SICOM": "Empalme SICOM 2026",  # ← Si existe en la tabla
    "MINAS": "Contrato Minas Energía",
    ...
}
```

**Problema:** Si "SICOM" no está en `public.proyectos_innovadataco`, NO se mapea.

---

### 2.3 `extraer_contexto_relacional()` — Consulta SQL

**Propósito:** Busca datos financieros/estructurados del proyecto en PostgreSQL.

```python
def extraer_contexto_relacional(self, pregunta: str) -> str:
    pregunta_upper = pregunta.upper()
    termino_proyecto = None
    
    # 1. Busca tokens en la pregunta
    for token_clave, nombre_real in self.catalogo_proyectos_tokens.items():
        if token_clave in pregunta_upper:
            termino_proyecto = nombre_real
            break  # ← Toma el PRIMER match y sale
    
    # 2. Si no encuentra token → Retorna vacío
    if not termino_proyecto:
        return ""  # ← NO hay contexto SQL
    
    # 3. Consulta PostgreSQL
    sql = """
        SELECT nombre_proyecto, estado_ejecucion, costo_ejecutado, 
               costo_total, descripcion_hito, fecha_proximo_hito, responsable 
        FROM public.proyectos_innovadataco 
        WHERE translate(lower(nombre_proyecto), 'áéíóúü', 'aeiouu') 
        LIKE translate(lower(%s), 'áéíóúü', 'aeiouu') 
        LIMIT 1;
    """
    datos = self._ejecutar_query(sql, (f"%{termino_proyecto}%",))
    
    # 4. Si no encuentra datos → Retorna vacío
    if not datos:
        return ""  # ← NO hay contexto SQL
    
    # 5. Formatea respuesta
    return (
        f"\n[DATOS FINANCIEROS REALES DE LA BASE DE DATOS]:\n"
        f"- Proyecto: {datos[0]}\n"
        f"- Estado: {datos[1]}%\n"
        f"- Inversión: ${datos[2]:,.2f} COP\n"
        f"- Costo Total: ${datos[3]:,.2f} COP\n"
        f"- Próximo Hito: {datos[4]} ({datos[5]})\n"
        f"- Responsable: {datos[6]}\n"
    )
```

**Problemas identificados:**

| Problema | Impacto | Solución |
|----------|---------|----------|
| Solo busca en `public.proyectos_innovadataco` | Ignora tabla `pm2.proyecto` | Unificar tablas o consultar ambas |
| `LIMIT 1` | Solo trae 1 proyecto | Aumentar a LIMIT 5 o filtrar mejor |
| Toma PRIMER token match | Puede ser incorrecto | Priorizar tokens más largos/específicos |
| Sin fallback si no hay datos | Retorna vacío | Agregar mensaje "No hay datos SQL" |

---

### 2.4 `consultar()` — Orquestador Principal

**Propósito:** Combina SQL + Vectorial + LLM para generar respuesta.

```python
def consultar(self, pregunta: str) -> str:
    # PASO 1: Contexto relacional (SQL)
    contexto_sql = self.extraer_contexto_relacional(pregunta)
    # Si no encuentra token → ""
    
    # PASO 2: Contexto vectorial (Qdrant)
    try:
        # 2a. Generar embedding
        res_emb = requests.post(
            f"{self.url}/api/embeddings", 
            json={"model": self.embed, "prompt": pregunta}, 
            timeout=15
        )
        vector = res_emb.json()['embedding']
        
        # 2b. Buscar en Qdrant
        res_qdrant = self.client_vector.query_points(
            collection_name=self.collection,
            query=vector,
            limit=10  # TOP 10 documentos
        )
        
        # 2c. Formatear documentos
        documentos_encontrados = []
        for hit in res_qdrant.points:
            payload = hit.payload
            score_geo = hit.score  # Similitud (0-1)
            documentos_encontrados.append(
                f"--- FUENTE [Bóveda: {sector_tag} | "
                f"Precisión Geométrica: {score_geo:.4f} | "
                f"Componente: {doc_name}] ---\n"
                f"{payload['contenido']}"
            )
        contexto_docs = "\n\n".join(documentos_encontrados)
        
    except Exception as e:
        contexto_docs = f"Error: {e}"
    
    # PASO 3: Construir prompt
    prompt = f"""
    Eres ODIN-CORE... [system prompt fijo]
    
    {contexto_sql}  # ← Puede estar vacío
    
    INFORMACIÓN DOCUMENTAL RECUPERADA:
    {contexto_docs}  # ← Documentos de Qdrant
    
    PREGUNTA: {pregunta}
    
    RESPUESTA EJECUTIVA INTEGRADA:
    """
    
    # PASO 4: Generar con LLM
    response = requests.post(
        f"{self.url}/api/generate",
        json={"model": self.llm, "prompt": prompt, "stream": False},
        timeout=120
    )
    return response.json()['response']
```

---

## 3. DIAGRAMA DE FLUJO CON EJEMPLO REAL

### Escenario: Usuario pregunta "¿Qué es SICOM?"

```
Pregunta: "¿Qué es SICOM?"
          ↓
┌────────────────────────────────────────┐
│ extraer_contexto_relacional("¿Qué es SICOM?") │
│                                        │
│ 1. pregunta_upper = "¿QUÉ ES SICOM?"  │
│ 2. Busca "SICOM" en catalogo_proyectos_tokens │
│    → ¿Está? DEPENDE de la tabla        │
│                                        │
│  CASO A: SICOM está en catálogo        │
│  → Consulta SQL:                       │
│  SELECT * FROM public.proyectos_innovadataco │
│  WHERE nombre_proyecto ILIKE '%SICOM%'     │
│  → Retorna datos financieros           │
│                                        │
│  CASO B: SICOM NO está en catálogo     │
│  → Retorna "" (VACÍO)                  │
└────────────────────────────────────────┘
          ↓
┌────────────────────────────────────────┐
│ Búsqueda Vectorial (Qdrant)            │
│                                        │
│ 1. Embedding de "¿Qué es SICOM?"     │
│    → Vector de 768 dimensiones        │
│                                        │
│ 2. Busca en Qdrant:                    │
│    query_points(limit=10)              │
│                                        │
│ 3. Recupera documentos similares:      │
│    → "M-132 MANUAL ARQUITECTURA SICOM" │
│    → "Mintransporte Resolución 45005"  │
│    → "ISO 14813-6"                     │
│    → "Radares de velocidad"            │
│                                        │
│ 4. Formatea con "Precisión Geométrica" │
│    → score de similitud (0.0 - 1.0)   │
└────────────────────────────────────────┘
          ↓
┌────────────────────────────────────────┐
│ Construcción de Prompt                 │
│                                        │
│ Contexto SQL: "" (vacío o datos)       │
│                                        │
│ Contexto Vectorial:                    │
│ --- FUENTE [Bóveda: tecnologica |      │
│     Precisión Geométrica: 0.7344 |       │
│     Componente: M-132 MANUAL...] ---   │
│ "El SICOM es un sistema de información │
│  para el sector minero-energético..." │
│                                        │
│ [Más documentos...]                    │
│                                        │
│ PREGUNTA: ¿Qué es SICOM?               │
│                                        │
│ System: "Responde con tono corporativo,│
│  autoritario, sumamente técnico..."    │
└────────────────────────────────────────┘
          ↓
┌────────────────────────────────────────┐
│ Generación con qwen2.5:32b             │
│                                        │
│ Modelo recibe:                         │
│ - System prompt (obligación de        │
│   responder "técnico y preciso")       │
│ - Contexto SQL (puede estar vacío)     │
│ - 10 documentos (algunos irrelevantes)│
│ - Pregunta del usuario                 │
│                                        │
│ Resultado:                             │
│ Si contexto SQL vacío + docs mixtos:   │
│ → ALUCINACIÓN (inventa para cumplir)   │
│                                        │
│ Si contexto SQL presente + docs       │
│ relevantes:                            │
│ → Respuesta basada en datos           │
└────────────────────────────────────────┘
```

---

## 4. PROBLEMAS DE LA LÓGICA

### 4.1 Problema #1: Dependencia del Catálogo de Tokens

**Código:**
```python
for token_clave, nombre_real in self.catalogo_proyectos_tokens.items():
    if token_clave in pregunta_upper:
        termino_proyecto = nombre_real
        break
```

**Problema:** Si el proyecto "SICOM" no está en `public.proyectos_innovadataco`, NO se consulta SQL.

**Impacto:** ODIN pierde datos financieros/estructurados del proyecto.

**Solución:**
```python
# Agregar búsqueda por palabras clave adicionales
terminos_adicionales = ["SICOM", "EMPALME", "CONTRATO", "MINTRANSPORTE"]
for termino in terminos_adicionales:
    if termino in pregunta_upper and termino not in self.catalogo_proyectos_tokens:
        # Buscar en múltiples tablas
        sql = """
            SELECT nombre_proyecto FROM pm2.proyecto 
            WHERE nombre ILIKE %s 
            UNION ALL
            SELECT nombre_proyecto FROM public.proyectos_innovadataco 
            WHERE nombre_proyecto ILIKE %s;
        """
```

---

### 4.2 Problema #2: LIMIT 1 en Consulta SQL

**Código:**
```python
sql = "... LIMIT 1;"
```

**Problema:** Solo trae 1 proyecto, aunque haya varios relacionados.

**Impacto:** Si hay "Empalme SICOM" y "Contrato SICOM", solo trae el primero.

**Solución:**
```python
sql = "... LIMIT 5;"  # Traer más resultados
# O filtrar por código específico:
sql = "... WHERE codigo = 'SICOM-2026' LIMIT 1;"
```

---

### 4.3 Problema #3: Sin Filtrado por Sector en Qdrant

**Código:**
```python
res_qdrant = self.client_vector.query_points(
    collection_name=self.collection,
    query=vector,
    limit=10  # Sin filtro de sector
)
```

**Problema:** Recupera documentos de TODOS los sectores.

**Impacto:** Pregunta sobre SICOM (tecnología) → Trae documentos de transporte.

**Solución:**
```python
# Detectar sector de la pregunta
sector = self.detectar_sector(pregunta)  # "tecnologica"

# Filtrar en Qdrant
res_qdrant = self.client_vector.query_points(
    collection_name=self.collection,
    query=vector,
    limit=10,
    query_filter=models.Filter(
        must=[
            models.FieldCondition(
                key="sector",
                match=models.MatchValue(value=sector)
            )
        ]
    )
)
```

---

### 4.4 Problema #4: Prompt Obliga a Responder

**System prompt:**
```
"Responde con un tono corporativo, autoritario, sumamente técnico y preciso. 
Utiliza los datos exactos adjuntos."
```

**Problema:** Cuando no hay datos, el LLM DEBE inventar para cumplir.

**Impacto:** Alucinaciones, respuestas irrelevantes.

**Solución:**
```python
prompt = f"""
Eres ODIN, asistente técnico de InnovaDataCo.
REGLAS:
1. Si no tienes información específica, di: 
   "No tengo datos sobre eso en mi base de conocimiento"
2. No inventes números, fechas o documentos
3. Responde de forma directa y concisa
4. Basa tus respuestas ÚNICAMENTE en los datos proporcionados arriba

{contexto_sql}

{contexto_docs}

PREGUNTA: {pregunta}

RESPUESTA:
"""
```

---

### 4.5 Problema #5: Sin Memoria de Conversación

**Código:**
```python
def consultar(self, pregunta: str) -> str:
    # Cada llamada es independiente
    contexto_sql = self.extraer_contexto_relacional(pregunta)
    # ...
```

**Problema:** No recuerda conversaciones previas.

**Impacto:**
- Usuario: "¿Qué es SICOM?"
- ODIN: [Explica SICOM]
- Usuario: "¿Y cuándo empieza?"
- ODIN: [No sabe que se refiere al empalme SICOM]

**Solución:**
```python
class OdinBrain:
    def __init__(self):
        # ... existing code ...
        self.historial: List[Dict[str, str]] = []
        self.max_historial = 10
    
    def consultar(self, pregunta: str) -> str:
        # Agregar pregunta a historial
        self.historial.append({"role": "user", "content": pregunta})
        
        # Construir contexto con historial
        contexto_historial = "\n".join([
            f"{msg['role']}: {msg['content']}" 
            for msg in self.historial[-5:]  # Últimos 5 mensajes
        ])
        
        # Incluir en prompt
        prompt = f"""
        HISTORIAL DE CONVERSACIÓN:
        {contexto_historial}
        
        {contexto_sql}
        {contexto_docs}
        
        PREGUNTA ACTUAL: {pregunta}
        """
        
        # ... generar respuesta ...
        
        # Guardar respuesta en historial
        self.historial.append({"role": "assistant", "content": respuesta})
        
        # Limitar tamaño
        if len(self.historial) > self.max_historial:
            self.historial = self.historial[-self.max_historial:]
        
        return respuesta
```

---

## 5. FLUJO DE DATOS REAL

### 5.1 ¿De dónde saca ODIN la información?

| Fuente | Tabla/Colección | Tipo de Datos | Cuándo se Usa |
|--------|----------------|---------------|---------------|
| **PostgreSQL** | `public.proyectos_innovadataco` | Datos financieros, hitos, responsables | Cuando detecta token del proyecto en la pregunta |
| **PostgreSQL** | `public.odin_ingest_state` | Control de archivos indexados | Al inicializar (mapeo dinámico) |
| **Qdrant** | `innovadataco_core` | Documentos completos (PDF, DOCX) | Siempre (búsqueda semántica) |
| **Ollama** | `qwen2.5:32b` | Generación de respuestas | Siempre (último paso) |
| **Ollama** | `nomic-embed-text` | Embeddings para búsqueda | Siempre (conversión texto → vector) |

### 5.2 Ejemplo de Flujo Completo

**Pregunta:** "¿Cuál es el presupuesto del proyecto Chía?"

```
1. Inicialización (ya hecha en __init__):
   - catalogo_proyectos_tokens = {"CHIA": "Proyecto APP Chía-Girardot", ...}

2. extraer_contexto_relacional("¿Cuál es el presupuesto...?"):
   - pregunta_upper = "¿CUÁL ES EL PRESUPUESTO DEL PROYECTO CHÍA?"
   - Busca "CHIA" en catálogo → ENCONTRADO
   - termino_proyecto = "Proyecto APP Chía-Girardot"
   - Consulta SQL:
     SELECT costo_total, costo_ejecutado ... 
     WHERE nombre_proyecto ILIKE '%Proyecto APP Chía-Girardot%'
   - Retorna:
     "[DATOS FINANCIEROS REALES]:
      - Proyecto: Proyecto APP Chía-Girardot
      - Inversión Ejecutada: $2,500,000,000 COP
      - Costo Total: $5,000,000,000 COP"

3. Búsqueda Vectorial:
   - Embedding de "¿Cuál es el presupuesto del proyecto Chía?"
   - Busca en Qdrant → Recupera documentos de Chía-Girardot
   - Retorna chunks de PDFs/manuals

4. Construye Prompt:
   "Eres ODIN-CORE...
   
   [DATOS FINANCIEROS REALES]:
   - Proyecto: Proyecto APP Chía-Girardot
   - Inversión: $2,500,000,000 COP
   
   [DOCUMENTOS]:
   - Manual de Arquitectura Chía...
   - Resolución Mintransporte...
   
   PREGUNTA: ¿Cuál es el presupuesto?
   
   RESPUESTA:"

5. Genera con qwen2.5:32b:
   - Recibe datos reales de SQL
   - Recibe documentos relevantes
   - Genera respuesta precisa:
     "El presupuesto total del Proyecto APP Chía-Girardot 
      es de $5,000,000,000 COP, de los cuales se han 
      ejecutado $2,500,000,000 COP (50%)."
```

---

## 6. CONCLUSIONES SOBRE LA LÓGICA

### 6.1 Fortalezas

| Aspecto | Evaluación |
|---------|------------|
| **Pool de conexiones** | ✅ Reutiliza conexiones PostgreSQL eficientemente |
| **Mapeo dinámico** | ✅ Auto-aprende proyectos y archivos al iniciar |
| **Stop words** | ✅ Ignora palabras comunes para mejor precisión |
| **Embeddings locales** | ✅ Privacidad, no depende de API externa |
| **Timeout configurado** | ✅ 120s para LLM, 15s para embeddings |

### 6.2 Debilidades

| Aspecto | Evaluación | Impacto |
|---------|------------|---------|
| **Catálogo estático** | 🔴 Se crea al iniciar, no se actualiza en caliente | Nuevos proyectos no detectados hasta reinicio |
| **LIMIT 1** | 🔴 Solo 1 resultado SQL | Pierde información de proyectos relacionados |
| **Sin filtro sector** | 🟡 Trae documentos de todos los sectores | Respuestas mezcladas e irrelevantes |
| **Prompt obligatorio** | 🔴 Debe responder "técnico y preciso" | Alucina cuando no hay datos |
| **Sin memoria** | 🟡 Cada mensaje independiente | No mantiene contexto conversacional |
| **Sin fecha/hora** | 🟡 No tiene acceso temporal | No puede responder "qué día es hoy" |
| **Tabla única** | 🟡 Solo `public.proyectos_innovadataco` | Ignora `pm2.proyecto` y otras tablas |

### 6.3 Por qué ODIN "Inventa" cuando pregunta por SICOM

1. **No está en catálogo:** `public.proyectos_innovadataco` no tiene proyecto "SICOM"
2. **Contexto SQL vacío:** `extraer_contexto_relacional()` retorna `""`
3. **Documentos irrelevantes:** Qdrant trae transporte/minas en lugar de SICOM
4. **Prompt obliga:** "Responde técnico y preciso" → inventa para cumplir
5. **Sin fallback:** No está programado para decir "No tengo datos"

### 6.4 Recomendaciones para Corregir

1. **Agregar SICOM a `public.proyectos_innovadataco`**
   ```sql
   INSERT INTO public.proyectos_innovadataco 
   (nombre_proyecto, estado_ejecucion, costo_total, responsable)
   VALUES 
   ('Empalme SICOM 2026', 25, 3115475000, 'Jelkin Carrillo');
   ```

2. **Mejorar prompt con fallback**
   ```python
   "Si no tienes información específica, di 'No tengo datos sobre eso'"
   ```

3. **Agregar filtro por sector**
   ```python
   query_filter = models.Filter(
       must=[models.FieldCondition(key="sector", match=models.MatchValue(value="tecnologica"))]
   )
   ```

4. **Agregar memoria de conversación**
   ```python
   self.historial = []  # Guardar últimos 10 mensajes
   ```

5. **Consultar múltiples tablas**
   ```python
   sql = """
       SELECT * FROM public.proyectos_innovadataco WHERE ...
       UNION ALL
       SELECT * FROM pm2.proyecto WHERE ...;
   """
   ```

---

**Análisis completado por ZEUS**
**Archivo:** `odin_brain.py` v6.3.5
**Fecha:** 2026-05-20

**Este análisis desglosa la lógica completa de extracción de datos de ODIN, identificando por qué falla con ciertas preguntas y cómo corregirlo.**
