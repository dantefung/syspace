#!/bin/bash

# << comment
# 好的，我来一行一行解释这个脚本：

# ---

# **第一行**
# ```bash
# ADDR1=$(redis-cli -h "$SENTINEL_HOST" -p "$SENTINEL_PORT" SENTINEL get-master-addr-by-name "$MASTER_1")
# ```
# - 使用 `redis-cli` 命令连接到 Redis Sentinel。
# - `-h "$SENTINEL_HOST"` 指定 Sentinel 的主机地址。
# - `-p "$SENTINEL_PORT"` 指定 Sentinel 的端口。
# - `SENTINEL get-master-addr-by-name "$MASTER_1"` 是向 Sentinel 查询一个叫做 `$MASTER_1` 的主节点信息（即找出它的 IP 和端口）。
# - 整个命令的输出保存到变量 `ADDR1`。通常输出是两行，第一行是 IP，第二行是端口。

# 返回结果:  
# 1) "192.2.1.163"
# 2) "63379"

# ---

# **第二行**
# ```bash
# IP1=$(echo "$ADDR1" | sed -n 1p)
# ```
# - 从 `ADDR1` 中取出第一行（`sed -n 1p`），也就是主节点的 IP 地址。
# - 赋值到变量 `IP1`。

# ---

# **第三行**
# ```bash
# PORT1=$(echo "$ADDR1" | sed -n 2p)
# ```
# - 从 `ADDR1` 中取出第二行（`sed -n 2p`），也就是主节点的端口号。
# - 赋值到变量 `PORT1`。

# ---

# **第四行**
# ```bash
# echo "$MASTER_1 -> $IP1:$PORT1"
# ```
# - 打印一行，展示 `$MASTER_1` 这个主节点的名称，以及它对应的 IP 和端口，格式像：
#   ```
#   master-name -> 192.168.1.100:6379
#   ```

# ---

# 总结一下：
# 这个脚本就是 **从 Redis Sentinel 查询某个主节点的 IP 和端口，然后打印出来**。

# 要不要我顺便也给你画一个小流程图？🌟  
# （如果要的话，告诉我～）

# 输出示例：
# compare_sentinel_masters.sh
# 🔍 Getting master address for xyz-session-01...
# ercp-session-01 -> 192.168.1.100:63379
# 🔍 Getting master address for xyz-session-02...
# ercp-session-02 -> 192.168.1.101:63379

# ⚠️  两个 master group 指向的是不同的 Redis 实例。

# comment

SENTINEL_HOST="192.168.1.101"
SENTINEL_PORT="27331"

MASTER_1="xyz-session-01"
MASTER_2="xyz-session-02"

echo "🔍 Getting master address for $MASTER_1..."
ADDR1=$(redis-cli -h "$SENTINEL_HOST" -p "$SENTINEL_PORT" SENTINEL get-master-addr-by-name "$MASTER_1")
IP1=$(echo "$ADDR1" | sed -n 1p)
PORT1=$(echo "$ADDR1" | sed -n 2p)
echo "$MASTER_1 -> $IP1:$PORT1"

echo "🔍 Getting master address for $MASTER_2..."
ADDR2=$(redis-cli -h "$SENTINEL_HOST" -p "$SENTINEL_PORT" SENTINEL get-master-addr-by-name "$MASTER_2")
IP2=$(echo "$ADDR2" | sed -n 1p)
PORT2=$(echo "$ADDR2" | sed -n 2p)
echo "$MASTER_2 -> $IP2:$PORT2"

echo
if [ "$IP1:$PORT1" = "$IP2:$PORT2" ]; then
    echo "✅ 两个 master group 指向的是同一个 Redis 实例。"
else
    echo "⚠️  两个 master group 指向的是不同的 Redis 实例。"
fi

