#!/usr/bin/bash

# 启动zookeeper
docker stop zookeeper

# 启动RocketMQ
docker stop rmqnamesrv
docker stop rmqbroker
docker stop rmqconsole


# 启动Redis
docker stop redis-test

# 启动mysql
docker stop mysql
