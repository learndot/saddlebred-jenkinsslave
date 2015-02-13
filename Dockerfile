FROM dockerfile/java:oracle-java7
MAINTAINER ServiceRocket Tools

RUN apt-get update && apt-get install -y \
    openssh-server \
    ca-certificates \
    curl \
    apt-transport-https \
    ca-certificates \
    lxc \
    iptables

# Install Docker from Docker Inc. repositories.
RUN echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9 \
  && apt-get update -qq \
  && apt-get install -qqy lxc-docker

# Configure SSH as part of Jenkins slave requirement
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]