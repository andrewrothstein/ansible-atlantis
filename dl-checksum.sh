#!/usr/bin/env sh
VER=${1:-v0.10.0}
DIR=~/Downloads
MIRROR=https://github.com/runatlantis/atlantis/releases/download

dl()
{
    local os=$1
    local arch=$2
    local platform="${os}_${arch}"
    local url=$MIRROR/$VER/atlantis_${platform}.zip
    local lfile=$DIR/atlantis_${platform}_$VER.zip
    if [ ! -e $lfile ];
    then
       wget -q -O $lfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl linux amd64
dl linux 386
dl linux arm
dl darwin amd64


