#!/bin/bash

TABLE_PREFIX=sys_user
TEMP_SQL="SELECT count(uid) from ${TABLE_PREFIX}_%s;"
echo ${TEMP_SQL}

MIN=0
MAX=3
SUM=0
for((i=${MIN};i<${MAX};i++));
do
    echo "${TABLE_PREFIX}_${i}"
    printf "${TEMP_SQL}\n" ${i}
    SQL=$(printf "${TEMP_SQL}" ${i})
    echo $SQL
done