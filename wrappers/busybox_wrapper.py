#!/usr/bin/env python3
# busybox_wrapper.py — Simulates BusyBox Wrapper App logic in Python

import os
import shutil
import subprocess
from datetime import datetime

ASSET_PATH = "./assets/busybox"  # Simulated embedded binary
TARGET_PATH = os.path.expanduser("~/.local/bin/busybox")
DASHBOARD = os.path.expanduser("~/Download/busybox-wrapper-report.txt")

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("  BusyBox Wrapper App (Python UI)")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("BusyBox is a multi-call binary that provides 300+ Unix tools in one executable.")
print("This wrapper installs it locally and exports a dashboard report.")
input("→ Press Enter to install BusyBox locally...")

# Extract and install
os.makedirs(os.path.dirname(TARGET_PATH), exist_ok=True)
shutil.copy2(ASSET_PATH, TARGET_PATH)
os.chmod(TARGET_PATH, 0o755)
print(f"✓ BusyBox installed at: {TARGET_PATH}")

# Validate
version = subprocess.check_output([TARGET_PATH]).decode().splitlines()[0]
applet_list = subprocess.check_output([TARGET_PATH, "--list"]).decode().splitlines()
applet_count = len(applet_list)

# Export dashboard
os.makedirs(os.path.dirname(DASHBOARD), exist_ok=True)
with open(DASHBOARD, "w") as f:
    f.write("BusyBox Wrapper Report\n")
    f.write("----------------------\n")
    f.write(f"Version: {version}\n")
    f.write(f"Applets: {applet_count}\n")
    f.write(f"Installed at: {TARGET_PATH}\n")
    f.write(f"Timestamp: {datetime.now()}\n")

print(f"✓ Dashboard exported to: {DASHBOARD}")

# Optional shell interface
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("  Shell Interface (type 'exit' to quit)")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
while True:
    cmd = input("busybox> ")
    if cmd.strip() == "exit":
        break
    try:
        output = subprocess.check_output([TARGET_PATH] + cmd.split())
        print(output.decode())
    except subprocess.CalledProcessError:
        print("❌ Command failed")
