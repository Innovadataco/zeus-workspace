#!/bin/bash

TOKEN="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"
REPO="Innovadataco/IDC_2026_01"
BRANCH="master"
SOURCE_DIR="/root/.openclaw/workspace/ZEUS-CONFIG/PM2-DOCUMENTOS/CC-FICHAS-COMPLETAS"

echo "📤 Subiendo CC-01 a CC-05..."
echo ""

FICHAS=(
  "CC-01-CCTV--Sistema-de-Videovigilancia-.md"
  "CC-02-AID--Detecci-n-de-Incidentes-.md"
  "CC-03-DMS-VMS--Sistema-de-Mensajer-a-Variable-.md"
  "CC-04-ECS-SOS--Sistema-de-Llamada-de-Emergenci.md"
  "CC-05-VDS-TDS--Sistema-de-Detecci-n-de-Tr-fico.md"
)

for fichero in "${FICHAS[@]}"; do
  # Extraer número CC
  ccnum=$(echo "$fichero" | grep -o 'CC-[0-9]*')
  nuevo_nombre="${ccnum}.md"
  
  echo "Subiendo: $ccnum"
  
  if [ -f "$SOURCE_DIR/$fichero" ]; then
    CONTENT=$(base64 -w0 "$SOURCE_DIR/$fichero")
    
    # Verificar si existe
    SHA=$(curl -s -H "Authorization: token $TOKEN" \
      "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$nuevo_nombre?ref=$BRANCH" 2>/dev/null | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
    
    if [ -n "$SHA" ]; then
      curl -s -X PUT \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$nuevo_nombre" \
        -d "{\"message\":\"Agregar $nuevo_nombre\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" > /dev/null
    else
      curl -s -X PUT \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        "https://api.github.com/repos/$REPO/contents/CC-FICHAS/$nuevo_nombre" \
        -d "{\"message\":\"Agregar $nuevo_nombre\",\"content\":\"$CONTENT\",\"branch\":\"$BRANCH\"}" > /dev/null
    fi
    echo "  ✅ $nuevo_nombre subido"
  else
    echo "  ❌ No encontrado: $fichero"
  fi
  sleep 0.5
done

echo ""
echo "✅ CC-01 a CC-05 subidos"
