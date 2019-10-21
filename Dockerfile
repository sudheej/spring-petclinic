#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package -Dmaven.artifact.threads=20 -XX:+TieredCompilation -XX:TieredStopAtLevel=1

#
# Package stage
#
FROM openjdk:11-jre-slim
COPY --from=build /home/app/target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/demo.jar"]
