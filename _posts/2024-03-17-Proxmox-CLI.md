---
title: Proxmox CLI
date: 2025-01-05 00:00:00 -0400
categories: [servers,proxmox]
tags: [proxmox,cli]
author: dmcken
comments: false
---

This is to be a list of various CLI commands or scenarios for either automation or if for some reason the GUI is unavailable or unresponsive.

# Config

Configs are stored in /etc/pve, while direct editing of these files is not recommended or supported the information in these files can be useful in an emergency situation or when the GUI is unavilable / unresponsive.

* In cluster setups this is a fuse mount-point managed by the corosync process.
* Loss of quorum can make this mount point read-only.

## Config layout

* VMs config:
  * /etc/pve/nodes/<node name>/<VM ID>.conf
* Done

# Cluster

## Core

## Storage



# VMs

### VM is locked

Problem: can’t lock file ‘/var/lock/qemu-server/lock-<VMID>.conf’ – got timeout or `VM is locked (backup|snapshot|clone|etc)`

Solution 1:
`qm unlock <VMID>`

Solution 2:
`rm /var/lock/qemu-server/lock-<VMID>.conf`


## Containers

# LXC

### Directory mapping:

Directly mapping a directory from the host into a LXC container (similar to a docker bind-mount). While not great from a cluster it is useful

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

# Networking

# Storage

# Commands

## Proxmox - Official

| Command      | Description |
| ---------------------- | ----------- |
| proxmox-offline-mirror |     |
| proxmox-backup-client  |     |
| proxmox-file-restore   |     |
| pve-firewall           |     |
| pve-ha-crm             |     |
| pve-ha-lrm             |     |
| pveam                  |     |
| pvebanner              |     |
| pvecm                  | Proxmox cluster management |
| pveceph                |     |
| pvedaemon              |     |
| pvefw-logger           |     |
| pvenode                |     |
| pvereport              |     |
| pveperf                | Proxmox VE Benchmark |
| pvescheduler |     |
| pvesh        | CLI version of the API |
| pvesm        | Proxmox storage management |
| pvesr        | Storage Replication |
| pveum        |     |
| pveupdate    |     |
| pveupgrade   |     |
| pveversion   |     |



| qm | VM management |

## External

| Command      | Description |
| -------      | ----------- |
| pct          |     |
| qmrestore | Restore qemu server backups |
| `qm remote-migrate` and `pct remote-migrate` | Migrate a VM to a different cluster |
| nfsstat -m |  |
| NFS connection `netstat | grep :nfs` or `ss -a | grep nfs` |    |
|

# Services

| Services | Description |
| --------- | ------------ |
| corosync | Syncronizes files in /etc/pve |
| pve-guests |     |
| pvebanner |     |
| pvernetcommit |       |
