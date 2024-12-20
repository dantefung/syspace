@echo off
chcp 65001
title 微信多开
 
:start
set /p num=请输入要打开的微信数量：
 
if "%num%"=="" (
echo 请输入数字
goto start
)
 
set count=0
 
:loop
if %count%==%num% (
goto end
)
 
start "" "D:\WeChat\WeChat.exe"
set /a count+=1
goto loop
 
:end
echo 打开微信完成
pause>nul
