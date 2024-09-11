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

    # 使用 paste -s -d ',' - 命令将排序后的数组重新连接成逗号分隔的字符串。
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

echo '开始校验>>> 国际|额外服务|全部公司|全部国家|全部城市'

<<comment
$2 值来自:

SELECT GROUP_CONCAT(b.type_code)
FROM rental_base_db.value_added_biz_config_tbl a
INNER JOIN rental_base_db.value_added_biz_config_company_tbl c
ON a.id = c.biz_config_id
AND a.host_location = '0'
AND a.service_type = 1
AND c.company_id = '0' 
INNER JOIN rental_base_db.value_added_biz_config_type_code_tbl b
ON b.biz_config_id = a.id

comment

# $1 预期值  $2 数据库查询的实际值
compare_sequences "301,215,9,1010,8,7,13,200,1008,204,203,14,10,10214,55,52,4,10219,10218" \
                  "10,13,14,4,7,8,9,1010,1008,52,55,301,10219,10218,10214,200,203,204,215"


echo '开始校验>>> 国际|额外服务|yesaway|全部国家|全部城市'


<<comment
$2 值来自:

SELECT GROUP_CONCAT(b.type_code)
FROM rental_base_db.value_added_biz_config_tbl a
INNER JOIN rental_base_db.value_added_biz_config_company_tbl c
ON a.id = c.biz_config_id
AND a.host_location = '0'
AND a.service_type = 1
AND c.company_id = '2' 
INNER JOIN rental_base_db.value_added_biz_config_type_code_tbl b
ON b.biz_config_id = a.id

comment

compare_sequences "10217,10215,1301,216,10213,61,62,201,54,206,210,205,212,401,202,213,211,402,209,3,1007,1009,207,214,2,15,10220" \
                "15,2,3,1007,1009,54,61,62,401,402,10217,10213,10215,201,202,1301,205,206,10220,207,209,210,211,212,213,214,216"

echo '开始校验>>> 国际保险配置|全部公司|全部国家|全部城市'

<<comment
$2 值来自:

SELECT GROUP_CONCAT(b.type_code)
FROM rental_base_db.value_added_biz_config_tbl a
INNER JOIN rental_base_db.value_added_biz_config_company_tbl c
ON a.id = c.biz_config_id
AND a.host_location = '0'
AND a.service_type = 2
AND c.company_id = '0' 
INNER JOIN rental_base_db.value_added_biz_config_type_code_tbl b
ON b.biz_config_id = a.id

comment

compare_sequences "7,11,32,34,38,42,48,63,64,65,100,200,201,202,203,204,205,206,207,208,209,210,211,214,215,216" \
                "48,11,200,201,202,203,204,7,205,206,207,208,209,63,64,65,210,211,214,215,216,32,34,38,100,42"


echo '开始校验>>> 国际保险配置|yesaway|新西兰,泰国|全部城市'

<<comment
$2 值来自:

SELECT GROUP_CONCAT(b.type_code)
FROM rental_base_db.value_added_biz_config_tbl a
INNER JOIN rental_base_db.value_added_biz_config_company_tbl c
ON a.id = c.biz_config_id
AND a.host_location = '0'
AND a.service_type = 2
AND c.company_id = '2' 
INNER JOIN rental_base_db.value_added_biz_config_type_code_tbl b
ON b.biz_config_id = a.id

comment
compare_sequences "20220" \
                "20220"


echo '---------------------国内-----------------------'

echo '开始校验>>> 国内额外服务配置|全部公司|中国|全部省份|全部城市'

<<comment
$2 值来自:

-- 国内额外服务配置|全部公司|中国|全部省份|全部城市
SELECT GROUP_CONCAT(b.type_code)
FROM rental_base_db.value_added_biz_config_tbl a
INNER JOIN rental_base_db.value_added_biz_config_company_tbl c
ON a.id = c.biz_config_id
AND a.host_location = '1'
AND a.service_type = 1
AND c.company_id = '0' 
AND a.state_ids LIKE '%[0]%'
INNER JOIN rental_base_db.value_added_biz_config_type_code_tbl b
ON b.biz_config_id = a.id
INNER JOIN rental_base_db.value_added_biz_config_city_tbl d
ON d.biz_config_id = a.id
AND d.city_id = '0'
comment

compare_sequences "10214,203,8,7,9,10216,10" \
                "10,7,8,9,10216,10214,203"

echo '开始校验>>> 国内额外服务雪地胎| 人工校验即可..'
echo '开始校验>>> 国内保险配置| 人工校验即可..'