# wait for the rest of the services to startup
sleep 20 

# Create script to download blacklist
echo '#!/bin/sh

logger Starting blockads scripts

# clean up old list
rm /tmp/adhosts

# get new list
wget -qO- http://sbc.io/hosts/hosts | grep "^0.0.0.0" > /tmp/adhosts;
 
# restart service
killall dnsmasq
dnsmasq -u root -g root --conf-file=/tmp/dnsmasq.conf

logger Finished executing blockads script' >> /tmp/custom.sh;

# add executable right 
chmod +x /tmp/custom.sh

# add blacklist to dnsmasq
grep "addn-hosts=/tmp/adhosts" /tmp/dnsmasq.conf || echo "addn-hosts=/tmp/adhosts" >> /tmp/dnsmasq.conf;

# execute script
/tmp/custom.sh