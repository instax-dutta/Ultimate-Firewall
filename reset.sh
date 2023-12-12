#!/bin/bash

echo "Resetting the IP Table Rules"
sleep 5

# Set default policies to ACCEPT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

sleep 5

echo "Deleting the Existing Rules"
sleep 5

# Flush all existing rules
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD

sleep 5

echo "Deleting the Existing Chains"
# Delete any custom chains
iptables -X

sleep 2

echo "Done Resetting the IP Table Rules"
echo "Exiting the Script"
echo "We suggest a reboot to make sure the rules are reset"
exit 0
