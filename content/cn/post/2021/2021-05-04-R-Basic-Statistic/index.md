---
title: R语言基本统计
author: 桑峰
date: 2021-05-04
slug: blog
output: html_document
categories:
  - 统计
tags:
  - r
  - lm
  - glm
  - anova
  - t.test
  - cor
  - lme
---

本文为笔者在学习b站up主@[学术数据分析及可视化](https://space.bilibili.com/43536169?spm_id_from=333.788.b_765f7570696e666f.1)相关视频的笔记。文中只是笔者个人的理解，描述也只是便于自己理解。在使用相关内容时，还需要进一步查看相关的手册或帮助文档。

# 相关

cor()用于计算两个向量的相关系数。ggm::pcor()用于计算偏相关系数。这两个函数只能计算相关系数。cor.test(), psych::cor.test和psych::pcor.test()分别计算相关系数和偏相关系数及其显著性检验的结果。

# 差异性

## t检验

t.test()用于进行独立样本或配对样本t检验。要求各组内方差相等。相应的非参数版本为wilcox.test()。

## 方差分析

方差分析要求数据满足三个条件，分别是正态性、方差齐性和独立性。独立性一般在实验设计阶段考虑。这里只讨论前两个条件。

### 对正态性的检验

数据是否满足正态性可以通过直方图hist(), qq图qqplot()和shapiro.test()进行检验。其中shapiro.test()检验的零假设为数据满足正态性。

### 对方差齐性的检验

方差齐性检验可以通过bartlett.test(), leveneTest()和fligner.test()进行。它们的零假设均为各组方差相等。

### 单/多因素方差分析(ANOVA)

使用aov()。TukeyHSD()用于进行事后检验/多重比较。

### 单/多因素重复测量方差分析(ANCOVA)

aov(y~x+Error(subjects/Group))

### 非参数方差分析

其中一种利用重采样的方法使用lmPerm::aovp()，用法与aov()类似。

# 回归

## 回归拟合

lm()。
拟合通常用于数据可视化，涉及两个变量之间的关系。目的是找到两个变量之间最合适的关系。
评价模型好坏的指标有残差标准误$\sqrt{\frac{sum(residual^2)}{n-p-1}}$和决定系数$R^2=1-\frac{RSS}{TSS}$。
anova(fit, fitnull)可以比较拟合模型与零模型之间是否有差异。零模型一般为$\hat{y}=mean(y)$。
包aomisc提供了许多不同函数的拟合函数。以线性和指数函数拟合为例。

### 线性/多项式

`\(y=a+bx+cx^2\)`
drm(y~x, fct=DRC.poly2())等价于lm(y~x+I(x^2)).

### 指数

`\(y=a*exp(k*x)\)`
drm(y~x, fct=DRC.expoDecay())

## 回归分析

回归分析通常用于模型构建预测等，可以包含多个变量。

### 一般线性模型

lm().
AIC()用于比较模型的好坏，值越小模型越好。也可以用anova()对两个模型是否存在差异进行检验。
MASS::stepAIC(), leaps::resubsets()和car::subsets()可以筛选纳入模型的变量。car::vif()可以计算自变量的膨胀系数，值越大表示与其他变量的共线性更强。

### 广义线性模型

把因变量按照特定的分布进行转换，以符合特定的概率分布，再利用该分布进行预测。glm()，需要指定函数分布族family。高斯分布的glm与lm的结果是相同的。
当响应变量为分类变量时，采用logistic（二分类）。glm(formula, data, family=binomial('logit'))。涉及三分类及以上时，可以用nnet::multinom()进行建模分析。

### 线性混合模型

nlme和lme4包提供了相关的函数。nlme::lme(), lme4::lmer(). Eg. lme(Richness~NAP, random=~1|Beach, data) or lmer(Richness~NAP+1|Beach, data).

### 广义线性混合模型

lme4::glmer()和glmmADMB::glmmadmb()提供了相关的建模函数。

### 其他

其他还包括贝叶斯回归模型、广义非线性模型和广义非线性混合模型。

# 参考

B站UP主@[学术数据分析及可视化](https://space.bilibili.com/43536169?spm_id_from=333.788.b_765f7570696e666f.1)。
