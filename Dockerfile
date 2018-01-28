FROM debian:9
WORKDIR /tmp
COPY docker-bootstrap.sh ./
RUN ./docker-bootstrap.sh
ENTRYPOINT ["ffmpeg"]
 
