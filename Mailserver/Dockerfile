# Postfix
#
# VERSION 0.0.1
#
FROM ubuntu:16.04

MAINTAINER Thiago Rider Augusto <thiago.rider@gmail.com> "https://github.com/thiagorider"

LABEL Description="This image is used to set a smtp server with Postfix+Dovecot(imap/pop3)"

ENV DEBIAN_FRONTEND noninteractive

# Get and install gosu
ENV GOSU_VERSION 1.7
RUN set -x \
		&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
		&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" --no-check-certificate \
		&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" --no-check-certificate \
		&& export GNUPGHOME="$(mktemp -d)" \
		&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
		&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
		&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
		&& chmod +x /usr/local/bin/gosu \
		&& gosu nobody true \
		&& apt-get purge -y --auto-remove ca-certificates wget

# Install mail services
RUN apt-get update && apt-get install -y \
	postfix \
	dovecot-imapd \
	dovecot-pop3d \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 25/tcp 110/tcp 143/tcp 587/tcp 993/tcp 995/tcp

VOLUME /var/log/postfix
VOLUME /var/spool/postfix

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["docker-entrypoint.sh"]

# REFERENCES
# www.krizna.com/ubuntu/setup-mail-server-ubuntu-14-04
#
