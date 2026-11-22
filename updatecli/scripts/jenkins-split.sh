#!/bin/bash

# Print the newest Jenkins core release at which a plugin was split out of core.
#
# Consumed by updatecli/updatecli.d/jenkins-lts.yaml (source "JenkinsLastSplit"), which
# keeps "a dependency on Jenkins versions newer than X" current in
# content/doc/developer/plugin-development/choosing-jenkins-baseline.adoc
#
# split-plugins.txt columns are: plugin ID, last core release still containing the
# plugin's functionality, implied plugin version. We want the highest value in column 2.
#
# This is the same file the documentation links readers to, and there is no published API
# for it, so it is read straight from the branch. The checks below exist so that a rename
# or a move upstream fails the run instead of writing a garbage value into the docs.

set -euo pipefail

url="https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/split-plugins.txt"

# --fail makes an HTTP error exit non-zero instead of handing us a body that parses as
# data: GitHub answers a missing raw file with "404: Not Found", which is three
# whitespace-separated fields and so survives a plain column-count check.
#
# The awk filter skips comments and blank lines, keeps only three-column rows, and
# requires column 2 to look like a version. sort --version-sort then orders the releases
# numerically, so the answer no longer depends on the file staying in increasing order.
version="$(
  curl --silent --show-error --fail --location "$url" |
    awk '$1 !~ /^#/ && NF == 3 && $2 ~ /^[0-9]+(\.[0-9]+)+$/ { print $2 }' |
    sort --version-sort |
    tail -n 1
)"

if [ -z "${version}" ]; then
  echo "ERROR: no split version found in ${url}" >&2
  exit 1
fi

printf '%s\n' "${version}"
