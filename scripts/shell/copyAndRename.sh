#!/bin/bash

# 要复制的文件名
cp FileName=seg-900-v1-a1.ts
# 复制的起始文件名的index
firstNum=901
# 复制的最终文件名的index
lastNum=968
# 中间的拼接字段
str1=seg-
# 最后的拼接字段，包括文件后缀名
str2=-v1-a1.ts

while [ $firstNum -le $lastNum ]; do
	# cp 批量复制文件并改成有顺序的文件名
	cp -vf $cpFileName $str1$firstNum$str2
	# 循环加1，改名
	let i+=1
done