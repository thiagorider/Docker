# Postfix
#
# VERSION 0.0.1
#
FROM ubuntu:16.04

MAINTAINER Thiago Rider Augusto <thiago.rider@gmail.com> "https://github.com/thiagorider"

LABEL Description="This image is used to set a smtp server with Postfix"

RUN apt-get update && apt-get install -y \
	postfix \
	mailutils

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 25/tcp 465/tcp 587/tcp

VOLUME /var/log/postfix
VOLUME /var/spool/postfix

# CMD ["", "", ""]

# REFERENCES
# www.krizna.com/ubuntu/setup-mail-server-ubuntu-14-04
#
