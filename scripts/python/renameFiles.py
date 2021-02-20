#!/usr/bin/env python3

import os
import os.path
import re

def get_files_list(dir):
	files_list = []
	oldname_list = []
	for parent, dirnames, filenames in os.walk(dir):
		for filename in filenames:
			# 获取后缀名
			ext = os.path.splitext(filename)[1]
			if ext == '.mp4':
				oldname_list.append([os.path.join(parent, filename)])
				files_list.append([os.path.join(parent, filename.replace('_更多IT资源微信535950311 ', '').replace('(2)', '').replace('_更多IT资源微信535950311', ''))])
	return files_list, oldname_list

if __name__ == '__main__':

	dir = input('请输入路径，结尾加上/\n')

#	dir = '/Users/hurley/Documents/SpringCloud+Vertx+Disruptor金融业撮合交易系统实战'
#	files_list = get_files_list(dir)
	
	files_list = []
	oldname_list = []
	for parent, dirnames, filenames in os.walk(dir):
		for filename in filenames:
			# 获取后缀名
			ext = os.path.splitext(filename)[1]
			if ext == '.mp4':
				# name = re.sub(u"\\（.*?）|\\{.*?}|\\[.*?]|\\【.*?】", "", filename.decode())
				oldname_list.append([os.path.join(parent, filename)])
				files_list.append([os.path.join(parent, filename.replace('_更多IT资源微信535950311 ', '').replace('(2)', '').replace('_更多IT资源微信535950311', ''))])
	
	for i in range(len(files_list)):
		print(oldname_list[i])
		os.rename(oldname_list[i][0], files_list[i][0])
#	print(files_list)