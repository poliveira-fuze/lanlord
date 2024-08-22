#!/bin/bash

# Define the network interfaces
ETHERNET_INTERFACE="en0"  # Usually en0 for Ethernet
WIFI_INTERFACE="en1"      # Usually en1 for Wi-Fi

# Check if Ethernet is connected
ETHERNET_STATUS=$(ifconfig $ETHERNET_INTERFACE | grep "status: active")

if [ "$ETHERNET_STATUS" != "" ]; then
    # Ethernet is connected, disable Wi-Fi
    networksetup -setairportpower $WIFI_INTERFACE off
else
    # Ethernet is not connected, enable Wi-Fi
    networksetup -setairportpower $WIFI_INTERFACE on
fi
