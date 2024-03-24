---
title: Python One-liners
date: 2024-03-20 00:00:01 -0400
categories: [python]
tags: [python]
author: dmcken 
comments: false
---


## Num 001
Looking at https://wiki.mikrotik.com/wiki/Manual:Spanning_Tree_Protocol I wanted to see the hex values for the list of priority values 0, 4096, 8192, 12288, 16384, 20480, 24576, 28672, 32768, 36864, 40960, 45056, 49152, 53248, 57344, 61440


```python
x = [0, 4096, 8192, 12288, 16384, 20480, 24576, 28672, 32768, 36864, 40960, 45056, 49152, 53248, 57344, 61440]

# Yes the inner list can be removed
pprint.pprint(list(zip(x, list(map(lambda x: "{0:x}".format(x), x)))))
```

Output:
```python
[(0, '0'),
 (4096, '1000'),
 (8192, '2000'),
 (12288, '3000'),
 (16384, '4000'),
 (20480, '5000'),
 (24576, '6000'),
 (28672, '7000'),
 (32768, '8000'),
 (36864, '9000'),
 (40960, 'a000'),
 (45056, 'b000'),
 (49152, 'c000'),
 (53248, 'd000'),
 (57344, 'e000'),
 (61440, 'f000')]
 ```
![working-python-one-liner-1](/assets/img/2024-03-20-working-of-python-one-liner-1.png)
