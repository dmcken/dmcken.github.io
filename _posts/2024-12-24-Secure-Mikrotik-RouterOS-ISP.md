---
title: Secure Mikrotik RouterOS ISP template
date: 2024-12-24 00:00:01 -0400
categories: [mikrotik,security]
tags: [mikrotik,security]
author: dmcken
comments: false
---

# Core settings

## Routerboard

* Auto-upgrade: Enable

## SSH

* Strong Crypto: Enable
* Host Key Type: Ed25519

After changing the "Host Key Type" regenerate the host key.


# ISP Specific

## Extra packages

* calea
* container
* gps
* rose-storage
* tr069-client
* ups
* user-manager
* zerotier

## Interface lists

```
/interface list
add name=exclude_discovery
```

## Neighbor discovery

## Services