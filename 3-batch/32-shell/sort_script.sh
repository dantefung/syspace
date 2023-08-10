#!/bin/bash

# 国际额外服务-全部公司-全局配置
#sequence1="301,215,9,1010,8,7,13,200,1008,204,203,14,10,10214,55,52,4,10219,10218"
#sequence2="10,13,14,4,7,8,9,1010,1008,52,55,301,10219,10218,10214,200,203,204,215"
#
#sorted_sequence1=$(echo "$sequence1" | tr ',' '\n' | sort -n | paste -s -d ',' -)
#sorted_sequence2=$(echo "$sequence2" | tr ',' '\n' | sort -n | paste -s -d ',' -)
#
#echo "排序后的序列1: $sorted_sequence1"
#echo "排序后的序列2: $sorted_sequence2"
#
#if [ "$sorted_sequence1" = "$sorted_sequence2" ]; then
#    echo "序列1和序列2相同"
#else
#    echo "序列1和序列2不相同"
#fi


# 定义一个比较函数
compare_sequences() {
    local sequence1="$1"
    local sequence2="$2"

    sorted_sequence1=$(echo "$sequence1" | tr ',' '\n' | sort -n | paste -s -d ',' -)
    sorted_sequence2=$(echo "$sequence2" | tr ',' '\n' | sort -n | paste -s -d ',' -)

    echo "排序后的序列1: $sorted_sequence1"
    echo "排序后的序列2: $sorted_sequence2"

    if [ "$sorted_sequence1" = "$sorted_sequence2" ]; then
        echo "序列1和序列2相同"
    else
        echo "序列1和序列2不相同"
    fi
}

echo '开始校验, 国际额外服务|全部公司|全部国家|全部城市'

<<comment
$2 值来自:

comment

compare_sequences "301,215,9,1010,8,7,13,200,1008,204,203,14,10,10214,55,52,4,10219,10218" \
                  "10,13,14,4,7,8,9,1010,1008,52,55,301,10219,10218,10214,200,203,204,215"






