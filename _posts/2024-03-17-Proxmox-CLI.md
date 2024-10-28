---
title: Proxmox CLI
date: 2024-03-17 00:00:00 -0400
categories: [servers,proxmox]
tags: [proxmox,cli]
author: dmcken
comments: false
---

This is to be a list of various CLI commands for either automation or if for some reason the GUI is unavailable.


## VMs



### VM is locked

Problem: can’t lock file ‘/var/lock/qemu-server/lock-<VMID>.conf’ – got timeout or `VM is locked (backup|snapshot|clone|etc)`

Solution 1:
`qm unlock <VMID>`

Solution 2:
`rm /var/lock/qemu-server/lock-<VMID>.conf`

