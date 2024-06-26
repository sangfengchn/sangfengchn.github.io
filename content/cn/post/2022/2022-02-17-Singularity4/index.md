---
title: Singularity-04-安装MATLAB
author: 桑峰
date: 2022-02-17
slug: blog
output: html_document
categories:
  - singularity
tags:
  - singularity
  - matlab
  - 服务器
  - centos
---

以下是记录本人在使用学院高性能计算平台运行singularity中遇到的问题以及相应的解决方法，不一定适用于其他场景。

# 建立基础镜像

```bash
sudo singularity build --sandbox tmp/ docker://centos:7
```

尝试过ubuntu:20.04和18.04，在服务器上均会报告“**FATAL: kernel too old**”的错误。Centos6.10和7可以，但是6.10的yum源已经不再支持。因此使用Centos7作为基础镜像。

# 安装MATLAB

这里参考：https://zhuanlan.zhihu.com/p/394298249

需要注意的是，安装之前，需要在系统里面安装一些库文件和编译器，命令如下：

```bash
yum install libX11 libXmu
yum install gcc java-11-openjdk-devel
```

*libXmu中包含libXt.so.6。*

# 后处理

安装好MATLAB后，发现无法通过**singularity exec**去调用。在**/environment**文件中将MATLAB的安装路径添加进PATH环境变量里面也无法直接运行（可能是写入的命令格式有问题，不确定）。之后查到可以定义一个recipe文件（append.def），通过已经生成的镜像重新构建镜像。recipe文件内容如下：

```bash
Bootstrap: localimage
From: tmp/

%environment
        export PATH=/usr/local/matlab/R2020a/bin:$PATH
```

然后重新构建镜像：

```bash
sudo singularity build --sandbox senv-matlab/ append.def
```

构建完成后，需要将镜像打包为可读写的格式（.img文件）。

```bash
sudo singularity build --writable senv-matlab.img senv-matlab/
```

这里生成的senv-matlab.img就可在服务器上使用了，也可在服务器上将其转换为压缩格式（.sif/.sqsh/.simg文件等）。不知道为什么直接在本地（Ubuntu 21.10）压缩后，在本地无运行镜像，会报告如下错误。

```bash
ERROR  : Failed to mount squashfs image in (read only): Invalid argument
ABORT  : Retval = 255
```

# 参考

1. https://zhuanlan.zhihu.com/p/394298249

2. http://tigeroses.com/2021/05/30/singularity-container/
