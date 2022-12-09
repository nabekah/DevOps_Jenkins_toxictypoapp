FROM maven:3.6.3-openjdk AS builder
WORKDIR /app
COPY pom.xml /app/

COPY . .

RUN mvn verify

FROM openjdk:8-jre-alpine AS RUN

WORKDIR /app

COPY --from=bulder /app/target /app/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x  /usr/local/bin/entrypoint.sh
