#!/bin/bash
# serve_bundle.sh — Extracts and serves a bundle with index.html

set -e

BUNDLE="$1"
PORT=8080
PREVIEW_DIR="/tmp/bundle_preview"

if [ -z "$BUNDLE" ]; then
  echo "❌ Usage: serve_bundle.sh <bundle.zip|bundle.tar>"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Serving Bundle Preview 🌐"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

rm -rf "$PREVIEW_DIR"
mkdir -p "$PREVIEW_DIR"

case "$BUNDLE" in
  *.zip) unzip "$BUNDLE" -d "$PREVIEW_DIR" ;;
  *.tar) tar -xf "$BUNDLE" -C "$PREVIEW_DIR" ;;
  *) echo "❌ Unsupported bundle format"; exit 1 ;;
esac

cd "$PREVIEW_DIR"

if [ ! -f "index.html" ]; then
  echo "❌ No index.html found in bundle"
  exit 1
fi

URL="http://localhost:$PORT/index.html"
echo "✓ Serving $BUNDLE at $URL"

if command -v termux-open-url >/dev/null 2>&1; then
  termux-open-url "$URL" >/dev/null 2>&1 &
else
  xdg-open "$URL" >/dev/null 2>&1 &
fi

python3 -m http.server "$PORT"
