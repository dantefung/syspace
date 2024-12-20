#!/bin/bash

<< comment
在Shell脚本中，可以通过位置参数来接收命令行传递的变量。以下是一些基本用法：
位置参数：
$0：脚本本身的名称。
$1, $2, $3, ... : 第一个、第二个、第三个等命令行参数。
$#：传递给脚本的参数个数。
$@：所有参数作为一个单词列表。
$*：所有参数作为一个字符串。
示例： 假设有一个名为 example.sh 的脚本，内容如下：
comment

echo '---------------------这是"$*"的输出---------------------------'
for arg in "$*"
  do
    echo $arg
  done

echo '-----------------------以下为$@的输出，参数列表打印---------------------------'
for arg in "$@"
  do
    echo $arg
  done


echo "脚本名称: $0"
echo "第一个参数: $1"
echo "第二个参数: $2"
echo "参数总数: $#"
echo "所有参数 (作为单词列表): $@"
echo "所有参数 (作为单个字符串): $*"

echo "----测试默认值-----"
param1=${1:-"i'm default_value"}
echo "参数1: $param1"
