---
title: FreeSurfer笔记之二
author: 桑峰
date: 2022-03-15
slug: blog
output: html_document
categories:
  - FreeSurfer
tags:
  - freesurfer
  - surface
  - curvature
  - vertex
---


# The measures about curvatures

## mris_curvature_stats

?h.smoothwm.xxx.crv is the the binary-curvature files where xxx is the different measures. Detailed descriptation is as follows:

> k1 	maximum curvature
>
> k2 	minimum curvature
>
> K 	Gaussian 	= k1*k2
>
> H	Mean 		= 0.5*(k1+k2)
>
> C	Curvedness 	= sqrt(0.5*(k1*k1+k2*k2))
>
> S	Sharpness 	= (k1 - k2)^2
>
> BE	Bending Energy 	= k1*k1 + k2*k2
>
> SI	Shape Index	= atan((k1+k2)/(k2-k1))
>
> FI	Folding Index	= |k1|*(|k1| - |k2|)

In each file, the corresponding measures for each vertex were saved. And you may read it by read.fs.curv() in R package "freesurferformats".

**Example: mris_curvature_stats -F pial/smoothwm/white -G -o xxx sub-2455 rh**

xxx is the file to save descriptation statistical results. -F is flag of surface name, the default is smoothwm in FreeSurfer Version 7.2.0. -G is calculated a series of derived curvature values from current surface file.

## mris_curvature

It calculated the mean curvature and Gaussian curvature for a surface.

**Example: mris_curvature -w lh.white**

This command will output the lh.white.H and lh.white.K.

**Example: mris_curvature -w -a 10 lh.white**

This command smooth 10 for the original outputs.

## The Integrated Rectified Mean/Gaussian Curvature

The descriptation is MeanCurv is the integral of the absolute value of H and GausCurv is the integral of the absolute value of K.

It seem is taking the absolute vaule for each vertex and multi with the area, and sum for all vertex on the region. (https://www.mail-archive.com/freesurfer@nmr.mgh.harvard.edu/msg55168.html, and https://www.mail-archive.com/freesurfer@nmr.mgh.harvard.edu/msg45618.html).



# Other measures

The area of a the pial/white is ?h.area.pial/?h.area. The ?h.volume and ?h.thickness is the volume and thickness of cortical.
