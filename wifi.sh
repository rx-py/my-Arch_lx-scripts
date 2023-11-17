#=======================================================
# ╔═╗╔╗╔╗     ╔══╗╔╗ ╔╗
# ║╔╝╚╬╬╝╔═══╗║╔╗║║║ ║║
# ║║ ╔╬╬╗╚═══╝║╚╝║║╚═╝║
# ╚╝ ╚╝╚╝     ║╔═╝╚═╗╔╝
#             ║║  ╔═╝║ 
#             ╚╝  ╚══╝ 
#
#  Author: rx-py
#  Github: github.com/rx-py
#
#=======================================================

# making network connections using nmcli-Network Manager

#!/bin/bash

# assuming two different networks
SSID1="wi-fi1"
SSID2="wi-fi2"
PASSWORD1="password1"
PASSWORD2="password2"

# Function to connect to a Wi-Fi network by SSID and password
connect_by_ssid() {
    local SSID="$1"
    local PASSWORD="$2"

    # Check if NetworkManager is running
    nmcli -t -f RUNNING g | grep -q "running"
    if [ $? -ne 0 ]; then
        echo "NetworkManager is not running. Starting NetworkManager..."
        sudo systemctl start NetworkManager
        sleep 2
    fi

    # Connect to the specified Wi-Fi network
    echo "Connecting to $SSID..."
    nmcli device wifi rescan
    nmcli device wifi connect "$SSID" password "$PASSWORD"
    if [ $? -eq 0 ]; then
        echo "Connected to $SSID."
    else
        echo "Failed to connect to $SSID."
    fi
}

# Check if an argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <wi-fi1 or wi-fi2>"
    exit 1
fi

# Use a case statement to determine which Wi-Fi network to connect to
case "$1" in
    "wi-fi1")
        connect_by_ssid "$SSID1" "$PASSWORD1"
        ;;
    "wi-fi2")
        connect_by_ssid "$SSID2" "$PASSWORD2"
        ;;
    *)
        echo "Invalid argument. Usage: $0 <wi-fi1 or wi-fi2>"
        exit 1
        ;;
esac

