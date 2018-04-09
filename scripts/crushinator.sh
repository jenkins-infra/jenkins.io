#!/usr/bin/env bash

FILENAME=$1
OUTPUTFILE="${FILENAME}_pngcrush_`date '+%Y%m%d%H%M'`"

if [ -z $FILENAME ]; then
    echo "Need a filename as the first argument"
    exit 1;
fi;

which pngcrush 2>&1 > /dev/null

if [ $? -ne 0 ]; then
    echo "Must have pngcrush installed"
    exit 1;
fi;


pngcrush -reduce "$FILENAME" "$OUTPUTFILE"

if [ $? -ne 0 ]; then
    echo "Error crushing ${FILENAME} to ${OUTPUTFILE}"
    exit 1;
fi;

mv "$OUTPUTFILE" "$FILENAME"
