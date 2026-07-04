#!/bin/bash

# 停止所有服务

echo "停止所有服务..."

# 停止 Spring Boot 服务
echo "停止 Spring Boot 服务..."
pkill -f "spring-boot:run"
pkill -f "test-1.0.0.jar"
pkill -f "gateway-1.0.0.jar"

# 停止 Nacos
echo "停止 Nacos..."
cd nacos
./stop-nacos.sh
cd ..

echo ""
echo "所有服务已停止！"
