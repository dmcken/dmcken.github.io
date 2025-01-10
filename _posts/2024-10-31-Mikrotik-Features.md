---
title: Mikrotik missing features
date: 2024-10-31 12:00:00 -0400
categories: [mikrotik,features-requests]
tags: [mikrotik]
author: dmcken
comments: false
---

List of desired features currently missing from Mikrotik RouterOS v7.

## OSPF

* Interfaces are no longer listed in the neighbor list.

## EVPN

* BGP support is currently missing.
  * This includes just using a mikrotik as a route reflector for leaf devices.
* VxLAN transport is active but no coordination between devices.

## System

### Memory usage

While you can get a breakdown of both CPU usage on a per-CPU basis or process (Tool -> Profile). There is no way to get a breakdown of memory usage by even general categories.

### History

(As of 7.16)

Log messages now include changes:
```
address list entry added by api:dmcken@192.168.1.80 (*5 = /ip firewall address-list add address=10.0.0.0/8 comment=RFC1918 list=RFC1918)
```

`System` -> `History`

Only have trace and action visible to GUI, redo and undo are visible via CLI.

### Users

User database is kept separate of the general config, copying the user database from one router to another is currently not possible.

## Tools

### Netwatch

* Host should be able to take DNS name (see: https://help.mikrotik.com/docs/spaces/ROS/pages/8323208/Netwatch) - Only IPs are accepted.
  * Possible workaround using script.

