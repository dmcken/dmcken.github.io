---
title: Juniper logical systems
date: 2024-03-20 00:00:01 -0400
categories: [Networking, Juniper]
tags: [juniper,vMX]
author: dmcken 
comments: false
---


My notes on how to work with logical systems on JunOS.

## Base config:

```
version 17.2R1.13;
system {
    host-name vMX-1;
    root-authentication {
        encrypted-password ""; ## SECRET-DATA
    }
    login {
        user david.mcken {
            uid 2000;
            class super-user;
            authentication {
                encrypted-password ""; ## SECRET-DATA
            }
        }
    }
    services {
        ssh {
            root-login deny;
        }
    }
    syslog {
        user * {
            any emergency;
        }
        file messages {
            any notice;
            authorization info;
        }
        file interactive-commands {
            interactive-commands any;
        }
    }
    processes {
        dhcp-service {
            traceoptions {
                file dhcp_logfile size 10m;
                level all;
                flag all;
            }
        }
    }
}
logical-systems {
    RTR-1 {
        interfaces {
            lt-0/0/10 {
                unit 0;
            }
            lo0 {
                unit 1;
            }
        }
        protocols {
            ospf {
                area 0.0.0.0 {
                    interface lt-0/0/10.0;
                }
            }
        }
        routing-options {
            router-id 1.0.0.1;
            autonomous-system 1;
        }
    }
    RTR-2 {
        interfaces {
            lt-0/0/10 {
                unit 1;
            }
            lo0 {
                unit 2;
            }
        }
        protocols {
            ospf {
                area 0.0.0.0 {
                    interface lt-0/0/10.1;
                }
            }
        }
        routing-options {
            router-id 1.0.0.2;
            autonomous-system 2;
        }
    }
}
chassis {
    fpc 0 {
        pic 0 {
            tunnel-services {
                bandwidth 1g;
            }
        }
    }
}
interfaces {
    lt-0/0/10 {
        unit 0 {
            encapsulation ethernet;
            peer-unit 1;
            family inet {
                address 1.1.1.1/30;
            }
        }
        unit 1 {
            encapsulation ethernet;
            peer-unit 0;
            family inet {
                address 1.1.1.2/30;
            }
        }
    }
    fxp0 {
        unit 0 {
            family inet {
                dhcp {
                    vendor-id Juniper-vmx;
                }
            }
        }
    }
    lo0 {
        unit 1 {
            family inet {
                address 1.0.0.1/32;
            }
        }
        unit 2 {
            family inet {
                address 1.0.0.2/32;
            }
        }
    }
}
```

## Setting and clearing default logical system

```
david.mcken@vMX-1> set cli logical-system RTR-1
Logical system: RTR-1

david.mcken@vMX-1:RTR-1> clear cli logical-system
Cleared default logical system

david.mcken@vMX-1>
```

You now no longer need to keep specifying the logical-system and use commands as if there was no logical system in use.

```
david.mcken@vMX-1:RTR-1&gt; show interfaces terse
Interface               Admin Link Proto    Local                 Remote
lt-0/0/10
lt-0/0/10.0             up    up   inet     1.1.1.1/30
lo0
lo0.1                   up    up   inet     1.0.0.1             --&gt; 0/0

david.mcken@vMX-1:RTR-1&gt; show ospf neighbor
Address          Interface              State     ID               Pri  Dead
1.1.1.2          lt-0/0/10.0            Full      1.0.0.2          128    35

david.mcken@vMX-1:RTR-1&gt; show route

inet.0: 4 destinations, 4 routes (4 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

1.0.0.1/32         *[Direct/0] 00:03:46
                    &gt; via lo0.1
1.1.1.0/30         *[Direct/0] 01:02:43
                    &gt; via lt-0/0/10.0
1.1.1.1/32         *[Local/0] 01:02:43
                      Local via lt-0/0/10.0
224.0.0.5/32       *[OSPF/10] 01:03:26, metric 1
                      MultiRecv

inet6.0: 1 destinations, 1 routes (1 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

ff02::2/128        *[INET6/0] 01:03:26
                      MultiRecv

david.mcken@vMX-1:RTR-1&gt;
```

Thus far most commands seem to lose the logical-system option while you have a default logical-system set.

```
david.mcken@vMX-1&gt; show route logical-system RTR-1

inet.0: 4 destinations, 4 routes (4 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

1.0.0.1/32         *[Direct/0] 00:09:50
                    &gt; via lo0.1
1.1.1.0/30         *[Direct/0] 01:08:47
                    &gt; via lt-0/0/10.0
1.1.1.1/32         *[Local/0] 01:08:47
                      Local via lt-0/0/10.0
224.0.0.5/32       *[OSPF/10] 01:09:30, metric 1
                      MultiRecv

inet6.0: 1 destinations, 1 routes (1 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

ff02::2/128        *[INET6/0] 01:09:30
                      MultiRecv

david.mcken@vMX-1&gt; set cli logical-system RTR-1
Logical system: RTR-1

david.mcken@vMX-1:RTR-1&gt; show route logical-system RTR-2
                                    ^
permission denied.

david.mcken@vMX-1:RTR-1&gt;
```

## Configuration

```
david.mcken@vMX-1:RTR-1&gt; configure
Entering configuration mode

[edit]
david.mcken@vMX-1:RTR-1# show
interfaces {
    lt-0/0/10 {
        unit 0;
    }
    lo0 {
        unit 1;
    }
}
protocols {
    ospf {
        area 0.0.0.0 {
            interface lt-0/0/10.0;
        }
    }
}
routing-options {
    router-id 1.0.0.1;
    autonomous-system 1;
}

[edit]
david.mcken@vMX-1:RTR-1# exit
Exiting configuration mode
```
