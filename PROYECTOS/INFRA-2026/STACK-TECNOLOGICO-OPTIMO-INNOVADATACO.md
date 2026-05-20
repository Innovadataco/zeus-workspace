# STACK TECNOLÓGICO ÓPTIMO — Innovadataco AI Platform
## Mac Studio 32GB + Raspberry Pi 16GB
**Fecha:** 2026-05-20  
**Autor:** ZEUS AI Architecture Studio  
**Nivel:** Brutalmente honesto. Nada de fantasías.

---

## REALIDAD DEL HARDWARE

### Mac Studio (Apple Silicon, 32GB RAM)

| Métrica | Valor Real | Lo que significa |
|---------|-----------|------------------|
| RAM unificada | 32GB | Compartida entre CPU, GPU, Neural Engine |
| GPU | 16-32 cores | Buena para inferencia local acelerada |
| Neural Engine | 16 cores | Excelente para embeddings, clasificación |
| SSD | ~512GB-1TB | Suficiente para 4-5 modelos grandes |
| CPU | M1 Max/Ultra | Rápido, eficiente energéticamente |

**Verdad brutal:**  
32GB NO es suficiente para correr un modelo 70B en 4-bit (necesita ~42GB).  
Puedes correr 30B-40B cómodamente. Para 70B necesitas cuantización extrema (2-bit) o CPU offload (lento).

### Raspberry Pi 5 (16GB RAM)

| Métrica | Valor Real | Lo que significa |
|---------|-----------|------------------|
| RAM | 16GB LPDDR4X | Decente para servicios, INSUFICIENTE para LLMs |
| CPU | ARM Cortex-A76 4x2.4GHz | Lento para inferencia de transformers |
| GPU | VideoCore VII | Inútil para LLMs (no soporta CUDA/ROCm) |
| SSD | MicroSD/USB3 | I/O lento comparado con NVMe |

**Verdad brutal:**  
La Raspberry Pi NO puede correr LLMs útiles localmente. Ni siquiera un 7B en 4-bit es usable (demasiado lento).  
Su rol es: bases de datos, cache, orquestación, monitoreo. Punto.

---

## DECISIONES ARQUITECTÓNICAS FUNDAMENTALES

### Principio #1: HÍBRIDO ESTRATÉGICO

**Local (Mac Studio):** Todo lo que requiere baja latencia, privacidad, o funciona offline  
**Cloud (APIs):** Todo lo que requiere modelos más grandes, alta precisión, o tareas esporádicas  
**Raspberry Pi:** Infraestructura de soporte, bases de datos, mensajería

### Principio #2: MODELOS POR TAREA

| Tarea | Modelo Local | Modelo Cloud (Fallback) |
|-------|-------------|------------------------|
| Respuestas consultoría | qwen2.5:32b | Kimi k2.5, Claude 3.5 Sonnet |
| Embeddings | nomic-embed-text (local) | — |
| Clasificación | nomic-embed-text + sklearn (local) | — |
| Generación código complejo | codellama:13b (local) | Claude 3.5 Sonnet, o1-mini |
| Debugging profundo | — | Claude 3.5 Sonnet, Kimi k2.5 |
| Transcripción audio | whisper:medium (local) | Whisper API |
| Resumen documentos largos | qwen2.5:32b | Kimi k2.5 (contexto 2M) |
| Análisis contratos jurídicos | qwen2.5:32b | Claude 3.5 Sonnet |

### Principio #3: AISLAMIENTO POR SERVICIO

Cada servicio corre en contenedor Docker. Si un servicio falla, no afecta a los demás.  
La Raspberry Pi orquesta contenedores. La Mac Studio corre los LLMs y procesamiento pesado.

---

## STACK POR MÁQUINA

### 🖥️ MAC STUDIO (32GB RAM)

#### Capa 1: Runtime de Modelos

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **Ollama** | latest | Servidor de modelos locales | Standard de facto. API REST simple. Soporte Apple Silicon nativo con Metal GPU. |
| **llama.cpp** | latest (backend) | Motor de inferencia | Ollama lo usa internamente. Metal GPU aceleración en Apple Silicon. |
| **Python 3.11** | 3.11.9+ | Runtime principal | 3.11 es el sweet spot: estable, compatible, rendimiento. NO uses 3.12 todavía (problemas con algunas libs de IA). |
| **Node.js 20 LTS** | 20.x | Backend services, bot Telegram | Para servicios que necesitan event-driven (bots, webhooks). |

#### Modelos a Instalar (Ollama)

```bash
# Core — Razonamiento empresarial, consultoría
ollama pull qwen2.5:32b        # ~20GB. Mejor relación calidad/velocidad para 32GB RAM.
                                 # Soporta español nativamente. Capacidad de reasoning buena.

# Fallback más ligero
ollama pull qwen2.5:14b        # ~9GB. Para queries simples o cuando 32B está ocupado.

# Embeddings — Crítico para RAG
ollama pull nomic-embed-text   # ~275MB. Embeddings de alta calidad. Multilingüe.

# Código
ollama pull codellama:13b      # ~7.5GB. Autocompletado, generación de scripts.
ollama pull deepseek-coder:6.7b # ~4GB. Fallback rápido para código.

# Audio (opcional)
ollama pull whisper:medium     # ~2GB. Transcripción local de reuniones.

# Visión (opcional, si necesitas analizar planos/imágenes)
ollama pull llava:13b          # ~7.5GB. Análisis de imágenes técnicas.
```

**Uso de RAM:**  
- qwen2.5:32b en 4-bit: ~19GB  
- nomic-embed-text: ~300MB  
- codellama:13b: ~7GB  
- whisper:medium: ~2GB  
- **Total concurrente máximo:** ~28GB (deja 4GB para sistema y otros procesos)

#### Capa 2: Framework de Agentes

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **LangChain** | 0.2.x | Orquestación de RAG | Estándar. Integración con Qdrant, PostgreSQL, Ollama. No uses LangGraph todavía (overkill). |
| **LangSmith** | (cloud) | Observabilidad | Tracing de cada paso del agente. Ver dónde falla. 14 días gratis, luego pago. Alternativa libre: LiteLLM proxy. |
| **LiteLLM** | 1.40.x+ | Gateway universal de LLMs | Proxy unificado. Rutear entre Ollama local, Kimi API, Claude API. Circuit breaker, rate limiting, cost tracking. |
| **FastAPI** | 0.110.x | API REST del agente | Alto rendimiento, async nativo, auto-documentación OpenAPI. |
| **Uvicorn** | 0.30.x | Servidor ASGI | Con workers=4 para aprovechar cores de M1. |

#### Capa 3: Procesamiento de Documentos

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **PyMuPDF (fitz)** | 1.24.x | Extracción PDF nativa | Más rápido que pypdf. Maneja PDFs complejos, escaneados. |
| **pdfplumber** | 0.11.x | Extracción tablas PDF | Para resoluciones con tablas de datos financieros. |
| **python-docx** | 1.1.x | Procesamiento Word | Lectura/escritura DOCX sin dependencias pesadas. |
| **openpyxl** | 3.1.x | Procesamiento Excel | Para planillas de proyectos. |
| **geopandas** | 0.14.x | Procesamiento KMZ/KML | Análisis geoespacial si necesitas verificar polígonos de proyectos. |
| **pyproj** | 3.6.x | Proyecciones cartográficas | Para conversiones de coordenadas en archivos de geotecnia. |

#### Capa 4: Integraciones

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **google-api-python-client** | 2.130.x | Gmail, Calendar, Drive | API oficial. Lenta pero estable. |
| **google-auth-oauthlib** | 1.2.x | OAuth2 para Google | Para el flujo de autorización de cuentas de Innovadataco. |
| **python-telegram-bot** | 20.x | Bot de Telegram | Async nativo, manejo de webhooks. NO uses telebot (sincrónico, viejo). |
| **aiohttp** | 3.9.x | Cliente HTTP async | Para llamadas concurrentes a APIs externas. |
| **httpx** | 0.27.x | Cliente HTTP moderno | Reemplazo moderno de requests. Soporte HTTP/2, async. |

#### Capa 5: Utilidades

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **Celery** | 5.4.x | Cola de tareas distribuidas | Para procesar ingestión de documentos en background. |
| **Redis** | 7.x (via Docker) | Broker de Celery, cache, sesiones | Rápido, simple. Usado por Celery como broker. |
| **Flower** | 2.0.x | Monitoreo de Celery | Dashboard web para ver estado de tareas. |
| **Pydantic** | 2.7.x | Validación de datos | Esencial para APIs robustas. v2 es 10x más rápido que v1. |
| **python-dotenv** | 1.0.x | Variables de entorno | Para configuración local. |
| **loguru** | 0.7.x | Logging avanzado | Reemplazo de logging estándar. Más limpio, rotación automática. |
| **prometheus-client** | 0.20.x | Métricas para Prometheus | Exponer métricas del agente. |

---

### 🥧 RASPBERRY PI (16GB RAM)

**Verdad brutal #2:** La Raspberry Pi NO correrá modelos de IA. Su trabajo es ser la infraestructura de datos y mensajería. Es un "data plane", no un "compute plane".

#### Capa 1: Bases de Datos

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **PostgreSQL 15** | 15.x | Base de datos relacional principal | Robustez, JSONB nativo, full-text search. Para datos de proyectos, sesiones, eventos. |
| **pgvector** | 0.7.x | Extensión vectorial para PostgreSQL | ALTERNATIVA a Qdrant. Si Qdrant te da problemas, pgvector en PostgreSQL funciona para <100k vectores. |
| **Qdrant** | 1.9.x (Docker) | Base de datos vectorial | Mejor rendimiento que pgvector para búsqueda semántica. Docker en Raspberry Pi es usable con pocos datos. |
| **Redis** | 7.2.x | Cache, sesiones, pub/sub | Ultra rápido para operaciones frecuentes. No uses como base de datos primaria. |

#### Capa 2: Orquestación y Mensajería

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **Docker + Docker Compose** | 25.x | Contenerización | Aislamiento de servicios. PostgreSQL, Qdrant, Redis, N8N cada uno en su contenedor. |
| **N8N** | 1.44.x (Docker) | Orquestación visual de workflows | Para flujos "no-code" que no justifican código: alertas simples, webhooks, integraciones básicas. |
| **RabbitMQ** | 3.13.x (Docker) | Message broker para Celery | Alternativa a Redis como broker. Más confiable para tareas críticas. |
| **MinIO** | 2024-05.x (Docker) | Almacenamiento de objetos compatible S3 | Para backups de documentos, logs, modelos. Más ligero que AWS S3 local. |

#### Capa 3: Monitoreo y Observabilidad

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **Prometheus** | 2.52.x (Docker) | Métricas y scraping | Recolecta métricas de todos los servicios. |
| **Grafana** | 11.0.x (Docker) | Dashboards y alertas | Visualización de métricas. Alertas por email/Telegram cuando algo falla. |
| **Node Exporter** | 1.8.x (Docker) | Métricas del sistema | CPU, RAM, disco, red de la Raspberry Pi. |
| **Uptime Kuma** | 1.23.x (Docker) | Monitoreo de servicios | Chequea cada 30s si Ollama, Qdrant, PostgreSQL están vivos. Notifica por Telegram. |

#### Capa 4: Networking

| Software | Versión | Propósito | Justificación |
|----------|---------|-----------|---------------|
| **Tailscale** | latest | VPN mesh entre Mac Studio y Raspberry Pi | Zero-config VPN. La Mac y la Pi ven sus IPs privadas sin abrir puertos. Esencial. |
| **Caddy** | 2.8.x (Docker) | Reverse proxy + HTTPS | Reemplazo moderno de Nginx. Configuración automática de HTTPS via Let's Encrypt si expones servicios. |
| **Cloudflare Tunnel** | latest | Exposición segura a internet | Si necesitas acceso remoto sin IP pública. Gratuito, seguro. |

---

## ARQUITECTURA DE RED FINAL

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         INTERNET                                         │
│    (Gmail API, Kimi API, Claude API, Telegram API, Cloudflare)          │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                      MAC STUDIO (32GB RAM)                               │
│                   "Compute Plane" — El cerebro                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  OLLAMA (Servidor de Modelos)                                     │  │
│  │  ├── qwen2.5:32b (consultoría, razonamiento)                     │  │
│  │  ├── qwen2.5:14b (fallback rápido)                               │  │
│  │  ├── nomic-embed-text (embeddings)                               │  │
│  │  ├── codellama:13b (código)                                      │  │
│  │  └── whisper:medium (audio)                                       │  │
│  │  Port: 11434                                                      │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  AGENTE PRINCIPAL (FastAPI + Uvicorn)                             │  │
│  │  ├── /query     → Consultas empresariales                        │  │
│  │  ├── /ingest    → Indexar documentos                             │  │
│  │  ├── /status    → Estado del sistema                             │  │
│  │  ├── /google    → Proxy a Google APIs                            │  │
│  │  └── /telegram  → Webhook del bot                                │  │
│  │  Port: 8000                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  LITELLM PROXY (Gateway de LLMs)                                  │  │
│  │  ├── /ollama/*  → Ollama local                                   │  │
│  │  ├── /kimi/*    → Kimi API (cloud)                                │  │
│  │  ├── /claude/*  → Claude API (cloud)                              │  │
│  │  └── Circuit breaker, rate limiting, cost tracking               │  │
│  │  Port: 4000                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  CELERY WORKERS (Procesamiento en background)                     │  │
│  │  ├── Ingesta de documentos nuevos de Drive                       │  │
│  │  ├── Generación de reportes periódicos                           │  │
│  │  └── Limpieza de vectores obsoletos                             │  │
│  │  (conectados a Redis/RabbitMQ en Raspberry Pi)                  │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  GOOGLE SYNC DAEMON                                               │  │
│  │  ├── Monitorea Gmail cada 5 minutos                              │  │
│  │  ├── Monitorea Calendar cada 15 minutos                          │  │
│  │  ├── Monitorea Drive cada 30 minutos                             │  │
│  │  └── Genera eventos en Redis para el Agente                      │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  TELEGRAM BOT (python-telegram-bot 20.x, async)                   │  │
│  │  ├── Comandos: /start, /status, /proyecto, /documento          │  │
│  │  ├── Procesa mensajes → llama al Agente                          │  │
│  │  └── Envía alertas proactivas desde Redis                        │  │
│  │  (webhook o polling)                                             │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ Tailscale VPN (WireGuard)
                                    │ 100.x.x.x IPs privadas
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                     RASPBERRY PI (16GB RAM)                              │
│                  "Data Plane" — La memoria y el sistema                   │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  POSTGRESQL 15 (Docker)                                           │  │
│  │  ├── proyectos_innovadataco (datos empresariales)                │  │
│  │  ├── odin_ingest_state (estado de ingestión)                     │  │
│  │  ├── odin_sessions (sesiones de usuarios)                      │  │
│  │  ├── odin_events (eventos del sistema)                          │  │
│  │  ├── odin_feedback (feedback de usuarios)                        │  │
│  │  └── pgvector extensión (backup vectorial)                       │  │
│  │  Port: 5432                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  QDRANT (Docker)                                                  │  │
│  │  ├── Colección: innovadataco_core                                 │  │
│  │  ├── Vectores: 768 dims (nomic-embed-text)                       │  │
│  │  ├── Payload: sector, documento, contenido, fecha                │  │
│  │  └── Filtros: por sector, por fecha, por score                   │  │
│  │  Port: 6333                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  REDIS 7 (Docker)                                                 │  │
│  │  ├── Cache de respuestas (TTL 5 min)                             │  │
│  │  ├── Sesiones de usuarios (TTL 1 hora)                           │  │
│  │  ├── Cola de Celery (broker)                                     │  │
│  │  ├── Pub/sub de eventos (alertas proactivas)                     │  │
│  │  └── Rate limiting (llamadas a APIs externas)                    │  │
│  │  Port: 6379                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  PROMETHEUS + GRAFANA + UPTIME KUMA (Docker)                      │  │
│  │  ├── Métricas del sistema cada 15s                               │  │
│  │  ├── Dashboards de rendimiento                                   │  │
│  │  ├── Alertas por Telegram cuando hay fallos                     │  │
│  │  └── Health checks cada 30s de todos los servicios               │  │
│  │  Ports: 9090, 3000, 3001                                        │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  N8N (Docker) — Workflows automáticos                             │  │
│  │  ├── Flujo: Nuevo email en Gmail → Alerta Telegram               │  │
│  │  ├── Flujo: Documento nuevo en Drive → Indexar en Qdrant       │  │
│  │  └── Flujo: Reunión en 30 min → Preparar contexto                │  │
│  │  Port: 5678                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │  MINIO (Docker) — Almacenamiento de objetos                       │  │
│  │  ├── Backups de documentos procesados                            │  │
│  │  ├── Backups de bases de datos                                   │  │
│  │  └── Almacenamiento de modelos (opcional)                       │  │
│  │  Port: 9000                                                     │  │
│  └───────────────────────────────────────────────────────────────────┘  │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## DECISIONES CONTROVERSIALES (Y POR QUÉ)

### ❌ NO uses Docker en la Mac Studio

**Por qué:** Docker en macOS usa una VM (colima/Docker Desktop) que consume 4-8GB RAM. Con 32GB ya limitados, es un lujo que no puedes darte.  
**Alternativa:** Instala todo nativo (brew install postgresql, redis, etc.) o usa Homebrew services.

### ❌ NO corras PostgreSQL/Qdrant en la Mac Studio

**Por qué:** La Mac necesita toda la RAM para los modelos. PostgreSQL + Qdrant consumen 2-4GB.  
**Alternativa:** La Raspberry Pi con 16GB tiene RAM sobrada para bases de datos.

### ❌ NO uses LangGraph

**Por qué:** Overkill para tu caso de uso. Agrega complejidad sin beneficio real. LangChain puro + FastAPI es suficiente.  
**Alternativa:** Si necesitas state machines, usa una simple clase Python con Redis para persistencia.

### ❌ NO uses Kubernetes

**Por qué:** K3s en Raspberry Pi consume 1GB RAM solo por el orchestrator. Docker Compose es suficiente para 2 máquinas.  
**Alternativa:** Docker Compose + Tailscale.

### ❌ NO uses local LLMs para transcripción de reuniones largas

**Por qué:** Whisper en M1 Max transcribe 1 hora de audio en ~20 minutos. Es usable pero no en tiempo real.  
**Alternativa:** Para reuniones críticas, usa Whisper API (cloud, $0.36/hora). Para quick notes, whisper:medium local.

### ✅ SÍ usa LiteLLM como gateway

**Por qué:** Te permite cambiar entre Ollama/Kimi/Claude sin cambiar código. Circuit breaker integrado. Si Ollama cae, automáticamente rutea a Kimi.  
**Costo:** LiteLLM proxy es open source. El cloud proxy tiene costo pero el self-hosted es gratis.

### ✅ SÍ usa N8N en la Raspberry Pi

**Por qué:** Para flujos simples ("email llega → alerta Telegram"), N8N es más rápido que escribir código. Libera al desarrollador para tareas complejas.  
**Limitación:** No uses N8N para lógica de negocio compleja. Ahí sí, código Python.

---

## INSTALACIÓN PASO A PASO

### Mac Studio (Compute)

```bash
# 1. Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Python 3.11 (NO uses el sistema)
brew install python@3.11
# Usa pyenv para manejar versiones
brew install pyenv
pyenv install 3.11.9
pyenv global 3.11.9

# 3. Node.js 20
brew install node@20

# 4. Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 5. Modelos
ollama pull qwen2.5:32b
ollama pull qwen2.5:14b
ollama pull nomic-embed-text
ollama pull codellama:13b

# 6. Tailscale
brew install tailscale
sudo tailscale up

# 7. Dependencias Python
cat > requirements.txt << 'EOF'
fastapi==0.110.0
uvicorn[standard]==0.30.0
pydantic==2.7.0
langchain==0.2.0
langchain-community==0.2.0
httpx==0.27.0
aiohttp==3.9.0
celery==5.4.0
redis==5.0.0
python-telegram-bot==20.8
google-api-python-client==2.130.0
google-auth-oauthlib==1.2.0
python-dotenv==1.0.0
loguru==0.7.0
prometheus-client==0.20.0
PyMuPDF==1.24.0
pdfplumber==0.11.0
python-docx==1.1.0
openpyxl==3.1.0
geopandas==0.14.0
pyproj==3.6.0
EOF
pip install -r requirements.txt

# 8. LiteLLM Proxy
pip install litellm[proxy]

# 9. Estructura de proyecto
mkdir -p ~/Innovadataco/{agent,ingest,bot,google,monitoring}
```

### Raspberry Pi (Data)

```bash
# 1. Docker + Compose
sudo apt update && sudo apt upgrade -y
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
sudo apt install docker-compose-plugin

# 2. Tailscale
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# 3. Estructura de directorios
mkdir -p ~/innovadataco/{postgres,qdrant,redis,grafana,prometheus,n8n,minio,backup}

# 4. Docker Compose (data plane)
cat > ~/innovadataco/docker-compose.yml << 'EOF'
version: '3.8'

services:
  postgres:
    image: postgres:15-alpine
    container_name: innovadataco-postgres
    environment:
      POSTGRES_USER: innova
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: innovadataco
    volumes:
      - ./postgres/data:/var/lib/postgresql/data
      - ./postgres/init:/docker-entrypoint-initdb.d
    ports:
      - "5432:5432"
    restart: unless-stopped

  qdrant:
    image: qdrant/qdrant:latest
    container_name: innovadataco-qdrant
    volumes:
      - ./qdrant/storage:/qdrant/storage
    ports:
      - "6333:6333"
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    container_name: innovadataco-redis
    command: redis-server --appendonly yes --maxmemory 4gb --maxmemory-policy allkeys-lru
    volumes:
      - ./redis/data:/data
    ports:
      - "6379:6379"
    restart: unless-stopped

  prometheus:
    image: prom/prometheus:v2.52.0
    container_name: innovadataco-prometheus
    volumes:
      - ./prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
      - ./prometheus/data:/prometheus
    ports:
      - "9090:9090"
    restart: unless-stopped

  grafana:
    image: grafana/grafana:11.0.0
    container_name: innovadataco-grafana
    volumes:
      - ./grafana/data:/var/lib/grafana
    ports:
      - "3000:3000"
    restart: unless-stopped

  n8n:
    image: n8nio/n8n:1.44.0
    container_name: innovadataco-n8n
    environment:
      N8N_BASIC_AUTH_ACTIVE: true
      N8N_BASIC_AUTH_USER: admin
      N8N_BASIC_AUTH_PASSWORD: ${N8N_PASSWORD}
    volumes:
      - ./n8n/data:/home/node/.n8n
    ports:
      - "5678:5678"
    restart: unless-stopped

  uptime-kuma:
    image: louislam/uptime-kuma:1.23.0
    container_name: innovadataco-uptime
    volumes:
      - ./uptime/data:/app/data
    ports:
      - "3001:3001"
    restart: unless-stopped

  minio:
    image: minio/minio:latest
    container_name: innovadataco-minio
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: innova
      MINIO_ROOT_PASSWORD: ${MINIO_PASSWORD}
    volumes:
      - ./minio/data:/data
    ports:
      - "9000:9000"
      - "9001:9001"
    restart: unless-stopped
EOF

# 5. Iniciar
docker compose up -d
```

---

## CONSUMO DE RECURSOS ESPERADO

### Mac Studio (32GB)

| Servicio | RAM | CPU | Cuándo corre |
|----------|-----|-----|-------------|
| Ollama (32B) | 19GB | 4 cores | Siempre (hot) |
| Ollama (14B) | 9GB | 2 cores | Fallback |
| FastAPI + Uvicorn | 1GB | 1 core | Siempre |
| LiteLLM Proxy | 500MB | 1 core | Siempre |
| Celery Worker (x2) | 2GB | 2 cores | Bajo demanda |
| Telegram Bot | 500MB | 1 core | Siempre |
| Google Sync Daemon | 500MB | 1 core | Background |
| Sistema macOS | 4GB | 2 cores | Siempre |
| **TOTAL** | **~28GB** | **12 cores** | — |

**Nota:** Cuando Celery procesa documentos pesados, Ollama puede bajar a 14B para liberar RAM. LiteLLM maneja esto automáticamente.

### Raspberry Pi (16GB)

| Servicio | RAM | CPU | Cuándo corre |
|----------|-----|-----|-------------|
| PostgreSQL | 2GB | 1 core | Siempre |
| Qdrant | 1GB | 1 core | Siempre |
| Redis | 512MB | 1 core | Siempre |
| Prometheus | 512MB | 1 core | Siempre |
| Grafana | 1GB | 1 core | Siempre |
| N8N | 1GB | 1 core | Bajo demanda |
| Uptime Kuma | 256MB | 0.5 core | Siempre |
| MinIO | 512MB | 0.5 core | Bajo demanda |
| Docker overhead | 1GB | 1 core | Siempre |
| **TOTAL** | **~8GB** | **7 cores** | — |

**Margen de seguridad:** 8GB libres para picos de uso. Suficiente.

---

## COSTOS OPERATIVOS (MENSUALES)

### Cloud APIs (Fallback)

| Servicio | Uso estimado | Costo/mes |
|----------|-------------|-----------|
| Kimi k2.5 API | ~500k tokens | ~$15-25 |
| Claude 3.5 Sonnet | ~200k tokens | ~$10-15 |
| Whisper API | ~10 horas audio | ~$3-5 |
| Gmail/Calendar/Drive API | Gratis (limites altos) | $0 |
| Telegram Bot API | Gratis | $0 |
| **TOTAL CLOUD** | | **~$30-45/mes** |

### Infraestructura

| Componente | Costo | Nota |
|-------------|-------|------|
| Electricidad Mac Studio | ~$10-15/mes | Siempre encendido |
| Electricidad Raspberry Pi | ~$2-3/mes | Mínimo |
| Tailscale | Gratis (hasta 100 dispositivos) | $0 |
| Dominio (opcional) | ~$12/año | Para Caddy/Cloudflare |
| **TOTAL INFRA** | | **~$15-20/mes** |

**Total operativo mensual:** ~$45-65 USD  
**Comparación:** Un asistente humano junior cuesta $1,500-2,500/mes. Un consultor senior $5,000+/mes.  
**ROI:** Se paga solo si ahorra 2-3 horas de trabajo humano al mes.

---

## CHECKLIST DE IMPLEMENTACIÓN

### Semana 1: Fundación
- [ ] Instalar stack base en Mac Studio (Ollama, Python, Node)
- [ ] Instalar Docker Compose en Raspberry Pi
- [ ] Configurar Tailscale VPN entre ambas máquinas
- [ ] Levantar PostgreSQL + Qdrant + Redis en Raspberry Pi
- [ ] Verificar conectividad: Mac → Raspberry Pi (PostgreSQL)

### Semana 2: Core AI
- [ ] Descargar modelos Ollama (32B, 14B, embeddings)
- [ ] Configurar LiteLLM proxy con fallback a Kimi
- [ ] Implementar FastAPI básico con endpoints /query, /health
- [ ] Integrar Qdrant (búsqueda vectorial) vía LangChain
- [ ] Prueba end-to-end: consulta → contexto → respuesta

### Semana 3: Google Integration
- [ ] Configurar OAuth2 para Gmail, Calendar, Drive
- [ ] Implementar sync daemon (lectura periódica)
- [ ] Indexar documentos de Drive en Qdrant
- [ ] Configurar N8N para flujos simples (email → alerta)

### Semana 4: Proactividad
- [ ] Implementar Telegram bot con comandos
- [ ] Configurar alertas proactivas (reuniones, deadlines)
- [ ] Configurar Grafana dashboards
- [ ] Configurar Uptime Kuma health checks
- [ ] Documentar todo en GitHub

### Mes 2: Refinamiento
- [ ] Implementar memoria conversacional (Redis sessions)
- [ ] Implementar feedback loop (thumbs up/down)
- [ ] Ajustar prompts para consultoría específica
- [ ] Optimizar chunking de documentos legales
- [ ] Test de estrés: 100 consultas concurrentes

---

## VEREDICTO FINAL

### ✅ LO QUE SÍ PUEDES HACER

| Objetivo | Nivel | Limitación |
|----------|-------|-----------|
| Consultoría proyectos | 8/10 | Respuestas en 10-15s. No supera a un experto humano, pero es competente. |
| Desarrollo productos (código) | 7/10 | 70% del trabajo de un junior. Necesita revisión senior para arquitectura. |
| Gestión Google proactiva | 8/10 | Alertas, resúmenes, preparación de reuniones. Funciona bien. |
| Privacidad total | 10/10 | Todo local excepto fallback opcional a Kimi/Claude. |
| Costo operativo | 9/10 | ~$50/mes vs $5,000+ asesor humano. |

### ❌ LO QUE NO PUEDES HACER (con este hardware)

| Limitación | Por qué | Alternativa |
|------------|---------|-------------|
| Modelos >70B | 32GB RAM insuficiente | Usar Kimi/Claude API para tareas complejas |
| Transcripción tiempo real | Whisper en M1 no es tiempo real | Whisper API (cloud) para reuniones largas |
| Entrenamiento de modelos | Necesita GPU dedicada + semanas | No entrenes. Usa fine-tuning via API si es necesario. |
| Procesamiento de video | Sin GPU CUDA/ROCm | No aplica a consultoría. |
| Múltiples usuarios simultáneos | 32B ocupa toda la RAM | Cola de requests, respuestas en serie. |

### 🟡 LO QUE ES DIFÍCIL PERO POSIBLE

| Desafío | Solución |
|---------|----------|
| Alucinaciones en respuestas jurídicas | RAG estricto + prompts con fallback + validación humana obligatoria |
| Latencia de 15s en consultas | Cache Redis + respuestas pre-computadas para FAQs |
| Modelo no sabe de proyectos nuevos | Re-ingesta automática cada N horas + cache TTL corto |
| Google OAuth expira cada 7 días | Refresh automático + alerta si falla |

---

**Fecha:** 2026-05-20  
**Autor:** ZEUS AI Architecture Studio  
**Licencia:** PROPIEDAD INTELECTUAL DE INNOVADATACO  

> "La diferencia entre una fantasía y un sistema es que el sistema tiene limitaciones conocidas y un plan para mitigarlas."
> — ZEUS
