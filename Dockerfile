FROM gliderlabs/alpine:3.3
MAINTAINER Martin Seeler <developer@chasmo.de>

# Set correct environment variables.
ENV HOME /root
ENV MAJOR 8
ENV MINOR 72

WORKDIR /tmp

RUN apk --update add wget ca-certificates && \
 wget "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-2.23-r0.apk" && \
 wget "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-bin-2.23-r0.apk" && \
 wget "https://github.com/andyshinn/alpine-pkg-glibc/releases/download/unreleased/glibc-i18n-2.23-r0.apk" && \
 apk add --no-cache --allow-untrusted glibc-2.23-r0.apk glibc-bin-2.23-r0.apk glibc-i18n-2.23-r0.apk && \
 /usr/glibc-compat/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true && \
 echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh && \
 wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u72-b15/server-jre-8u72-linux-x64.tar.gz -O server-jre.tar.gz && \
 mkdir oracle-server-jre && \
 tar -xzf server-jre.tar.gz -C ./oracle-server-jre && \
 mkdir -p /opt/oracle-server-jre && \
 cp -r /tmp/oracle-server-jre/jdk1.${MAJOR}.0_${MINOR}/* /opt/oracle-server-jre/ && \
 ln -s /opt/oracle-server-jre/bin/* /usr/bin/ && \
 chmod ugo+x /usr/bin/java && \
 rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
 apk del wget ca-certificates glibc-i18n
