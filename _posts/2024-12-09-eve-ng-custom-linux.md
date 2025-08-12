---
title: EVE-NG Custom Linux Image.
date: 2024-12-09 00:00:01 -0400
categories: [eve-ng,linux]
tags: [eve-ng,linux]
author: dmcken
comments: false
---


# Create a custom EVE-NG linux image

## Paths previously taken and Introduction
An update and copy archive of:
https://www.2stacks.net/blog/getting-started-with-frr-on-eveng/

(As of 2024-12-09 the certificate is for github so I have no idea when it expired).

I will be following the direction to produce a FRRouting image but I will be adapting appropriately so a generic image of my chosen linux (ubuntu) will also be produced so images of different software can also be produced.

## Introduction (original)

If you’ve been around networking long enough chances are you have heard of the open source routing software Zebra or Quagga. You may have used them without knowing, if you ever worked with Sidewinder firewalls or Brocade’s Vyatta. If you :heart: Linux and open source routing you may have heard of the next evolution in open source routing FRRouting aka Free Range Routing (FRR). If you haven’t;

> FRR is a routing software package that provides TCP/IP based routing services with routing protocols support such as BGP, RIP, OSPF, IS-IS and more. It uses the Linux kernel’s routing stack for packet forwarding.

FRR has been around since 2016 when it was forked from the Quagga project. It has a growing number of contributors and support from various networking vendors such as Cumulus, VMware, Volta, Orange and 6wind with the common goal of creating a “world class routing stack.” The FRR project is currently licensed under the GPLv2+ and is overseen by The Linux Foundation in an effort to ensure the project’s growth and sustainability.

In this post I’m going to demonstrate how to install FRR on the popular network modeling platform [EVE-NG](http://www.eve-ng.net/). This will allow you to evaluate FRR and its many features and hopefully inspire you to get more involved with open source routing.

## Prerequisites

If you are not familiar with [EVE-NG](https://www.eve-ng.net/) or Emulated Virtual Environment (EVE), it is a platform for designing, testing and training with virtual appliances and network emulation software. Although geared more towards networking, you can emulate almost anything in Eve-NG that can run on the [KVM](https://www.linux-kvm.org/page/Main_Page) hypervisor. Since FRR is a routing platform Eve-NG provides everything you need to start creating labs and proof of concepts using FRR.

Eve-NG can run on bare metal or as a virtual appliance on KVM and VMware. There are a few different [installation](https://www.eve-ng.net/documentation/installation/system-requirement) methods so I’m not going to cover that in this post. Once you have a running instance of Eve-NG you can follow along with how to set up FRR for use within Eve-NG.

## Client Tools

Whether you choose to work from a Windows, Mac or Linux OS you’ll need the following tools to work with Eve-NG and to install FRR:

* VNC
* Telnet
* SSH

It is highly recommended that you install the Eve-NG [Client Integration tools](https://github.com/SmartFinn/eve-ng-integration) for your specific OS.

## Installation

Before we start installing FRR its important to check the FRR [Releases](https://github.com/FRRouting/frr/releases) page. Here you’ll find a list of versions and their supported features as well as the different installation methods for your chosen base operating system.

If you are interested in testing a specific feature you should also review the [Supported Protocols](https://docs.frrouting.org/en/latest/overview.html#supported-protocols-vs-platform) section of the FRR documentation. Here you’ll find the OS and kernel version requirements for all of FRR’s supported features.

It’s important to note that some of the newest features of FRR require the latest linux kernel versions. I’m going to start with a standard installation of the [Ubuntu Server](https://ubuntu.com/download/server) version 24.04.1 LTS and demonstrate how to upgrade to the most recent kernel versions.

The process I’m going to use is well documented in the EVE-NG [Linux How-To](https://www.eve-ng.net/documentation/howto-s/106-howto-create-own-linux-image) documentation. I’ve only added a few steps I’ve found useful for working with FRR.

### Get Ubuntu Server ISO

Using SSH or the console, log in as root to your Eve-NG server and download the latest LTS version of the Ubuntu Server.

```bash
wget https://releases.ubuntu.com/24.04.1/ubuntu-24.04.1-live-server-amd64.iso
```

### Create qemu directories and images

From your Eve-NG server create the required directories and image files. Eve-NG requires the directory be prefixed with linux-. I’m going to install FRR using the latest available Debian package version 7.1. I’ve chosen a base disk size of 16GB but you can use any size you like so long as it meets the Ubuntu server [minimum requirements](https://help.ubuntu.com/lts/serverguide/preparing-to-install.html#system-requirements).

```bash
cd /opt/unetlab/addons/qemu/
mkdir linux-frr-7.1 && cd ./linux-frr-7.1
cp /root/ubuntu-24.04.1-live-server-amd64.iso cdrom.iso
/opt/qemu/bin/qemu-img create -f qcow2 virtioa.qcow2 16G
# Verify the image
qemu-img info virtioa.qcow2
```

The final output should looke like the following:

```bash
image: virtioa.qcow2
file format: qcow2
virtual size: 16G (17179869184 bytes)
disk size: 196K
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits:
```
