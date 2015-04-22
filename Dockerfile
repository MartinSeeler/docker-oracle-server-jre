FROM gliderlabs/alpine
MAINTAINER Martin Seeler <developer@chasmo.de>

# Set correct environment variables.
ENV HOME /root
ENV MAJOR 8
ENV MINOR 45

RUN apk --update add wget ca-certificates

# Download oracle's server jre
WORKDIR /tmp
RUN wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && apk add --allow-untrusted glibc-2.21-r2.apk
RUN wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" &&  apk add --allow-untrusted glibc-bin-2.21-r2.apk 
RUN /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u45-b14/server-jre-8u45-linux-x64.tar.gz -O server-jre.tar.gz
RUN mkdir oracle-server-jre
RUN tar -xzf server-jre.tar.gz -C ./oracle-server-jre
RUN mkdir -p /opt/oracle-server-jre

# Install it in /opt/oracle-server-jre and create symlinks
RUN cp -r /tmp/oracle-server-jre/jdk1.${MAJOR}.0_${MINOR}/* /opt/oracle-server-jre/
RUN ln -s /opt/oracle-server-jre/bin/java /usr/bin/java
RUN chmod ugo+x /usr/bin/java

# Clean up APK when done.
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
