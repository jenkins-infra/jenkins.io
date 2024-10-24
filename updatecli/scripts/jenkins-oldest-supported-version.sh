#!/bin/bash

# This script fetches the Jenkins version data from the Jenkins update site and determines the latest patch version of the oldest LTS version.

set -euo pipefail

# Fetch the JSON data from the Jenkins update site and store it in a variable.
json_data=$(curl -sL https://updates.jenkins.io/tiers.json)

# Extract the oldest LTS version from the JSON data.
# The jq command is used to parse the JSON data and extract the oldest LTS version, which is stored in the oldest_lts variable.
oldest_lts=$(echo $json_data | jq -r '.stableCores[0]')

# Split the oldest LTS version into major, minor, and patch versions.
# Splits the oldest_lts version into major, minor, and patch versions using the IFS (Internal Field Separator) and read commands.
# The IFS is set to '.' to split the version string at the dot character.
# The -ra options to read command make it read into an array (-a) and automatically recognize backslashes (-r).
# The split parts are stored in the VERSION_PARTS array.
# The major and minor versions are then concatenated with a dot and stored in the major_minor variable.
IFS='.' read -ra VERSION_PARTS <<< "$oldest_lts"
major_minor="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}"

# Filter the stableCores array to get versions that start with the major and minor version of the oldest LTS version,
# sort the versions in version sort order, get the last line (which is the latest patch version),
# and store it in a variable.
latest_patch=$(echo "$json_data" | jq -r --arg version "$major_minor" '.stableCores[] | select(startswith($version))' | sort -V | tail -n 1)

# Print the latest patch version of the oldest LTS version.
echo "$latest_patch"
