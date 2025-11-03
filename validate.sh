#!/data/data/com.termux/files/usr/bin/bash
# BusyBox Project Validation Script

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 BusyBox Validation Suite"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Run validators
if [ -d ./validators ]; then
  for v in ./validators/*.sh; do
    [ -f "$v" ] && echo "🧪 Running validator: $v" && bash "$v"
  done
else
  echo "⚠️ No validators directory found"
fi

# Permissions check
[ -f ./permissions.sh ] && echo "🔑 Checking permissions..." && bash ./permissions.sh

# Test harness
[ -f ./test_run.sh ] && echo "🧪 Running test harness..." && bash ./test_run.sh

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Validation complete"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
