#!/usr/bin/env bash

set -euo pipefail

REDIRECTS_FILE="/tmp/jira-to-github-redirects.conf"

MAPPINGS_URL="https://raw.githubusercontent.com/jenkinsci/artifacts-from-jira-issues/refs/heads/main/mappings/jira_keys_to_github_ids.txt"
MAPPINGS_FILE=$(mktemp)

curl -sL "$MAPPINGS_URL" -o "$MAPPINGS_FILE"

# Clear or create the redirects file
> "$REDIRECTS_FILE"

# Process each line
while IFS=: read -r jira_key github_ref; do
  # Extract the number after JENKINS-
  if [[ $jira_key =~ JENKINS-([0-9]+) ]]; then
    issue_num="${BASH_REMATCH[1]}"
    
    # Extract the repo path and issue number from github_ref (e.g., jenkinsci/jenkins#13336)
    if [[ $github_ref =~ (.+)#([0-9]+) ]]; then
      repo_path="${BASH_REMATCH[1]}"
      github_issue="${BASH_REMATCH[2]}"

      echo "rewrite ^/issue/$issue_num$ https://github.com/$repo_path/issues/$github_issue permanent;" >> "$REDIRECTS_FILE"
    fi
  fi
done < "$MAPPINGS_FILE"

rm -f "$MAPPINGS_FILE"

echo "Redirects file generated at $REDIRECTS_FILE"
