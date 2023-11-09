#!/bin/bash

#计算文件夹内文件行数

folder_path="./"  # 替换为你要计算的文件夹路径
total_lines=0

# 递归函数，计算指定文件夹下所有文本文件的行数
count_lines() {
    local directory="$1"

    # 遍历文件夹下的所有文件和子文件夹
    for item in "$directory"/*; do
        if [ -f "$item" ]; then
            # 如果是文件，统计行数并累加到总行数
            lines=$(wc -l < "$item")
            total_lines=$((total_lines + lines))
        elif [ -d "$item" ]; then
            # 如果是文件夹，递归调用自身
            count_lines "$item"
        fi
    done
}

count_lines "$folder_path"
echo "总行数: $total_lines"
