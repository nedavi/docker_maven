# Используем базовый образ с Maven и JDK
FROM maven:3.8.5-openjdk-11 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем pom.xml и скачиваем зависимости
COPY pom.xml .
RUN mvn dependency:resolve

# Копируем все остальные файлы и собираем проект
COPY src ./src
RUN mvn package

# Второй этап — создание легковесного образа для запуска
FROM openjdk:11-jre-slim
WORKDIR /app

# Копируем созданный jar-файл из предыдущего этапа
COPY --from=build /app/target/docker_maven-1.0-SNAPSHOT.jar app.jar

# Команда запуска jar-файла
CMD ["java", "-jar", "app.jar"]
