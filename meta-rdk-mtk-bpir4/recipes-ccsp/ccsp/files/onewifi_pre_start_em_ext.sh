#!/bin/sh
sleep 5

iw phy phy0 interface add wifi0 type __ap
iw phy phy0 interface add wifi0.1 type __ap
iw phy phy0 interface add wifi1 type __ap
iw phy phy0 interface add wifi2 type __ap
iw phy phy0 interface add wifi1.1 type __ap

#Obtain the wifi0 mac address
wifi_mac="$(cat /sys/class/ieee80211/phy0/macaddress)"
#Strip the : and increment mac by 1 to get wifi1 macaddress
mac=$(echo $wifi_mac | tr -d ':')
mac_incr=$((0x$mac + 8))
wifi0_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
#Increment again by 1 to get wifi2 address
mac_incr=$(($mac_incr + 1))
wifi0_1_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
#Increment again by 1 to get wifi2 address
mac_incr=$(($mac_incr + 1))
wifi1_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
mac_incr=$(($mac_incr + 1))
wifi1_1_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
mac_incr=$(($mac_incr + 1))
wifi2_mac=$(printf "%012x" $mac_incr | sed 's/../&:/g;s/:$//')
#print the mac address
echo $wifi0_mac
echo $wifi1_mac
echo $wifi2_mac

#Update the mac address using ip link command
ifconfig wifi0 down
ifconfig wifi0.1 down
ifconfig wifi1 down
ifconfig wifi1.1 down
ifconfig wifi2 down
ip link set dev wifi0 address $wifi0_mac
ip link set dev wifi0.1 address $wifi0_1_mac
ip link set dev wifi1 address $wifi1_mac
ip link set dev wifi1.1 address $wifi1_1_mac
ip link set dev wifi2 address $wifi2_mac
ifconfig wifi0 up
ifconfig wifi1 up
ifconfig wifi1.1 up
ifconfig wifi2 up

#To update al_mac addr in EasymesgCfg.json
al_mac_addr=`cat /nvram/EasymeshCfg.json | grep AL_MAC_ADDR  | cut -d '"' -f4`
al_mac=`iw dev wifi1.1 info | grep addr | cut -d ' ' -f2`

if [ "$al_mac_addr" = "00:00:00:00:00:00" ]; then
        sed -i "s/$al_mac_addr/$al_mac/g" /nvram/EasymeshCfg.json
fi

exit 0
