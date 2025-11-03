#!/bin/bash
# generate_index.sh — Generates HTML index of BusyBox applets

set -e

OUT="index.html"
BIN_DIR="./modules/system/xbin"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Generating BusyBox Applet Index 📦"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

echo "<html><body><h1>BusyBox Applets</h1><ul>" > "$OUT"
for bin in "$BIN_DIR"/*; do
  echo "<li><code>$(basename "$bin")</code></li>" >> "$OUT"
done
echo "</ul></body></html>" >> "$OUT"

echo "✓ Generated $OUT"
