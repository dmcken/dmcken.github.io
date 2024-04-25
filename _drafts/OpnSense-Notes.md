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
  * https://www.youtube.com/watch?v=dTUvlFfThPw
  * https://docs.opnsense.org/manual/how-tos/transparent_bridge.html
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
* Interesting plugins:
  * os-chrony
  * os-clamav
  * os-crowdsec
  * os-dmidecode
  * os-dnscrypt-proxy
  * os-freeradius
  * os-frr
  * os-git-backup
  * os-hw-probe
  * os-lldp
  * os-netdata
  * os-ntopng
  * Monitoring tools:
    * os-wazuh-agent - Wazuh
    * os-zabbix-agent - Zabbix 
  * Utilities:
    * os-iperf
  * VM Guest addons:
    * os-qemu-guest-agent	
    * os-virtualbox
    * os-vmware
    * os-xen