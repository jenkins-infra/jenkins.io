#!/bin/bash

set -eux

# Fetch the Jenkins release data
wget -q -O - https://www.jenkins.io/changelog-stable/rss.xml | \
# Use awk to extract the LTS version numbers
awk -F'[<>]' '/<title>Jenkins /{split($3,a," "); print a[2]}' | \
# Use sort to get the versions in order
sort -t. -k1,1n -k2,2n -k3,3n | \
# Use awk to get the last version of each unique base version
awk -F. '{x[$1"."$2]=$0} END {for (i in x) print x[i]}' | \
# Use sort again to get the versions in order
sort -t. -k1,1n -k2,2n -k3,3n | \
# Use tail to get the last three
tail -3