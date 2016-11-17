#!/usr/bin/env bash
cd "$(dirname "$0")"
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
export FC_DEFAULT="\e[39m"
export FC_BLACK="\e[30m"
export FC_RED="\e[31m"
export FC_GREEN="\e[32m"
export FC_YELLOW="\e[33m"
export FC_BLUE="\e[34m"
export FC_MAGENTA="\e[35m"
export FC_CYAN="\e[36m"
export FC_LIGHT_GRAY="\e[37m"
export FC_DARK_GRAY="\e[90m"
export FC_LIGHT_RED="\e[91m"
export FC_LIGHT_GREEN="\e[92m"
export FC_=LIGHT_YELLOW"\e[93m"
export FC_LIGHT_BLUE="\e[94m"
export FC_LIGHT_MAGENTA="\e[95m"
export FC_LIGHT_CYAN="\e[96m"
export FC_WHITE="\e[97m"

export BC_DEFAULT="\e[49m"
export BC_BLACK="\e[40m"
export BC_RED="\e[41m"
export BC_GREEN="\e[42m"
export BC_YELLOW="\e[43m"
export BC_BLUE="\e[44m"
export BC_MAGENTA="\e[45m"
export BC_CYAN="\e[46m"
export BC_LIGHT_GRAY="\e[47m"
export BC_DARK_GRAY="\e[100m"
export BC_LIGHT_RED="\e[101m"
export BC_LIGHT_GREEN="\e[102m"
export BC_=LIGHT_YELLOW"\e[103m"
export BC_LIGHT_BLUE="\e[104m"
export BC_LIGHT_MAGENTA="\e[105m"
export BC_LIGHT_CYAN="\e[106m"
export BC_WHITE="\e[107m"

export S_BOLD="\e[1m"
export S_DIM="\e[2m"
export S_UNDERLINED="\e[4m"
export S_BLINK="\e[5m"
export S_INV="\e[7m"
export S_HIDDEN="\e[8m"
export export
export R_ALL="\e[0m"
export R_BOLD="\e[21m"
export R_DIM="\e[22m"
export R_UNDERLINED="\e[24m"
export R_BLINK="\e[25m"
export R_INV="\e[27m"
export R_HIDDEN="\e[28m"
function _exec_module (){
    #$1=name $2=param
    set -x
    test -d "modules/$1" || _l_error "module $1 not found"
    test -f "modules/$1/prepare/Dockerfile" && {
      test -d "modules/$1/prepared/$2" || {
        test -d "modules/$1/prepared/$2_tmp" && rm -rf "modules/$1/prepared/$2_tmp"
        mkdir -p "modules/$1/prepared/$2_tmp"
        set -e
        docker build -t "buildbox.sh_$1" "modules/$1/prepare/"
        docker run -i --rm -v "$(realpath "modules/$1/prepared/$2_tmp")":/prepared -t "buildbox.sh_$1" "$1" "$2"
        set +e
        mv "modules/$1/prepared/$2_tmp" "modules/$1/prepared/$2"
      }
    }
    test -d "modules/$1/prepared/$2/" && cp -r "modules/$1/prepared/$2/"* "$dockerfiledir"
    test -f "modules/$1/install/Dockerfile.sh" && "modules/$1/install/Dockerfile.sh" "$1" "$2" >> "$dockerfile"

}
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
function _sources_list(){
  echo deb http://httpredir.debian.org/debian jessie main contrib non-free
  echo deb http://httpredir.debian.org/debian jessie-updates main
  echo deb http://security.debian.org jessie/updates main
}
main(){
  set -e
  set -x
  name=$1
  export dockerfiledir="Dockerfiles/$name"
  test -d "$dockerfiledir" || _l_error "Dockerfiledir $dockerfiledir not present"
  test -f "$dockerfiledir/config.sh" || _l_error "configfile $dockerfiledir/config.sh not present"
  export dockerfile="$dockerfiledir/Dockerfile"
  . "$dockerfiledir/config.sh"
  :>"$dockerfile"
  _sources_list >"$dockerfiledir/sources.list";
  _df_init
  for var in $MODULES
  do
    IFS=":" read -r -a option <<< "$var"
    case "${option[0]}" in
      "add")
        _df_add
        _df_add  "#FROM PARAM $var:"
        _df_add "WORKDIR /tmp"
        _df_add "USER root"
        _exec_module "${option[1]//[^a-zA-Z0-9.-]/}" "${option[2]//[^a-zA-Z0-9.-]/}"
        _df_add "#END  PARAM $var">>"$dockerfile"
        _df_add
        ;;
      *)
        echo "unknown option '${option[0]}'"
        exit 1
        ;;
    esac
 done
}
main "$@"
