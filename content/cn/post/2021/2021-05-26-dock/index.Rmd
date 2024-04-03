---
title: 全屏模式Dock栏不消失
author: 桑峰
date: '2021-05-26'
slug: blog
categories:
  - 工具
tags:
  - Dock
  - bug
  - Catalina
---

### 环境

> OS: MacOS Catalina (10.15.7)

正常情况是无论Dock是否设置自动隐藏，在全屏模式下，它都会自动隐藏。这里采取的解决方法是重置Dock的默认设置，并重启Dock栏。

### 操作

```bash
defaults write com.apple.dock autohide-delay -int 0
defaults write com.apple.dock autohide-time-modifier -float 1.0
killall Dock
```

### 参考

[1] https://blog.csdn.net/santa12138/article/details/111293518
