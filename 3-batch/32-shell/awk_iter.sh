#!/bin/bash


 while read line 
      do
          #指定awk分隔符为"",则awk会将字符串的每个字符都就视为一个独立的元素
          echo ${line} | awk -F "" '{
              for (i=1;i<NF;i++){
                  #注意这里展示了awk中如何引用单引号
                  if ($i=="'\''"){
                       printf("%s",$(i+1))
                       i++
                  }
              }
              printf("\n")
          }'
     done < awk_test_str.txt
