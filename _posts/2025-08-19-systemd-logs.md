---
title: SystemD logs - notes
date: 2025-01-05 00:00:00 -0400
categories: [servers,proxmox]
tags: [proxmox,cli]
author: dmcken
comments: false
---



# SystemD logs - Notes










## View units

```bash
systemctl list-unit-files --all
```

## View logs for a specific unit

```bash
journalctl -u sshd.service
```
