---
title: 一周小结
author: 桑峰
date: 2021-09-03
slug: blog
output: html_document
categories:
  - Summary
tags:
  - Parallel
  - Python
  - R
  - annot
  - ggplot2
---

## Python并行处理

Python 中的concurrent包提供了对于并行运行的接口，包括进程级并行和线程级并行。下面是一个例子。

```python
from concurrent.futures import ProcessPoolExecutor, ThreadPoolExecutor

def func(a, b):
    return a*b

if __name__ == '__main__':
    n_core = 4
    nums = 10000
    b = 2

    res = [0 for _ in range(nums)]
    with ProcessPoolExecutor(n_core) as pool:
        futures = {pool.submit(func, i, b): i for i in range(1, nums)}
        for f in futures:
            res[futures[f]] = f.result()
    
    res = [0 for _ in range(nums)]
    with ThreadPoolExecutor(n_core) as pool:
        futures = {pool.submit(func, i, b): i for i in range(1, nums)}
        for f in futures:
            res[futures[f]] = f.result()
```

在并行处理时，写明 ***python if __name__ == '__main__'*** 以声明主进程。

进程级并行时，各个并行进程之间独享计算资源（尤其是内存）。对于这个例子，就是会为每个进程拷贝一个 **b** 。这样的好处是进程之间基本不会相互影响，对于I/O型任务的效率提升较大；而缺点是会增加内存的消耗。

对于线程级并行，并行线程之间可以共享变量，因此相比起进程级别的并行，消耗的内存会更少。

> 上面的线程和进程相关的描述是笔者久远的记忆加上自己的理解，可能不准确，但代码可用。

**futures[f]** 会返回 **{pool.submit(func, i, b): i for i in range(1, nums)}** 里面的 **i**。

## R并行处理

R 里面的 **snowfall** 包提供了并行的接口。

```r
library(snowfall)

parallel <- function(x, y) {
  sfCat(print(x))
  return(x * y)
}

b <- 2
sfInit(parallel = TRUE, cpus = 4, slaveOutfile = 'demo.log')
sfLibrary(snowfall)
sfExport('b')
res <- sfSapply(1:5, parallel, b)
sfStop()
```

**sfInit** 用于设置基础环境，其中 **slaveOutfile** 用来重定向并行中的输出信息，方便检测进度。

**sfLibrary** 函数导入并行函数需要的包。

**sfExport** 函数将外部变量和函数导入并行函数。

**sfSapply** 类似 R 中其他的***apply**函数族，返回值类似。

**sfCat** 函数将并行过程中的信息输出。如果在 **slaveOutfile** 中设置了，输出信息将保存到相应的文件中。

## annot文件

**FreeSurfer** 中的函数可以将 **.annot** 文件转换为 **.gii** 文件，命令如下。

```bash
mris_convert --annot lh.aparc.annot lh.white lh.aparc.gii
```

## ggplot2中自定义字体

```r
library(showtext)

font.add('calibri', 'xxx.ttf')
showtext.auto()
ggplot() ...
```

**showtext** 包可以载入外部字体。利用 **font.add** 函数，载入字体文件。**showtext.auto** 函数可以在后面的绘图中自动使用载入的字体。

