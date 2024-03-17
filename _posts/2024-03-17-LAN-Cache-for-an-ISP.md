---
title: LAN Cache for an ISP
date: 2024-03-17 00:00:00 -0400
categories: [ISP, software-config]
tags: [lan-cache]     # TAG names should always be lowercase
author: dmcken 
comments: false
---



How to scale LAN cache to ISP scale:



Now lets start LAN Cache:

```bash
docker run \
  --restart unless-stopped \
  --name lancache-dns \
  --detach \
  -p 53:53/udp \
  -p 53:53/tcp \
  -e USE_GENERIC_CACHE=true \
  -e UPSTREAM_DNS=8.8.8.8 \
  -e DNS_BIND_IP=192.168.1.20 \
  -e LANCACHE_IP=192.168.1.20 \
  -e CACHE_DOMAINS_REPO="https://github.com/dmcken/cache-domains.git" \
  -e CACHE_DOMAINS_BRANCH="ubuntu-archives" \
  lancachenet/lancache-dns:latest

docker run \
  --restart unless-stopped \
  --name lancache \
  --detach \
  -v /cache/data:/data/cache \
  -v /cache/logs:/data/logs \
  -p 80:80 \
  -p 443:443 \
  -e CACHE_DOMAINS_REPO="https://github.com/dmcken/cache-domains.git" \
  -e CACHE_DOMAINS_BRANCH="ubuntu-archives" \
  lancachenet/monolithic:latest

```




