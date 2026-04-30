#!/bin/bash

TOKEN="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"
SOURCE_REPO="Innovadataco/APP-CHIA-GIRARDOT"
DEST_REPO="Innovadataco/IDC_2026_01"
BRANCH="master"

echo "📤 Copiando fichas CC entre repositorios..."
echo "Origen: $SOURCE_REPO/Fichas ITS/"
echo "Destino: $DEST_REPO/CC-FICHAS/"
echo ""

# Lista de fichas a copiar
FICHAS=(
  "CC-06.md" "CC-07.md" "CC-08.md" "CC-09.md" "CC-10.md"
  "CC-11.md" "CC-12.md" "CC-13.md" "CC-14.md" "CC-15.md"
  "CC-16.md" "CC-17.md" "CC-18.md" "CC-19.md" "CC-20.md"
  "CC-21.md" "CC-22.md" "CC-23.md" "CC-24.md" "CC-25.md"
  "CC-26.md" "CC-27.md" "CC-28.md" "CC-29.md" "CC-30.md"
  "CC-31.md" "CC-32.md" "CC-33.md" "CC-34.md" "CC-35.md"
  "CC-36.md" "CC-37.md" "CC-38.md" "CC-39.md" "CC-40.md"
  "CC-41.md" "CC-42.md"
)

TOTAL=${#FICHAS[@]}
echo "Total fichas a copiar: $TOTAL"
echo ""

COUNT=0
for fichero in "${FICHAS[@]}"; do
  COUNT=$((COUNT + 1))
  echo "[$COUNT/$TOTAL] Copiando: $fichero"
  
  # Descargar contenido del repo origen
  CONTENT=$(curl -s "https://raw.githubusercontent.com/$SOURCE_REPO/main/Fichas%20ITS/$fichero" | base64 -w0)
  
  if [ -z "$CONTENT" ] || [ "$CONTENT" == "null" ]; then
    echo "  ⚠️ No se pudo descargar"
    continue
  fi
  
  # Verificar si existe en destino
  SHA=$(curl -s -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$DEST_REPO/contents/CC-FICHAS/$fichero?ref=$BRANCH" 2>/dev/null | grep -o '"sha": "[^"]*"' | head -1 | cut -d'"' -f4)
  
  if [ -n "$SHA" ]; then
    # Actualizar
    curl -s -X PUT \
      -H "Authorization: token $TOKEN" \
      -H "Accept: application/vnd.github.v3+json" \
      "https://api.github.com/repos/$DEST_REPO/contents/CC-FICHAS/$fichero" \
      -d "{\"message\":\"Actualizar $fichero desde APP-CHIA-GIRARDOT\",\"content\":\"$CONTENT\",\"sha\":\"$SHA\",\"branch\":\"$BRANCH\"}" > /dev/null
    echo "  ✅ Actualizado"
  else
    # Crear nuevo
    curl -s -X PUT \
      -H "Authorization: token $TOKEN" \
      -H "Accept: application/vnd.github.v3+json" \
      "https://api.github.com/repos/$DEST_REPO/contents/CC-FICHAS/$fichero" \
      -d "{\"message\":\"Agregar $fichero desde APP-CHIA-GIRARDOT\",\"content\":\"$CONTENT\",\"branch\":\"$BRANCH\"}" > /dev/null
    echo "  ✅ Copiado"
  fi
  
  sleep 0.5
done

echo ""
echo "═══════════════════════════════════════════════════"
echo "✅ Copia completada"
echo "═══════════════════════════════════════════════════"
echo ""
echo "📂 Destino final:"
echo "https://github.com/Innovadataco/IDC_2026_01/tree/master/CC-FICHAS/"
