#!/usr/bin/env python3
# 获取图标文件夹中所有的图标名称，并写入txt文件

import os
import numpy as np

# 路径
path = '/Users/hurley/BigSurIcons/icons/'
# 按字母顺序排序，key=str.casefold是不区分大小写
dir = sorted(os.listdir(path), key=str.casefold)
# 写入txt文件，需要先创建文件
fopen = open('/Users/hurley/BigSurIcons/icons.txt', 'w')
for d in dir:
    # 截取名字，因为图标名称是xxx.icns，所以从倒数第5位截取
	string = '- [x] ' + d[:-5] + '\n'
	fopen.write(string)

fopen.close()