#!/bin/bash

# Fetches test matrix (platforms + JDKs) from Jenkins CI Jenkinsfiles
# and the package types from the packaging repo.
# Usage: ./fetch-test-configurations.sh [platforms|jdks|packages|yaml]

set -eu -o pipefail

MODE=${1:-yaml}

# These are public URLs, no auth needed
CORE_JF=$(curl -sL "https://raw.githubusercontent.com/jenkinsci/jenkins/master/Jenkinsfile")
ATH_JF=$(curl -sL "https://raw.githubusercontent.com/jenkinsci/acceptance-test-harness/master/Jenkinsfile")
PKG_MK=$(curl -sL "https://raw.githubusercontent.com/jenkinsci/packaging/master/Makefile")

# Parse the 'platforms' and 'jdks' arrays from the axes definition in each Jenkinsfile
CORE_PLATFORMS=$(echo "$CORE_JF" | grep -oP "platforms:\s*\[.*?\]" | head -1 | grep -oP "'[^']+'" | tr -d "'" | sort -u)
ATH_PLATFORMS=$(echo "$ATH_JF" | grep -oP "platforms:\s*\[.*?\]" | head -1 | grep -oP "'[^']+'" | tr -d "'" | sort -u)
ALL_PLATFORMS=$(echo -e "${CORE_PLATFORMS}\n${ATH_PLATFORMS}" | sort -u | grep -v '^$')

CORE_JDKS=$(echo "$CORE_JF" | grep -oP "jdks:\s*\[.*?\]" | head -1 | grep -oP "[0-9]+" | sort -un)
ATH_JDKS=$(echo "$ATH_JF" | grep -oP "jdks:\s*\[.*?\]" | head -1 | grep -oP "[0-9]+" | sort -un)
ALL_JDKS=$(echo -e "${CORE_JDKS}\n${ATH_JDKS}" | sort -un | grep -v '^$')

# The packaging repo builds deb, rpm, and msi — parse from the Makefile's 'package' target
ALL_PACKAGES=$(echo "$PKG_MK" | grep -oP '^package:\s*\K.*' | tr ' ' '\n' | sort -u | grep -v '^$')
# Fallback if the grep didn't find anything
if [ -z "$ALL_PACKAGES" ]; then
  ALL_PACKAGES=$(printf "deb\nrpm\nwar")
fi

case "$MODE" in
  platforms)
    echo "$ALL_PLATFORMS" | tr '\n' ',' | sed 's/,$//'
    ;;
  jdks)
    echo "$ALL_JDKS" | tr '\n' ',' | sed 's/,$//'
    ;;
  packages)
    echo "$ALL_PACKAGES" | tr '\n' ',' | sed 's/,$//'
    ;;
  yaml)
    # Outputs a YAML block that can be inserted into the changelog files
    echo "    tested_configurations:"
    echo "      platforms:"
    echo "$ALL_PLATFORMS" | while read -r platform; do
      echo "        - ${platform}"
    done
    echo "      jdks:"
    echo "$ALL_JDKS" | while read -r jdk; do
      echo "        - ${jdk}"
    done
    echo "      packages:"
    echo "$ALL_PACKAGES" | while read -r pkg; do
      echo "        - ${pkg}"
    done
    echo "      sources:"
    echo "        - title: Core CI"
    echo "          url: https://github.com/jenkinsci/jenkins/blob/master/Jenkinsfile"
    echo "        - title: Acceptance Tests"
    echo "          url: https://github.com/jenkinsci/acceptance-test-harness/blob/master/Jenkinsfile"
    echo "        - title: Packaging"
    echo "          url: https://github.com/jenkinsci/packaging/blob/master/Makefile"
    ;;
  *)
    echo "Usage: $0 [platforms|jdks|packages|yaml]" >&2
    exit 1
    ;;
esac
