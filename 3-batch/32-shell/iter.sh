#!/bin/bash

echo "接收参数1:"$1
 awk '/`[a-z]*[_]*[a-z]*`/{print $3}' rental_company_db4.sql | while read line
 do
    echo $line
    echo $line | sed -e 's/`//g'
    # sed 查找结果赋值给变量
    target=$(echo $line | sed -e 's/`//g')
    echo $target
    # 字符串拼接
    tmp="rentcar_company_"$target
    echo "测试字符串拼接:"$tmp
    target=$1$target
    echo $target

done
