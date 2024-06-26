---
title: 医学影像技术笔记-01-DICOM文件方向
author: 桑峰
date: 2021-06-02
slug: blog
output: html_document
categories:
  - 医学影像
tags:
  - dicom
---

本文为B站up主[@智能医学成像-贾广](https://space.bilibili.com/475985153?spm_id_from=333.788.b_765f7570696e666f.1)相关视频的笔记。

**DICOM** (Digital Imaging and Communications in Medicine) 是医学成像领域通用的数据格式，被广泛应用于各种医学成像设备当中，包括但不限于CT、超声、核磁共振等设备。

# DICOM文件方向

DICOM文件以病人为中心，它的指向或朝向（orientation）通过头文件中的一些字段标识。这些字段包括：

> (0x0008, 0x5100), Patient Position
>
> (0x0020, 0x0032), Image Position
> 
> (0x0020, 0x0037), Image Orientation
>
> (0x0028, 0x0030), Pixel Spacing
> 
> (0x0018, 0x0050), Slice Thickness

### Tag: (0x0008, 0x5100)

用来记录病人进入扫描仪中的朝向或姿势。它的值为**[H | F] F { [P | S] | D[R | L] }**。**[ ]**或**{ }**限定取值范围，**｜**表示在**[ ]**限定的范围内二者取其一。**[H | F]F**表示头或脚先进入扫描仪，**[P | S]**表示面朝上或下，**D[R | L]**表示侧卧面朝右或左。例如，*HFP表示病人头部先进入扫描仪，并且面朝上*。

### Tag: (0x0020, 0x0032)

描述图像**第一个像素**（左上角）的坐标(x, y, z)。这里以**病人**为中心，x的正方向表示病人的左边，y的正方向表示病人的后边，z的正方向表示病人的上面。

### Tag: (0x0020, 0x0037)

该字段包含6个不超过16字节的数字，前三个表示图像矩阵从左往右的方向与图像坐标轴x、y和z的余弦值，后三个表示图像矩阵从上往下的方向与坐标轴x、y和z的余弦值。

例如图1，该文件在(0x0020, 0x0037)处的值为*0020,0037,Image Orientation (Patient)=1e-016\\1\\0\\0.00523601152635\\-1e-016\\-0.9999862919977*，近似为**(0, 1, 0, 0, 0, -1)**表示图像从左往右的方向为病人从前往后的方向，即图像的右侧为病人的后侧（第二位为+1）；图像从上往下的方向为病人从上往下的方向，及图像的下面，就是病人的下面（第六位为-1）。当然，这里的示例数据是**矢状位**扫描的，图像的朝向和病人位置的关系比较明显，但对于冠状位采集的影像，通过该字段可以确认影像左右与病人左右的对应关系。


<center>
    <img style="width:50%;" 
    src="./img/Snipaste_2021-06-02_20-53-02.png">
    <br>
    <div style="color:orange; border-bottom: 1px solid #d9d9d9;
    display: inline-block;
    color: #999;
    padding: 2px;">图1. DICOM图像实例</div>
</center>


### 参考

[1] https://space.bilibili.com/475985153?spm_id_from=333.788.b_765f7570696e666f.1
