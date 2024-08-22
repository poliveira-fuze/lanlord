#!/usr/bin/env bats

setup() {
  # Prepare a temporary directory for testing
  TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR"

  # Create dummy script and template for testing
  echo '#!/bin/bash' > lanlord.sh
  chmod +x lanlord.sh
  echo '<?xml version="1.0" encoding="UTF-8"?>' > lanlord_template.plist
}

teardown() {
  # Clean up temporary directory
  rm -rf "$TEST_DIR"
}

@test "install_lanlord.sh creates symlink" {
  run bash ../install_lanlord.sh
  [ -L "/usr/local/bin/lanlord.sh" ]
}

@test "install_lanlord.sh creates LaunchDaemon plist" {
  run bash ../install_lanlord.sh
  [ -f "/Library/LaunchDaemons/com.example.lanlord.plist" ]
}

@test "uninstall_lanlord.sh removes symlink" {
  # Run the uninstall script
  run bash ../uninstall_lanlord.sh
  [ ! -L "/usr/local/bin/lanlord.sh" ]
}

@test "uninstall_lanlord.sh removes LaunchDaemon plist" {
  # Run the uninstall script
  run bash ../uninstall_lanlord.sh
  [ ! -f "/Library/LaunchDaemons/com.example.lanlord.plist" ]
}
