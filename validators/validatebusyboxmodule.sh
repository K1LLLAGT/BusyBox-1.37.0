#!/system/bin/sh
# validate_busybox_module.sh
# Contributor-safe BusyBox module validator with dashboard export

MODROOT="/data/adb/modules"
MODID=$(ls "$MODROOT" | grep -i busybox | head -1)
MODPATH="$MODROOT/$MODID"
BUSYBOX="$MODPATH/system/xbin/busybox"
DASHBOARD="/sdcard/Download/busybox-validation-report.txt"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Module Validation Report"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Check binary
if [ ! -x "$BUSYBOX" ]; then
  echo "❌ BusyBox binary not found at $BUSYBOX"
  echo "Check if the module is installed and enabled in Magisk."
  exit 1
fi

# Version
VERSION=$($BUSYBOX | head -1)
echo "✓ Version: $VERSION"

# Applet count
APPLET_COUNT=$($BUSYBOX --list | wc -l)
echo "✓ Applets available: $APPLET_COUNT"

# Symlink check
SYMLINK_DIR="/system/xbin"
LINKED=$(
  find "$SYMLINK_DIR" -type l -exec ls -l {} \; 2>/dev/null | grep "$MODID/system/xbin/busybox" | wc -l
)
echo "✓ Symlinks in $SYMLINK_DIR: $LINKED"

# Export dashboard
{
  echo "BusyBox Validation Report"
  echo "--------------------------"
  echo "Module ID: $MODID"
  echo "Version: $VERSION"
  echo "Applet count: $APPLET_COUNT"
  echo "Symlinks in $SYMLINK_DIR: $LINKED"
  echo "Validated at: $(date)"
} > "$DASHBOARD"

echo "✓ Dashboard exported to: $DASHBOARD"
echo "✓ Validation complete!"
