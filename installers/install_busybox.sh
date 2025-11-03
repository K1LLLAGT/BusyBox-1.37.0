#!/data/data/com.termux/files/usr/bin/bash
# install_busybox.sh — Extracts, validates, and dashboards BusyBox from assets/

set -e

ASSET_PATH="./assets/busybox"
TARGET_PATH="$HOME/.local/bin/busybox"
DASHBOARD="$HOME/Download/busybox-wrapper-report.txt"
DRY_RUN=false

# ┌─────────────────────────────────────────────┐
# │           Parse Flags                       │
# └─────────────────────────────────────────────┘
for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

# ┌─────────────────────────────────────────────┐
# │           Narration                         │
# └─────────────────────────────────────────────┘
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Wrapper Installer (Bash)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[install_busybox] Asset: $ASSET_PATH"
echo "[install_busybox] Target: $TARGET_PATH"
echo "[install_busybox] Dashboard: $DASHBOARD"
echo "[install_busybox] Dry-run mode: $DRY_RUN"

# ┌─────────────────────────────────────────────┐
# │           Dry-run Mode                      │
# └─────────────────────────────────────────────┘
if [ "$DRY_RUN" = true ]; then
  echo "[install_busybox] Dry-run: no install performed"
  exit 0
fi

# ┌─────────────────────────────────────────────┐
# │           Install BusyBox                   │
# └─────────────────────────────────────────────┘
echo "BusyBox is a multi-call binary that provides 300+ Unix tools in one executable."
echo "Installing to: $TARGET_PATH"

mkdir -p "$(dirname "$TARGET_PATH")"
cp "$ASSET_PATH" "$TARGET_PATH"
chmod 0755 "$TARGET_PATH"

# ┌─────────────────────────────────────────────┐
# │           Validate and Export Dashboard     │
# └─────────────────────────────────────────────┘
VERSION=$("$TARGET_PATH" | head -1)
APPLET_COUNT=$("$TARGET_PATH" --list | wc -l)

{
  echo "BusyBox Wrapper Report"
  echo "----------------------"
  echo "Version: $VERSION"
  echo "Applets: $APPLET_COUNT"
  echo "Installed at: $TARGET_PATH"
  echo "Timestamp: $(date)"
} > "$DASHBOARD"

if grep -q "Applets:" "$DASHBOARD"; then
  echo "✓ Dashboard validated"
else
  echo "❌ Dashboard missing applet count"
fi

echo "✓ Dashboard exported to: $DASHBOARD"

# ┌─────────────────────────────────────────────┐
# │           Applet Test Loop                  │
# └─────────────────────────────────────────────┘
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Applet Test (type 'exit' to skip)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
while true; do
  read -p "test applet> " CMD
  [ "$CMD" = "exit" ] && break
  "$TARGET_PATH" $CMD || echo "❌ Applet failed"
done
