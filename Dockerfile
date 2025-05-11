FROM ubuntu:22.04

# setup sudo and ubuntu user with sudo rights and no password
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y sudo curl
RUN adduser --disabled-password --gecos '' ubuntu && adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ubuntu
WORKDIR /home/ubuntu

# don't leave the locale as POSIX, otherwise we get the dreaded UnicodeDecodeError
ENV LANG=C.UTF-8

# copy files one at a time to create individual caching layers
COPY install/system.sh /tmp/install/
RUN sudo /tmp/install/system.sh

COPY install/nvidia-repo.sh /tmp/install/
RUN sudo /tmp/install/nvidia-repo.sh

COPY install/nvidia-drivers.sh /tmp/install/
RUN sudo /tmp/install/nvidia-drivers.sh

COPY install/nvidia-cuda.sh /tmp/install/
RUN sudo /tmp/install/nvidia-cuda.sh

COPY install/nvidia-docker.sh /tmp/install/
RUN sudo /tmp/install/nvidia-docker.sh
