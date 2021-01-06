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

# 如果图片不是PNG格式，则转化为PNG格式
convertToPng() {
	# 获取输入的图片的文件类型
	imageType=$(sips -g format "$1" | awk -F: '{print $2}')
	# 转换为字符串格式
	typeStr="echo $imageType"
	if [ "$typeStr" = "png" ]; then
		echo "$1为PNG格式的图片，不需要转换"
		# 直接拷贝即可
		cp "$1" PngFolder/"$1"
	else
		echo "$1格式需要转换"
		filename=$1
		# 截取文件名称，截取最后一个.号之前的字符
		filehead=${filename%.*}
		# 转化为PNG格式的图片
		sips -s format png "$1" --out PngFolder/"${filehead}".png
	fi
}

# 自动生成Icon
createIconImage() {
	# -Z等比例按照给定的尺寸缩放最长边
	# 先删除旧文件夹
	rm -rf IconFolder
	# 创建Icon文件夹
	mkdir IconFolder

	icon_image_name=$1
	# 图片尺寸的数组
	icon_array=(20 29 40 58 60 76 80 87 120 152 167 180 1024)
	# 遍历
	for item in "${icon_array[@]}";
	do
		sips -Z "$item" "$icon_image_name" --out IconFolder/AppIcon_"$item"x"$item".png
	done
}

# 自动生成LaunchImage
CreateLaunchImage() {
	# 先删除旧文件夹
	rm -rf LaunchImageFolder
	# 再创建CEB文件夹
	mkdir LaunchImageFolder
	image_name=$1
	# 图片高度
	h_array=(960 1024 1136 1334 1792 2048 2208 2436 2688)
	# 图片宽度
	w_array=(640 768  640  750  828  1536 1242 1125 1242)
	array_count=${#h_array[@]}
	for ((i=0; i<"$array_count"; i++))
	do
		sips -z "${h_array[i]}" "${w_array[i]}" "$image_name" --out LaunchImageFolder/"LaunchImage_${h_array[i]}x${w_array[i]}.png"
		# 个别图片需要横屏图片
		if [ "${h_array[i]}" = 1792 ] || [ "${h_array[i]}" = 2208 ] || [ "${h_array[i]}" = 2436 ] || [ "${h_array[i]}" = 2688 ]; then
			sips -z "${w_array[i]}" "${h_array[i]}" "$image_name" --out LaunchImageFolder/"LaunchImage_${w_array[i]}x${h_array[i]}.png"
		fi
	done
}

# 读取用户输入选择的函数
readUserSelect() {
    # 判断用户输入的选择项是否在数组选项内
    isContain="0"
    temp_select=$1
    select_array=(1 2 3)
    for item in "${select_array[@]}";
    do
        if [ "$item" = "$temp_select" ]; then
            isContain="888"
        fi
    done

    if [ "$isContain" = "888" ]; then
        # 参数有效
        echo "当前用户选择了：$temp_select"
        user_select="$select_para"
	else
		# 参数无效
		echo "请输入所选的正确的操作数字"
		read -r $select_para
		sleep 0.5
		# 递归调用本函数
		readUserSelect "$select_para"
	fi
}

# 主函数
Main() {
	# 提示用户进行选择
    cd "$(dirname "$0")" || exit
    echo "~~~~~~~~~~~~~~~~~~ 输入数字操作(e.g. 输入：1) ~~~~~~~~~~~~~~~"
	echo "~~~~~~~~~ 1 一键生成AppIcon(图片名称需为AppIcon)      ~~~~~~~~"
	echo "~~~~~~~~~ 2 一键生成App启动图(图片名称需为LaunchImage) ~~~~~~~~"
	echo "~~~~~~~~~ 3 一键将所有图片转化为PNG格式                ~~~~~~~~"

    # 读取用户的选择
	readUserSelect "$user_select"
	# 选择的方法
	method="$user_select"
	if [ -n "$method" ]; then
		if [ "$method" = "1" ]; then
			isFileExist "$icon_image_name"
			createIconImage "$image_name"
		elif [ "$method" = "2" ]; then
			isFileExist "$launch_image_name"
			CreateLaunchImage "$image_name"
		elif [ "$method" = "3" ]; then
			convertToPng
		else
			echo "参数输入无效"
		fi
	fi
}

cd "$(dirname "$0")" || exit 0

if [ -z "$1" ]; then
	Main
fi