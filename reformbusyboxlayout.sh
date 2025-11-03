#!/bin/bash
# reform_busybox_layout.sh — Reorganizes BusyBox wrapper suite into modular, contributor-safe layout

set -e

DRY_RUN=false
DASHBOARD="reform-report.txt"
ROOT_DIR="$(basename "$PWD")"

for arg in "$@"; do
  [[ "$arg" == "--dry-run" ]] && DRY_RUN=true
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Reforming $ROOT_DIR Layout"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[reform] Dry-run mode: $DRY_RUN"

# ┌─────────────────────────────────────────────┐
# │           Create Target Folders             │
# └─────────────────────────────────────────────┘
for folder in installers wrappers validators meta modules dashboards scripts assets; do
  echo "[reform] Ensuring $folder/"
  [ "$DRY_RUN" = false ] && mkdir -p "$folder"
done

# ┌─────────────────────────────────────────────┐
# │           Move Files into Categories        │
# └─────────────────────────────────────────────┘
move_safe() {
  local file="$1"
  local target="$2"
  if [ -f "$file" ]; then
    echo "[reform] Moving $file → $target/"
    [ "$DRY_RUN" = false ] && mv "$file" "$target/"
    echo "$file → $target/" >> "$DASHBOARD"
  else
    echo "[reform] Skipped missing: $file"
  fi
}

# Scripts
move_safe scaffold_busybox_module.sh scripts/
move_safe customize.sh scripts/

# Installers
move_safe build_apk.sh installers/
move_safe install_apk.sh installers/
move_safe install_busybox.sh installers/
move_safe install_busybox.py installers/

# Wrappers
move_safe busybox_wrapper.sh wrappers/
move_safe busybox_wrapper.py wrappers/

# Validators
move_safe validate_apk.sh validators/
move_safe validatebusyboxmodule.sh validators/

# Metadata
move_safe AndroidManifest.xml meta/
move_safe MainActivity.kt meta/
move_safe module.prop meta/
move_safe busybox-wrapper-app.txt meta/

# Dashboards
move_safe busybox-scaffold-report.txt dashboards/
move_safe busybox_commands_list.txt dashboards/

# Modules
[ -d "system" ] && echo "[reform] Moving system/ → modules/" && [ "$DRY_RUN" = false ] && mv system modules/ && echo "system/ → modules/" >> "$DASHBOARD"
[ -d "META-INF" ] && echo "[reform] Moving META-INF/ → modules/" && [ "$DRY_RUN" = false ] && mv META-INF modules/ && echo "META-INF/ → modules/" >> "$DASHBOARD"

# ┌─────────────────────────────────────────────┐
# │           Final Narration                   │
# └─────────────────────────────────────────────┘
echo "✓ Layout reform complete"
echo "✓ Dashboard exported to: $DASHBOARD"
