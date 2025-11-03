#!/bin/bash
# bundle_wizard.sh — Interactive walkthrough for generating, previewing, and publishing BusyBox documentation

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Documentation Wizard 🧙"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

read -p "→ Run layout reform? [Y/n] " reform
if [[ "$reform" =~ ^[Yy]?$ ]]; then
  bash reform_busybox_layout.sh
fi

read -p "→ Generate README.md? [Y/n] " readme
if [[ "$readme" =~ ^[Yy]?$ ]]; then
  bash generate_readme.sh
fi

read -p "→ Generate index.html dashboard? [Y/n] " index
if [[ "$index" =~ ^[Yy]?$ ]]; then
  bash generate_index.sh
fi

read -p "→ Preview dashboard in browser? [Y/n] " serve
if [[ "$serve" =~ ^[Yy]?$ ]]; then
  bash serve_index.sh
fi

read -p "→ Bundle documentation into zip? [Y/n] " bundle
if [[ "$bundle" =~ ^[Yy]?$ ]]; then
  bash generate_dashboard_bundle.sh
fi

read -p "→ Publish bundle and generate QR code? [Y/n] " publish
if [[ "$publish" =~ ^[Yy]?$ ]]; then
  bash publish_bundle.sh
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✓ Documentation flow complete"
echo "✓ Your BusyBox suite is ready for sharing"
