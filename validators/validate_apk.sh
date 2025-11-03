!/bin/bash
# validate_apk.sh — Validates BusyBox Wrapper APK installation and dashboard export

set -e

PACKAGE_NAME="com.greg.busybox_1361"
DASHBOARD_PATH="$HOME/Download/busybox-wrapper-report.txt"
VALIDATION_REPORT="validate-apk-report.txt"
VERBOSE=false
DRY_RUN=false

for arg in "$@"; do
  [[ "$arg" == "--verbose" ]] && VERBOSE=true
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Wrapper APK Validator"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[validate_apk] Package name: $PACKAGE_NAME"
echo "[validate_apk] Dashboard path: $DASHBOARD_PATH"
echo "[validate_apk] Dry-run mode: $DRY_RUN"
echo "[validate_apk] Verbose mode: $VERBOSE"

if [ "$DRY_RUN" = true ]; then
  echo "[validate_apk] Dry-run: no validation performed"
  exit 0
fi

if pm list packages | grep "$PACKAGE_NAME" >/dev/null; then
  echo "✓ Package is installed"
  INSTALL_STATUS="installed"
else
  echo "❌ Package not found"
  INSTALL_STATUS="missing"
fi

if [ -f "$DASHBOARD_PATH" ]; then
  echo "✓ Dashboard file found"
  DASHBOARD_STATUS="present"
  VERSION=$(grep "Version:" "$DASHBOARD_PATH" | cut -d':' -f2- | xargs)
  APPLET_COUNT=$(grep "Applets:" "$DASHBOARD_PATH" | cut -d':' -f2 | xargs)
  INSTALL_PATH=$(grep "Installed at:" "$DASHBOARD_PATH" | cut -d':' -f2- | xargs)
else
  echo "❌ Dashboard file missing"
  DASHBOARD_STATUS="missing"
  VERSION="N/A"
  APPLET_COUNT="N/A"
  INSTALL_PATH="N/A"
fi

if [ "$VERBOSE" = true ]; then
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Dashboard Summary"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "Version:       $VERSION"
  echo "Applets:       $APPLET_COUNT"
  echo "Install path:  $INSTALL_PATH"
fi

{
  echo "BusyBox APK Validation Report"
  echo "-----------------------------"
  echo "Package name: $PACKAGE_NAME"
  echo "Install status: $INSTALL_STATUS"
  echo "Dashboard status: $DASHBOARD_STATUS"
  echo "Version: $VERSION"
  echo "Applets: $APPLET_COUNT"
  echo "Install path: $INSTALL_PATH"
  echo "Timestamp: $(date)"
} > "$VALIDATION_REPORT"

echo "✓ Validation report exported to: $VALIDATION_REPORT"
