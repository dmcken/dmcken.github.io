---
title: Proxmox CLI cookbook
# date: 2024-04-07 00:00:01 -0400
categories: [proxmox,bash,ssh]
tags: [proxmox,bash,ssh]
author: dmcken
comments: false
---

# Introduction

The proxmox OS is a debian base, the beginings of some documentation of that shell is available from (Proxmox themselves)[https://pve.proxmox.com/pve-docs/index.html#_command_line_interface], this is somewhat lacking.

This will also cover commands / scenarios where


## Install / Getting started

Getting your proxmox onto your network (especially via say iDRAC / iLo).

## Storage management

list storage definition:
```bash
pvesm status
```

## Backup and Restore backups

```bash
qmrestore <archive file> <vmid>
    --pool
    --storage
```

### proxmox-backup-client

* list
* restore
* status
* version

## LXC

### Directory mapping:
https://pve.proxmox.com/wiki/Linux_Container#_bind_mount_points
https://forum.proxmox.com/threads/mount-host-directory-into-lxc-container.66555/

```bash
# Add the following to /etc/pve/lxc/<container_id>.conf
# Requires a reboot to activate
mp0: /mnt/nas0/,mp=/nas0

or

# Does not require a reboot, is immediate.
pct set 102 -mp0 /mnt/nas0/,mp=/nas0/
```



## Commands to investigate

| Command      | Description |
| -------      | ----------- |
| pct          |     |
| pvecm        |     |
| pveceph      |     |
| pve-firewall |     |
| pve-ha-crm   |     |
| pve-ha-lrm   |     |
| pvenode      |     |
| pvesm        |     |
| pvesr        |     |
| pveum        |     |
| pveam        |     |
| pvebanner    |     |
| pvedaemon    |     |
| pvefw-logger |     |
| pvereport    |     |
| pvescheduler |     |
| pveupdate    |     |
| pveupgrade   |     |
| pveversion   |     |
| proxmox-offline-mirror |     |
| proxmox-backup-client  |     |
| proxmox-file-restore   |     |
| pvesh   | CLI version of the API |
| pvesr   | Storage Replication |
| qmrestore | Restore qemu server backups |

