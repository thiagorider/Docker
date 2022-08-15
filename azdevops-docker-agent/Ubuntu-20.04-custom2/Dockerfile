FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND=noninteractive
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    dnsutils \
    gnupg \
    gnupg-agent \
    iputils-ping \
    jq \
    libcurl4 \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libnss3-dev \
    libreadline-dev \
    libssl-dev \
    libunwind8 \
    locales \
    netcat \
    openssh-client \
    python3-pip \
    software-properties-common \
    sshpass \
    unzip \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8
ENV LC_ALL=en_US.utf8

# Setup Thirdy Party Repositories
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ focal main" > /etc/apt/sources.list.d/azure.list && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list && \
    echo "deb [arch=amd64] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" > /etc/apt/sources.list.d/microsoft.list
# Setup Thirdy Party Repositories Keys
RUN curl -fsL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    curl -fsL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    curl -fsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg

RUN apt-get update && \
    apt-get install -y \
    azure-cli \
    docker-ce \
    git \
    kubectl \
    && rm -rf /var/lib/apt/lists/*

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Install python
RUN add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update && \
    apt-get install -y \
    python3.6-dev python3.6-venv \
    python3.7-dev python3.7-venv \
    python3.8-dev python3.8-venv \
    python3.9-dev python3.9-venv \
    python3.10-dev python3.10-venv \
    python3.11-dev python3.11-venv \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHON_WORKDIR=/azp/_work/_tool/Python
RUN mkdir -p $PYTHON_WORKDIR
WORKDIR $PYTHON_WORKDIR
RUN for PY_VER_MAJOR in 3.6 3.7 3.8 3.9 3.10 3.11; do \
    echo "* Installing python${PY_VER_MAJOR} *"; \
    PY_VER=$(python${PY_VER_MAJOR} -c "import sys; print('.'.join([f'{val}' for val in sys.version_info[:3]]))") \
    && mkdir -p $PY_VER \
    && ln -s $PY_VER ${PY_VER_MAJOR} \
    && cd $PYTHON_WORKDIR/$PY_VER \
    && python${PY_VER_MAJOR} -m venv x64 \
    && ./x64/bin/pip install --upgrade pip pipenv \
    && python${PY_VER_MAJOR} -m pip install --upgrade pip pipenv \
    && touch x64.complete \
    && cd $PYTHON_WORKDIR; \
    echo -e "* End of installation of python${PY_VER_MAJOR} *\n"; \
    done;

RUN ln -s /usr/bin/python3 /usr/bin/python

# System & Image Cleanup
RUN apt-get clean

FROM build AS deploy
WORKDIR /azp
COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT ["./start.sh"]