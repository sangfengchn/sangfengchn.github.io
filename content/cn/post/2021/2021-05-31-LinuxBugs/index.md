---
title: Linux-sudo xxx 无法找到命令
author: 桑峰
date: 2021-05-31
slug: blog
output: html_document
categories:
  - 服务器
tags:
  - Linux
  - sudo
---

### 问题描述

安装singularity后，将其安装路径通过.bashrc文件添加进PATH，并重新载入.bashrc. 尝试运行singularity，正常可用。但运行sudo singularity时，提示无法找到此命令。

> singularity version: 2.6.0-dist
>
> install path: /usr/local/singularity
>
> OS version: CentOS 7

### 解决方法

在/usr/bin中创建singularity的连接文件即可。

```bash
sudo ln -s /usr/local/singularity/bin/singularity /usr/bin/singularity
```

### 参考

[1] https://blog.csdn.net/tanmx219/article/details/86750322
