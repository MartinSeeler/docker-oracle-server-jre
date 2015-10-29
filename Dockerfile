FROM gliderlabs/alpine:3.2
MAINTAINER Martin Seeler <developer@chasmo.de>

# Set correct environment variables.
ENV HOME /root
ENV MAJOR 8
ENV MINOR 65

WORKDIR /tmp

RUN apk --update add wget ca-certificates && \
 wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && apk add --allow-untrusted glibc-2.21-r2.apk && \
 wget "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" &&  apk add --allow-untrusted glibc-bin-2.21-r2.apk && \
 /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
 wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u65-b17/server-jre-8u65-linux-x64.tar.gz -O server-jre.tar.gz && \
 mkdir oracle-server-jre && \
 tar -xzf server-jre.tar.gz -C ./oracle-server-jre && \
 mkdir -p /opt/oracle-server-jre && \
 cp -r /tmp/oracle-server-jre/jdk1.${MAJOR}.0_${MINOR}/* /opt/oracle-server-jre/ && \
 ln -s /opt/oracle-server-jre/bin/* /usr/bin/ && \
 chmod ugo+x /usr/bin/java && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apk del wget ca-certificates
