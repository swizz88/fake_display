#!/bin/bash
# Script to enable fake display
echo "Enabling fake display..."

# Create an Xorg configuration file for the fake display
sudo bash -c 'cat > /usr/share/X11/xorg.conf.d/xorg.conf <<EOF
Section "Device"
    Identifier  "Configured Video Device"
    Driver      "dummy"
    VideoRam    16384
EndSection

Section "Monitor"
    Identifier  "Configured Monitor"
    HorizSync   30.0-90.0
    VertRefresh 50.0-85.0
    Modeline "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
EndSection

Section "Screen"
    Identifier  "Default Screen"
    Monitor     "Configured Monitor"
    Device      "Configured Video Device"
    DefaultDepth 24
    SubSection "Display"
        Depth     24
        Modes     "1920x1080"
    EndSubSection
EndSection
EOF'

# Restart the display manager to apply the changes
sudo systemctl restart display-manager
echo "Fake display has been successfully enabled."
