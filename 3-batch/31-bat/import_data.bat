:: DATE: 2021��3��24�� 11:20:07
:: AUTHOR: DANTE FUNG
:: DESC: ��������ĳ���ļ����µ�sql�ű���ָ���Ŀ���

@echo off  
set errorlevel=0  
  
:: �޸�Ϊmysql��װ·��   
set path_home_mysql=D:\software\develop\phpstudy\phpstudy_pro\Extensions\MySQL8.0.12\
set path_bin_mysql=%path_home_mysql%bin\  
  
:: �޸�Ϊmysqlʹ�õ�������(local_test)   
set database_mysql=local_test  
  
:: �޸�Ϊmysql��½�û�������(root,sujian)   
set user_mysql=root  
set password_mysql=root  
  
echo %path_bin_mysql%
:: ������ǰ�ļ����µ�����sql�ļ�������ָ�������ݿ���.
set "target=%cd%"
for /f "delims=" %%a in ('dir /b /a-d "%target%\*.sql"') do (
   echo  "------------------START------------------ "
   echo  ��ʼ���� %%a �ļ� ...
   cd %path_bin_mysql%
   mysql -u%user_mysql% -p%password_mysql% %database_mysql% < %%a
   echo  ���� %%a �ļ����!
   echo  "------------------END------------------ "
   echo  "  "
)
pause
::echo %%a
::%path_bin_mysql%mysql -u%user_mysql% -p%password_mysql% %database_mysql% < %%a
::%path_bin_mysql%mysql -u%user_mysql% -p%password_mysql% %database_mysql% < testsql.sql  