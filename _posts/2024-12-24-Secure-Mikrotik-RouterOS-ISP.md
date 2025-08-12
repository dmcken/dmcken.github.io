---
title: Secure Mikrotik RouterOS ISP template
date: 2024-12-24 00:00:01 -0400
categories: [mikrotik,security]
tags: [mikrotik,security]
author: dmcken
comments: false
---

A secure ISP template, ansible implementation will be published.

# Core settings

## Routerboard

* Auto-upgrade: Enable

## Services

If you want to see what ports Mikrotik uses and the matching ports:
https://help.mikrotik.com/docs/spaces/ROS/pages/103841820/Services

`IP->Services` section controls the core management interfaces available on the router. Common services that would be enabled:
* api(-ssl)
* ssh
* winbox
* www(-ssl) - REST API

These services can be isolated in their own VRF for connectivity to a OOB network.

### Hiding services

Sometimes you want to keep running a service but not expose it

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