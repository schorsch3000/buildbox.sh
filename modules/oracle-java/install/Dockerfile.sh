#!/usr/bin/env bash

echo "ADD oracle-java*.deb /tmp/$1/"
echo "RUN dpkg -i /tmp/$1/*.deb || true"
echo "RUN apt-get install -y -f"
echo "RUN rm -rf /tmp/$1/*.deb"
echo "RUN ln -s /usr/lib/jvm/jdk-*-oracle-x64/jre/ /usr/lib/jvm/custom"
echo "ENV JAVA_HOME /usr/lib/jvm/custom"
echo "RUN java -version"
