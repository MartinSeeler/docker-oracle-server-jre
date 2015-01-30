FROM phusion/baseimage:0.9.15
MAINTAINER Martin Seeler <developer@chasmo.de>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update the system and install all dependencies
RUN apt-get update
RUN apt-get install -y wget

# Download oracle's server jre
WORKDIR /tmp
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/server-jre-8u31-linux-x64.tar.gz -O server-jre.tar.gz
RUN mkdir oracle-server-jre
RUN tar --strip-components=1 -x -f server-jre.tar.gz -C ./oracle-server-jre

# Install it in /opt/oracle-server-jre and create symlinks
RUN mv ./oracle-server-jre /opt
RUN ln -s /opt/oracle-server-jre/bin/java /usr/bin/java
RUN chmod ugo+x /usr/bin/java

# ...put your own build instructions here...

# end of your own build instructions

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
