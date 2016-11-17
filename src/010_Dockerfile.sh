#!/usr/bin/env bash
function _df_init(){
  _df_add "FROM debian:8"
  _df_add "ENV DEBIAN_FRONTEND noninteractive"
  _df_add "ADD sources.list /etc/apt/"
  _df_add "RUN apt-get update && apt-get upgrade -y"
  _df_add "RUN apt-get install -y wget curl nano"
  _df_add "RUN useradd -ms /bin/bash hugo"
}
function _df_add(){
  echo "$@" >> "$dockerfile"
}
