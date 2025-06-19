FROM alpine/git AS source
WORKDIR /app
RUN git clone https://github.com/artisantek/docker-sample-java-webapp.git
	
FROM maven AS build
WORKDIR /app
COPY --from=source /app/docker-sample-java-webapp/. /app
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar javawebapp.jar
CMD ["java", "-jar", "javawebapp.jar"]
