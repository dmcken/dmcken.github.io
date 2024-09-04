---
title: Mikrotik Management Firewall Considerations
# date: 2024-04-07 00:00:01 -0400
categories: [networking,mikrotik,winbox]
tags: [networking,mikrotik]
author: dmcken 
comments: false
---

## Winbox network discovery:

UDP packet with a dst port of 5678

## MAC telnet

* Packets to mikrotik:
  * mac_dst: 
  * mac_src:
  * ip_dst: broadcast
  * ip_src:
  * protocol: UDP
  * port_src: <random>
  * port_dst: 20561
* Packets from mikrotik:
  * mac_dst: 
  * mac_src:
  * ip_dst: 0.0.0.0
  * ip_src:
  * protocol: UDP
  * port_src: 20561
  * port_dst: <random>


