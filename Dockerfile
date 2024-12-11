# Используем официальный образ Maven для сборки
FROM maven:3.8.4-openjdk-11-slim AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл pom.xml и зависимости
COPY pom.xml .

# Собираем зависимости
RUN mvn dependency:go-offline

# Копируем весь проект
COPY . .

# Собираем JAR файл
RUN mvn clean package

# Запускаем приложение
ENTRYPOINT ["java", "-jar", "target/docker_maven-1.0-SNAPSHOT.jar"]