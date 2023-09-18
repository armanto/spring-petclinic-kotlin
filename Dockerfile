# FROM gradle:4.7.0-jdk8-alpine AS build
FROM gradle:8-jdk17-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build

# FROM openjdk:8-jre-slim
FROM openjdk:17
EXPOSE 8080
COPY --from=build /home/gradle/src/build/libs/spring-petclinic-kotlin-3.1.3.jar /app/
RUN bash -c 'touch /app/spring-petclinic-kotlin-3.1.3.jar'
ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseContainerSupport", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/spring-petclinic-kotlin-3.1.3.jar"]
