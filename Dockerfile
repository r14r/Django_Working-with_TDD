FROM ubuntu:latest

LABEL MAINTAINER="Ralph Göstenmeier"

#
RUN apt-get --yes update
RUN apt-get --yes upgrade

# set environment variables
ENV TZ 'Europe/Berlin'

RUN echo $TZ > /etc/timezone 
RUN apt-get install -y tzdata
RUN rm /etc/localtime && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata 
RUN apt-get clean

#
RUN apt-get install --yes software-properties-common build-essential lsb-release wget curl sudo git vim unzip
RUN apt-get install --yes python3-pip python3-venv
RUN ln -s /usr/bin/python3 /usr/bin/python

#RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
#RUN apt-get install --yes nodejs
#RUN npm -g update npm
#RUN npm -g install yarn npm-check-updates

ARG USERHOME=/home/user

# Create User and gave him sudo permissions
RUN groupadd work -g 1000 && adduser user --uid 1000 --gid 1000 --home $USERHOME --disabled-password --gecos User
RUN echo '%work        ALL=(ALL)       NOPASSWD: ALL' >/etc/sudoers.d/work

#
EXPOSE 3000 
EXPOSE 8000

# -----------------------------------------------------------------------------
USER user


RUN echo "\n\nPATH=$PATH:/home/user/.local/bin" >>/home/user/.bashrc

VOLUME [ "/workspace", "/app" ]
WORKDIR /workspace

COPY requirements.txt /workspace/requirements.txt
WORKDIR /workspace
RUN pip install -r requirements.txt

# -----------------------------------------------------------------------------
CMD ["bash", "-l"]
