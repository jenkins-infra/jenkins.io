#!/usr/bin/env bash

TARGETPATH=$1

if [ -z "$TARGETPATH" ]; then
    echo "Need a filename or directory as the first argument"
    exit 1;
fi;

which pngcrush 2>&1 > /dev/null

if [ $? -ne 0 ]; then
    echo "Must have pngcrush installed"
    exit 1;
fi;

if [ -d "$TARGETPATH" ]; then
    find "$TARGETPATH" -name *.png -exec pngcrush -ow -noforce -reduce {} ";"
else
    pngcrush -ow -noforce -reduce "$TARGETPATH"
fi;

if [ $? -ne 0 ]; then
    echo "Error crushing ${TARGETPATH}"
    exit 1;
fi;
