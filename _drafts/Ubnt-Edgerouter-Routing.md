---
title: Proxmox CLI cookbook
# date: 2024-04-07 00:00:01 -0400
categories: [networking,ubiquiti]
tags: [networking,ubiquiti]
author: dmcken
comments: false
---



## OSPF

```
configure
set protocols ospf redistribute connected metric-type 1
commit
save
exit
exits
```
