#!/bin/bash
# extract-packages.sh — Extracts and documents packages from firmware tarball

set -e

TAR_FILE="/sdcard/Download/SAMFW.COM_SM-S928U_CCT_S928USQU4CYI9_fac.tar"
OUTPUT_DIR="$HOME/SAMFW.COM_SM-S928U_CCT_S928USQU4CYI9_fac"
OUTPUT_MD="$OUTPUT_DIR/README.md"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Firmware Package Extractor 📦"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[extract] Tarball: $TAR_FILE"
echo "[extract] Output directory: $OUTPUT_DIR"
echo "[extract] Markdown: $OUTPUT_MD"

mkdir -p "$OUTPUT_DIR"
tar -xf "$TAR_FILE" -C "$OUTPUT_DIR"

echo "# Extracted Packages\n" > "$OUTPUT_MD"
find "$OUTPUT_DIR" -type f | while read -r file; do
  echo "- $(basename "$file")" >> "$OUTPUT_MD"
done

echo "✓ Package info written to $OUTPUT_MD"
