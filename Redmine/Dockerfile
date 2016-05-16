# Improvement for Redmine Official Container Image
#
# Official Image container does not allow e-mail configuration through environment vars.
# This image aims to solve this issue.
#
# <docker start commands list and examples>
#
#

# Base docker image
FROM redmine
MAINTAINER Thiago Rider Augusto <thiago.rider@gmail.com>

RUN apt-get update && apt-get install -y subversion git

COPY /plugins/* /usr/src/redmine/plugins/

# Set the same entrypoint as the official image does
ENTRYPOINT [ "/docker-entrypoint.sh" ]

# EXPOSE 3000
# CMD ["rails", "server", "-b", "0.0.0.0"]
