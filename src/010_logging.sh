#!/usr/bin/env bash
function _l_debug(){
  echo -e "$FC_GREEN$1\n$R_ALL"

}
function _l_notice(){
  echo -e "$FC_YELLOW$1\n$R_ALL"

}
function _l_warning(){
  echo -e "$FC_RED$1\n$R_ALL"

}
function _l_error(){
  echo -e "$FC_LIGHT_RED$1\n$R_ALL"
  exit 1

}
