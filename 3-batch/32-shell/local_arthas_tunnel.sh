#!/bin/bash

# 使用代理
# ./local_arthas_tunnel.sh 192.168.1.1 1080
# 不使用代理
# ./local_arthas_tunnel.sh 

PROXY_HOST=$1
PROXY_PORT=$2

if [ -n "$PROXY_HOST" ] && [ -n "$PROXY_PORT" ]; then
  echo "代理服务器  $PROXY_HOST:$PROXY_PORT"
fi

# 检查并下载 arthas-tunnel-server-x.y.z-fatjar.jar
ARTHAS_TUNNEL_JAR="arthas-tunnel-server-4.0.4-fatjar.jar"
# 使用 [ ! -f "$ARTHAS_TUNNEL_JAR" ] 检查文件是否存在
if [ ! -f "$ARTHAS_TUNNEL_JAR" ]; then
    echo '下载 arthas-tunnel-server-x.y.z-fatjar.jar'
    if [ -n "$PROXY_HOST" ] && [ -n "$PROXY_PORT" ]; then
        echo "使用代理下载 $ARTHAS_TUNNEL_JAR"
        curl -x HTTPS_PROXY://$PROXY_HOST:$PROXY_PORT -OL https://github.com/alibaba/arthas/releases/download/arthas-all-4.0.4/$ARTHAS_TUNNEL_JAR
    else 
        curl -OL https://github.com/alibaba/arthas/releases/download/arthas-all-4.0.4/$ARTHAS_TUNNEL_JAR
    fi
else
    echo "$ARTHAS_TUNNEL_JAR 已经存在，跳过下载."
fi

# 检查并下载 arthas-boot.jar
ARTHAS_BOOT_JAR="arthas-boot.jar"
if [ ! -f "$ARTHAS_BOOT_JAR" ]; then
    echo '下载 arthas-boot.jar'
    if [ -n "$PROXY_HOST" ] && [ -n "$PROXY_PORT" ]; then
        echo "使用代理下载 $ARTHAS_BOOT_JAR" 
        curl -x HTTPS_PROXY://$PROXY_HOST:$PROXY_PORT -OL https://alibaba.github.io/arthas/$ARTHAS_BOOT_JAR
    else
        curl -OL https://alibaba.github.io/arthas/$ARTHAS_BOOT_JAR
    fi
else
    echo "$ARTHAS_BOOT_JAR 已经存在，跳过下载."
fi

# 检查是否已经存在 arthas-tunnel-server 进程
# 使用 pgrep -f arthas-tunnel-server 查找包含 arthas-tunnel-server 字样的进程。
if pgrep -f arthas-tunnel-server > /dev/null; then
    echo 'arthas-tunnel-server 已经在运行，跳过启动.'
else
    echo '启动 arthas-tunnel-server'
    # 2>&1：将标准错误重定向到标准输出，确保所有日志都写入同一个文件。
    # & 将命令放到后台运行。
    nohup java -Dserver.port=8081 -jar -Darthas.enable-detail-pages=true $ARTHAS_TUNNEL_JAR > arthas-tunnel-server.log 2>&1 &

    # 睡眠 8s
    sleep 8
fi

# 如果存在arthas进程则杀掉重启
aPid=$(pgrep -f arthas-boot)
if [ -n "$aPid" ]; then
  echo "存在arthas-boot进程$aPid, 杀掉重启."
  kill -9 "$aPid"
fi

echo "删除arthas.log日志, 启动arthas-boot"
rm -rf arthas.log

# 静默 attach 到进程ID为1
#nohup java -jar arthas-boot.jar 1 --tunnel-server 'ws://127.0.0.1:7777/ws' --batch-script get_session.script > arthas.log 2>&1 &
nohup java -jar arthas-boot.jar 1 --tunnel-server 'ws://127.0.0.1:7777/ws' > arthas.log 2>&1 &

echo "启动中, 请稍等..."
# 睡眠10s
sleep 10

# 获取主机的IP地址
ip_address=$(hostname -I | awk '{print $1}')
echo '请在浏览器打开如下链接:'
echo "                       "
echo "http://$ip_address:8081"
echo "                       "
# 提取 agentId
sessionId=$(cat arthas.log | grep -v pid | grep id | awk '{print $2}')
echo "请填写agentId:"
echo "                       "
echo $sessionId
echo "                       "