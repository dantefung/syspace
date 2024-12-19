#!/bin/bash

# 获取主机的IP地址
ip_address=$(hostname -I | awk '{print $1}')

echo "当前主机的IP地址是: $ip_address"

<< comment
grep -v 是 grep 命令的一个选项，它的作用是从输入中排除匹配指定模式的行，即显示不匹配的行。
具体来说，-v 代表“invert match”，意思是反转匹配结果。通常情况下，grep 会显示所有与给定模式匹配的行，而加上 -v 后，则会显示所有不匹配该模式的行。
comment

echo $(ifconfig | grep 'inet ' | grep -v 127.0.0.1 | awk '{print $2}' | cut -d: -f2 | head -n 1)
