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

# this script should get your default network settings back to its original

#!/bin/bash

interface="wlan0"               # or whichever interface your network uses
mac_addr="14:7d:da:XX:XX:XX"    # use 'ip address' command to find your mac address
computer_name="MacBookAir9,1"
host_name="hostname"


# Revert MAC address
sudo ip link set "$interface" down
sudo ip link set dev "$interface" address "$mac_addr"
sudo ip link set "$interface" up


# Revert computer name and hostname
sudo hostnamectl set-hostname "$host_name"
sudo sed -i "s/^127.0.1.1 .*/127.0.1.1  $computer_name/" /etc/hosts


# Connect to trusted WiFi network
ssid="Wi-Fi-name"
password="SuperStrongPassword123"

## you can uncomment the following for a simple reconnection to a Wi-Fi
# sudo nmcli device wifi rescan
# sudo nmcli device wifi connect "$ssid" password "$password"

## or uncomment this if you prefer a manually configured connection
# bash wifi.sh wi-fi1    # reference 'wifi.sh' script


echo "connected to WiFi: $host_name: $ssid"
