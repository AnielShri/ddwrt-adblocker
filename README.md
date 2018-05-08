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

## Usage
* Copy the text from `startup.sh`  to your `Administartion` -> `Commands` startup section
* Copy the text from `custom.sh` to your `Administration` -> `Commands` custom script section
* Enable `local DNS`  in `Services` -> `Services` -> `DNSMasq`
* Add cron job under `Administration` -> `Management` -> `Cron` for automatic updates (`0 11 * * 3 root /bin/sh /tmp/custom.sh` updates every wednesday at 11AM)
* Reboot router and open the pi-hole ad page to see if it worked: https://pi-hole.net/pages-to-test-ad-blocking-performance/

## Notes
* For some reason the semicolons are needed at the end of pipe operations. Without these, the host filename or conf file get garbled characters
* Both scripts print to Syslog. Enable it in `Services` -> `Syslog` to see if the scripts started

