#!/usr/bin/env bash

echo "ADD node-*-linux-x64.tar.gz /tmp/nodejs/"
echo "RUN mkdir -p /opt/nodejs"
echo "RUN cp -rp /tmp/nodejs/node-v*-linux-x64/* /opt/nodejs/"
echo "ENV PATH $PATH:/opt/nodejs/bin/"
echo "RUN node -v"
echo "RUN npm -v"
