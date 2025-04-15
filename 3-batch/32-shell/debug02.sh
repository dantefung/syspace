#!/bin/bash

# 定义颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}=== 脚本基本信息 ===${NC}"
echo -e "${BLUE}脚本名称（\$0）     :${NC} ${GREEN}$0${NC}"
echo -e "${BLUE}总参数个数（\$#）   :${NC} ${GREEN}#$#${NC}"
echo -e "${BLUE}所有参数（\$@）     :${NC} ${GREEN}$@${NC}"
echo -e "${BLUE}所有参数（\$*）     :${NC} ${GREEN}$*${NC}"

echo ""
echo -e "${YELLOW}=== 逐个参数 ===${NC}"
i=1
for arg in "$@"; do
  echo -e "${BLUE}参数 $i（\$${i})      :${NC} ${GREEN}$arg${NC}"
  ((i++))
done

echo ""
echo -e "${YELLOW}=== 特殊变量示例 ===${NC}"
echo -e "${BLUE}当前用户（\$USER）   :${NC} ${GREEN}$USER${NC}"
echo -e "${BLUE}当前路径（\$PWD）    :${NC} ${GREEN}$PWD${NC}"
echo -e "${BLUE}Shell 进程 ID（\$\$） :${NC} ${GREEN}$$${NC}"
