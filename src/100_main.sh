#!/usr/bin/env bash
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
