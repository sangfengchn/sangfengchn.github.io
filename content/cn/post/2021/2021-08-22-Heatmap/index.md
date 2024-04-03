---
title: Python作图-Heatmap
author: 桑峰
date: 2021-08-22
slug: blog
output: html_document
categories:
  - Python
tags:
  - heatmap
  - seaborn
  - matplotlib
---

本文用于记录笔者在使用seaborn绘制heatmap中遇到的一些问题和解决方法。

完整的代码如下所示：

```python
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import matplotlib.ticker as ticker
sns.set_theme(style="white")

mat = np.random.rand(68*68)
mat = mat.reshape((68, 68))
labels = pd.DataFrame({'Name': range(1, 69)})


cmap = sns.color_palette('flare', as_cmap=True)

font = fm.FontProperties(fname='Resource/font/calibri.ttf')

p = sns.heatmap(
    mat,
    mask=(mat==0),
    cmap=cmap,
    square=True,
    xticklabels=True,
    yticklabels=True,
    center=0.75,
    vmin=0.5)

ax = p.figure.axes[0]
ax.axvline(34, color='k', alpha=0.8, linestyle='-', linewidth=0.8)
ax.axhline(34, color='k', alpha=0.8, linestyle='-', linewidth=0.8)
ax.set_title('Title of Heatmap', fontproperties=font, fontsize=14)
ax.set_xticklabels(labels['Name'], fontproperties=font, fontsize=4)
ax.set_yticklabels(labels['Name'], fontproperties=font, fontsize=4)

barax = p.figure.axes[1]
barax.set_ylabel('Mean Value', fontproperties=font, fontsize=12)
barticks = barax.get_yticks()
tickformat = '{:.1f}'
barax.yaxis.set_major_locator(ticker.FixedLocator(barticks))
barax.set_yticklabels([tickformat.format(x) for x in barticks], fontproperties=font, fontsize=10)
barax.tick_params(direction='in', width=0)

plt.savefig('demo.png', bbox_inches='tight', dpi=500)
```

<center>
    <img style="width:50%;" 
    src="./img/fig_1.png">
    <br>
    <div style="color:orange; border-bottom: 1px solid #d9d9d9;
    display: inline-block;
    color: #999;
    padding: 2px;">图1. 示例结果</div>
</center>


# 解释

导入相关包：

```python 
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.font_manager as fm
import matplotlib.ticker as ticker
# 设置显示主题
sns.set_theme(style="white")
```

数据准备：

```python 
# 生成68x68的随机数矩阵
mat = np.random.rand(68*68)
mat = mat.reshape((68, 68))
# 热图标签
labels = pd.DataFrame({'Name': range(1, 69)})
```

颜色映射：

```python 
cmap = sns.color_palette('flare', as_cmap=True)
```

选择matplotlib中的flare配色。如图2所示。

<center>
    <img style="width:50%;" 
    src="./img/fig_2.png">
    <br>
    <div style="color:orange; border-bottom: 1px solid #d9d9d9;
    display: inline-block;
    color: #999;
    padding: 2px;">图2. flare配色</div>
</center>


字体设置：

```python 
font = fm.FontProperties(fname='Resource/font/calibri.ttf')
```

fname为自定义字体存放位置。

绘图：

```python 
p = sns.heatmap(
    mat,
    mask=(mat==0),
    cmap=cmap,
    square=True,
    xticklabels=True,
    yticklabels=True,
    center=0.75,
    vmin=0.5)
```

mat为显示的矩阵；mask是和mat相同大小的0/1矩阵，其中1表示相应位置不在热图中显示；cmap为颜色映射；square为True表示设置热图中每个小格子为正方形；xticklabels和yticklabels为True表示显示热图横纵坐标轴标尺标签；center表示Colorbar中心处颜色对应的数值；vmin为Colorbar中最低颜色对应的数值。

热图区域设置：

```python 
# 获取矩形图对象
ax = p.figure.axes[0]
# 添加竖直线x=34
ax.axvline(34, color='k', alpha=0.8, linestyle='-', linewidth=0.8)
# 添加水平线y=34
ax.axhline(34, color='k', alpha=0.8, linestyle='-', linewidth=0.8)
# 设置标题，并应用自定义字体
ax.set_title('Title of Heatmap', fontproperties=font, fontsize=14)
# 设置横纵坐标轴标尺标签，并应用自定义字体
ax.set_xticklabels(labels['Name'], fontproperties=font, fontsize=4)
ax.set_yticklabels(labels['Name'], fontproperties=font, fontsize=4)
```

该figure中包含两个axes，第一个是矩形图本身，第二个axes是Colorbar的区域。

Colorbar设置：

```python 
# 获取Colorbar对象
barax = p.figure.axes[1]
# 设置Colorbar标题
barax.set_ylabel('Mean Value', fontproperties=font, fontsize=12)
# 获取Colorbar中y轴标尺
barticks = barax.get_yticks()
# 标尺显示数字格式为保留1位小数位的浮点数
tickformat = '{:.1f}'
# 设置y轴标尺，并设置其标签，字体自定义
barax.yaxis.set_major_locator(ticker.FixedLocator(barticks))
barax.set_yticklabels([tickformat.format(x) for x in barticks], fontproperties=font, fontsize=10)
# 设置标尺形状，即坐标轴数字对应的短线。这里为了美观，不显示标尺短线。
barax.tick_params(direction='in', width=0)
```

保存图片：

```python 
# 保存图片，并设为dpi为500
plt.savefig('demo.png', bbox_inches='tight', dpi=500)
```

