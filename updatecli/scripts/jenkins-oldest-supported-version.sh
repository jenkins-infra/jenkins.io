#!/bin/bash

# This script fetches the Jenkins version data from the Jenkins update site and determines the latest patch version of the oldest LTS version.

set -euxo pipefail

# Fetch the JSON data from the Jenkins update site and store it in a variable.
json_data=$(curl -s https://updates.jenkins.io/tiers.json)

# Extract the oldest LTS version from the JSON data.
oldest_lts=$(echo $json_data | jq -r '.stableCores[0]')

# Split the oldest LTS version into major, minor, and patch versions.
IFS='.' read -ra VERSION_PARTS <<< "$oldest_lts"
major_minor="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}"

# Filter the stableCores array to get versions that start with the major and minor version of the oldest LTS version,
# sort the versions in version sort order, get the last line (which is the latest patch version),
# and store it in a variable.
latest_patch=$(echo "$json_data" | jq -r --arg version "$major_minor" '.stableCores[] | select(startswith($version))' | sort -V | tail -n 1)

# Print the latest patch version of the oldest LTS version.
echo "$latest_patch"