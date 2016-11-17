#!/usr/bin/env bash
function _sources_list(){
  echo deb http://httpredir.debian.org/debian jessie main contrib non-free
  echo deb http://httpredir.debian.org/debian jessie-updates main
  echo deb http://security.debian.org jessie/updates main
}
