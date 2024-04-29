---
title: Ceph Notes
# date: 2024-04-07 00:00:01 -0400
categories: [storage, ceph]
tags: [storage,ceph]
author: dmcken 
comments: false
---

Ceph commands:

* `ceph osd tree`
* Ceph Buckets:
  * Create Bucket
    * `ceph osd crush add-bucket a1 room`
  * Move host:
    * `ceph osd crush move host1 datacenter=dc1 room=room1 row=row1 rack=rack1`
* Set OSD class:
  * `ceph osd crush set-device-class nvme osd.20`


Ceph rules:
Recommended rules for Proxmox:
```shell
ceph osd crush rule create-replicated backend_hdd default host hdd
ceph osd crush rule create-replicated backend_ssd default host ssd
ceph osd crush rule create-replicated backend_nvme default host nvme
```
https://www.ibm.com/docs/en/storage-ceph/5?topic=rules-creating-crush-replicated-pools

It will look like this in the config:
```shell
rule replicated_hdd {
    id 0
    type replicated
    min_size 1
    max_size 10
    step take default class hdd
    step chooseleaf firstn 0 type host
    step emit
}
rule replicated_ssd {
    id 1
    type replicated
    min_size 1
    max_size 10
    step take default class ssd
    step chooseleaf firstn 0 type host
    step emit
}
rule replicated_nvme {
    id 2
    type replicated
    min_size 1
    max_size 10
    step take default class nvme
    step chooseleaf firstn 0 type host
    step emit
}
```
