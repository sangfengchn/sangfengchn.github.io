---
title: R包安装报错
author: 桑峰
date: '2022-09-09'
slug: blog
categories:
  - 工具类
tags:
  - R
  - cxx
---

# Error: C++14 standard requested but CXX14 is not defined

参考：https://www.zxzyl.com/archives/1283/

升级gcc，并设置r包编译使用的gcc路径。

设置方法：

首先在～/.R目录下新建文件Makevars；

将
