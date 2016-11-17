#!/usr/bin/env bash
set -e
set -x
version="$2"
cd /prepared
wget -c "http://apache.mirror.digionline.de/maven/maven-3/$version/binaries/apache-maven-$version-bin.tar.gz"
chmod 777 ./*.tar.gz
