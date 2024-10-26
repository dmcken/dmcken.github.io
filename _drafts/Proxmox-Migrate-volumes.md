---
title: Proxmox migrate volumes
# date: 2024-04-07 00:00:01 -0400
categories: [proxmox,storage,zfs]
tags: [proxmox,storage,zfs]
author: dmcken
comments: false
---


# From https://forum.proxmox.com/threads/fastest-way-to-copy-zfs-volume-from-server-to-another.139464/

# Setup SSH keys and connect to box to accept the key

zfs snapshot tank/vm-100-disk-0@now
zfs create -V 60gb tank/vm-100-disk-0
zfs send -Rpv rpool/vm-X-disk-Y@now | ssh -o BatchMode=yes root@$IP zfs recv -Fv rpool/vm-X-disk-Y


# Convert qcow2 to raw

# Convert raw to qcow2

# Convert a raw image to ZFS volume



# References
* [https://forum.proxmox.com/threads/fastest-way-to-copy-zfs-volume-from-server-to-another.139464/]
