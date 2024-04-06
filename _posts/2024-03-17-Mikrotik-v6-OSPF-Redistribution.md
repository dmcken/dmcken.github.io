---
title: Mikrotik (v6) OSPF Redistribution
date: 2024-03-17 00:00:00 -0400
categories: [mikrotik]
tags: [mikrotik,v6,routing,ospf]
author: dmcken 
comments: false
---

## Problem definition:

The Mikrotik OSPF software allows you to specify that you wish to redistribute certain types of routes (e.g. connected or static). What may not be easily obvious is controlling said redistribution (similar to route-maps in Cisco and export policies in Juniper).

## Solution:

We will create an out filter to control the redistribution of these routes, my current setup is as follows:


```
/routing filter
add action=discard chain=ospf-out comment="Unconditional Blacklist" prefix=10.254.254.4/30 prefix-length=30-32
add action=accept chain=ospf-out comment="Allow all connected subnets" protocol=connect
add action=accept bgp-communities=0:10 chain=ospf-out comment="Allow static with BGP community 0:10" protocol=static
add action=discard chain=ospf-out</code></pre>
```

### Explanation
* Chain name needs to match the name in "Out Filter" in the OSPF instance.
* If there is a network no matter what you want redistributed then I recommend setting this at the top of the chain specifying said network.
* Usually you want to redistribute all connected networks (except maybe VPNs).
* Usually static routes you want to control, of the available arbitrary tags that you can use to flag that you wish to redistribute that static route the easiest seems to be the bgp-community (the other would be the route tag but in 6.46.8 it doesn't appear to work). For this example I used 0:10 (for obvious reasons the community is not passed through OSPF).
* Reject all other prefixes.

Activate the filters with the following:<br/>
![ospf-general-tab](/assets/img/2024-03-17-Mikrotik-OSPF-Instance-General-Tab.png)
_RouterOSv6 OSPF General Tab_
