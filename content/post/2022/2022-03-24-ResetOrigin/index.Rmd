---
title: 对PET图像进行归中心处理
author: 桑峰
date: 2022-03-24
slug: blog
output: html_document
categories:
  - SPM
tags:
  - pet
  - fdg
---

本段代码参考自：https://github.com/DlutMedimgGroup/Chinese-Brain-PET-Template/blob/master/Matlab%20Scripts/Reset_Origin.m

```matlab
%对图像进行归中心的处理
function [] = Reset_Origin(ROOT)
niftiRootPath = fullfile(ROOT, '*.nii');
niftiSubs = dir(niftiRootPath);
%归中心处理
for i = 1:numel(niftiSubs)
    disp(fullfile(ROOT, niftiSubs(i).name))%显示当前处理图像名称
    st.vol = spm_vol(fullfile(ROOT, niftiSubs(i).name));
    vs = st.vol.mat\eye(4);
    vs(1:3,4) = (st.vol.dim+1)/2;
    spm_get_space(st.vol.fname,inv(vs));
end
end
```
