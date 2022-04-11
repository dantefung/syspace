#!/usr/bin/bash

# 启动zookeeper
docker start zookeeper

# 启动RocketMQ
docker start rmqnamesrv
docker start rmqbroker
docker start rmqconsole


# 启动Redis
docker start redis-test

# 启动mysql
docker start mysql
