#!/bin/bash
# permissions.sh — Audits and restores contributor-safe permissions across BusyBox wrapper suite

set -e

REPORT="permissions-report.txt"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Permissions Auditor 🛡️"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[perm] Interactive wizard mode enabled"
echo "[perm] Report file: $REPORT"

echo "BusyBox Permissions Audit — $(date)" > "$REPORT"

# ┌─────────────────────────────────────────────┐
# │           Fix Directory Permissions         │
# └─────────────────────────────────────────────┘
fix_dir() {
  local dir="$1"
  if [ -d "$dir" ]; then
    echo "[perm] Directory: $dir → 755"
    echo "DIR $dir → 755" >> "$REPORT"
    chmod 755 "$dir"
  fi
}

# ┌─────────────────────────────────────────────┐
# │           Fix Script Permissions            │
# └─────────────────────────────────────────────┘
fix_script() {
  local file="$1"
  if [[ "$file" == *.sh || "$file" == *.py ]]; then
    echo "[perm] Script: $file → 700"
    echo "SCRIPT $file → 700" >> "$REPORT"
    chmod 700 "$file"
  fi
}

# ┌─────────────────────────────────────────────┐
# │           Fix Data File Permissions         │
# └─────────────────────────────────────────────┘
fix_data() {
  local file="$1"
  if [[ "$file" == *.txt || "$file" == *.md || "$file" == *.kts || "$file" == *.properties ]]; then
    echo "[perm] Data: $file → 644"
    echo "DATA $file → 644" >> "$REPORT"
    chmod 644 "$file"
  fi
}

# ┌─────────────────────────────────────────────┐
# │           Wizard Mode Prompts               │
# └─────────────────────────────────────────────┘
read -p "→ Fix directory permissions (755)? [Y/n] " fix_dirs
read -p "→ Fix script permissions (700)? [Y/n] " fix_scripts
read -p "→ Fix data/report permissions (644)? [Y/n] " fix_datafiles

# ┌─────────────────────────────────────────────┐
# │           Apply Fixes Across Suite          │
# └─────────────────────────────────────────────┘
if [[ "$fix_dirs" =~ ^[Yy]?$ ]]; then
  for dir in */; do fix_dir "$dir"; done
fi

for file in *; do
  [ -f "$file" ] || continue
  [[ "$fix_scripts" =~ ^[Yy]?$ ]] && fix_script "$file"
  [[ "$fix_datafiles" =~ ^[Yy]?$ ]] && fix_data "$file"
done

echo "✓ Permissions audit complete"
echo "✓ Report saved to: $REPORT"
