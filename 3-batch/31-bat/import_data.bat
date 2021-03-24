:: DATE: 2021年3月24日 11:20:07
:: AUTHOR: DANTE FUNG
:: DESC: 批量导入某个文件夹下的sql脚本到指定的库里

@echo off  
set errorlevel=0  
  
:: 修改为mysql安装路径   
set path_home_mysql=D:\software\develop\phpstudy\phpstudy_pro\Extensions\MySQL8.0.12\
set path_bin_mysql=%path_home_mysql%bin\  
  
:: 修改为mysql使用的数据名(local_test)   
set database_mysql=local_test  
  
:: 修改为mysql登陆用户名密码(root,sujian)   
set user_mysql=root  
set password_mysql=root  
  
echo %path_bin_mysql%
:: 遍历当前文件夹下的所有sql文件并导入指定的数据库内.
set "target=%cd%"
for /f "delims=" %%a in ('dir /b /a-d "%target%\*.sql"') do (
   echo  "------------------START------------------ "
   echo  开始导入 %%a 文件 ...
   cd %path_bin_mysql%
   mysql -u%user_mysql% -p%password_mysql% %database_mysql% < %%a
   echo  导入 %%a 文件完成!
   echo  "------------------END------------------ "
   echo  "  "
)
pause
::echo %%a
::%path_bin_mysql%mysql -u%user_mysql% -p%password_mysql% %database_mysql% < %%a
::%path_bin_mysql%mysql -u%user_mysql% -p%password_mysql% %database_mysql% < testsql.sql  