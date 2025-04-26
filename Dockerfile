#stage1

FROM maven:3.8.3-openjdk-17 AS builder

#set working directory
WORKDIR /app

#copy source code from local to container
COPY . /app

#Build application and skip test cases
RUN mvn clean install -DskipTests=true

#stage2  - app build

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

#Expose application port 

EXPOSE 8080

#start the application

CMD ["java", "-jar", "expenseapp.jar"]