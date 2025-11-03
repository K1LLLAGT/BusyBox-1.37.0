!/bin/bash
# install_apk.sh — Installs BusyBox Wrapper APK with narration and dashboard export

set -e

APK_PATH="BusyBox.apk"
PACKAGE_NAME="com.greg.busybox_1361"
DASHBOARD="install-apk-report.txt"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Wrapper APK Installer"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[install_apk] APK path: $APK_PATH"
echo "[install_apk] Package name: $PACKAGE_NAME"

# ┌─────────────────────────────────────────────┐
# │           Validate APK                      │
# └─────────────────────────────────────────────┘
if [ ! -f "$APK_PATH" ]; then
  echo "❌ APK not found: $APK_PATH"
  exit 1
fi

# ┌─────────────────────────────────────────────┐
# │           Install APK                       │
# └─────────────────────────────────────────────┘
echo "[install_apk] Installing APK..."
pm install -r "$APK_PATH" || { echo "❌ Install failed"; exit 1; }

# ┌─────────────────────────────────────────────┐
# │           Validate Installation             │
# └─────────────────────────────────────────────┘
echo "[install_apk] Verifying install..."
pm list packages | grep "$PACKAGE_NAME" >/dev/null || { echo "❌ Package not found after install"; exit 1; }

# ┌─────────────────────────────────────────────┐
# │           Export Dashboard                  │
# └─────────────────────────────────────────────┘
{
  echo "BusyBox APK Install Report"
  echo "---------------------------"
  echo "Package name: $PACKAGE_NAME"
  echo "APK path: $APK_PATH"
  echo "Install status: success"
  echo "Timestamp: $(date)"
} > "$DASHBOARD"

echo "✓ APK installed successfully"
echo "✓ Dashboard exported to: $DASHBOARD"
