#!/bin/bash

# Define a variable to hold the URL
# This is where we're getting our data from.
# For this file, assume that theentries are in increasing order and get the second column (which is the last pre-split version)
# TODO Figure out a way to obtain this content differently, this is terrible
url="https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/split-plugins.txt"

# Fetch the file from the URL, get the last line, and print the second field
# Let's break it down:

# curl -s $url: This part of the command fetches the file from the URL stored in the 'url' variable.
# The '-s' option tells curl to do this silently, i.e., without showing progress or error messages.

# | (pipe): This is a pipe. In Unix-like operating systems, pipe is a method for inter-process communication.
# Using '|' causes the standard output (stdout) from the command on the left
# to be passed as standard input (stdin) to the command on the right.

# awk 'END{print $2}': 'awk' is a programming language that is designed for text processing and typically used as a data extraction and reporting tool.
# 'END' is a special pattern that matches the end of the input, so this part of the command is executed after all the input has been read.
# In other words, it operates on the last line of the input.
# '{print $2}' tells awk to print the second field of the line. By default, awk splits the line into fields based on whitespace,
# so this will print the part of the line between the first and second space.
curl --silent --location $url | awk 'END{print $2}'
