#!/bin/bash

# Ensure only root can run the script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Variable containing the list of ports to be opened (space-separated)
PORT_LIST="22 49 53 123 1812 1813 2379 2380 6443 8285 8443 10250 10256 10257 10259"  # Example ports: SSH, HTTP, HTTPS

# Port range to be opened
PORT_RANGE_START=30000
PORT_RANGE_END=32767

# Flush all existing rules
iptables -F
iptables -X
iptables -Z

# Allow all traffic on loopback interface
iptables -A INPUT -i lo -j ACCEPT

# Allow incoming traffic on specified ports
for PORT in $PORT_LIST; do
    iptables -A INPUT -p tcp --dport "$PORT" -j ACCEPT
done

# Allow incoming traffic on port range
iptables -A INPUT -p tcp --dport $PORT_RANGE_START:$PORT_RANGE_END -j ACCEPT



# Allow established connections to continue
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Drop all other incoming traffic
iptables -A INPUT -j DROP


# For systems using netfilter-persistent (typically Debian/Ubuntu)
# netfilter-persistent save

echo "Specified ports and range are now open: $PORT_LIST and $PORT_RANGE_START-$PORT_RANGE_END"
