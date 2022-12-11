FROM openjdk:8-jre
WORKDIR /app
COPY ./target /app/

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x  /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
