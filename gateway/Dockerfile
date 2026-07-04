# 1. 指定基础镜像：使用极其轻量级的 Alpine Linux + Java 21 运行环境
FROM eclipse-temurin:21-jre-alpine

# 2. 设定工作目录
WORKDIR /app

# 3. 把你在 target 目录下打好的 jar 包，复制进镜像里，并改名叫 app.jar
COPY target/*.jar app.jar

# 4. 告诉 Docker 启动容器时执行什么命令 (就是执行 java -jar app.jar)
ENTRYPOINT ["java", "-jar", "app.jar"]