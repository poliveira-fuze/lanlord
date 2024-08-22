#!/usr/bin/env bats

setup() {
  # Prepare a temporary directory for testing
  TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR"

  # Create dummy script and template for testing
  echo '#!/bin/bash' > lanlord.sh
  chmod +x lanlord.sh
  echo '<?xml version="1.0" encoding="UTF-8"?>' > lanlord_template.plist
  ln -s "$PWD/lanlord.sh" /usr/local/bin/lanlord.sh
  echo '<?xml version="1.0" encoding="UTF-8"?>' > /Library/LaunchDaemons/com.example.lanlord.plist
}

teardown() {
  # Clean up temporary directory
  rm -rf "$TEST_DIR"
}

@test "uninstall_lanlord.sh removes symlink" {
  run bash ../uninstall_lanlord.sh
  [ ! -L "/usr/local/bin/lanlord.sh" ]
}

@test "uninstall_lanlord.sh removes LaunchDaemon plist" {
  run bash ../uninstall_lanlord.sh
  [ ! -f "/Library/LaunchDaemons/com.example.lanlord.plist" ]
}
