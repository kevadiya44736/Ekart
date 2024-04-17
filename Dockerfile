FROM openjdk:11-jdk-slim AS build

WORKDIR /app

COPY . .

RUN apt-get update && \ 
    apt-get install -y maven && \
    mvn dependency:go-offline

RUN mvn clean package



FROM openjdk:8u151-jdk-alpine3.7

EXPOSE 8070

WORKDIR /app

COPY --from=build /app/target/shopping-cart-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT exec java -jar app.jar
