---
title: 作图-R语言中的冲击图(Alluvial)
author: 桑峰
date: 2021-05-08
slug: blog
output: html_document
categories:
  - 作图
tags:
  - r
  - alluvial
  - 冲击图
---

冲击图可以非常直观地描述一组观测值的多个离散变量的情况。

R语言中生成冲击图需要依赖包**ggalluvial**. 使用以下代码安装依赖包。


```R
install.packages("ggalluvial")
```

# 示例数据

这里用随机生成的虚拟数据作为示例数据**data**。**data**中每一行表示一个观测值。其中，每个观测值有三个维度的属性，分别是**A**，**B**和**C**。对于**A**属性，有**3**个水平，分别是**a1**，**a2**和**a3**。**B**属性有**2**个水平，**C**属性有**4**个水平。总共包含**3000**个观测值。因此，**data**的大小为**3000\*3**.


```r
data <- data.frame(
  id = seq(1:3000),
  A = rep(c('a1', 'a2', 'a3'), 1000),
  B = rep(c('b1', 'b2'), 1500),
  C = rep(c('c1', 'c2', 'c3', 'c4'), 750)
)
knitr::kable(head(data))
```



| id|A  |B  |C  |
|--:|:--|:--|:--|
|  1|a1 |b1 |c1 |
|  2|a2 |b2 |c2 |
|  3|a3 |b1 |c3 |
|  4|a1 |b2 |c4 |
|  5|a2 |b1 |c1 |
|  6|a3 |b2 |c2 |
将数据转换为长格式数据**data_long**。


```r
library(tidyverse)

data_long <- data %>%
  as_tibble() %>%
  pivot_longer(cols=c(A, B, C), names_to = 'X', values_to = 'Response') %>%
  group_by(X, Response)

data_long %>%
  head() %>%
  knitr::kable()
```



| id|X  |Response |
|--:|:--|:--------|
|  1|A  |a1       |
|  1|B  |b1       |
|  1|C  |c1       |
|  2|A  |a2       |
|  2|B  |b2       |
|  2|C  |c2       |
这里转换为长格式数据的目的在于将**A**，**B**和**C**三个属性和它们的不同水平相互组合。其中**X**表示不同的属性，将来在冲击图中作为**x轴**。**Response**为各属性的不同取值，在图中表示为每个柱子**划分**的段。原始数据中的1行在长格式数据中被拆分成了3行。


# 绘图代码


```r
library(ggalluvial)

ggplot(data_long,
       aes(x = X, stratum = Response, alluvium = id, fill = Response, label = Response)) +
  scale_x_discrete(expand = c(.1, .1)) +
  geom_flow() +
  geom_stratum(alpha = .5) +
  geom_text(stat = "stratum", size = 4) +
  ylab('Number of subjects') +
  xlab('') +
  theme_classic()
```

<img src="{{< blogdown/postref >}}index_files/figure-html/unnamed-chunk-3-1.png" width="672" />


# 参考

1. https://blog.csdn.net/qq_42458954/article/details/109106860
