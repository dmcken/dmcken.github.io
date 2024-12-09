---
title: Message Broker Comparison
# date: 2024-04-07 00:00:01 -0400
categories: [message broker]
tags: [message broker]
author: dmcken
comments: false
---


Comparison of message brokers (publish/subscribe paradigm).

To compare:
* Apache Kafka
* RabbitMQ
* Redis

Comparisons:
* Subscription:
  * Topic-based
  * Content-based
* QoS Guarantees:
  * Correctness:
    * at most once
    * at least once
    * exactly once
  * Ordering
    * none
    * partitioned ordering
    * global order
* Disk I/O
  * And other bottlenecks
* High availability
* Scalability
* Throughput
* Done

## References
* https://dl.acm.org/doi/10.1145/3093742.3093908
