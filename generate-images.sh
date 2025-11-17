#!/usr/bin/env bash

set -e

# -------------------------------------------------------
#  MegaPet Image Generator
#  Auto-detects ImageMagick (magick or convert)
# -------------------------------------------------------

# Detect ImageMagick command
if command -v magick &> /dev/null; then
  IM="magick"
elif command -v convert &> /dev/null; then
  IM="convert"
else
  echo "❌ ImageMagick not found."
  echo "Install with: sudo apt install imagemagick"
  exit 1
fi

echo "🔧 Using ImageMagick command: $IM"
echo "🔧 Starting image generation..."

# Loop over all *.1920.webp source images
for src in *.1920.webp; do
  [ -e "$src" ] || continue  # skip if no matches

  base="${src%.1920.webp}"

  echo "📸 Processing: $src"

  # High resolution (desktop)
  out_high="${base}.1600.webp"
  $IM "$src" -resize 1600x -quality 85 "$out_high"
  echo "  → Created: $out_high"

  # Medium resolution (tablet)
  out_medium="${base}.1280.webp"
  $IM "$src" -resize 1280x -quality 82 "$out_medium"
  echo "  → Created: $out_medium"

  # Low resolution (mobile)
  out_low="${base}.800.webp"
  $IM "$src" -resize 800x -quality 80 "$out_low"
  echo "  → Created: $out_low"

  # Tiny preview
  out_thumb="${base}.400.webp"
  $IM "$src" -resize 400x -quality 75 "$out_thumb"
  echo "  → Created: $out_thumb"

  echo ""
done

echo "🎉 Done! Images generated successfully."

