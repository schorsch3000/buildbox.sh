#!/usr/bin/env bash
set -e
set -x
version="$2"
url="https://nodejs.org/dist/v$version/node-v$version-linux-x64.tar.gz"
cd /prepared
wget -c "$url"
chmod 777 ./*.tar.gz
