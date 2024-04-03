---
title: FreeSurfer笔记之一
author: 桑峰
date: 2022-03-11
slug: blog
output: html_document
categories:
  - FreeSurfer
tags:
  - freesurfer
  - surface
  - t1w
---

## Outputs

FreeSurfer首先去除颅骨（stripped skull），生成brainmask.mgz文件，并进一步分出灰质、白质和皮下结构，保存在aseg.mgz文件中。与此同时，得到白质/灰质的初步估计（?h.orig），随后对分界面进行进一步的调整得到?j.white。在?h.white的基础上，分界面继续向外膨胀得到?h.pial，并进一步膨胀得到?h.inflated。?h.sphere为?h.inflated膨胀形成的球面。可以用来与其他空间图像进行配准（例如fsaverage）。


recon-all命令中的-qcache可以生成fsaverage空间中的且经过平滑后的数据。

### label文件夹

.ctab文件为颜色表（color table），存储不同atlas定义脑区的颜色。.annot文件为分区信息，其中包含每个vertex所属的脑区等信息。.label文件保存所有vertex所属脑区编号和坐标。

### surf文件夹
?h.area为midthickness表面的面积，?h.area.pial为灰质（软脑膜）表面的面积。?h.sulc为沟回宽度。

### stats文件夹

保存不同分区下的灰质指标。

## 命令

### mris_preproc

将个体皮层空间中的指标文件投射到fsavergae等标准皮层空间。


#### Example-1

Resample abcXX-anat/surf/lh.thickness onto fsaverage:

```bash
mris_preproc --s abc01-anat \
             --s abc02-anat \
             --s abc03-anat \
             --s abc04-anat \
             --target fsaverage \
             --hemi lh \
             --meas thickness \
             --out abc-lh-thickness.mgh
```

#### Example-2

Same as #1 but smooths by 5mm fwhm:

```bash
mris_preproc --s abc01-anat \
             --s abc02-anat \
             --s abc03-anat \
             --s abc04-anat \
             --target fsaverage \
             --hemi lh \
             --meas thickness \ 
             --fwhm 5 \
             --out abc-lh-thickness.sm5.mgh
```

### mri_glmfit

GLM建模统计。

### mri_glmfit-sim

多重比较校正。

### mri_vol2vol / mri_vol2surf / mri_surf2surf

体素/皮层空间到体素/皮层空间的投射。

#### Example-1

将fsaverage空间中的prcellation文件（aaa.annot）转换到个体皮层空间（bbb.annot）。

```bash
mri_surf2surf --hemi lh \
  --srcsubject fsaverage \
  --sval-annot aaa.annot \
  --trgsubject sub-xxx \
  --trgsurfval bbb.annot
```

### mris_calc

类似fslmath，对图像进行计算。


### fs皮层空间到MNI体素空间

首先需要对一个标准空间中的图像进行recon-all处理，这里以ch2.nii.gz为例。（参考B站up[\@七彩神经](https://space.bilibili.com/567290402/?spm_id_from=333.999.0.0)）

```bash

recon-all -s ch2 -i ch2.nii.gz -all

# 将fsaverage空间中的label文件转换到个体的皮层空间
mri_label2label --srclabel xxx \
                --srcsubject fsaverage \
                --trgsubject ch2 \
                --trglabel xxx \
                --regmethod surface \
                --hemi xxx

# 生成个体体素空间到皮层空间的映射关系
tkregister2 --mov xxx/ch2/mri/orig.mgz \
            --noedit \
            --s ch2 \
            --regheader \
            --reg register.dat

# 将个体皮层空间中的label转换为体素空间中的.nii文件
mri_label2vol --label xxx \
              --temp xxx/ch2/mri/orig.mgz \
              --subject ch2 \
              --hemi xxx \
              --o xxx \
              --proj frac 0.1 0.1 \
              --fillthresh 0.5 \
              --reg register.dat
```

## 参考

[1]: [FreeSurferWiki](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferWiki)

[2]: [Andy's Brain Book](https://andysbrainbook.readthedocs.io/en/latest/)
