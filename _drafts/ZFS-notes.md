---
title: Proxmox CLI cookbook
# date: 2024-04-07 00:00:01 -0400
categories: [server,zfs]
tags: [server,zfs]
author: dmcken
comments: false
---



## Encryption


```bash
zfs create -o encryption=on -o keylocation=prompt -o keyformat=passphrase

zfs change-key
zfs load-key -r <dataset path>
zfs unload-key -r <dataset path>

ls -l /banshee/encrypted/child2

zfs get keystatus banshee/encrypted

zfs send -w
```

## References:
* https://docs.oracle.com/cd/E18752_01/html/819-5461/gazsu.html
* https://docs.oracle.com/cd/E18752_01/html/819-5461/gbciq.html
* https://arstechnica.com/gadgets/2021/06/a-quick-start-guide-to-openzfs-native-encryption/
* https://wiki.archlinux.org/title/ZFS#Unlock_at_boot_time:_systemd
