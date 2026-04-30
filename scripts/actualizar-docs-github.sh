#!/bin/bash
# Script para actualizar los documentos PM2 en GitHub

TOKEN="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"
REPO="Innovadataco/IDC_2026_01"
BRANCH="master"

echo "🚀 Actualizando documentos PM2 en GitHub..."
echo ""

# Función para actualizar un archivo
update_file() {
    local file=$1
    local name=$2
    
    echo "📄 Actualizando: $name"
    
    # Obtener SHA actual
    SHA=$(curl -s -H "Authorization: token $TOKEN" \
        "https://api.github.com/repos/$REPO/contents/$name?ref=$BRANCH" | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
    
    # Codificar contenido
    CONTENT=$(base64 -w0 "$file")
    
    # Actualizar archivo
    curl -s -X PUT \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO/contents/$name" \
        -d "{\"message\":\"Actualizar $name con nombre oficial ZEUS - Agente IA InnovaDataCo\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" | grep -q '"content"' && echo "✅ $name actualizado" || echo "❌ Error en $name"
}

# Actualizar cada archivo
update_file "/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/01-ACTA-CONSTITUCION.md" "01-ACTA-CONSTITUCION.md"
sleep 1
update_file "/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/02-CRONOGRAMA-GANTT.md" "02-CRONOGRAMA-GANTT.md"
sleep 1
update_file "/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/03-REGISTRO-RIESGOS.md" "03-REGISTRO-RIESGOS.md"
sleep 1
update_file "/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/04-MATRIZ-STAKEHOLDERS.md" "04-MATRIZ-STAKEHOLDERS.md"
sleep 1
update_file "/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/05-PLAN-COMUNICACIONES.md" "05-PLAN-COMUNICACIONES.md"

echo ""
echo "✅ Proceso completado!"
