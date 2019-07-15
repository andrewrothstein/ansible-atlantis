#!/usr/bin/env sh
VER=v0.8.3
DIR=~/Downloads
MIRROR=https://github.com/runatlantis/atlantis/releases/download

dl()
{
    OS=$1
    PLATFORM=$2
    URL=$MIRROR/$VER/atlantis_${OS}_$PLATFORM.zip
    LFILE=$DIR/atlantis_${OS}_${PLATFORM}_$VER.zip
    if [ ! -e $LFILE ]
    then
       wget -q -O $LFILE $URL
    fi
    printf "    # %s\n" $URL
    printf "    %s-%s: sha256:%s\n" $OS $PLATFORM `sha256sum $LFILE | awk '{print $1}'`
}

printf "  %s:\n" $VER
dl linux amd64
dl linux 386
dl linux arm
dl darwin amd64


