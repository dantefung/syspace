@echo off
echo 禁止PC版微信自动更新...
echo 127.0.0.1 dldir1.qq.com >> %windir%\System32\drivers\etc\hosts
echo 127.0.0.1 dldir1v6.qq.com >> %windir%\System32\drivers\etc\hosts
attrib +r %windir%\System32\drivers\etc\hosts
