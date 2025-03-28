---
title: Singularity-03-创建镜像
author: 桑峰
date: 2021-06-01
slug: blog
output: html_document
categories:
  - 服务器
tags:
  - singularity
  - wsl
---

在Windows 10的Linux子系统（**WLS**）中安装singularity(version=2.6.0)，并创建镜像。

在之前多次尝试中发现，在直接创建.simg镜像时会报告错误（Error: no more available loop devices.），导致创建失败。尝试发现可以通过添加**--sandbox**参数解决。完整命令如下：


```bash
sudo singularity build --sandbox image_name library/recipes
```

其中，image_name为镜像的名称，library/recipes可以为shub，docker链接或符合singularity语法的配置文件（config.def）。如果在wsl中，输入上述命令后，提示无法找到此命令，而直接输入singularity可以正常显示相关信息。那么可以为singularity创建链接文件解决。

```bash
sudo ln -s /usr/local/singularity/bin/singularity /usr/bin/singularit
```

配置文件实例：

```bash
Bootstrap: yum

OSVersion: 7

MirrorURL: http://mirror.centos.org/centos-%{OSVERSION}/%{OSVERSION}/os/$basearch/

Include: yum

%labels

    Python version: 3.9.5

    R version: 4.1.0


%post

    yum -y update

    yum -y groupinstall "Development Tools"

    yum install -y gcc gcc-c++ gcc-gfortran java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64

    yum install -y readline-devel bzip2-devel libXt-devel fonts-chinese tcl tcl-devel tclx tk tk-devel mesa-libGLU mesa-libGLU-devel libcurl libcurl-devel xz-devel.x86_64 libjpeg-devel pcre2-devel libtiff-devel libicu-devel which vim

%environment

    export LC_ALL=C
```

奇怪的是，如果把配置文件的名称改为demo.def或test.def，则无法创建镜像。

等创建完成，可以在运行命令中添加**--writable**参数运行镜像，并在镜像中安装相关的软件。

```bash
singularity shell --writable image_name
```

软件安装完成后，可以通过如下命令将镜像重新打包为.simg文件。

```bash
singularity build image_name.simg image_name/
```

### 参考

[1] https://sylabs.io/guides/2.5/admin-guide/

[2] https://sylabs.io/guides/2.6/user-guide/
