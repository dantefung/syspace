#!/bin/bash

echo "=== 脚本基本信息 ==="
echo "脚本名称（\$0）     : $0"
echo "总参数个数（\$#）   : $#"
echo "所有参数（\$@）     : $@"
echo "所有参数（\$*）     : $*"

echo ""
echo "=== 逐个参数 ==="
i=1
for arg in "$@"; do
  echo "参数 $i（\$${i})      : $arg"
  ((i++))
done

echo ""
echo "=== 特殊变量示例 ==="
echo "当前用户（\$USER）   : $USER"
echo "当前路径（\$PWD）    : $PWD"
echo "Shell 进程 ID（\$\$） : $$"
