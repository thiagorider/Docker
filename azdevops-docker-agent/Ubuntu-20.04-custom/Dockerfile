FROM ubuntu:20.04

ENV LANG=C.UTF-8

# Install basic distro dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    file \
    ftp \
    git \
    gnupg \
    gss-ntlmssp \
    iproute2 \
    iputils-ping \
    locales \
    netcat \
    make \
    ssh \
    jq \
    lsb-release \
    sudo \
    time \
    unzip \
    wget \
    zip \
    tar \
    software-properties-common \
    python3 \
    python3-pip && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Install Git-LFS
RUN curl -fsSL https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash - && \
	apt-get update -y && apt-get install git-lfs -y

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" && \
    apt-get update -y && apt-get install docker.io -y 

# Install Kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update -y && apt-get install kubectl -y

# Install Google Cloud CLI
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update -y && apt-get install google-cloud-cli -y

# OTHERS
# Install basic node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install nodejs -y

# Install pipenv
RUN pip3 install pipenv

# Install AZD Agent
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Clean APT cache
RUN rm -rf /var/lib/apt/lists/*

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /vsts

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]