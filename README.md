## Features

- **Automatic Network Switching**: Prioritizes Ethernet over Wi-Fi when connected.
- **Seamless Fallback**: Switches back to Wi-Fi if Ethernet fails.
- **Easy Setup**: Simple installation and configuration.

## Installation

To get started with LanLord, follow these steps:

1. **Download LanLord**:

Clone the repository or download the source code.
```bash
git clone https://github.com/yourusername/lanlord.git
cd lanlord
```

2. **Run the Installer**:

Make sure the script is executable:
```bash
chmod +x install_lanlord.sh
```

Execute the installer script:
```bash
sudo ./install_lanlord.sh
```

You will be prompted for:
- The directory where the LanLord script should be symlinked (e.g., `/usr/local/bin`).
- The full path to your network switch script (e.g., `/usr/local/bin/lanlord.sh`).
- The name for the LaunchDaemon (e.g., `com.example.lanlord`).
- The interval in seconds for how often the script should run (e.g., `60`).

## Usage

Once installed, LanLord will automatically manage your network connections based on the Ethernet availability. The script will run at the specified interval and handle the network switching seamlessly.

### Verifying the Installation

- **Check if LanLord is Running**:

  ```bash
  sudo launchctl list | grep lanlord
  ```

- **View Logs**:

  To view the log output of LanLord, you can check system logs using:

  ```bash
  log show --predicate 'process == "lanlord"' --info
  ```

## Uninstallation

If you need to remove LanLord, follow these steps:

1. Run the Uninstaller:

    - Make sure the script is executable:
      ```bash
      chmod +x uninstall_lanlord.sh
      ```
    - Execute the uninstaller script:
      ```bash
      sudo ./uninstall_lanlord.sh
      ```
    - You will be prompted for the name of the LaunchDaemon you want to remove.

2. Manual Cleanup (if needed):

    - If you encounter any issues with removal, manually check and remove any residual files or symlinks.

## Troubleshooting

1. Script Not Running:
    - Ensure the script has execute permissions:
      ```bash
      chmod +x /usr/local/bin/lanlord.sh
      ```
    - Check the LaunchDaemon plist file for any errors in the configuration.

2. Network Not Switching:
    - Verify that your Ethernet and Wi-Fi interfaces are correctly named and configured.
    - Check logs for errors or issues related to network detection.

## Contributing

If you'd like to contribute to LanLord, please fork the repository, make your changes, and submit a pull request. ~~For detailed contribution guidelines, refer to the CONTRIBUTING.md file in the repository.~~

## License

LanLord is open-source software licensed under the MIT License.
