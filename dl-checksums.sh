#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/runatlantis/atlantis/releases/download

dl()
{
    local ver=$1
    local lchecksums=$2
    local os=$3
    local arch=$4
    local platform="${os}_${arch}"
    local file="atlantis_${platform}.zip"
    local url="${MIRROR}/${ver}/${file}"
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep -e "${file}\$" $lchecksums | awk '{ print $1; }')
}

dl_ver() {
    local ver=$1

    # https://github.com/runatlantis/atlantis/releases/download/v0.33.0/checksums.txt
    local rchecksums="${MIRROR}/${ver}/checksums.txt"

    local lchecksums="${DIR}/atlantis_${ver}_checksums.txt"
    if [ ! -e "$lchecksums" ];
    then
        curl -sSLf -o "$lchecksums" "$rchecksums"
    fi

    printf "  # %s\n" $rchecksums
    printf "  %s:\n" $ver
    dl $ver $lchecksums darwin amd64
    dl $ver $lchecksums darwin arm64
    dl $ver $lchecksums linux 386
    dl $ver $lchecksums linux amd64
    dl $ver $lchecksums linux arm
    dl $ver $lchecksums linux arm64
    dl $ver $lchecksums windows 386
    dl $ver $lchecksums windows amd64
}

dl_ver ${1:-v0.33.0}
