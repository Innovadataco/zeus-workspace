# REGLA DE FLUJO DE TRABAJO - DOCUMENTOS Y ENTREGABLES

**Aplicable a:** TODOS los proyectos (IDC_2026_01, futuros IDC_YYYY_NN)  
**Versión:** 1.0  
**Fecha:** 28 Abril 2026  
**Autoridad:** CEO Jelkin Zair Carrillo Franco  
**Aprobación:** ZEUS, PROCEDE ✅

---

## 📋 PRINCIPIO FUNDAMENTAL

Todo documento o análisis generado por ZEUS debe seguir este flujo:

**BORRADOR → REVISIÓN → APROBACIÓN → PUBLICACIÓN OFICIAL**

---

## 🔄 FLUJO DE TRABAJO ESTÁNDAR

### PASO 1: BORRADOR (GitHub/BORRADORES/)

**Cuándo:**
- Investigaciones de mercado
- Análisis comparativos
- Borradores de entregables (E6, E7, E8, etc.)
- Cualquier documento nuevo

**Ubicación:**
```
GitHub Repo del Proyecto/
└── BORRADORES/
    ├── E6-analisis-camaras-YYYYMMDD.md
    ├── Investigacion-proveedores-YYYYMMDD.md
    └── [nombre-descriptivo-fecha].md
```

**Naming convention:**
- Usar descripción clara
- Incluir fecha: AAAA-MM-DD
- Ejemplo: `E6-analisis-camaras-ITS-2026-04-28.md`

---

### PASO 2: REVISIÓN (por CEO)

**Proceso:**
1. ZEUS sube borrador a GitHub/BORRADORES/
2. ZEUS notifica a CEO vía Telegram
3. CEO revisa en GitHub (puede comentar línea por línea)
4. CEO indica:
   - "ZEUS, PROCEDE" → Aprobar y publicar
   - "Corrige X" → Volver a Paso 1
   - "Descarta" → Eliminar borrador

**Tiempo de respuesta esperado:** 24-48 horas

---

### PASO 3: PUBLICACIÓN OFICIAL (Post-aproBACIÓN)

**Cuándo CEO dice "ZEUS, PROCEDE":**

1. **Mover en GitHub:**
   ```
   BORRADORES/ → ENTREGABLES/
   ```
   - Cambiar nombre a versión final (quitar fecha)
   - Ejemplo: `E6-Analisis-Tecnologias-v1.md`

2. **Subir a Google Drive:**
   ```
   Drive/[PROYECTO]/03-EJECUCION/[ENTREGABLE-X]/
   ```
   - Formato: PDF (para cliente)
   - También: DOCX (editable)
   - También: MD (backup técnico)

---

## 📂 ESTRUCTURA DE REPOSITORIO POR PROYECTO

```
IDC_YYYY_NN/
├── README.md                    ← Información general
├── BORRADORES/                  ← Trabajo en progreso
│   ├── .gitkeep
│   └── README.md                ← "Esta carpeta contiene borradores"
│
├── ENTREGABLES/                 ← Documentos aprobados
│   ├── E1-Diagnostico-ITS/
│   │   └── v1-final.md
│   ├── E2-Analisis-Brechas/
│   │   └── v1-final.md
│   ├── E6-Analisis-Tecnologias/
│   │   ├── v1-final.md
│   │   └── v1-final.pdf
│   └── ...
│
└── PM2/                         ← Gestión del proyecto
    ├── 01-ACTA-CONSTITUCION.md
    ├── 02-CRONOGRAMA-GANTT.md
    ├── 03-REGISTRO-RIESGOS.md
    ├── 04-MATRIZ-STAKEHOLDERS.md
    └── 05-PLAN-COMUNICACIONES.md
```

---

## 📋 CHECKLIST ANTES DE SUBIR BORRADOR

- [ ] Nombre descriptivo con fecha
- [ ] Encabezado con: Proyecto, Fecha, Autor (ZEUS)
- [ ] Estado marcado como: 🟡 BORRADOR - PENDIENTE REVISIÓN
- [ ] Resumen ejecutivo al inicio
- [ ] Notas de fuentes/referencias
- [ ] Preguntas para el CEO (si aplica)

---

## 📋 CHECKLIST POST-APROBACIÓN

- [ ] Mover de BORRADORES/ a ENTREGABLES/
- [ ] Renombrar a versión final (v1, v2, etc.)
- [ ] Actualizar estado a: ✅ APROBADO
- [ ] Subir PDF a Drive (para cliente)
- [ ] Subir DOCX a Drive (editable)
- [ ] Notificar a CEO: "Publicado en [links]"

---

## 🚫 EXCEPCIONES (No aplica flujo)

Estos documentos van DIRECTO a su ubicación final:

1. **Documentos PM2** → GitHub/PM2/ directo
   - Actas, cronogramas, riesgos (gestión interna)

2. **Actualizaciones menores** → GitHub directo
   - Correcciones de typo
   - Actualizaciones de fecha
   - Cambios menores de formato

3. **Emergencias** → Drive directo
   - Cuando CEO solicita "urgente, sin revisión"

---

## 📊 EJEMPLOS DE APLICACIÓN

| Tipo de Trabajo | Ejemplo | Flujo |
|-----------------|---------|-------|
| Investigación mercado | "Análisis cámaras ITS" | BORRADOR → Revisión → ENTREGABLES + Drive |
| Borrador entregable E6 | "E6-analisis-tecnologias" | BORRADORES → Aprobación → ENTREGABLES + Drive |
| Actualización cronograma | Cambiar fecha reunión | Directo a PM2/ (sin revisión) |
| Acta de reunión | Acta Mesa Técnica | Directo a 01-GOBERNANZA/ en Drive |

---

## 🔐 PERMISOS

| Rol | Puede crear en BORRADORES | Puede aprobar | Puede publicar en ENTREGABLES |
|-----|---------------------------|---------------|-------------------------------|
| ZEUS | ✅ Sí | ❌ No | ✅ Solo con "ZEUS, PROCEDE" |
| CEO (Jelkin) | ✅ Sí | ✅ Sí | ✅ Sí |

---

## 📝 NOTAS PARA ZEUS

1. **Siempre** notificar a CEO cuando suba un borrador
2. **Nunca** mover de BORRADORES/ a ENTREGABLES/ sin aprobación explícita
3. **Siempre** mantener sincronización GitHub ↔ Drive para documentos oficiales
4. **Nunca** eliminar borradores rechazados (mover a BORRADORES/ARCHIVADOS/)

---

**Esta regla aplica a todos los proyectos presentes y futuros de Innovadataco.**

---

**Aprobado por:** Jelkin Zair Carrillo Franco, CEO  
**Implementado por:** ZEUS - Agente IA InnovaDataCo  
**Fecha de vigencia:** Desde 28 Abril 2026, indefinido

---

*ZEUS online. La empresa está operando.* ⚡
