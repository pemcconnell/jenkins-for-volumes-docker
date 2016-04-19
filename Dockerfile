FROM jenkinsci/jenkins:2.0-rc-1

USER root

# gosu
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && curl -sSL -o /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
  && curl -sSL -o /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

COPY volume-permissions.sh /usr/local/bin/volume-permissions.sh

ENV JAVA_OPTS="-Xmx8192m"

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/volume-permissions.sh"]
