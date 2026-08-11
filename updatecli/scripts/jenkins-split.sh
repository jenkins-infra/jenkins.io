#!/bin/bash

# Define a variable to hold the URL
# This is where we're getting our data from.
url="https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/split-plugins.txt"

# Fetch the file from the URL, extract the second column of valid data rows, and find the highest version.
# Let's break it down:

# curl -s $url: Fetches the file silently.
# awk '!/^#/ && NF==3 {print $2}': Ignores comments and empty lines, ensuring only valid 3-column rows are processed. Prints the second column.
# sort -V: Sorts the versions mathematically (Version sort).
# tail -n 1: Grabs the very last item, which is the highest version.
curl --silent --location $url | awk '!/^#/ && NF==3 {print $2}' | sort -V | tail -n 1
