#!/usr/bin/env bash

echo "ADD apache-maven-*.tar.gz /tmp/maven/"
echo "RUN mkdir -p /opt/maven"
echo "RUN cp -rp /tmp/maven/apache-maven-*/* /opt/maven/"
echo "ENV PATH $PATH:/opt/maven/bin/"
echo "RUN mvn -v"
