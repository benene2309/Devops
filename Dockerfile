FROM openjdk:8-jdk-alpine

MAINTAINER Jonas Hecht

#VOLUME /tmp


RUN echo 'Add Spring Boot app.jar to Container'

ADD "target/containerized-companies-0.0.1-SNAPSHOT.jar" companies-service.jar


ENV JAVA_OPTS=""
RUN echo 'Fire up our Spring Boot app by default '
# Fire up our Spring Boot app by default
ENTRYPOINT ["java", "-jar", "/companies-service.jar"]
EXPOSE 2222
RUN echo 'end file companies '
