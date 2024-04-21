---
title: OpnSense Notes
# date: 2024-04-07 00:00:01 -0400
categories: [firewall, opnsense]
tags: [firewall, opnsense,ids]
author: dmcken 
comments: false
---



Todo:

* Setup guide for an OpnSense on proxmox and how to alter the networking to control
  which VMs are sent through the filter


Questions to answer:
* Transparent bridge - can we firewall / IDS in such a setup?
  * Out of band management recommended.
* HA, what options are available?
  * CARP
  * Hardware failover
* 2FA:
  * Google Authenticator
  * TOTP
* Routing:
  * OSPF
  * BGP
  * (FRR also available)
* VPN:
  * IPSec
  * OpenVPN
  * Wireguard
  * stunnel
  * ZeroTier
* Security
  * ZenArmor
    * TLS Inspect
  * Wazuh agent
    * Can view firewall logs  
  * Bogon update sources.
* Monitoring:
  * Insight - netflow analyzer
  * MonIT - monitor and respond to local issues.
* Backup:
  * Git backup of config
* NTP