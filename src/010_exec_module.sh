#!/usr/bin/env bash
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
