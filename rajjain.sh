#!/bin/bash

# Run as root
if [ "$EUID" -ne 0 ]; then
  echo "Run this script with sudo"
  exit
fi

echo "Scanning your network..."
echo "-------------------------"

# Scan local network
nmap -sn 192.168.1.0/24  | grep "Nmap scan report" | awk '{print $5}' > ip_list.txt

# Count devices
count=$(wc -l < ip_list.txt)

echo "Devices found: $count"
echo "-------------------------"

# Show IPs with numbers
nl ip_list.txt

echo "-------------------------"

# SSH option
read -p "Do you want to SSH into any IP? (y/n): " choice

if [ "$choice" = "y" ]; then
    read -p "Enter IP number: " num
    ip=$(sed -n "${num}p" ip_list.txt)

    if [ -z "$ip" ]; then
        echo "Invalid IP number"
        exit 1
    fi

    read -p "Enter SSH username: " user

    echo "🔐 Connecting to $ip ..."
    ssh "$user@$ip"
else
    echo "Scan complete. Exiting."
fi
