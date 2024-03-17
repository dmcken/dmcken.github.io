---
title: NetCat Proxy
date: 2024-03-17 00:00:00 -0400
categories: [Networking, misc]
tags: [netcat]     # TAG names should always be lowercase
author: dmcken 
comments: false
---

## Problem definition:
You are locked out of a device for some reason but can get to it from your router which for some reason has netcat installed (in my case EdgeRouter).

```bash
mkfifo fifo
while true; do nc -l -p 8443 <fifo | nc 10.7.1.32 443 >fifo; done
```

<p>So while this works with some systems at least to view the device config, some devices like Ubiquiti's SolarSwitch seem to do some "weird stuff" and changing parameters does not work for some reason. </p>



<p>Credit to: https://notes.tweakblogs.net/blog/7955/using-netcat-to-build-a-simple-tcp-proxy-in-linux.html however the script on that page does not work on the EdgeRouters.</p>