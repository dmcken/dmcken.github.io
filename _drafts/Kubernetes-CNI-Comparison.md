---
title: Kubernetes CNI comparison
# date: 2024-04-07 00:00:01 -0400
categories: [server,linux.k8s,cni]
tags: [server,linux,k8s,cni]
author: dmcken
comments: false
---

# Comparison of multiple CNIs

CNI in Kubernetes parlance is equivalent to a network controller. This post will perform a comparison between some of the offering at the time of writing. The goal is to compare advanced features.

## CNI notes / explanations:
### Flannel

* Default for k3s

### Canal

### Cilinum
### Calico

## tl;dr

| Group | Feature | Canal | Flannel | Cilinum | Calico | Weave |
| :-------: | :-----: | :-----: | :-------: | :-------: | :------: |
| Security |
| | Policy definition| |
| |
| Routing |
| | BGP |
| | Underlay |
| | Egress Gateway [^egress-gateway] |
| IPAM
| | Load balancer |



[^egress-gateway]: The egress gateway feature routes all IPv4 connections originating from pods and destined to specific cluster-external CIDRs through particular nodes, from now on called “gateway nodes”.




