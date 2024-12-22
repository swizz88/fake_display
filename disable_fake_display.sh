#!/bin/bash
# Script to disable fake display
STATE_FILE="/tmp/fake_display_disabled"

echo "Checking fake display status..."

# Check if the script has already run in the current boot session
if [ -f "$STATE_FILE" ]; then
    echo "Script has already run in this boot session. Skipping."
    exit 0
fi

# Mark that the script is running for the first time after boot
echo "Marking that the script is running for the first time after boot..." > "$STATE_FILE"

# Check and remove the Xorg configuration file if it exists
if [ -f /usr/share/X11/xorg.conf.d/xorg.conf ]; then
    echo "Disabling fake display..."
    sudo rm /usr/share/X11/xorg.conf.d/xorg.conf
    sudo systemctl restart display-manager
    echo "Fake display has been disabled."
else
    echo "Fake display is not active."
fi
