---
title: 笔记-RMarkdown和ggplot2
author: 桑峰
date: 2022-07-10
slug: blog
output: html_document
categories:
  - visualization
tags:
  - rmarkdown
  - ggplot2
---

# R Markdown图表交叉引用

在R Markdown中给图表添加引用是首先需要在文件的输出格式设置为以下三种之一。

```r
output:
  # bookdown::word_document2: default
  bookdown::html_document2: default
  # bookdown::pdf_document2: default
```

其次在绘制图表时需要添加标签，如下图<a href="#fig:fig-demo">1</a>所示：

<div class="figure">
<img src="./img/demo.png" alt="这是一个示例。"  />
<p class="caption"><span id="fig:fig-demo"></span>Figure 1: 这是一个示例。</p>
</div>

其中fig-demo为图片的标签。在文中引用时，输入**\<a href="#fig:fig-demo">1</a>**即可自动添加图片引用。

# ggplot2添加标签

## 修改坐标轴端点样式

坐标轴端点样式可以通过如下命令修改，下图<a href="#fig:fig-round">2</a>、图<a href="#fig:fig-butt">3</a>和图<a href="#fig:fig-square">4</a>分别是三种端点样式的是示例图。

```r
theme(axis.line = element_line(lineend='round'))
```

<div class="figure">
<img src="./img/demo-round.png" alt="这是round。"  />
<p class="caption"><span id="fig:fig-round"></span>Figure 2: 这是round。</p>
</div>

<div class="figure">
<img src="./img/demo-butt.png" alt="这是butt。"  />
<p class="caption"><span id="fig:fig-butt"></span>Figure 3: 这是butt。</p>
</div>

<div class="figure">
<img src="./img/demo-square.png" alt="这是square。"  />
<p class="caption"><span id="fig:fig-square"></span>Figure 4: 这是square。</p>
</div>

## 给柱状图添加标签

给柱状图每个柱子添加相应的数字标签可以通过geom_text函数完成，显示效果如图<a href="#fig:fig-label">5</a>所示。

```r
tmpData %>%
  count(MRIAGE_group, Sex) %>%
  ggplot(aes(x = MRIAGE_group, y = n, fill = Sex, label = n)) +
  geom_bar(stat = 'identity', position = position_dodge()) +
  geom_text(position = position_dodge(width = 0.9), vjust = -0.1) +
  labs(x = 'Age', y = 'Number') +
  theme_classic(base_size = 20) +
  theme(
    axis.line = element_line(lineend='round'),
    axis.text.x = element_text(angle = 45, hjust = 0.5, vjust = 0.6))
```

<div class="figure">
<img src="./img/demo-label.png" alt="柱状图标签。"  />
<p class="caption"><span id="fig:fig-label"></span>Figure 5: 柱状图标签。</p>
</div>


