#!/bin/bash
# serve_index.sh — Serves index.html from root or dashboards and opens it in browser

set -e

PORT=8080
DRY_RUN=false
ROOT_DIR="$HOME/busybox-1.36.1"
INDEX_HTML=""

for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
  [[ "$arg" == "--port="* ]] && PORT="${arg#--port=}"
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Index Server 🌐"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

cd "$ROOT_DIR"

if [ -f "index.html" ]; then
  INDEX_HTML="index.html"
elif [ -f "dashboards/index.html" ]; then
  INDEX_HTML="dashboards/index.html"
else
  echo "❌ No index.html found in root or dashboards/"
  exit 1
fi

echo "[serve] Dry-run mode: $DRY_RUN"
echo "[serve] Port: $PORT"
echo "[serve] File: $INDEX_HTML"

if [ "$DRY_RUN" = true ]; then
  echo "[serve] Dry-run complete. No server launched."
  exit 0
fi

URL="http://localhost:$PORT/$INDEX_HTML"
echo "✓ Starting server at $URL"

if command -v termux-open-url >/dev/null 2>&1; then
  termux-open-url "$URL" >/dev/null 2>&1 &
else
  xdg-open "$URL" >/dev/null 2>&1 &
fi

python3 -m http.server "$PORT"
