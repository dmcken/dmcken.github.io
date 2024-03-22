---
title: PON Network design considerations
date: 2024-03-21 00:00:01 -0400
categories: [networking,PON]
tags: [pon,design]
author: dmcken 
comments: false
---

Direct response to https://www.reddit.com/r/networking/comments/1bkb8mb/is_there_a_good_crash_course_on_gpon/ :


I'd say you want to figure out what system they use as it will dictate all of the ancillary considerations given how thin of a layer GPON itself is. To tell you how thin a layer it is allot of vendors have it down to being the SFP: https://www.fiercetelecom.com/telecom/cisco-breaks-down-olt-chassis-new-pluggable . Exaware / Tibit offers something very similar (https://exaware.com/solutions/access/). You can drop the Tibits into almost any 10G SFP+ port so imagine a 48 port 1U switch dense PON headend device.

# Points you want to consider

## Security:
* Whitelist / Blacklist of modems allowed to connect. Spoofing is more difficult on a PON but is not impossible.
* Connecting the PON platform to your billing system. RADIUS and TR-069 are the common interfaces used.
* Controlling what customers can do and being able to track them down from the headend devices becomes important when you have hundreds of customers.
* Bridge mode is the best from a security perspective as now the entire PON disappears from traceroutes and usually is invisible to the customer so the GPON kit usually can't be attacked directly.
* The above also implies that the upstream routers and your customers can communicate directly and all of the side effects of that (probably best given that most PON vendor's approach to security is... how you say "lacking" at best). This is usually because of the speeds involved most PON platforms look no further than the layer 2 headers and thus can't do much more security-wise.

## General PON design: 
 This section will heavily reference https://dl.ubnt.com/ds/uf_gpon.pdf .

* What's your launch power and the receiver sensitivity of your modems? As an example the Ubnt PON SFPs you can see on page 5 the class B kit can transmit from 1.5 to 5 dBm and the class C from 3 to 7 dBm. On the Rx side the lowest sensitivity is around -28 dBm
* How to design the cabling as you want UPC connections at the final terminations (especially the headend). Losses over distance (usually 0.35 dB / km) and across your various splitters (1x2 - 3.something dB, 1x4 - 6.something dB, 1x16 - 13 dBm, 1x32 - 17 dBm , etc) come into play here. Exact numbers for the Ubnt kit can be seen on page 8, other manufacturers' numbers may be different.
* These design considerations dictates the potential over-provisioning that can occur on the fiber outside plant. But at the maximum you will likely never exceed 128 customers on a single PON with 32 or 64 being the more realistic maximums.
Capacity planning:
* This is almost non issue on a PON given that at its worst you almost need all the customers on a single port to be high end business / BitTorrent users to even push the port close to capacity.
* Honestly if you are considering a business complex you may want to look at XGS-PON which operates symmetrical 10G vs a standard that has less upstream capacity.
* QoS is built in and still a tool to keep ready in your toolbox but properly designed your PON should never be having to decide on which packet to queue to a user. In the case of a DDoS you should be handling that upstream.
* PON design allows for any splitters to be a 2xY design which uplinks to multiple OLT devices or separate ports to protect against fiber breaks upstream of the splitter or failure of the headend OLT devices (important given they are one of the few active / powered devices on a PON). This type of design is rarely used but are a tool available if you have a scenario that can use it.

## CPE:
* What vendors are allowed to connect, and their capabilities?
* Does your platform even support CPE from other vendors?
* What modes / features:
  * Do they support bridge mode?
  * DHCP option 82 insertion?
  * IPv6?
  * What is visible in the management interface, automation, etc.
* This is the biggest cause of issues and the major differential between vendors. Vendor lock in is still a major issue that you need to be aware of. Some vendors will implement extensions to the inband provisioning protocol and reject any CPE that fails to implement those extensions.
