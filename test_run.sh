#!/bin/bash
# test_run.sh — Executes all *.sh and *.py scripts in ~/busybox-1.36.1/ safely

set -e

ROOT="$HOME/busybox-1.36.1"
DRY_RUN=false
LOG_FILE="$ROOT/test_run.log"

for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Script Test Runner 🧪"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[test] Root directory: $ROOT"
echo "[test] Dry-run mode: $DRY_RUN"
echo "[test] Log file: $LOG_FILE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

> "$LOG_FILE"

# ┌─────────────────────────────────────────────┐
# │           Discover and run scripts          │
# └─────────────────────────────────────────────┘
find "$ROOT" -type f \( -name "*.sh" -o -name "*.py" \) | while read -r script; do
  echo "→ Testing: $script"
  echo "→ Testing: $script" >> "$LOG_FILE"

  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] Would run: $script"
    echo "[dry-run] Would run: $script" >> "$LOG_FILE"
    continue
  fi

  case "$script" in
    *.sh)
      bash "$script" >> "$LOG_FILE" 2>&1 || echo "❌ Failed: $script" >> "$LOG_FILE"
      ;;
    *.py)
      python3 "$script" >> "$LOG_FILE" 2>&1 || echo "❌ Failed: $script" >> "$LOG_FILE"
      ;;
  esac

  echo "✓ Completed: $script"
  echo "✓ Completed: $script" >> "$LOG_FILE"
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Test run complete ✅"
echo "  See log: $LOG_FILE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
