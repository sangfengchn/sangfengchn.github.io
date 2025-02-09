---
title: 下载templateflow
author: 桑峰
date: 2022-02-18
slug: blog
output: html_document
categories:
  - NeuroImage
tags:
  - templateflow
  - fmriprep
---

templateflow中包含了一些典型的神经影像脑模版，可在fmriprep等工具中使用。本文主要介绍如何下载templateflow。

# 准备

GitHub上有它的仓库，但是那只是DataLab的索引，因此直接下载是不能下载到模版文件的。需要通过DataLab下载。

首先，安装DataLab（以Ubuntu 21.10为例）。

```bash
conda install -c conda-forge datalad
# OR
sudo apt-get install datalab
```

# 下载

下载索引文件，并使用DataLab下载模版。

```bash
git clone https://github.com/templateflow/templateflow.git
cd templateflow
# tpl-* 下载所有模版
datalad get -r tpl-fsLR
```

# 通过python下载

笔者在使用datalad下载过程中，会经常遇到进度条长时间不动的情况。而且印象当中，笔者以前用python下载成功过，速度也不是很慢。因此这里将python下载templateflow的方法也追加进来。

首先设置环境变量。

```bash
export TEMPLATEFLOW_HOME=$HOME/.templateflow
```

使用pip安装templateflow包。

```bash
python -m pip install -U templateflow
```

下载templateflow。

```bash
python -c "from templateflow.api import get; get(['MNI152NLin2009cAsym', 'MNI152NLin6Asym', 'OASIS30ANTs', 'MNIPediatricAsym', 'MNIInfant'])"
```

这里可以根据需要下载相应的模版文件。

# 相关链接

templateflow项目地址：https://github.com/templateflow/

DataLad网址：https://www.datalad.org/

python下载参考网址：https://fmriprep.org/en/1.5.9/spaces.html
