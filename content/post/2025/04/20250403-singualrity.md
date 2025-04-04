---
title: Singularity Installation
author: 桑峰
date: 2025-04-03
slug: blog
output: html_document
categories:
  - toolbox
tags:
  - singularity
  - install
---

刚发现之前写的sigularity安装步骤中，无法下载相应版本的源代码。因此，笔者尝试按照官方文档[^1]的说明，尝试安装新版(**singularityCE 4.3.0**)，并记录下如下步骤。

说明：环境为win11的wsl，版本为ubuntu 20.04.6 LST.

## 安装依赖

```bash
sudo apt-get install conmon
# Ensure repositories are up-to-date
sudo apt-get update
# Install debian packages for dependencies
sudo apt-get install -y \
   autoconf \
   automake \
   cryptsetup \
   fuse2fs \
   git \
   fuse \
   libfuse-dev \
   libseccomp-dev \
   libtool \
   pkg-config \
   runc \
   squashfs-tools \
   squashfs-tools-ng \
   uidmap \
   wget \
   zlib1g-dev
```

## 安装Go

SingularityCE是Go语言编写的，因此除上述依赖外，还需要安装Go语言。

```bash
export VERSION=1.24.1 OS=linux ARCH=amd64 && \
    wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz && \
    sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz && \
    rm go$VERSION.$OS-$ARCH.tar.gz
```

设置环境变量。

```bash
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
    source ~/.bashrc
```

## 编译安装sigularity

```bash
./mconfig --without-libsubid && \
    make -C ./builddir && \
    sudo make -C ./builddir install
```

笔者在生成makefile时，添加了 **--without-libsubid** 参数，是因为如果不添加此标记，无法生成正确的makefile。并且在该版本的系统上，无法安装libsubid-dev。

至此，如果顺利的话，singularity就已经安装好了。其文件位置在 **/uar/local/bin/singularity** .


[^1]: https://docs.sylabs.io/guides/4.3/admin-guide/installation.html
