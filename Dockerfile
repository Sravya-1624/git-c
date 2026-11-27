FOR MAVEN-W 
# Stage 1: Build the Maven project
FROM maven:3.9-eclipse-temurin-8 AS build

WORKDIR /app

# Copy project files
COPY pom.xml .
COPY src ./src

# Build WAR file
RUN mvn clean package -DskipTests

# Stage 2: Deploy on Tomcat
FROM tomcat:9.0-jdk8-temurin

# Copy WAR file into Tomcat
COPY --from=build /app/target/maven_web_java.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
