---
title: 利用blogdown建立个人博客
author: 桑峰
date: '2021-04-04'
slug: blog
categories:
  - 工具类
tags:
  - blog
  - R
  - blogdown
---

## 准备工作

安装RStudio和R包blogdown。

## 创建博客

在R终端中输入如下代码即可创建默认主题的博客。

```R
blogdown::new_site()
```

另外也可以在RStudio中通过图形界面创建。

1. 鼠标点击File -> New Project... -> New Directory -> Website using blogdown

2. 在弹出的对话框的Directory name内输入本地存放项目的目录名。Create project as subdirectory of: 为项目的父目录。之后点击Create Project 按钮。Hugo theme为博客的主题。这里我们用默认主题。其他主题参考[HUGO主题页面](https://themes.gohugo.io)。

<img src="index.assets/image-20210404173021104.png" style="width:50%;float:center;">

3. 在R终端中输入```blogdown::server_site()```即可在本地部署博客。

## 在Gitee上部署博客

1. 首先需要在gitee上创建仓库，并将Depoly directory更改为 **“.”**（不带引号） 。

<img src="index.assets/image-20210404173840632.png" style="width:50%;float:center;">


2. 在R终端中输入```blogdown::hugo_build(relativeURLs=TRUE)```并运行。可以看到在home目录下生成了public。该目录下即为生成的博客静态页面。此时点击public/index.html是可以在浏览器查看的。

3. 将public中的文件同步到刚创建的gitee或github仓库中。使用的命令如下：

   ```bash
   cd public
   git init
   git add .
   git commit -m 'first commit'
   git remote add origin xxxx.git
   git push -f origin master
   ```

之后就可以通过访问username.gitee.io/home访问自己的博客了。

至此，我们使用blogdown创建了自己的博客，并使用hugo生成了静态页面。最后通过gitee或github发布生成的静态页面。