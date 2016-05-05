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


#ADD https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb

#ADD https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb /src/google-chrome-stable_current_amd64.deb

# Set the same entrypoint as the official image does
ENTRYPOINT [ "chromium-browser" ]
