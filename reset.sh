echo "Resetting the Ip Table Rules"
wait for 5 seconds
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
wait for 5 seconds
echo "Deleting the Existing Rules"
wait for 5 seconds
iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
wait for 5 seconds
echo "Deleting the Existing Chains"
iptables -F
wait for 2 seconds

echo "Done Resetting the Ip Table Rules"
echo "Exiting the Script"
echo "We suggest a reboot to make sure the rules are reset"
exit 0
