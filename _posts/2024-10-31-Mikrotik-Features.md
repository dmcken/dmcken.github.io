---
title: Mikrotik missing features
date: 2024-10-31 12:00:00 -0400
categories: [mikrotik,features-requests]
tags: [mikrotik]
author: dmcken
comments: false
---


## EVPN

* BGP support is currently missing.
* VxLAN transport is active but no coordination.

## System

### History

(As of 7.16)

Log messages now include changes:
```
address list entry added by api:dmcken@192.168.1.80 (*5 = /ip firewall address-list add address=10.0.0.0/8 comment=RFC1918 list=RFC1918)
```

`System` -> `History`

Only have trace and action visible to GUI, redo and undo are visible via CLI.


## Tools

### Netwatch

* Host should be able to take DNS name (see: https://help.mikrotik.com/docs/spaces/ROS/pages/8323208/Netwatch) - Only IPs are accepted.
  * Possible workaround using script.

