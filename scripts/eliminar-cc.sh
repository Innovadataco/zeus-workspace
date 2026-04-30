#!/bin/bash

TOKEN="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"
REPO="Innovadataco/IDC_2026_01"
BRANCH="master"

echo "🗑️ Eliminando fichas CC..."
echo ""

# Obtener lista de archivos en CC-FICHAS
ARCHIVOS=$(curl -s -H "Authorization: token $TOKEN" \
  "https://api.github.com/repos/$REPO/contents/CC-FICHAS?ref=$BRANCH" 2>/dev/null | grep -o '"name": "[^"]*\.md"' | cut -d'"' -f4)

TOTAL=$(echo "$ARCHIVOS" | wc -l)
echo "Total a eliminar: $TOTAL"
echo ""

COUNT=0
for archivo in $ARCHIVOS; do
  COUNT=$((COUNT + 1))
  echo "[$COUNT/$TOTAL] Eliminando: $archivo"
  
  # Obtener SHA
  SHA=$(curl -s -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$archivo?ref=$BRANCH" 2>/dev/null | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
  
  if [ -n "$SHA" ]; then
    curl -s -X DELETE \
      -H "Authorization: token $TOKEN" \
      -H "Accept: application/vnd.github.v3+json" \
      "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$archivo" \
      -d "{\"message\":\"Eliminar $archivo - Contenido incorrecto\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" > /dev/null
    echo "  ✅ Eliminado"
  fi
  sleep 0.3
done

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ Todas las fichas CC eliminadas"
echo "═══════════════════════════════════════════════════"
