FROM debian:8
ENV DEBIAN_FRONTEND noninteractive
RUN useradd -ms /bin/bash hugo
RUN echo "deb http://httpredir.debian.org/debian jessie main contrib non-free" >/etc/apt/sources.list
RUN echo "deb http://httpredir.debian.org/debian jessie-updates main" >>/etc/apt/sources.list
RUN echo "deb http://security.debian.org jessie/updates main" >>/etc/apt/sources.list
RUN apt-get update ;\
    apt-get -y upgrade ;\
    apt-get install -y java-package \
                       expect       \
                       libgtk2.0-0  \
                       libxslt1.1   \
                       wget
ADD *.exp /
ADD build.sh /bin/
RUN chmod +x /bin/build.sh
ENTRYPOINT ["/bin/build.sh"]