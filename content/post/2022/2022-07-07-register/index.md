---
title: 配准方法示例
author: 桑峰
date: 2022-07-07
slug: blog
output: html_document
categories:
  - NeuroImage
tags:
  - register
  - ants
  - fsl
---

配准可以把不同空间中的脑影像进行对齐。典型地，在下面场景中就需要用到配准。

> 我们有一个在b空间中（例如，MNI152）的感兴趣区，可我们想的到a空间（例如，个体空间）上感兴趣区中的脑指标。大致的思路是，将b空间中的脑图像和a空间中的脑图像进行配准并保存配准的转换参数。之后将转换参数应用到b空间的感兴趣区图像上就能得到a空间中的感兴趣区图像了。

下面尝试用几种方法实现上述步骤。说明，b.nii.gz和roi.nii.gz都是在b空间中的图像，后者是感兴趣区。目的是的到a空间中的感兴趣区。

## ANTs

```bash
antsRegistrationSyNQuick.sh \
    -d 3 \
    -f a.nii.gz \
    -m b.nii.gz \
    -o b_space-a


antsApplyTransforms -d 3 \
    -i roi.nii.gz \
    -r a.nii.gz \
    -t b_space-a0GenericAffine.mat \
    -t b_space-a1Warp.nii.gz \
    -o roi_space-a.nii.gz
```

## fsl

fsl在配准的时候通常要经过线性和非线性配准，用到的命令分别是flirt和fnirt。

```bash
flirt -ref a.nii.gz \
  -in b.nii.gz \
  -omat b2a_linWarp.mat \
  -v

# 很慢
fnirt --ref=a.nii.gz \
  --in=b.nii.gz \
  --aff=b2a_linWarp.mat \
  --cout=b2a_nlinWarp \
  --verbose

applywarp --ref=a.nii.gz \
  --in=roi.nii.gz \
  --warp=b2a_nlinWarp.nii.gz \
  --out=roi_space-a.nii.gz \
  -v
```

其他一些有用的命令：

1. 将多个线性配准的变换参数文件合并为一个文件：

```bash
convert_xfm -omat AtoC.mat -concat BtoC.mat AtoB.mat
```

2. 求解逆转换参数

```bash
convert_xfm -omat refvol2invol.mat -inverse invol2refvol.mat
```

3. 应用线性变换参数生成配准后的图像

```bash
flirt -in newvol -ref refvol -out outvol -init invol2refvol.mat -applyxfm
```

