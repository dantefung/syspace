#!/bin/bash

echo "接收参数1, 要导出的数据库名:"$1
echo "接收参数2, 要添加的前缀:"$2

echo "开始导出数据..."
#-- 在宿主机上执行，导出数据到容器内/目录下
exportCmd="docker exec -it mysql /bin/bash -c '/usr/bin/mysqldump -t -uroot -p123456 $1 > $1.sql'"
echo "执行命令:"$exportCmd
bash -c "docker exec -it mysql /bin/bash -c '/usr/bin/mysqldump -t -uroot -p123456 $1 > $1.sql'"
#-- 在宿主机上执行, 将容器内/目录下的脚本拷贝到宿主机上
bash -c "docker cp mysql:/$1.sql /mnt/d/db-script/migrate2dms"
echo "处理数据中..."
#-- 修改sql字符rental_
 echo "删除"$1".sql文件中_tbl后缀..."
 sed -i 's/_tbl//g' $1".sql"


 echo "备份原文件"$1".sql, 新文件为:"$1"_ori.sql"
 cp $1".sql" $1"_ori.sql"

echo "抓取类似格式的行，找到有用的sql行..."
 grep '`[a-z]*' $1"_ori.sql" > $1".sql"
echo "删除一些无用的语句..." 
 sed -i '/LOCK/d' $1".sql"
 sed -i '/ALTER/d' $1".sql"
 sed -i '/Dumping/d' $1".sql"

echo "替换旧表名为新表名..."
 srcStr=""
 toStr=""
 i=0
 awk '/`[a-z]*([_][a-z]*)*`/{print $3}' $1".sql" | uniq | while read line
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