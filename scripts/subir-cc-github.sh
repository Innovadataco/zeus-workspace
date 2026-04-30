#!/bin/bash

TOKEN="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"
REPO="Innovadataco/IDC_2026_01"
BRANCH="master"
SOURCE_DIR="/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-REALES"

echo "📤 Subiendo fichas CC a GitHub..."
echo "Repositorio: $REPO"
echo "Carpeta: CC-FICHAS/"
echo ""

# Crear carpeta CC-FICHAS en GitHub si no existe
mkdir -p "$SOURCE_DIR"

# Contar archivos
TOTAL=$(ls -1 "$SOURCE_DIR"/*.md 2>/dev/null | wc -l)
echo "Total archivos: $TOTAL"
echo ""

# Subir cada archivo
COUNT=0
for file in "$SOURCE_DIR"/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        COUNT=$((COUNT + 1))
        
        echo "[$COUNT/$TOTAL] Subiendo: $filename"
        
        # Codificar contenido
        CONTENT=$(base64 -w0 "$file")
        
        # Verificar si existe
        SHA=$(curl -s -H "Authorization: token $TOKEN" \
            "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename?ref=$BRANCH" 2>/dev/null | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
        
        if [ -n "$SHA" ]; then
            # Actualizar
            curl -s -X PUT \
                -H "Authorization: token $TOKEN" \
                -H "Accept: application/vnd.github.v3+json" \
                "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename" \
                -d "{\"message\":\"Actualizar $filename\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" > /dev/null
        else
            # Crear nuevo
            curl -s -X PUT \
                -H "Authorization: token $TOKEN" \
                -H "Accept: application/vnd.github.v3+json" \
                "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename" \
                -d "{\"message\":\"Agregar $filename - Ficha Técnica CC\",\"content\":\"$CONTENT\",\"branch\":\"$BRANCH\"}" > /dev/null
        fi
        
        echo "  ✅ OK"
        sleep 0.5
    fi
done

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ $COUNT fichas CC subidas a GitHub"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Ubicación:"
echo "https://github.com/Innovadataco/IDC_2026_01/tree/master/CC-FICHAS/"
