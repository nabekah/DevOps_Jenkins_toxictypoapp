FROM openjdk:8-jre

WORKDIR /app

COPY ./target /app/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x  /usr/local/bin/entrypoint.sh
CMD java -jar ./app/toxictypoapp-1.0-SNAPSHOT.jar
# ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
