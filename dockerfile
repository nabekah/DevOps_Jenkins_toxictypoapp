FROM openjdk:8-jre

WORKDIR /app

COPY ./target /app

COPY entrypoint.sh entrypoint.sh

RUN chmod +x  entrypoint.sh
#  CMD java -jar toxictypoapp-1.0-SNAPSHOT.jar
#  ENTRYPOINT [ "entrypoint.sh" ]
