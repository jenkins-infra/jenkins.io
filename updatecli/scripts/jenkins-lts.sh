#!/bin/bash

# This script fetches the Jenkins release data, extracts the LTS version numbers, sorts them, and then outputs a specific version based on a "backward" argument.

# -e  causes the script to exit immediately if any command fails.
# -u  treats unset variables as an error and exits the script.
set -eu -o pipefail

# Get the "backward" argument, default to 0 if not provided.
# This argument specifies which version to get, starting from 0 for the latest version.
backward=${1:-0}

# Subtract 1 from backward to start from 0.
backward=$((backward + 1))

# Uses the wget command to download the RSS feed of the Jenkins changelog and outputs it to the standard output (-O -).
wget -q -O - https://www.jenkins.io/changelog-stable/rss.xml | \
# Uses awk to extract the LTS (Long-Term Support) version numbers from the downloaded RSS feed.
# It searches for lines containing <title>Jenkins, splits the third field based on spaces, and prints the second element of the resulting array.
awk -F'[<>]' '/<title>Jenkins /{split($3,a," "); print a[2]}' | \
# Sorts the version numbers in ascending order.
# It uses the sort command with the delimiter set to dot (-t.) and sorts numerically (-n) based on the first, second, and third fields (-k1,1n -k2,2n -k3,3n).
sort -t. -k1,1n -k2,2n -k3,3n | \
# Uses awk to get the last version of each unique base version.
# It creates an associative array x with the first and second fields as the key and the whole version number as the value.
# In the END block, it iterates over the array and prints the values.
awk -F. '{x[$1"."$2]=$0} END {for (i in x) print x[i]}' | \
# Sorts the versions again in ascending order.
sort -t. -k1,1n -k2,2n -k3,3n | \
# Uses the tail command to get the "backward" version.
# It gets the last n lines, where n is the "backward" argument.
# Then it uses the head command to get the first line of the result, which is the desired version.
tail -n $backward | head -n 1
