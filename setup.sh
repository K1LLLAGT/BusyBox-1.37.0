#!/data/data/com.termux/files/usr/bin/bash
# BusyBox Project Setup Script (auto-download + auto-build)

VERSION="1.37.0"
SRC_URL="https://busybox.net/downloads/busybox-$VERSION.tar.bz2"
BIN_URL="https://busybox.net/downloads/binaries/$VERSION-defconfig-multiarch/busybox-arm64"
WORKDIR=~/busybox-1.36.1
SRC_DIR=~/downloads/busybox-$VERSION
BIN_PATH="$WORKDIR/busybox"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧱 BusyBox Project Setup (v$VERSION)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

mkdir -p ~/downloads "$WORKDIR"

# 1. Download BusyBox source if missing
if [ ! -d "$SRC_DIR" ]; then
  echo "🌐 Downloading BusyBox source $VERSION..."
  curl -L "$SRC_URL" -o ~/downloads/busybox-$VERSION.tar.bz2
  tar -xjf ~/downloads/busybox-$VERSION.tar.bz2 -C ~/downloads/
else
  echo "✅ BusyBox source already present: $SRC_DIR"
fi

# 2. Download prebuilt binary if missing
if [ ! -f "$BIN_PATH" ]; then
  echo "🌐 Downloading BusyBox binary..."
  curl -L "$BIN_URL" -o "$BIN_PATH"
  chmod +x "$BIN_PATH"
  echo "✅ BusyBox binary placed at $BIN_PATH"
else
  echo "✅ BusyBox binary already present: $BIN_PATH"
fi

# 3. Build from source if binary fails
if ! "$BIN_PATH" --help >/dev/null 2>&1; then
  echo "⚠️ Prebuilt binary not working, building from source..."
  cd "$SRC_DIR" || exit 1
  make defconfig
  make -j"$(nproc)"
  cp busybox "$BIN_PATH"
  chmod +x "$BIN_PATH"
  cd "$WORKDIR" || exit 1
  echo "✅ BusyBox built from source"
fi

# 4. Patch Android packaging configs
echo "📦 Updating Android packaging configs..."
cat > "$WORKDIR/package.config" <<EOF
# BusyBox package config
BUSYBOX_VERSION=$VERSION
BUSYBOX_BINARY=$BIN_PATH
EOF

cat > "$WORKDIR/AndroidManifest.xml" <<EOF
<manifest package="org.example.busybox"
    xmlns:android="http://schemas.android.com/apk/res/android">
    <application android:label="BusyBox v$VERSION">
        <meta-data android:name="busybox.config" android:value="package.config"/>
    </application>
</manifest>
EOF

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Setup complete with BusyBox v$VERSION"
echo "📋 Binary: $BIN_PATH"
echo "📋 Config: $WORKDIR/package.config"
echo "📋 Manifest: $WORKDIR/AndroidManifest.xml"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
