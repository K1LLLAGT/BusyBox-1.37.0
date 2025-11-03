#!/data/data/com.termux/files/usr/bin/bash
# scaffold_busybox_module.sh — Builds BusyBox module layout with narration and dry-run support

set -e

BUSYBOX_SRC="$PREFIX/bin/busybox"
MODULE_DIR=~/busybox-1.36.1
DASHBOARD="$MODULE_DIR/busybox-scaffold-report.txt"
DRY_RUN=false

for arg in "$@"; do
  [ "$arg" = "--dry-run" ] && DRY_RUN=true
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Module Scaffolding Tool"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[scaffold] Dry-run mode: $DRY_RUN"
echo "[scaffold] Source binary: $BUSYBOX_SRC"
echo "[scaffold] Target module: $MODULE_DIR"

# ┌─────────────────────────────────────────────┐
# │           Directory Layout                  │
# └─────────────────────────────────────────────┘
mkdir -p "$MODULE_DIR"/{system/xbin,META-INF/com/google/android}

# ┌─────────────────────────────────────────────┐
# │           Copy Binary & Set Permissions     │
# └─────────────────────────────────────────────┘
cp "$BUSYBOX_SRC" "$MODULE_DIR/system/xbin/busybox"
chmod 0755 "$MODULE_DIR/system/xbin/busybox"
echo "[scaffold] ✓ BusyBox binary installed"

# ┌─────────────────────────────────────────────┐
# │           Create module.prop                │
# └─────────────────────────────────────────────┘
cat > "$MODULE_DIR/module.prop" <<EOF
id=busybox
name=BusyBox 1.36.1
version=1.36.1
versionCode=1361
author=Greg
description=Full BusyBox suite with validator and dashboard export
EOF
echo "[scaffold] ✓ module.prop created"

# ┌─────────────────────────────────────────────┐
# │           Optional Symlink Setup            │
# └─────────────────────────────────────────────┘
if [ "$DRY_RUN" = false ]; then
  echo "[scaffold] 🧪 Installing applets into module path..."
  "$MODULE_DIR/system/xbin/busybox" --install -s "$MODULE_DIR/system/xbin"
  echo "[scaffold] ✓ Applets symlinked"
else
  echo "[scaffold] 🧪 Dry-run: skipping applet symlinks"
fi

# ┌─────────────────────────────────────────────┐
# │           Export Dashboard                  │
# └─────────────────────────────────────────────┘
VERSION=$("$MODULE_DIR/system/xbin/busybox" | head -1)
APPLET_COUNT=$("$MODULE_DIR/system/xbin/busybox" --list | wc -l)

{
  echo "BusyBox Module Scaffold Report"
  echo "------------------------------"
  echo "Version: $VERSION"
  echo "Applet count: $APPLET_COUNT"
  echo "Symlinks installed: $([ "$DRY_RUN" = false ] && echo yes || echo no)"
  echo "Scaffolded at: $(date)"
} > "$DASHBOARD"

echo "[scaffold] ✅ Dashboard exported to: $DASHBOARD"
echo "[scaffold] ✅ Module scaffold complete!"
