---
title: Juniper - Base JunOS config
date: 2024-03-24 00:00:01 -0400
categories: [networking,juniper]
tags: [networking,juniper]
author: dmcken 
comments: false
---



## Base system:

```
# Set individual device settings
set system host-name &lt;hostname&gt;
set system domain-name &lt;ISP router domain&gt;
set system time-zone UTC

# General system
delete system autoinstallation

# Setup general login parameters
set system login retry-options tries-before-disconnect 3
set system login retry-options backoff-threshold 1
set system login retry-options backoff-factor 5
set system login retry-options minimum-time 30
set system login retry-options maximum-time 120
set system login retry-options lockout-period 10

# Setup remote access
set system services ssh root-login deny
set system services ssh protocol-version v2
set system services ssh max-sessions-per-connection 5
set system services ssh client-alive-count-max 6
set system services ssh client-alive-interval 10
set system services ssh connection-limit 25
set system services ssh rate-limit 10

# General Internet settings
set system no-redirects
set system no-redirects-ipv6
set system no-ping-record-route
set system no-ping-time-stamp
set system internet-options icmpv4-rate-limit packet-rate 1000
set system internet-options icmpv6-rate-limit packet-rate 1000
set system internet-options no-source-quench
set system internet-options no-tcp-reset drop-all-tcp

# 
set system backup-router 172.18.2.1
set system backup-router destination 172.16.0.0/16
set system default-address-selection 

set system name-server 9.9.9.9
set system name-server 131.72.76.0

#
set system syslog user * any emergency
set system syslog file messages any notice
set system syslog file messages authorization info
set system syslog file interactive-commands interactive-commands any
set system syslog file User-Auth authorization any
set system syslog file audit interactive-commands any
set system syslog file processes daemon any
set system syslog time-format year
set system syslog time-format millisecond
set system syslog source-address 23.164.224.255

#
set system extensions
set system commit synchronize
set system ntp server 98.191.213.2</code></pre>
```

## Config management

```
set system max-configuration-rollbacks 49

# Backup of config
set system archival configuration transfer-on-commit
set system archival configuration archive-sites "scp://juniper@<config-host>.noc.<operator>.co:2222/<site>/<host>"
```

## Load balancing / Aggregated Ethernet (aeX)

```
set forwarding-options load-balance indexed-load-balance
```

## Common Routing options:
### router-id and ASN
```
routing-options {
    router-id $LOOPBACKIP$;
    autonomous-system 6653;
}
```

To Add:
* uRPF
    * https://www.juniper.net/documentation/en_US/junos/topics/example/unicast-rpf-ex-series.html
    * https://www.juniper.net/documentation/en_US/junos/topics/task/configuration/interfaces-configuring-unicast-rpf.html
* MC-LAG
* LLDP
* DNS
* NTP
* SNMP
* Syslog
    * time-format millisecond year
    * source-address
* netconf
* protect-re filter:
  * https://jncie.eu/how-to-deploy-vmx-with-multiple-res-and-multiple-fpcs-in-eve-ng-kvm/
* system accounting events
    * login
    * change-log
    * interactive-commands
* logic class tier 3
    * idle-timeout 30
    * login-alarms
    * permissions all
* Routing policies:
    * Blackholes
        * ASN for communities:
            * 16 vs 32 bit ASNs.
* vMX:
  * Docker:
    * https://community.juniper.net/browse/blogs/blogviewer?blogkey=cb2ba379-a181-43d5-ae3d-8ec3832f087f
    