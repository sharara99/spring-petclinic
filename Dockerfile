# ---------- Stage 1: Build with Maven ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy only pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B --no-transfer-progress

# Copy the rest of the source code
COPY . .

# Build the application
RUN mvn clean verify -DskipTests -B

# ---------- Stage 2: Runtime Image ----------
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the jar from the builder stage
COPY --from=builder /app/target/spring-petclinic-*.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
