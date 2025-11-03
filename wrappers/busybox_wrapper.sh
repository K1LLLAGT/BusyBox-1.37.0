# Add after install logic
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Applet Test (type 'exit' to skip)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
while true; do
  read -p "test applet> " CMD
  [ "$CMD" = "exit" ] && break
  "$TARGET_PATH" $CMD || echo "❌ Applet failed"
done
