#!/bin/bash

file_path=$1

# Replace '0000-00-00 00:00:00' with '2023-11-17 00:00:00'
#sed -i 's/0000-00-00 00:00:00/2023-11-17 00:00:00/g' "$file_path"

#!/bin/bash

# 定义要替换的字符串
OLD_STRING='0000-00-00 00:00:00'
NEW_STRING='2023-11-17 00:00:00'

# 替换字符串并将结果输出到新文件
sed "s/$OLD_STRING/$NEW_STRING/g" $file_path > output.sql

# 提示替换完成
echo "替换完成，请查看output.sql文件"
