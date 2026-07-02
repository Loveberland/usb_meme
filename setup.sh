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

# Create cleanup script to delete rick_main.py, setup.sh, and itself after execution 
cat << EOF > "$CLEANUP_SH"
#!/bin/bash

# Wait loop: sleep for 3 seconds while python is running this specific script 
while pgrep -f "rick_main.py" > /dev/null; do
	sleep 3
done

# Delete rick_main.py 
rm -f "$TEMP_SCRIPT"

# Delete this setup.sh on USB if still plugged in [cite: 2]
rm -f "$SETUP_PATH"

# Delete this cleanup script 
rm -f "\$0"
EOF

# Make the cleanup script executable
chmod +x "$CLEANUP_SH"

# Launch main python script in the background 
(cd "$TEMP_DIR" && nohup python3 "$TEMP_SCRIPT" >/dev/null 2>&1 &)

# Launch cleanup script in the background 
(cd "$TEMP_DIR" && nohup "$CLEANUP_SH" >/dev/null 2>&1 &)

# Exit the setup script 
exit 0
