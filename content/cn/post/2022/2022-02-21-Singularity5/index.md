---
title: Singularity-05-Matlab&fmriprep
author: 桑峰
date: 2022-02-21
slug: blog
output: html_document
categories:
  - Singularity
tags:
  - singularity
  - matlab
  - fmriprep
---

# 运行MATLAB

使用matlab镜像运行matlab可使用如下命令：

```bash
singularity exec matlab-r2020a.img matlab -batch xxx
```

其中matlab-r2020a.img为镜像名称，xxx为matlab脚本，不包含.m。

# 运行fmriprep

*脑院高性能平台最高支持fmriprep版本为20.1.3，版本再高会报告I/O异常的错误。*

在镜像中运行fmriprep的命令（不同版本的命令有些许差异，这里以20.1.3为例）如下：

```bash
singularity exec fmriprep-20.1.3.simg fmriprep data-test/ fres_data-test/ participant \
--skip_bids_validation \
--participant_label 12002 \
-w fwk_data-test/ \
--verbose \
--fs-license-file license_lin.txt
```

其中fmriprep-20.1.3.simg为镜像名称。data-test为存放所有被试的文件夹。

运行smriprep的命令如下：

```bash
singularity exec fmriprep-20.1.3.simg smriprep data-test/ sres_data-test/ participant \
--pariticipant_label 12002 \
-w fwk_data-test/ \
--fs-license-file license_lin.txt
```
