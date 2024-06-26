---
title: Python函数参数中的“*”
author: 桑峰
date: 2021-06-17
slug: blog
output: html_document
categories:
  - Python
tags:
  - Python
---

Python中，*除了可用于乘法和乘方运算外，还可以把它放在函数形式参数的前面，用来传递多个参数或进行参数的拆解。下面简单介绍后者的用法。

# 传递多参数

### 示例1 {#demo1}

```python
def f(*x):
    print(x)

f(1, 2, 3, 4)
```
输出：(1, 2, 3, 4)

可见，虽然在定义函数**f()**时，只用了一个形式参数x，但是由于*的存在，再调用该函数时，即便是传递多个参数，也会把多个参数当成一个变量x（这里当作元组处理）来处理。

### 示例2 {#demo2}

```python
def f(**x):
    print(x)
    
f(a=1, b=2, c=3, d=4)
```

输出：{'a': 1, 'b': 2, 'c': 3, 'd': 4}

\*\*也可以接收多个参数，但是跟\*不同的是，\*\*接收带有key的参数，并且将多个key-value形式的参数转换成为一个字典。

# 拆分参数 {#demo3}

```python
def f(*x):
    print(x)

# Test 1
f(1, 2)
# Test 2
f((1, 2))
# Test 3
f(*(1, 2))
```
三次调用的输出分别为：

Test 1: (1, 2)
Test 2: ((1, 2),)
Test 3: (1, 2)

Test 1的结果跟{#demo1}一样，此时的x为两个参数构成的元组。Test 2输入参数变成了一个由两个元素构成的元组，此时的x把这个元组当成一个整体作为它的第一个元素，形成了一个新的元组。Test 3在传递参数时，前面添加了*，此时函数f中的x为输入的元组本身，效果与Test 1相同。

### 参考

[1] https://zhuanlan.zhihu.com/p/93656773
