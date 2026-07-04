# Spring Cloud Alibaba 测试项目

这是一个基于 Spring Boot 4.0 和 Spring Cloud Alibaba 的微服务测试项目。

## 项目结构

```
cicd-test/
├── test/           # 测试服务模块 (端口: 8081)
├── gateway/        # 网关模块 (端口: 9000)
└── nacos/          # Nacos 服务注册中心
```

## 技术栈

- **Spring Boot**: 4.0.0
- **Spring Cloud**: 2024.0.0
- **Spring Cloud Alibaba**: 2025.1.0.0
- **Nacos**: 2.5.0
- **Java**: 17

## 模块说明

### 1. test 模块 (端口: 8081)

测试服务模块，提供简单的 REST API 接口。

**接口:**
- `GET /api/hello` - 返回问候信息
- `GET /api/health` - 健康检查

**服务名:** `test-service`

### 2. gateway 模块 (端口: 9000)

Spring Cloud Gateway 网关模块，使用 Nacos 服务发现，通过 `lb://` 负载均衡路由到 test 服务。

**路由配置:**
- `/test/**` -> `lb://test-service`

访问示例: `http://localhost:9000/test/api/hello`

## 快速开始

### 1. 启动 Nacos

```bash
cd nacos
./start-nacos.sh
```

访问 Nacos 控制台: http://localhost:8848/nacos
- 用户名: `nacos`
- 密码: `nacos`

### 2. 编译项目

```bash
mvn clean install
```

### 3. 启动 test 服务

```bash
cd test
mvn spring-boot:run
```

或者运行:
```bash
java -jar test/target/test.jar
```

### 4. 启动 gateway 服务

```bash
cd gateway
mvn spring-boot:run
```

或者运行:
```bash
java -jar gateway/target/gateway.jar
```

## 测试

### 直接访问 test 服务

```bash
curl http://localhost:8081/api/hello
```

### 通过网关访问

```bash
curl http://localhost:9000/test/api/hello
```

## 停止服务

停止 Nacos:
```bash
cd nacos
./stop-nacos.sh
```

## Nacos 配置

两个服务都配置了 Nacos 服务发现:

```yaml
spring:
  cloud:
    nacos:
      discovery:
        server-addr: localhost:8848
        namespace: public
        group: DEFAULT_GROUP
```

## 常见问题

### 1. 端口已被占用

确保端口 8081 (test)、9000 (gateway)、8848 (nacos) 没有被其他程序占用。

### 2. Nacos 连接失败

确保 Nacos 已经启动，可以通过浏览器访问 http://localhost:8848/nacos

### 3. 网关路由 404

检查:
1. test 服务是否已启动
2. test 服务是否已在 Nacos 注册成功（在 Nacos 控制台查看服务列表）
3. 网关路由配置是否正确

## 开发建议

- 修改代码后使用 `mvn clean package -DskipTests` 或 `mvn clean install -DskipTests` 重新编译
- 查看日志了解服务状态
- 在 Nacos 控制台监控服务注册情况

## License

MIT
