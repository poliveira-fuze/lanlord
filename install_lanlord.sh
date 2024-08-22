#!/bin/bash

echo "🚀 Welcome to the LanLord Installer! 🚀"

# Prompt the user for the symlink directory
read -p "📁 Enter the directory where LanLord should be symlinked (e.g., /usr/local/bin): " SYMLINK_DIR

# Verify if the directory exists
if [ ! -d "$SYMLINK_DIR" ]; then
    echo "❌ Error: The directory you provided does not exist. Please check the path and try again."
    exit 1
fi

# Prompt the user for the full path to the network switch script
read -p "📂 Enter the full path to your network switch script (e.g., /usr/local/bin/lanlord.sh): " SCRIPT_PATH

# Verify if the script path exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "❌ Error: The script path you provided does not exist. Please check the path and try again."
    exit 1
fi

# Symlink the script to the specified directory
SYMLINK_PATH="${SYMLINK_DIR}/lanlord.sh"
echo "🔗 Creating symlink for LanLord script at ${SYMLINK_PATH}..."
sudo ln -sf "$SCRIPT_PATH" "$SYMLINK_PATH"
echo "✅ Symlink created at ${SYMLINK_PATH}"

# Prompt the user for the LaunchDaemon name
read -p "🛠 Enter the name of the LaunchDaemon (e.g., com.example.lanlord): " DAEMON_NAME

# Prompt the user for the interval in seconds
read -p "⏰ Enter the interval in seconds for the script to run (e.g., 60): " INTERVAL

# Define the LaunchDaemon plist path and the template path
PLIST_PATH="/Library/LaunchDaemons/${DAEMON_NAME}.plist"
TEMPLATE_PATH="./lanlord_template.plist"

# Create the plist from the template by substituting placeholders
echo "📝 Creating LaunchDaemon plist from template..."

sudo sed \
    -e "s|{{DAEMON_NAME}}|${DAEMON_NAME}|g" \
    -e "s|{{SCRIPT_PATH}}|${SYMLINK_PATH}|g" \
    -e "s|{{INTERVAL}}|${INTERVAL}|g" \
    "$TEMPLATE_PATH" | sudo tee "$PLIST_PATH" > /dev/null

echo "✅ Plist created at ${PLIST_PATH}"

# Make sure the script is executable
echo "🔐 Ensuring the script is executable..."
sudo chmod +x "$SCRIPT_PATH"

# Load the LaunchDaemon
echo "🔄 Loading the LaunchDaemon..."
sudo launchctl load "$PLIST_PATH"

echo "🎉 LanLord has been installed successfully! 🎉"
echo "⚙️ The script will now run every ${INTERVAL} seconds."
