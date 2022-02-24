#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/runatlantis/atlantis/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3
    local platform="${os}_${arch}"
    local url=$MIRROR/$ver/atlantis_${platform}.zip
    local lfile=$DIR/atlantis_${platform}_${ver}.zip
    if [ ! -e $lfile ];
    then
       wget -q -O $lfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform `sha256sum $lfile | awk '{print $1}'`
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux 386
    dl $ver linux amd64
    dl $ver linux arm
    dl $ver linux arm64
    dl $ver windows 386
    dl $ver windows amd64
}

dl_ver ${1:-v0.18.2}
