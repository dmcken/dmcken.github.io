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

