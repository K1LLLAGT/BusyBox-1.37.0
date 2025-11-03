#!/bin/bash
# extract_packages.sh — Extracts and documents packages from firmware tarball

TAR_FILE="SAMFW.COM_SM-S928U_CCT_S928USQU4CYI9_fac.tar"
OUTPUT_MD="/sdcard/packages-info.md"

mkdir -p /tmp/extract
tar -xf "$TAR_FILE" -C /tmp/extract

echo "# Extracted Packages\n" > "$OUTPUT_MD"
find /tmp/extract -type f | while read -r file; do
  echo "- $(basename "$file")" >> "$OUTPUT_MD"
done

echo "✓ Package info written to $OUTPUT_MD"
