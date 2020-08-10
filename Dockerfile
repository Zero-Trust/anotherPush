FROM ubuntu:latest

RUN apt install -y git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


