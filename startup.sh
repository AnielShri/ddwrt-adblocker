# wait for the rest of the services to startup
sleep 20 

logger Starting blockads scripts

# clean up old list
rm /tmp/adhosts0

# get new list
wget -qO- http://sbc.io/hosts/hosts | grep "^0.0.0.0" > /tmp/adhosts0;
 
# add entry to config
grep addn-hosts /tmp/dnsmasq.conf || echo "addn-hosts=/tmp/adhosts0" >>/tmp/dnsmasq.conf;

# restart service
killall dnsmasq
dnsmasq -u root -g root --conf-file=/tmp/dnsmasq.conf

logger Finished executing blockads script
