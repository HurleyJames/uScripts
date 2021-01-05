#!/usr/bin/env python3

import urllib
import os
import sys

def _get_file_urls(file_url_txt):
	filepath = []
	file = open(file_url_txt, 'r')
	for line in file.readlines():
        # strip()用于移除字符串头尾指定的字符（只能开头或者结尾），默认删除空格或者换行符
		line = line.strip()
		filepath.append(line)

	file.close()
	return filepath

if __name__ == '__main__':
	file_url_txt = '/Users/hurley/Downloads/list-avgle-I0VmbmTHymz.txt'
	save_dir = 'save_dir/'
	filepath = _get_file_urls(file_url_txt)
	print(filepath)
