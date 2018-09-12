#!/usr/bin/env bash

FILENAME=$1

if [ -z "$FILENAME" ]; then
    echo "Need a filename as the first argument"
    exit 1;
fi;

which pngcrush 2>&1 > /dev/null

if [ $? -ne 0 ]; then
    echo "Must have pngcrush installed"
    exit 1;
fi;

pngcrush -ow -noforce -reduce "$FILENAME"

if [ $? -ne 0 ]; then
    echo "Error crushing ${FILENAME}"
    exit 1;
fi;
