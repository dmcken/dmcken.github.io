---
title: Python Text-to-Speech
date: 2024-03-20 00:00:01 -0400
categories: [python]
tags: [python,pyttsx3]
author: dmcken 
comments: false
---

Least viable example of python text to speech.

```python
import pyttsx3
s = pyttsx3.init()
s.say("Testing")
s.runAndWait()
```