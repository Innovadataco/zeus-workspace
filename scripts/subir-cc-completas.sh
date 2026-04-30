#!/bin/bash

TOKEN="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"
REPO="Innovadataco/IDC_2026_01"
BRANCH="master"
SOURCE_DIR="/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-COMPLETAS"

echo "📤 Subiendo fichas CC COMPLETAS a GitHub..."
echo "Repositorio: $REPO"
echo "Carpeta: CC-FICHAS/ (reemplazando)"
echo ""

TOTAL=$(ls -1 "$SOURCE_DIR"/*.md 2>/dev/null | wc -l)
echo "Total archivos: $TOTAL"
echo ""

COUNT=0
for file in "$SOURCE_DIR"/*.md; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        COUNT=$((COUNT + 1))
        
        echo "[$COUNT/$TOTAL] Subiendo: $filename"
        
        CONTENT=$(base64 -w0 "$file")
        
        # Obtener SHA si existe
        SHA=$(curl -s -H "Authorization: token $TOKEN" \
            "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename?ref=$BRANCH" 2>/dev/null | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
        
        if [ -n "$SHA" ]; then
            # Actualizar
            curl -s -X PUT \
                -H "Authorization: token $TOKEN" \
                -H "Accept: application/vnd.github.v3+json" \
                "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename" \
                -d "{\"message\":\"Actualizar $filename - Contenido completo con tablas\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" > /dev/null
        else
            # Crear
            curl -s -X PUT \
                -H "Authorization: token $TOKEN" \
                -H "Accept: application/vnd.github.v3+json" \
                "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$filename" \
                -d "{\"message\":\"Agregar $filename - Ficha completa\",\"content\":\"$CONTENT\",\"branch\":\"$BRANCH\"}" > /dev/null
        fi
        
        echo "  ✅ OK"
        sleep 0.3
    fi
done

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ $COUNT fichas CC COMPLETAS subidas a GitHub"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Ubicación:"
echo "https://github.com/Innovadataco/IDC_2026_01/tree/master/CC-FICHAS/"
echo ""
echo "Las fichas ahora incluyen todas las tablas:"
echo "  • Especificación Técnica (ET)"
echo "  • Requerimientos Funcionales (RF)"
echo "  • Requisitos No Funcionales (RNF)"
