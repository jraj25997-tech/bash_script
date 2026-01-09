#!/bin/bash

VPN="/home/kali/Downloads/jraj25997.ovpn"

for i in {1..5}; do
    xfce4-terminal --title="VPN-$i" --command="sudo openvpn --config $VPN" &
    sleep 15
done

echo "Waiting for tunnels..."
sleep 10

sudo ip addr flush dev tun1
sudo ip addr add 192.168.10.2/24 dev tun1

sudo ip addr flush dev tun2
sudo ip addr add 192.168.20.2/24 dev tun2

sudo ip addr flush dev tun3
sudo ip addr add 172.16.10.2/16 dev tun3

sudo ip addr flush dev tun4
sudo ip addr add 172.20.10.2/16 dev tun4

xfce4-terminal --title="MAC" --command="sudo macchanger -r eth0"

sleep 10

xfce4-terminal --title="INfo" --command="sudo bash -c 'ifconfig; echo; ip link show eth0; exec bash'"

echo "work done by RJ"



