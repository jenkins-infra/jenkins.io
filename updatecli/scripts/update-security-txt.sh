#!/bin/bash

# Read the date after "Expires:"
expires_date=$(grep -oP 'Expires: \K.*' content/.well-known/security.txt)

# Convert the expires date to seconds since epoch
expires_epoch=$(date -d "$expires_date" +%s)

# Get the current date in seconds since epoch
current_epoch=$(date +%s)

# Calculate the difference in seconds (30 days * 24 hours * 60 minutes * 60 seconds)
one_month_seconds=$((30 * 24 * 60 * 60))

# Check if the current date is less than one month close to the expires date
if (( current_epoch + one_month_seconds >= expires_epoch )); then
  # Add one year to the expires date
  new_expires_date=$(date -u -d "$expires_date + 1 year" +%Y-%m-%dT%H:%M:%S.000Z)
  echo "$new_expires_date"
else
  echo "$expires_date"
fi
