#!/bin/bash
# install.sh — Installs BusyBox tools with path-aware config and dashboard generation

set -e

PATH_TO_ROOTFS="$HOME/rootfs"
ROOTFS="$PATH_TO_ROOTFS"
INDEX_HTML="$ROOTFS/index.html"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Installer 🛠️"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[install] Root path: $PATH_TO_ROOTFS"
echo "[install] RootFS mount: $ROOTFS"
echo "[install] Permissions: 0755"
echo "[install] Dashboard: $INDEX_HTML"

mkdir -p "$ROOTFS"
chmod 0755 "$ROOTFS"

# Copy binaries
cp busybox "$ROOTFS/busybox"
ln -sf busybox "$ROOTFS/su"
ln -sf busybox "$ROOTFS/sudo"

# Generate dashboard
echo "<html><body><h1>BusyBox Dashboard</h1><ul>" > "$INDEX_HTML"
for bin in "$ROOTFS"/*; do
  echo "<li><a href=\"$(basename "$bin")\">$(basename "$bin")</a></li>" >> "$INDEX_HTML"
done
echo "</ul></body></html>" >> "$INDEX_HTML"
