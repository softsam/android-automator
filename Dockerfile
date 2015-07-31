FROM debian:latest

MAINTAINER softsam

ENV http_proxy "http://proxy:8080"
ENV https_proxy "http://proxy:8080"

# Add backport repository
RUN echo "# Backport repository"  >> /etc/apt/sources.list && \
    echo deb http://http.debian.net/debian jessie-backports main >> /etc/apt/sources.list

RUN apt-get update && \
    echo y | apt-get install docker.io && \
    apt-get clean && \
    apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Give access to docker host files
VOLUME /var/lib/docker

# Give access to automation directory, containing the apks, robot framework tests and output
VOLUME /root/automation

# Expose port for VNC (to connect to the emulator and see the tests playing live)
EXPOSE 5900

# Docker wrapper from DIND project
ADD https://raw.githubusercontent.com/jpetazzo/dind/master/wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

ADD ./run.sh /run.sh
RUN chmod +x /run.sh

CMD wrapdocker /run.sh