#!/usr/bin/env sh
VER=v0.5.1
DIR=~/Downloads
MIRROR=https://github.com/runatlantis/atlantis/releases/download

dl()
{
    OS=$1
    PLATFORM=$2
    wget -O $DIR/atlantis_${OS}_${PLATFORM}_$VER.zip $MIRROR/$VER/atlantis_${OS}_$PLATFORM.zip
}

dl linux amd64
dl linux 386
dl linux arm
dl darwin amd64
sha256sum $DIR/atlantis_*_$VER.zip

