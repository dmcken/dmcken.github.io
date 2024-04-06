---
title: Mikrotik MLAG - Notes and implementation
date: 2024-04-06 00:00:01 -0400
categories: [mikrotik, switching]
tags: [mikrotik,switching,lag]
author: dmcken 
comments: false
---

## How to setup MLAG on mikrotik switches

https://www.youtube.com/watch?v=xvb7Nd1xvRw




## Random notes:

* Between mikrotik devices they supposedly use ICCP similar to Cisco and Juniper:
  * https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/cether/configuration/15-s/ce-15-s-book/ce-iccp-multichass-vlan-red.pdf
  * TODO: Fill in juniper docs.
* Currently there is no wireshark dissector for the mikrotik version (or any it seems).



## Odd things seen:
* After a reboot of one of the peer switches or the ICCP link drops it takes aprox 8 minutes to re-establish connectivity.
  * MLAG state is connected.
  * Client sees both links as active.
* Done


## Bugs to investigate if fixed:
* https://forum.mikrotik.com/viewtopic.php?t=197532
* https://forum.mikrotik.com/viewtopic.php?t=198756
* https://forum.mikrotik.com/viewtopic.php?t=185237#p928292
* https://forum.mikrotik.com/viewtopic.php?t=195383 - To see if we can get the info from Mikrotik or if it will have to be reverse engineered.

