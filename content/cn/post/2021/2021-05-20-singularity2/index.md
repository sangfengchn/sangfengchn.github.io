---
title: Singularity-02-常见问题汇总
author: 桑峰
date: 2021-05-20
slug: blog
output: html_document
categories:
  - 服务器
tags:
  - singularity
  - install
---

### ERROR  : Base home directory does not exist within the container: /brain

用沙盒模式创建镜像，然后以交互方式进入镜像后创建/brain目录。之后将沙盒格式的镜像打包为.img文件即可。

```bash
# 创建沙盒镜像
singularity build --sandbox centos7 docker://centos:7

# 以交互方式打开镜像
singularity shell --writable centos7/
Singularity: Invoking an interactive shell within container...

# 镜像内创建缺失目录
Singularity centos7:~/envs> mkdir /brain
Singularity centos7:~/envs> exit

# 重新打包镜像
singularity build centos7.img centos7/
```

### ERROR  : Home directory is not owned by calling user: /usr/local/singularity-2.5.2

报错命令：singularity shell smriprep.simg

解决方法：添加--home xxx参数，这里必须是绝对路径。例如：singularity shell --home /babri/sangf/Desktop/test/ smriprep.simg
