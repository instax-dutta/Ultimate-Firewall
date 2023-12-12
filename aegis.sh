iptables=/sbin/iptables

read -p "Which Port Your Aegis is Running :" port

block_linux_connections=true

limit_global_connections=true
limit_global_connections_max=1

burstconns=50

$iptables -A INPUT -p tcp --dport $port --syn -m limit --limit $burstconns/s -j ACCEPT
$iptables -A INPUT -p tcp --dport $port --syn -j DROP

if $block_linux_connections ; then
    $iptables -A INPUT -p tcp -m tcp --syn --tcp-option 8 --dport $port -j REJECT
    echo 'Blocked linux connections!'
fi

if $limit_global_connections ; then
    $iptables -I INPUT -p tcp --dport $port -m state --state NEW -m limit --limit $limit_global_connections_max/s -j ACCEPT
    $iptables -A INPUT -p tcp -m tcp --dport $port -j ACCEPT
    $iptables -A INPUT -p tcp -m tcp --dport $port -m state --state RELATED,ESTABLISHED -j ACCEPT
    $iptables -A INPUT -p tcp -m tcp --dport $port --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 150 --connlimit-mask 32 --connlimit-saddr -j DROP
    $iptables -A INPUT -p tcp -m tcp --dport $port --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 10 --connlimit-mask 32 --connlimit-saddr -j DROP
    echo 'Limited global connections!'
fi

echo "Firewall applied successfully."
echo "Thanks For Using UltimateFirewall by Abhishek Dash"
