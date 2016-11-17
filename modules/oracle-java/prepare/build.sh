#!/usr/bin/env bash
set -e
set -x
version=$(echo "$2" | cut -d- -f1)
url="http://download.oracle.com/otn-pub/java/jdk/$2/jdk-$version-linux-x64.tar.gz"
cd /tmp
mkdir java
chmod 777 java
cd java
wget -c --header "Cookie: oraclelicense=a" "$url"
su hugo -c "/make-jpkg-oraclejava.exp \"$(basename "$url")\""
find -type f -name "*.deb" -exec cp "{}" /prepared/ \;
chmod 777 /prepared/*.deb
