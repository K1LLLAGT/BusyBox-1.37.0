#!/bin/bash
# menuconfig_patch.sh — Adds custom Config.in to BusyBox tree

set -e

TOP_CONFIG="busybox-1.36.1/Config.in"
CUSTOM_CONFIG="custom/Config.in"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Patching BusyBox Config.in 🧩"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if ! grep -q "$CUSTOM_CONFIG" "$TOP_CONFIG"; then
  echo "source \"$CUSTOM_CONFIG\"" >> "$TOP_CONFIG"
  echo "✓ Patched $TOP_CONFIG with $CUSTOM_CONFIG"
else
  echo "✓ Already patched"
fi
