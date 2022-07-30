iptables -A INPUT -p tcp -m tcp --dport 25565 --tcp-option 8 --tcp-flags FIN,SYN,RST,ACK SYN -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -m tcp --dport 25565 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 25565 --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 150 --connlimit-mask 32 --connlimit-saddr -j DROP
iptables -A INPUT -p tcp -m tcp --dport 25565 --tcp-flags FIN,SYN,RST,ACK SYN -m connlimit --connlimit-above 10 --connlimit-mask 32 --connlimit-saddr -j DROP
iptables -A INPUT -p tcp -m tcp --sport 123 -j REJECT --reject-with icmp-port-unreachable
iptables -A INPUT -p tcp -m tcp --sport 389 -j REJECT --reject-with icmp-port-unreachable

iptables -A INPUT -p tcp -m state --state NEW -m limit --limit 50/second --limit-burst 50 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -j DROP
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT 
iptables -A INPUT -p tcp --tcp-flags RST RST -m limit --limit 2/s --limit-burst 2 -j ACCEPT 
