#!/bin/bash
# generate_dashboard_bundle.sh — Bundles dashboards and docs into a zip

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Creating Dashboard Bundle 📦"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

zip -r dashboard_bundle.zip dashboards/ index.html README.md permissions-report.*

echo "✓ Created dashboard_bundle.zip"
