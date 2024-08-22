#!/bin/bash

echo "🛠️ Uninstalling LanLord... 🛠️"

# Prompt the user for the LaunchDaemon name
read -p "🛠 Enter the name of the LaunchDaemon to remove (e.g., com.example.lanlord): " DAEMON_NAME

# Define the LaunchDaemon plist path and symlink path
PLIST_PATH="/Library/LaunchDaemons/${DAEMON_NAME}.plist"
SYMLINK_PATH=$(sudo launchctl list | grep "${DAEMON_NAME}" | awk '{print "/usr/local/bin/lanlord.sh"}')  # Assuming symlink was created in /usr/local/bin

# Remove the LaunchDaemon plist
if [ -f "$PLIST_PATH" ]; then
    echo "🗑️ Removing LaunchDaemon plist at ${PLIST_PATH}..."
    sudo launchctl unload "$PLIST_PATH" 2>/dev/null
    sudo rm "$PLIST_PATH"
    echo "✅ LaunchDaemon plist removed."
else
    echo "⚠️ LaunchDaemon plist not found at ${PLIST_PATH}."
fi

# Remove the symlink if it exists
if [ -L "$SYMLINK_PATH" ]; then
    echo "🗑️ Removing symlink at ${SYMLINK_PATH}..."
    sudo rm "$SYMLINK_PATH"
    echo "✅ Symlink removed."
else
    echo "⚠️ Symlink not found at ${SYMLINK_PATH}."
fi

echo "🎉 LanLord has been uninstalled successfully! 🎉"
