#!/bin/bash

# 查询Downie进程是否存在，grep -v grep是去掉grep进程
process=`ps -ef| grep Downie | grep -v grep`;

if [ "$process" == "" ]; then
	open -a Downie;
	echo "打开Downie";
else
	echo "Downie已打开";
fi

# 通过进程数判断进程是否已运行，如果没有就启动程序
#count=`ps -ef|grep Downie|grep -v grep|wc -l`
#echo $count
#if [ "$count" -eq 0 ]; then
#	open -a Downie;
#	echo "打开Downie";
#else
#	echo "Downie已打开";
#fi