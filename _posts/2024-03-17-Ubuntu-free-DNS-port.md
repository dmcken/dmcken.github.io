---
title: Ubuntu - Free DNS port 53
date: 2024-03-17 00:00:00 -0400
categories: [Ubuntu, systemd]
tags: [systemd,dns]     # TAG names should always be lowercase
author: dmcken 
comments: false
---

Problem definition: On ubuntu (fill in version) and other systemd based systems the DNS port 53 is used by systemd-resolved which binds to 127.0.0.1:53. Unfortunately this prevents other software from binding to that port if you want to run your own DNS server (e.g PiHole, Bind or PowerDNS).

Symptoms:

Running `sudo lsof -i :53` will show entries present which indicates 

Solution: 

1. Edit the file `/etc/systemd/resolved.conf` and set the DNS= line to the DNS servers you want to use and DNSStubListener to the value "no" (without quotes).

    ```shell
    [Resolve]
    DNS=1.1.1.1,9.9.9.9
    DNSStubListener=no
    ```

    The stub listener is the systemd-resolvd running the process on port 53 which is effectively acting as a proxy for DNS requests. Instead this ends up creating a systemd managed resolv.conf file at `/run/systemd/resolve/resolv.conf` which you can link to the system resolv.conf in the next step.

2. Make symbolic link for the /etc/resolv.conf that is traditionally used on Linux systems:

    ```shell
    sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
    ```

3. Reboot
4. Confirm
