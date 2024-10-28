FROM cerit.io/hubs/minimalnb:27-09-2024-ai

USER root

RUN apt-get update && apt-get upgrade -y

RUN apt-get install wget gpg -y
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
RUN install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
RUN sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
RUN rm -f packages.microsoft.gpg

RUN chmod 1777 /tmp

RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install code -y

RUN apt-get update && apt-get install -y \
  git \
  python3 \
  python3-pip \
  build-essential \
  unzip \
  default-jdk \
  wget && rm -rf /var/lib/apt/lists/*

RUN pip3 --no-cache-dir install --upgrade \
  pip \
  setuptools

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs

RUN git lfs install

# USER jovyan