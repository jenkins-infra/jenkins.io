#!/bin/bash

# Injects tested_configurations into the latest release entry of a changelog YAML file.
# Idempotent — won't add the block if it already exists for that version.
# Usage: ./inject-test-configurations.sh <yaml_file> <platforms> <jdks> <packages>
# Example: ./inject-test-configurations.sh content/_data/changelogs/weekly.yml "linux,windows" "21,25" "deb,rpm,war"

set -eu -o pipefail

YAML_FILE=$1
PLATFORMS=$2
JDKS=$3
PACKAGES=${4:-}

if [ ! -f "$YAML_FILE" ]; then
  echo "Error: file not found: $YAML_FILE" >&2
  exit 1
fi

# Find the last version entry in the file (the most recent release)
LAST_VERSION_LINE=$(grep -n "version:" "$YAML_FILE" | tail -1 | cut -d: -f1)

if [ -z "$LAST_VERSION_LINE" ]; then
  echo "Error: no version entry found in $YAML_FILE" >&2
  exit 1
fi

# Check if this version already has tested_configurations
# Look at the next ~20 lines after the version line for an existing block
EXISTING=$(sed -n "${LAST_VERSION_LINE},$((LAST_VERSION_LINE + 20))p" "$YAML_FILE" | grep "tested_configurations" || true)

if [ -n "$EXISTING" ]; then
  echo "tested_configurations already exists for the latest version, skipping"
  exit 0
fi

# Find the 'date:' line right after the version line — we'll insert after it
DATE_LINE=""
for i in $(seq "$LAST_VERSION_LINE" "$((LAST_VERSION_LINE + 5))"); do
  if sed -n "${i}p" "$YAML_FILE" | grep -q "date:"; then
    DATE_LINE=$i
    break
  fi
done

if [ -z "$DATE_LINE" ]; then
  echo "Error: could not find date: line after version at line $LAST_VERSION_LINE" >&2
  exit 1
fi

# Figure out the indentation from the file (weekly.yml uses 4 spaces, lts.yml uses 2)
INDENT=$(sed -n "${LAST_VERSION_LINE}p" "$YAML_FILE" | grep -oP '^\s*' | sed 's/- /  /')

# Build the YAML block to insert
BLOCK="${INDENT}  tested_configurations:"
BLOCK="${BLOCK}\n${INDENT}    platforms:"
IFS=',' read -ra PLAT_ARR <<< "$PLATFORMS"
for p in "${PLAT_ARR[@]}"; do
  BLOCK="${BLOCK}\n${INDENT}      - ${p}"
done
BLOCK="${BLOCK}\n${INDENT}    jdks:"
IFS=',' read -ra JDK_ARR <<< "$JDKS"
for j in "${JDK_ARR[@]}"; do
  BLOCK="${BLOCK}\n${INDENT}      - ${j}"
done
if [ -n "$PACKAGES" ]; then
  BLOCK="${BLOCK}\n${INDENT}    packages:"
  IFS=',' read -ra PKG_ARR <<< "$PACKAGES"
  for pkg in "${PKG_ARR[@]}"; do
    BLOCK="${BLOCK}\n${INDENT}      - ${pkg}"
  done
fi
BLOCK="${BLOCK}\n${INDENT}    sources:"
BLOCK="${BLOCK}\n${INDENT}      - title: Core CI"
BLOCK="${BLOCK}\n${INDENT}        url: https://github.com/jenkinsci/jenkins/blob/master/Jenkinsfile"
BLOCK="${BLOCK}\n${INDENT}      - title: Acceptance Tests"
BLOCK="${BLOCK}\n${INDENT}        url: https://github.com/jenkinsci/acceptance-test-harness/blob/master/Jenkinsfile"
BLOCK="${BLOCK}\n${INDENT}      - title: Packaging"
BLOCK="${BLOCK}\n${INDENT}        url: https://github.com/jenkinsci/packaging/blob/master/Makefile"

# Insert the block right after the date: line
sed -i "${DATE_LINE}a\\${BLOCK}" "$YAML_FILE"

echo "Injected tested_configurations after line $DATE_LINE in $YAML_FILE"
