#!/usr/bin/env python3
# install_busybox.py — Extracts, validates, and dashboards BusyBox from assets

import os, shutil, subprocess, sys
from datetime import datetime

ASSET_PATH = "./assets/busybox"
TARGET_PATH = os.path.expanduser("~/.local/bin/busybox")
DASHBOARD = os.path.expanduser("~/Download/busybox-wrapper-report.txt")
DRY_RUN = "--dry-run" in sys.argv

# ┌─────────────────────────────────────────────┐
# │           Narration                         │
# └─────────────────────────────────────────────┘
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("  BusyBox Wrapper Installer (Python)")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print(f"[install_busybox] Asset: {ASSET_PATH}")
print(f"[install_busybox] Target: {TARGET_PATH}")
print(f"[install_busybox] Dashboard: {DASHBOARD}")
print(f"[install_busybox] Dry-run mode: {DRY_RUN}")

# ┌─────────────────────────────────────────────┐
# │           Dry-run Mode                      │
# └─────────────────────────────────────────────┘
if DRY_RUN:
    print("[install_busybox] Dry-run: no install performed")
    sys.exit(0)

# ┌─────────────────────────────────────────────┐
# │           Install BusyBox                   │
# └─────────────────────────────────────────────┘
print("BusyBox is a multi-call binary that provides 300+ Unix tools in one executable.")
print(f"Installing to: {TARGET_PATH}")

os.makedirs(os.path.dirname(TARGET_PATH), exist_ok=True)
shutil.copy2(ASSET_PATH, TARGET_PATH)
os.chmod(TARGET_PATH, 0o755)

# ┌─────────────────────────────────────────────┐
# │           Validate and Export Dashboard     │
# └─────────────────────────────────────────────┘
version = subprocess.check_output([TARGET_PATH]).decode().splitlines()[0]
applet_list = subprocess.check_output([TARGET_PATH, "--list"]).decode().splitlines()
applet_count = len(applet_list)

with open(DASHBOARD, "w") as f:
    f.write("BusyBox Wrapper Report\n")
    f.write("----------------------\n")
    f.write(f"Version: {version}\n")
    f.write(f"Applets: {applet_count}\n")
    f.write(f"Installed at: {TARGET_PATH}\n")
    f.write(f"Timestamp: {datetime.now()}\n")

if "Applets:" in open(DASHBOARD).read():
    print("✓ Dashboard validated")
else:
    print("❌ Dashboard missing applet count")

print(f"✓ Dashboard exported to: {DASHBOARD}")

# ┌─────────────────────────────────────────────┐
# │           Applet Test Loop                  │
# └─────────────────────────────────────────────┘
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("  Applet Test (type 'exit' to skip)")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
while True:
    cmd = input("test applet> ")
    if cmd.strip() == "exit":
        break
    try:
        output = subprocess.check_output([TARGET_PATH] + cmd.split())
        print(output.decode())
    except subprocess.CalledProcessError:
        print("❌ Applet failed")
