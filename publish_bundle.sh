#!/bin/bash
# publish_bundle.sh — Publishes BusyBox documentation bundle and generates a QR code for sharing

set -e

BUNDLE="busybox-docs.zip"
DEST="$HOME/Download"
DRY_RUN=false

for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
  [[ "$arg" == "--bundle="* ]] && BUNDLE="${arg#--bundle=}"
  [[ "$arg" == "--dest="* ]] && DEST="${arg#--dest=}"
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Publishing BusyBox Bundle"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[publish] Dry-run mode: $DRY_RUN"
echo "[publish] Bundle: $BUNDLE"
echo "[publish] Destination: $DEST"

if [ ! -f "$BUNDLE" ]; then
  echo "❌ Bundle not found: $BUNDLE"
  exit 1
fi

if [ "$DRY_RUN" = true ]; then
  echo "[publish] Dry-run complete. No files moved or QR generated."
  exit 0
fi

mkdir -p "$DEST"
cp "$BUNDLE" "$DEST/"
echo "✓ Bundle published to: $DEST/$BUNDLE"

# ┌─────────────────────────────────────────────┐
# │           Generate QR Code                  │
# └─────────────────────────────────────────────┘
QR_PATH="$DEST/qr-busybox-docs.png"
QR_TEXT="file://$DEST/$BUNDLE"

if command -v qrencode >/dev/null; then
  qrencode -o "$QR_PATH" "$QR_TEXT"
  echo "✓ QR code generated: $QR_PATH"
  echo "Scan to download: $QR_TEXT"
else
  echo "⚠️ qrencode not found. Install with: pkg install qrencode"
fi
