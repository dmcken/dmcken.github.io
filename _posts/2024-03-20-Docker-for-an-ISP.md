---
title: Docker for an ISP
date: 2024-03-18 00:00:01 -0400
categories: [Containers, Docker]
tags: [docker, networking]
author: dmcken 
comments: false
---


Problem definition: How to build an entire ISP management system on a single docker host?

* Mandatory services:
  * NTP
    * Docker container
  * DNS
  * DHCP
  * Netbox - Network documentation / automation
* Optional services:
  * Netflow:
  * Management services:
  * Random management scripts / connectors
* Done


## Change docker networks

Create / edit `/etc/docker/daemon.json`

```json
{
  "default-address-pools": [
    {"base":"172.30.0.0/18","size":24}
  ],
  "bip": "172.30.254.1/23"
}
```


## Disabling DNS daemon on systemd systems

## Local Docker Cache

https://docs.docker.com/registry/recipes/mirror/ full list of daemon.json options can be found here https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file

## Remove root for docker commands

```bash
sudo usermod -aG docker ${USER}
```

