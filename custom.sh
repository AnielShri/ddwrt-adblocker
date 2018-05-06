logger Starting blockads scripts

# clean up old list
rm /tmp/adhosts0

# get new list
wget -qO- http://sbc.io/hosts/hosts | grep "^0.0.0.0" > /tmp/adhosts0;
 
# restart service
killall dnsmasq
dnsmasq -u root -g root --conf-file=/tmp/dnsmasq.conf

logger Finished executing blockads script
