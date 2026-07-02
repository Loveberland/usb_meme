#!/bin/bash

# Keep path to this script for cleanup 
SETUP_PATH="$(readlink -f "$0")"

# Set temp directory path (equivalent to %TEMP%) 
TEMP_DIR="/tmp"
TEMP_SCRIPT="$TEMP_DIR/rick_main.py"

# Set path to cleanup script 
CLEANUP_SH="$TEMP_DIR/rick_cleanup.sh"

# Copy main.py to /tmp as rick_main.py 
SCRIPT_DIR="$(dirname "$SETUP_PATH")"
cp "$SCRIPT_DIR/main.py" "$TEMP_SCRIPT"

# Create cleanup script to kill terminals, delete temp files, and itself after execution 
cat << EOF > "$CLEANUP_SH"
#!/bin/bash

# Wait while python is running this specific script 
while pgrep -f "rick_main.py" > /dev/null; do
	sleep 1
done

# Kill all spawned terminal windows
pkill -f "gnome-terminal\|konsole\|xfce4-terminal\|mate-terminal\|lxterminal\|terminator\|tilix\|alacritty\|kitty\|wezterm\|foot\|urxvt\|rxvt\|xterm" 2>/dev/null

sleep 1

# Delete rick_main.py 
rm -f "$TEMP_SCRIPT"

# Delete this setup.sh on USB if still plugged in
rm -f "$SETUP_PATH"

# Delete this cleanup script 
rm -f "\$0"
EOF

# Make the cleanup script executable
chmod +x "$CLEANUP_SH"

# Find an available terminal emulator and launch the python script
TERMINAL_FOUND=false

# Try GNOME Terminal
if command -v gnome-terminal &> /dev/null; then
	gnome-terminal -- bash -c "cd '$TEMP_DIR' && python3 '$TEMP_SCRIPT'" &
	TERMINAL_FOUND=true
fi

# Try Konsole
if [ "$TERMINAL_FOUND" = false ] && command -v konsole &> /dev/null; then
	konsole -e bash -c "cd '$TEMP_DIR' && python3 '$TEMP_SCRIPT'" &
	TERMINAL_FOUND=true
fi

# Try Xfce4-terminal
if [ "$TERMINAL_FOUND" = false ] && command -v xfce4-terminal &> /dev/null; then
	xfce4-terminal --hold -e "bash -c 'cd \"$TEMP_DIR\" && python3 \"$TEMP_SCRIPT\"'" &
	TERMINAL_FOUND=true
fi

# Try xterm
if [ "$TERMINAL_FOUND" = false ] && command -v xterm &> /dev/null; then
	xterm -hold -e "bash -c 'cd \"$TEMP_DIR\" && python3 \"$TEMP_SCRIPT\"'" &
	TERMINAL_FOUND=true
fi

# Try x-terminal-emulator (generic fallback)
if [ "$TERMINAL_FOUND" = false ] && command -v x-terminal-emulator &> /dev/null; then
	x-terminal-emulator -e "bash -c 'cd \"$TEMP_DIR\" && python3 \"$TEMP_SCRIPT\"'" &
	TERMINAL_FOUND=true
fi

# If no terminal found, show error
if [ "$TERMINAL_FOUND" = false ]; then
	echo "Error: No terminal emulator found."
	exit 1
fi

# Launch cleanup script in the background 
(cd "$TEMP_DIR" && nohup "$CLEANUP_SH" >/dev/null 2>&1 &)

# Exit the setup script 
exit 0
