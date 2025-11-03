#!/bin/bash
# build_apk.sh — CLI tool to build and sign BusyBox Wrapper APK with narration and dry-run support

set -e

APP_NAME="BusyBox-1.36.1"
PACKAGE="com.greg.busybox_1361"
KEYSTORE="debug.keystore"
KEY_ALIAS="androiddebugkey"
KEY_PASS="android"
APK_OUT="BusyBox.apk"
APK_SRC="app/build/outputs/apk/debug/app-debug.apk"
DASHBOARD="build-apk-report.txt"

# ┌─────────────────────────────────────────────┐
# │           Pre-flight Narration              │
# └─────────────────────────────────────────────┘
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  BusyBox Wrapper APK Builder"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "[build_apk] App name: $APP_NAME"
echo "[build_apk] Package: $PACKAGE"
echo "[build_apk] Output: $APK_OUT"
echo "[build_apk] Keystore: $KEYSTORE"

# ┌─────────────────────────────────────────────┐
# │           Dry-run Mode                      │
# └─────────────────────────────────────────────┘
if [[ "$1" == "--dry-run" ]]; then
  echo "[build_apk] Dry-run mode: no build executed"
  exit 0
fi

# ┌─────────────────────────────────────────────┐
# │           Tool Validation                   │
# └─────────────────────────────────────────────┘
command -v ./gradlew >/dev/null || { echo "❌ gradlew not found"; exit 1; }
command -v apksigner >/dev/null || { echo "❌ apksigner not found"; exit 1; }

# ┌─────────────────────────────────────────────┐
# │           Keystore Generation               │
# └─────────────────────────────────────────────┘
if [ ! -f "$KEYSTORE" ]; then
  echo "[build_apk] Generating debug keystore..."
  keytool -genkey -v -keystore "$KEYSTORE" -alias "$KEY_ALIAS" \
    -keyalg RSA -keysize 2048 -validity 10000 \
    -storepass "$KEY_PASS" -keypass "$KEY_PASS" \
    -dname "CN=Greg, OU=Dev, O=BusyBox, L=Springfield, S=MI, C=US"
fi

# ┌─────────────────────────────────────────────┐
# │           APK Build                         │
# └─────────────────────────────────────────────┘
echo "[build_apk] Compiling APK..."
./gradlew assembleDebug

# ┌─────────────────────────────────────────────┐
# │           APK Signing                       │
# └─────────────────────────────────────────────┘
echo "[build_apk] Signing APK..."
apksigner sign \
  --ks "$KEYSTORE" \
  --ks-key-alias "$KEY_ALIAS" \
  --ks-pass pass:"$KEY_PASS" \
  --out "$APK_OUT" \
  "$APK_SRC"

# ┌─────────────────────────────────────────────┐
# │           Dashboard Export                  │
# └─────────────────────────────────────────────┘
{
  echo "BusyBox APK Build Report"
  echo "-------------------------"
  echo "App name: $APP_NAME"
  echo "Package: $PACKAGE"
  echo "APK output: $APK_OUT"
  echo "Keystore: $KEYSTORE"
  echo "Timestamp: $(date)"
} > "$DASHBOARD"

echo "✓ APK built and signed: $APK_OUT"
echo "✓ Dashboard exported to: $DASHBOARD"
