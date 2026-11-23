FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /workspace
COPY pom.xml ./
COPY src ./src
COPY web ./web
RUN mvn --batch-mode --no-transfer-progress clean package

FROM tomcat:11-jdk17-temurin

COPY --from=build /workspace/target/Site.war /usr/local/tomcat/webapps/Site.war

ENV PORT=8080
EXPOSE 8080
