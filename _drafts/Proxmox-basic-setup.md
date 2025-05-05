---
title: Proxmox production settings
# date: 2024-04-07 00:00:01 -0400
categories: [proxmox,storage,ceph]
tags: [proxmox,storage,ceph]
author: dmcken
comments: false
---

## Packages to install

apt install the following
* tmux - console multiplexer
* VirGL GPU
  * libgl1
  * libegl1

## Node / Host OS settings

Questions:
* Would randomizing the password for the root users make sense?
* How can we force pve for most operations?
* Is the data in the pve realm enough to create system users?
* How reasonable is switch management to fully IPv6?
* How to setup nested virtualization?

## VM settings:

### *NIX:
* System:
  * Machine: q35
  * Graphics Card: SPICE or VirGL GPU
* CPU:
  * Type: x86-64-v2-AES


### Windows:
* System:
  * Machine: q35
  * Graphics Card: SPICE or VirGL GPU
* CPU:
  * Type: x86-64-v2-AES



## To look into:
* SDN:
  * FRRouting:
* Hookscripts - https://pve.proxmox.com/pve-docs/pve-admin-guide.html#_hookscripts

