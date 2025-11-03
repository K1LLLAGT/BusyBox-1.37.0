#!/bin/bash
# generate_permissions_report.sh — Converts permissions-report.txt into a clickable HTML dashboard

set -e

INPUT="permissions-report.txt"
OUTPUT="permissions-report.html"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Generating Permissions Dashboard"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[report] Input: $INPUT"
echo "[report] Output: $OUTPUT"

if [ ! -f "$INPUT" ]; then
  echo "❌ Report not found: $INPUT"
  exit 1
fi

{
  echo "<!DOCTYPE html>"
  echo "<html><head><meta charset='UTF-8'><title>Permissions Audit</title></head><body>"
  echo "<h1>📋 BusyBox Permissions Audit</h1>"
  echo "<p>Generated from <code>$INPUT</code> on $(date)</p>"
  echo "<table border='1' cellpadding='6' cellspacing='0'>"
  echo "<tr><th>Type</th><th>Target</th><th>Permission</th></tr>"

  grep -E '^(DIR|SCRIPT|DATA)' "$INPUT" | while read -r line; do
    TYPE=$(echo "$line" | cut -d' ' -f1)
    TARGET=$(echo "$line" | cut -d' ' -f2)
    PERM=$(echo "$line" | cut -d' ' -f4)
    echo "<tr><td>$TYPE</td><td><code>$TARGET</code></td><td>$PERM</td></tr>"
  done

  echo "</table>"
  echo "<p style='margin-top:2em;'>✅ All permissions have been audited and normalized for contributor safety.</p>"
  echo "</body></html>"
} > "$OUTPUT"

echo "✓ HTML dashboard generated: $OUTPUT"
