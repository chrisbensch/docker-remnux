FROM ubuntu:20.04

LABEL maintainer="chris.bensch@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ENV SUDO_USER root

RUN apt-get clean && apt-get update \ 
&& apt-get install -y wget bash gnupg2 sudo \ 
&& wget --quiet https://github.com/REMnux/remnux-cli/releases/download/v1.3.3/remnux-cli-linux \
#&& gpg2 --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 22598A94 \ 
&& mv remnux-cli-linux /usr/local/bin/remnux \ 
&& chmod 755 /usr/local/bin/remnux \ 
&& adduser --quiet --disabled-password --shell /bin/bash --home /home/remnux --gecos "REMNUX Analyst" remnux \ 
&& echo "remnux:password" | chpasswd 
RUN apt-get clean && apt-get update
RUN sudo remnux install --mode=addon --user=remnux --verbose

VOLUME ["/data"]
WORKDIR /data

ENTRYPOINT ["/bin/bash"]
