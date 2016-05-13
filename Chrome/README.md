## Chrome Dockerfile


This repository contains **Dockerfile** of [Chrome](https://www.google.com/chrome/) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/r/thiagorider/chrome/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Base Docker Image

* [dockerfile/ubuntu](https://registry.hub.docker.com/u/library/ubuntu/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://hub.docker.com/r/thiagorider/chrome/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull thiagorider/chrome`

   (alternatively, you can build an image from Dockerfile: `docker build -t="thiagorider/chrome" github.com/thiagorider/Docker/Chrome`)


### Usage

    docker run -it --net host --cpuset-cpus 0 --memory 512mb -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/Downloads:/root/Downloads -v $HOME/.config/google-chrome/:/data --device /dev/snd -v /dev/shm:/dev/shm --name chrome thiagorider/chrome
