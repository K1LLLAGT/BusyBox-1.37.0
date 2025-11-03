#!/system/bin/sh
MODPATH="${0%/*}"
BUSYBOX="$MODPATH/system/xbin/busybox"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
ui_print "  BusyBox v1.36.1 by Greg"
ui_print "  (osm0sis build)"
ui_print "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
chmod 755 "$BUSYBOX"
cd "$MODPATH/system/xbin"
for applet in $($BUSYBOX --list); do
    [ "$applet" != "busybox" ] && ln -sf busybox "$applet"
done
ui_print "✓ BusyBox installed with $($BUSYBOX --list | wc -l) applets"
ui_print "✓ Installation complete!"
