---
title: R语言中的异常处理：TryCatch
author: 桑峰
date: '2024-04-08'
slug: TryCatchInR
categories:
  - 编程
tags:
  - R
---

因为需要在循环里面记录警告和报错对应的循环项。一开始的思路是用`warnings()`获取警告信息，在获取后再用`warning('')`清空警告信息。但在循环结束后，获取警告信息回返回包含多个元素的`list`，似乎清空警告信息没有生效。另外，这种方法没办法处理报错。第二种尝试是使用`tryCatch()`，虽然详细的原理还没弄明白，但目前也能实现一开始的需要了。因此记录一下。

### tryCatch


```r
# create a function maybe raise warning or error.
func <- function(x) {
  if (x %% 2 == 0) {
    warning('a')
  } else if (x %% 3 == 0) {
    stop('b')
  }
}

# the loop
for (i in 1:10) {
  res <- tryCatch({
    func(i)
    print('Normal')
    'Normal'
    }, 
    warning = function(w){
      priint('Warning')
     'Warning'
     }, 
   error = function(e){
     print('Error')
     'Error'
     },
   finally = {
     print('Finally')
   })
  print(sprintf('x: %d, res: %s', i, res))
}
```

```
## [1] "Normal"
## [1] "Finally"
## [1] "x: 1, res: Normal"
## [1] "Error"
## [1] "Finally"
## [1] "x: 2, res: Error"
## [1] "Error"
## [1] "Finally"
## [1] "x: 3, res: Error"
## [1] "Error"
## [1] "Finally"
## [1] "x: 4, res: Error"
## [1] "Normal"
## [1] "Finally"
## [1] "x: 5, res: Normal"
## [1] "Error"
## [1] "Finally"
## [1] "x: 6, res: Error"
## [1] "Normal"
## [1] "Finally"
## [1] "x: 7, res: Normal"
## [1] "Error"
## [1] "Finally"
## [1] "x: 8, res: Error"
## [1] "Error"
## [1] "Finally"
## [1] "x: 9, res: Error"
## [1] "Error"
## [1] "Finally"
## [1] "x: 10, res: Error"
```

观察输出，可以推测，先执行`func(i)`，如果没有异常和报错，执行之后的代码。并在`tryCatch()`结束前执行**finally**；如果有异常或者报错，则直接执行对应的代码，并在`tryCatch()`结束前执行**finally**。
