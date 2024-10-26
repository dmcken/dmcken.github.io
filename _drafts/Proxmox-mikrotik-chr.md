---
title: Proxmox Mikrotik CHR on zfs
# date: 2024-04-07 00:00:01 -0400
categories: [proxmox,storage,zfs,mikrotik]
tags: [proxmox,storage,zfs,mikrotik]
author: dmcken
comments: false
---






wget https://download.mikrotik.com/routeros/6.49.13/chr-6.49.13.img.zip
unzip chr-6.49.13.img.zip

qemu-img info chr-6.49.13.img
image: chr-6.49.13.img
file format: raw
virtual size: 64 MiB (67108864 bytes)
disk size: 33 MiB
Child node '/file':
    filename: chr-6.49.13.img
    protocol type: file
    file length: 64 MiB (67108864 bytes)
    disk size: 33 MiB



zfs list -t volume

dd if=chr-6.49.13.img of=/dev/zvol/tank/vm-101-disk-0 bs=1M

https://forum.proxmox.com/threads/import-convert-export-raw-images-to-zfs-volume.21241/
https://forum.proxmox.com/threads/migrate-qcow2-or-raw-images-to-zfs-volume.44966/















