---
title: 远程Jupyter Notebook设置
author: 桑峰
date: 2021-06-24
slug: blog
output: html_document
categories:
  - Python
tags:
  - Jupyter Notebook
  - Remote server
---

通过Jupyter可以使用远端服务器的计算资源，以下是设置步骤。

# 安装Jupyter

```bash
## pip 安装
pip install notebook

## conda安装
conda install -c conda-forge notebook
```

# 服务器端设置

### 生成密码密文：

```bash
jupyter notebook password
Enter password:  
Verify password: 
> [NotebookPasswordApp] Wrote hashed password to /home/you/.jupyter/jupyter_notebook_config.json
```

密文保存在/home/you/.jupyter/jupyter_notebook_config.json文件中。

### 修改配置文件

```bash
## 打开前面生成的配置文件
vim ~/.jupyter/jupyter_notebook_config.py
## 修改配置内容
c.NotebookApp.ip='*'
## 修改成将之前生成的密文
c.NotebookApp.password = u'xxx'
```

### 启动Jupyter

```bash
jupyter notebook --no-browser --port=8889
```

# 本地设置

打开本地终端，输入以下命令：

```bash
ssh -N -f -L localhost:8836:localhost:8889 xxx@ip
```

之后打开浏览器，在地址栏中输入http://localhost:8836即可。

# 参考

[1] https://blog.csdn.net/weixin_40641725/article/details/114636779

[2] https://zhuanlan.zhihu.com/p/166425946
