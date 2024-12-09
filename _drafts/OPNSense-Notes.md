---
title: OPNSense Notes
# date: 2024-04-07 00:00:01 -0400
categories: [firewall, opnsense]
tags: [firewall, opnsense,ids]
author: dmcken
comments: false
---


## Setup

### Install from ISO

### Upgrade to latest

### Post-install setup

#### CARP notes

It seems CARP can be setup on a interface with

#### Getting the OPNSense server onto your network

Check the routes via CLI (FreeBSD based)
```bash
netstat -rn
route add -net 10.0.0.0/8 <gw>
```


#### Plugins
* Virtualization:
  * If installed as a VM on Proxmox:
    1. Install `os-qemu-quest-agent`
    2. Setup the guest agent on the VM:
      1. Under Options of the VM locate "QEMU Guest Agent"
      2. Change settings to match:<br>
         ![ospf-general-tab](/assets/img/2024-10-27-QEMU-Guest-Agent-Setup-Proxmox.png)
    3. The VM now needs to be shutdown entirely (a reboot usually doesn't work).


#### Alternative admin user

Items to detemine before starting:
* Do you want to use SSH keys instead of password?

Procedure

* Create user:
  * Goto System -> Access -> Users
  * Create a user with the following:
    * Set appropriate password.
    * Valid login shell
    * Member of group: admins
    * Authorized key if you want to use for SSH login.


#### Allow SSH access
2024-12-01-SSH accessible to?
* Do you want SSH users to be able to sudo to root? And if yes, should a password be required.

Procedure:

* Turn on service:
  * Goto System -> Settings -> Administration:
    * Secure shell section:
      * Secure Shell Server: Enable
      * Login Group: wheel,admins
      * If you want password login:
        * Authentication Method: Enable Permit password login
      * If you don't want SSH accessible to all interfaces change "Listen Interfaces" to the desired interfaces.
    * Authentication section:
      * If you want sudo access:
        * sudo: "Ask password" or "No password"
        * Group to: wheel,admins
    * Save at the bottom.

Usage:

1. SSH to a usable IP on an available interface.
2. When you login for a root shell type `sudo -i`.
3. You will be dropped into the console prompt, 8 to get a root shell.


## Shell commands

### FRR Routing

#### Enter FRR Shell

```bash
vtysh
```


________

To format down here:

Alernative user setup:
- Separate name (allows root login via ssh to remain disabled).
- root-like
- sudo via ssh
- https://forum.opnsense.org/index.php?topic=33903.0


Observations:
* You have to restart the service (stop + start) to activate a peer under wireguard.

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
  * os-chrony - Time sync vs built in?
  * os-clamav
  * os-crowdsec
  * os-dmidecode
  * os-dnscrypt-proxy
  * os-freeradius
  * os-frr
  * os-git-backup
  * os-hw-probe
  * os-lldp -
  * maltrail -
  * os-netdata - detailed info for troubleshooting
  * os-ntopng
  * Load balancers:
    * caddy
    * haproxy
    * nginx
    * siproxyd - Support seems source-only.
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
* VPN redundancy (how to have multiple VPN servers in separate DCs that can be used to handle failover):
  * Config to sync (System -> HA)
    * Auth servers? Possibly no (LDAP or similar maybe)
    * Certificates
    * Firewall rules (from VPN subnets)
      * NAT - Maybe
      * OpenVPN
    * Users and groups
  * Setup a full wireguard mesh underlay
* Shells
  * csh
  * sh
  * tcsh

Pending questions:
* How best to implement clusters? (i.e. more than 2 hosts).
* CARP:
  * How slow is CARP to start responding to requests on the gateway IP?
  * Is there any way to recover public IP from having to be used for CARP? e.g. use IPv6 or private ips but float a public IP.
