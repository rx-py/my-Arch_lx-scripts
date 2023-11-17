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

# simple mac address spoof for arch linux

#!/bin/bash

set -e
set -o pipefail
export LC_CTYPE=C

interface="wlan0"
basedir="/directory/myscripts"   # directory where 'firstnames.txt' file is stored

# Spoof computer name
first_name=$(sed -n "$(shuf -i 1-2048 -n 1)p" "$basedir/firstnames.txt" | sed -e 's/[^a-zA-Z]//g')
model_name=$(cat /sys/class/dmi/id/product_name)
computer_name="$first_name’s $model_name"
host_name=$(echo "$computer_name" | sed -e 's/’//g' | sed -e 's/ /-/g')


# Spoof host name
sudo hostnamectl set-hostname "$host_name"
printf "Spoofed hostname to %s\n" "$host_name"

# Fixed MAC address prefix
mac_address_prefix="14:7d:da:"  # commonly identified to be apple mac products

# Generate random MAC address suffix
mac_address_suffix=$(openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//')

# Combine prefix and suffix to create the new MAC address
new_mac_address="${mac_address_prefix}${mac_address_suffix}"


# Spoof the MAC address
echo "Spoofing MAC address of $interface to $new_mac_address"
sudo ip link set dev "$interface" down
sudo ip link set dev "$interface" address "$new_mac_address"
sudo ip link set dev "$interface" up

# Verify the change
current_mac_address=$(ip link show "$interface" | awk '/ether/ {print $2}')

printf "Spoofed MAC address of $interface to %s\n" "$new_mac_address"
echo "Current MAC address of $interface: $current_mac_address"
