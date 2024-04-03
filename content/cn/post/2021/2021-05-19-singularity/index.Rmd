---
title: Singularity-01-安装
author: 桑峰
date: 2021-05-19
slug: blog
output: html_document
categories:
  - 服务器
tags:
  - singularity
  - install
---

简单来讲，Singularity是一种可以跨平台执行的小型虚拟机。在数据分析时，首先往往要搭建运行环境，比如R，python等。为了保证结果的可靠性，通常要保证跨设备环境的一致性。但是在跨运算设备之间搭建相同的环境是一项比较麻烦的事情。因此，如果只搭建一次环境，就可以在各个设备上使用，就比较轻松了。Singularity和Docker就提供了这样的功能。笔者在这里使用Singularity[1]，版本为2.4.6。

## 安装依赖库

### Ubuntu

```bash
sudo apt-get update
sudo apt-get install python dh-autoreconf build-essential libarchive-dev
```

### CentOS

```bash
sudo yum update
sudo yum groupinstall 'Development Tools'
sudo yum install libarchive-devel
```

## 编译安装

```bash
VER=2.4.6
wget https://github.com/singularityware/singularity/releases/download/$VER/singularity-$VER.tar.gz
tar xvf singularity-$VER.tar.gz
cd singularity-$VER
./autogen.sh
./configure --prefix="/usr/local/singularity-${VER}"
make
sudo make install
```

将**/usr/local/singularity-2.4.6/bin**添加进**$PATH**并重新加载配置文件。

```bash
echo "export $PATH=/usr/local/singularity-2.4.6/bin:$PATH" > ~/.bashrc
source ~/.bashrc
```

<center>
    <img style="width:50%;"
    src="./img/iShot2021-05-19 10.37.27.png">
    <br>
    <div style="color:orange; border-bottom: 1px solid #d9d9d9;
    display: inline-block;
    color: #999;
    padding: 2px;">图1. 显示singularity版本</div>
</center>

### 参考

[1]: [https://singularity.lbl.gov/index.html]
