#!/bin/bash
echo "替换旧表名为新表名..."
 srcStr=""
 toStr=""
 i=0
 awk '/`[a-z]*([_][a-z]*)+`/{print $3}' $1".sql" | uniq | while read line
 do
    echo $line
    echo $line | sed -e 's/`//g'
    # sed 查找结果赋值给变量
    target=$(echo $line | sed -e 's/`//g')
    echo $target
    # 字符串拼接
    #tmp="rentcar_company_"$target
    #echo "测试字符串拼接:"$tmp
    srcStr=$line
    toStr=$2$target
    echo $srcStr"--"$toStr
    if [ $i -eq 0 ]; then
      last=""
    else
      last=$i
    fi
    i=$(( $i + 1 ))
    bash -c "sed 's/$srcStr/$toStr/g' $1\"$last.sql\" > $1\"$i.sql\""
 done