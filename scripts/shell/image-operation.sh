#!/bin/bash
# 图片批处理，包括生成AppIcon、LaunchImage、转.png格式、2x、3x等
# 将该脚本放入到图片文件夹中，用终端运行即可

# 全局临时变量，储存用户选择
user_select=""
# 全局临时变量，储存图片名称
image_name=""
# 默认启动图片的名称
launch_image_name="LaunchImage.png"
# 默认Icon图片名称
icon_image_name="AppIcon.png"

# 判断文件是否存在
isFileExist() {
	temp_file_name=$1
	if [ -f "$temp_file_name" ]; then
		# 文件存在
		echo "*** 文件名称:$temp_file_name ***"
		image_name=$temp_file_name
	else
		# 文件不存在
		echo "*** 文件不存在:$temp_file_name ***"
		echo "*** 请输入文件名称或者路径，例如：LaunchImage.png ***"
		read -f file_name_para
		sleep 0.5
		# 递归调用该方法
		isFileExist "$temp_file_para"
	fi
}

# 判断是否是图片，是返回0，不是返回-1
isImage() {
	# 标准图片的格式有：jpeg | tiff | png | gif | jp2 | pict | bmp | qtif | psd | sgi | tga | jpg
	# 获取输入的图片的文件类型
    imageType=$(sips -g format "$1" | awk -F: '{print $2}')
    # 转换为字符串格式
	imageTypeStr="echo $imageType"
	# 去除空格和换行
	typeStr=$($imageTypeStr | xargs echo -n)
	if [ "$typeStr" = "png" ] || [ "$typeStr" = "jpeg" ] || [ "$typeStr" = "tiff" ] || [ "$typeStr" = "gif" ] || [ "$typeStr" = "jp2" ] || [ "$typeStr" = "pict" ] ||[ "$typeStr" = "bmp" ] || [ "$typeStr" = "qtif" ] || [ "$typeStr" = "psd" ] || [ "$typeStr" = "sgi" ] || [ "$typeStr" = "tga" ] || [ "$typeStr" = "jpg" ]; then
		return 0
	else 
		echo "$-1非图片格式，无法转换"
		return -1
	fi
}