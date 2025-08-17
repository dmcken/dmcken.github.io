---
title: Arch fix EFI partition
date: 2025-08-17 00:00:01 -0400
categories: [arch,linux]
tags: [arch,linux]
author: dmcken
comments: false
---



If you have a dual-boot with windows sometimes the boot loader can be overwritten





## Fix the partition and re-install kernel

Boot a live CD / USB


Replace <disk> with `nvme0n1` or the appropriate disk so the first mount command turns into `sudo mount /dev/nvme0n1p2 /mnt`.

```bash
sudo mount /dev/<disk>p2 /mnt
sudo mount /dev/<disk>p1 /mnt/efi
sudo arch-chroot /mnt
bootctl install
reinstall-kernels
```









