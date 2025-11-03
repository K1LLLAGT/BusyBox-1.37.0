#!/bin/bash
# generate_readme.sh — Builds a contributor-safe README from modular BusyBox layout

set -e

DRY_RUN=false
README="README.md"

for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Generating BusyBox README"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[readme] Dry-run mode: $DRY_RUN"
echo "[readme] Output file: $README"

# ┌─────────────────────────────────────────────┐
# │           Helper: Describe Files            │
# └─────────────────────────────────────────────┘
describe_file() {
  local file="$1"
  case "$file" in
    build_apk.sh) echo "- Builds and signs the BusyBox wrapper APK" ;;
    install_apk.sh) echo "- Installs the signed APK and validates install path" ;;
    install_busybox.sh|install_busybox.py) echo "- Installs BusyBox binary and exports dashboard" ;;
    busybox_wrapper.sh|busybox_wrapper.py) echo "- Launches BusyBox with optional applet test loop" ;;
    validate_apk.sh) echo "- Validates APK install and dashboard presence" ;;
    validatebusyboxmodule.sh) echo "- Validates BusyBox module symlinks and applet count" ;;
    scaffold_busybox_module.sh) echo "- Scaffolds BusyBox module layout and metadata" ;;
    customize.sh) echo "- Customizes applet sets and module props" ;;
    *) echo "- $file" ;;
  esac
}

# ┌─────────────────────────────────────────────┐
# │           Generate README Content           │
# └─────────────────────────────────────────────┘
{
  echo "# BusyBox Wrapper Suite"
  echo ""
  echo "This project scaffolds a modular, installable, and validated BusyBox wrapper for Android/Termux environments."
  echo ""
  echo "## 🏗️ Installers"
  for f in installers/*; do describe_file "$(basename "$f")"; done
  echo ""
  echo "## 🧪 Validators"
  for f in validators/*; do describe_file "$(basename "$f")"; done
  echo ""
  echo "## 🐚 Wrappers"
  for f in wrappers/*; do describe_file "$(basename "$f")"; done
  echo ""
  echo "## 📜 Metadata"
  for f in meta/*; do echo "- $(basename "$f")"; done
  echo ""
  echo "## 📦 Modules"
  for f in modules/*; do echo "- $(basename "$f")"; done
  echo ""
  echo "## 📊 Dashboards"
  for f in dashboards/*; do echo "- $(basename "$f")"; done
  echo ""
  echo "## 🧠 Scripts"
  for f in scripts/*; do describe_file "$(basename "$f")"; done
  echo ""
  echo "## ⚙️ Gradle Plugin"
  echo "- plugin/: Custom Gradle plugin scaffold for dashboard generation and build automation"
  echo ""
  echo "## 🧹 Reform Tools"
  echo "- reform_busybox_layout.sh: Reorganizes project into modular layout"
  echo "- generate_readme.sh: Builds this README from directory structure"
} > "$README"

if [ "$DRY_RUN" = true ]; then
  echo "[readme] Dry-run complete. README not written."
else
  echo "✓ README generated: $README"
fi
