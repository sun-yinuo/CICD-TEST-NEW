#!/bin/bash

# 项目快速启动脚本

echo "================================"
echo "Spring Cloud Alibaba 测试项目"
echo "================================"
echo ""

# 检查 Nacos 是否已安装
if [ ! -d "nacos/nacos" ]; then
    echo "未检测到 Nacos，正在安装..."
    cd nacos
    ./install-nacos.sh
    cd ..
    echo ""
fi

# 启动 Nacos
echo "1. 启动 Nacos..."
cd nacos
./start-nacos.sh
cd ..
echo ""

# 等待 Nacos 启动
echo "等待 Nacos 启动 (15秒)..."
sleep 15

# 编译项目
echo ""
echo "2. 编译项目..."
mvn clean install -DskipTests
echo ""

# 启动服务
echo "3. 启动微服务..."
echo ""
echo "启动 test 服务 (端口: 8081)..."
cd test
nohup mvn spring-boot:run > test.log 2>&1 &
TEST_PID=$!
echo "test 服务 PID: $TEST_PID"
cd ..

echo ""
echo "等待 test 服务启动 (10秒)..."
sleep 10

echo ""
echo "启动 gateway 服务 (端口: 9000)..."
cd gateway
nohup mvn spring-boot:run > gateway.log 2>&1 &
GATEWAY_PID=$!
echo "gateway 服务 PID: $GATEWAY_PID"
cd ..

echo ""
echo "等待 gateway 服务启动 (10秒)..."
sleep 10

echo ""
echo "================================"
echo "所有服务已启动！"
echo "================================"
echo ""
echo "Nacos 控制台: http://localhost:8848/nacos"
echo "  用户名: nacos"
echo "  密码: nacos"
echo ""
echo "Test 服务: http://localhost:8081/api/hello"
echo "Gateway 访问: http://localhost:9000/test/api/hello"
echo ""
echo "查看日志:"
echo "  Test: tail -f test/test.log"
echo "  Gateway: tail -f gateway/gateway.log"
echo "  Nacos: tail -f nacos/nacos/logs/start.out"
echo ""
echo "停止服务: ./stop-all.sh"
echo "================================"
