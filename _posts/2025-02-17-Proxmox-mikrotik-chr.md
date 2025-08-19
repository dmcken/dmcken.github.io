---
title: Proxmox Mikrotik CHR on zfs
# date: 2024-04-07 00:00:01 -0400
categories: [proxmox,storage,zfs,mikrotik]
tags: [proxmox,storage,zfs,mikrotik]
author: dmcken
comments: false
---

# Setting up a mikrotik CHR on proxmox

## Pre-requisites

```bash
apt install unzip
```

## Create VM

* OS:
    * Do not use any media
    * OS Type: Linux (6.x - 2.6 Kernel)
* System:
    * Machine: q35
* Disks:
    * ZFS storage of appropriate size (must be greater than 64MB for v6 and 128MB for v7).
    * If you want to partition the disk specify how much you want the mikrotik OS to use and then start it as it resizes to fill the disk on first boot. You can then resize the disk to the full size you want and add your extra partitions after. This does not apply to adding a 2nd or more disks, only if you want to partition the primary.
    * Note the disk ID (for the first disk it will be zero).
* CPU:
    * Cores: 2+
* Memory:
    * 128MiB+ (as appropriate to what you want to use).
    * Ballooning Device: <unchecked>
* Network:
    * VLAN Tag as appropriate
* Done
    * Note the VM ID assigned.

## Commands to write the image

The VM will have an ID that proxmox assigns it to find the ZFS volume name do `zfs list -t volume`, the output will look something like this:
```bash
NAME                       USED  AVAIL  REFER  MOUNTPOINT
rpool/data/vm-102-disk-0  4.14G   135G  4.14G  -
tank/vm-100-disk-0        25.3G   713G  25.3G  -
tank/vm-100-disk-1         120K   713G   120K  -
tank/vm-100-disk-2          64K   713G    64K  -
tank/vm-101-disk-0        25.1G   713G  25.1G  -
tank/vm-103-disk-0        5.55G   713G  5.55G  -
tank/vm-104-disk-0        27.1G   713G  27.1G  -
tank/vm-105-disk-0        8.28G   713G  8.28G  -
tank/vm-106-disk-0        16.7G   713G  16.7G  -
tank/vm-111-disk-0        35.3G   713G  35.3G  -
tank/vm-112-disk-0        14.4G   713G  14.4G  -
tank/vm-113-disk-0        24.9G   713G  24.9G  -
tank/vm-114-disk-0        3.58G   713G  3.58G  -
tank/vm-115-disk-0          56K   713G    56K  -
```

Where the format is `<zpool or dataset>/vm-<vm id>-disk-<disk id>`, note the dataset can be a sub-folder.

## Download and unpack image

If you are downloading manually or copying the latest image's URL from https://mikrotik.com/download this is the "Raw disk image".

```bash
wget https://download.mikrotik.com/routeros/7.19.4/chr-7.19.4.img.zip
unzip chr-7.19.4.img.zip
```

You can then verify the disk image using `qemu-img info chr-7.19.4.img` (filename without the .zip):

For v7+ images you will see something similar to the following:
```bash
image: chr-7.19.4.img
file format: raw
virtual size: 128 MiB (134217728 bytes)
disk size: 40.4 MiB
Child node '/file':
    filename: chr-7.19.4.img
    protocol type: file
    file length: 128 MiB (134217728 bytes)
    disk size: 40.4 MiB
```

For v6 images you should see something similar to the following:
```bash
image: chr-6.49.13.img
file format: raw
virtual size: 64 MiB (67108864 bytes)
disk size: 33 MiB
Child node '/file':
    filename: chr-6.49.13.img
    protocol type: file
    file length: 64 MiB (67108864 bytes)
    disk size: 33 MiB
```

From the above qemu output the minimum disk sizes specified in the create VM section should make sense (virtual size), if this increases in future images you will need to adjust the minimum accordingly.

## Write the image to the ZFS disk

Now write the mikrotik image to the ZFS disk (substituting the appropriate downloaded image for `if=` and the zfs path prefixed by `/dev/zvol/` for `of=`):
```bash
dd if=chr-6.49.13.img of=/dev/zvol/tank/vm-103-disk-0 bs=1M
or
dd if=chr-7.19.4.img of=/dev/zvol/rpool/data/vm-102-disk-0 bs=1M
```

Which should lead to output similar to the following:
```bash
128+0 records in
128+0 records out
134217728 bytes (134 MB, 128 MiB) copied, 0.400068 s, 335 MB/s
```

* The mikrotik OS will resize itself to fill the primary disk when it first boots.
* The default username and password is admin / <blank> for both v6 and v7.
* v7 will force you to change the password on first login.
* Once the first boot happens you can move storage to your hearts content (to ceph, iSCSI, etc).

## References

* https://forum.proxmox.com/threads/import-convert-export-raw-images-to-zfs-volume.21241/
* https://forum.proxmox.com/threads/migrate-qcow2-or-raw-images-to-zfs-volume.44966/

