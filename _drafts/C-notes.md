---
title: C / C++ notes
# date: 2024-04-07 00:00:01 -0400
categories: [c,cpp]
tags: [c,cpp]
author: dmcken
comments: false
---

## Algorithms

* std::transform - can be paralleized

## Containers

* queue


## Logging

Requirements:
* Let it hold onto the std::cout / osyncsctream (C++20).

Options:
*

## Random numbers

High precision random numbers

## Threads

### Threadpool

Requirements:
* Change size of pool
* queues to feed work units
* Enqueue work unit:
  * Pass parameters for threads to work on.

Options:
* boost::asio::thread_pool -

## Troubleshooting

### Memory checks
* valgrind -m