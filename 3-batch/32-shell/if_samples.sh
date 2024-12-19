


echo "检查文件是否存在"
FILE="example.txt"
if [ -f "$FILE" ]; then
    echo "文件 $FILE 存在."
else
    echo "文件 $FILE 不存在."
fi




echo "检查目录是否存在"
DIR="example_dir"
if [ -d "$DIR" ]; then
    echo "目录 $DIR 存在."
else
    echo "目录 $DIR 不存在."
fi



echo "检查变量是否为空"
VAR=""
if [ -z "$VAR" ]; then
    echo "变量 VAR 为空."
else
    echo "变量 VAR 非空."
fi

echo "检查变量是否非空"
VAR="value"
if [ -n "$VAR" ]; then
    echo "变量 VAR 非空."
else
    echo "变量 VAR 为空."
fi



echo "比较两个字符串"
STR1="hello"
STR2="world"
if [ "$STR1" == "$STR2" ]; then
    echo "字符串相等."
else
    echo "字符串不相等."
fi




echo "比较整数"
NUM1=10
NUM2=20
if [ "$NUM1" -lt "$NUM2" ]; then
    echo "$NUM1 小于 $NUM2."
elif [ "$NUM1" -gt "$NUM2" ]; then
    echo "$NUM1 大于 $NUM2."
else
    echo "$NUM1 等于 $NUM2."
fi



echo "使用逻辑运算符"
VAR1="true"
VAR2="false"
if [ "$VAR1" == "true" ] && [ "$VAR2" == "false" ]; then
    echo "VAR1 为 true 且 VAR2 为 false."
fi


echo "检查命令执行结果"
# if command_to_check; then
#     echo "命令执行成功."
# else
#     echo "命令执行失败."
# fi
