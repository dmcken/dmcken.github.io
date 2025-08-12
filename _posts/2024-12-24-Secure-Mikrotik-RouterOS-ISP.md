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

Sometimes you want to keep running a service but not expose it to the general internet.

Could we protect services behind SSH / bind strictly to 127.0.0.1/32?
* `ssh -L 8080:127.0.0.1:80 admin@<router IP>` - By running this I can go to http://127.0.0.1:8080 and access the web interface of my router through the tunnel.
* While I can firewall the port off or block access using the "allowed from" under services (you show up as 127.0.0.1 when coming through the SSH tunnel), the port is still seen as open in nmap scans and you can still connect to it via other IPs on the router.
* The best way forward IMHO is to have an option to bind services to at minimum localhost. Preffered option would be allow it to be bound to one or more IPs on the router (reducing the visible attack surface, degrading an attackers ability to fingerprint what the device is).
* Practically every IP service has this support as it is part of the socket `bind()` call which is common to all TCP/IP stacks, it just defaults to `bind("0.0.0.0", <port #>)` right now. This change is to allow the bind address(s) to be set to something different from the default.


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