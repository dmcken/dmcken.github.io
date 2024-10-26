---
title: Mikrotik Netflow issues
# date: 2024-04-07 00:00:01 -0400
categories: [networking,mikrotik,netflow]
tags: [networking,mikrotik,netflow]
author: dmcken
comments: false
---

# Mikrotik Netflow setups

Mikrotik templates:
* Netflow v9:
  * 260
* IPFIX:
  * 258
  * 259
  * 260

```bash
/ip traffic-flow
set active-flow-timeout=1m enabled=yes interfaces=br_aster
/ip traffic-flow ipfix
set dst-address-mask=no dst-mac-address=no first-forwarded=no gateway=no icmp-code=no icmp-type=no igmp-type=no \
in-interface=no ip-header-length=no ip-total-length=no ipv6-flow-label=no is-multicast=no last-forwarded=no \
nat-events=yes out-interface=no src-address-mask=no src-mac-address=no sys-init-time=no tcp-ack-num=no \
tcp-flags=no tcp-seq-num=no tcp-window-size=no tos=no ttl=no udp-length=no
/ip traffic-flow target
add dst-address=10.60.248.34 port=2020 v9-template-timeout=20s version=ipfix
```








Refs:
* Issues:
  * AS missing:
    * https://forum.mikrotik.com/viewtopic.php?t=199527
  * Counter wrap around:
    * https://serverfault.com/questions/739201/mikrotik-traffic-flow-netflow-octets-counter-wrapc
  * https://github.com/akvorado/akvorado/issues/417
  * https://github.com/pavel-odintsov/fastnetmon/issues/985
  * https://github.com/britram/python-ipfix/issues/26
* https://forum.mikrotik.com/viewtopic.php?t=162192
* External references:
  * https://www.iana.org/assignments/ipfix/ipfix.xhtml
* Done
