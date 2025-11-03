#!/data/data/com.termux/files/usr/bin/bash
# Helper script to fix AAPT2 path for Gradle builds in Termux

SDK_ROOT="$HOME/Android/Sdk"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Fixing AAPT2 for Gradle"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. Ensure sdkmanager is available
if ! command -v sdkmanager >/dev/null 2>&1; then
  echo "❌ sdkmanager not found. Please install Android SDK tools first."
  exit 1
fi

# 2. Install latest build-tools (34.0.0 or newer)
echo "📦 Installing Android build-tools..."
yes | sdkmanager "build-tools;34.0.0" >/dev/null

# 3. Detect latest installed build-tools version
LATEST=$(ls -1 "$SDK_ROOT/build-tools" | sort -V | tail -n 1)
AAPT2_PATH="$SDK_ROOT/build-tools/$LATEST/aapt2"

# 4. Verify aapt2 exists
if [ ! -f "$AAPT2_PATH" ]; then
  echo "❌ aapt2 not found in $AAPT2_PATH"
  exit 1
fi

chmod +x "$AAPT2_PATH"

# 5. Write gradle.properties override
cat > gradle.properties <<EOF
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.aapt2FromMavenOverride=$AAPT2_PATH
EOF

echo "✅ aapt2 override set to: $AAPT2_PATH"
echo "👉 Now run: ./gradlew clean assembleDebug --no-build-cache"
