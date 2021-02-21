# ddwrt-adblocker
Blocks ads on router level using DD-WRT

based on discussions found on this forum thread: 
https://www.dd-wrt.com/forum/viewtopic.php?t=313987

## Why this?
The simple answer: I have a cheap TP-Link TL-WR841ND router with no jffs, no USB port and limited (volatile) storage. This method:
* works even after rebooting
* keeps an up-to-date block list
* has limited overhead
* works on my cheap router

Other alternatives are the [pixelserv](https://secure.dd-wrt.com/phpBB2/viewtopic.php?p=434120&highlight=&sid=f9c90a3539cb6c2ae0f6e124877d909b) method and  using [jffs](https://www.dd-wrt.com/phpBB2/viewtopic.php?t=307533) to store the host list.

# Usage

1. Copy the [startup code](#startup-code) below to your `Administration` -> `Commands` and `Save Startup`. This will create a custom script to download a blacklist and add the domains to the dnsmasq. 

2. In `Services` -> `Services` -> Enable `DNSMasq`

3. In `Setup` -> `Basic Setup` -> Enable `Forced DNS Redirection`

4. To enable weekly updates, in `Administration` -> `Management` -> `Cron` -> `Additional Cron Jobs` add:
	> `0 11 * * 3 root /tmp/custom.sh`

### Startup code

```bash
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
```

## Notes
* Tested with `Firmware: DD-WRT v3.0-r45767 std (02/17/21)` on a `TP-Link TL-WR841ND v10`
* The script print to Syslog. Enable it in `Services` -> `Syslog` to see if the scripts started. Alternatively Telnet into the router and check if `/tmp/custom.sh` exists.

