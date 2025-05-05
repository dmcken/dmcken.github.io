---
title: Linux server management notes
# date: 2024-04-07 00:00:01 -0400
categories: [server,linux]
tags: [server,linux]
author: dmcken
comments: false
---








## Basic commands

### Find

```bash
find . -name Thumbs.db
```

## Hardware

* lspci
* lsusb
* lscpu
* lsblk
* lsscsi
* lsmod
* lshw

## Networking
https://linux-audit.com/cheat-sheets/ip/


### Troubleshooting

#### Ethtool

```bash
ethtool -S <interface>
```

https://docs.kernel.org/networking/device_drivers/ethernet/mellanox/mlx5/counters.html


#### ip


```bash
ip -stats link show [<dev>]
```





