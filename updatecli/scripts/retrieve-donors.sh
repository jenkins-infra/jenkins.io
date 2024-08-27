#!/bin/sh

# This script retrieves transaction data for a specific project from the LFX Crowdfunding API.
# The project is identified by its ID in the API request URL.
# The retrieved data is in JSON format and is saved to a temporary file.
# The script then processes the JSON data to select certain fields and remove others.

# Send a GET request to the LFX Crowdfunding API to retrieve transaction data for a specific project.
# The curl command is used with several options to set various HTTP headers.
# These headers include 'User-Agent', 'Accept', 'Accept-Language', 'Accept-Encoding', 'Origin', 'Connection', 'Sec-Fetch-Dest', 'Sec-Fetch-Mode', 'Sec-Fetch-Site', 'Pragma', 'Cache-Control', and 'TE'.
# These headers control various aspects of the HTTP request, such as the client software, media types, language, encoding, origin, connection, fetch context, caching, and transfer encoding.
curl 'https://api.crowdfunding.lfx.linuxfoundation.org/v1/projects/bce45251-1ff4-4131-9699-0a0017b31495/transactions' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:126.0) Gecko/20100101 Firefox/126.0' \
-H 'Accept: application/json, text/plain, */*' \
-H 'Accept-Language: en-US,en;q=0.5' \
-H 'Accept-Encoding: gzip, deflate, br, zstd' \
-H 'Origin: https://crowdfunding.lfx.linuxfoundation.org' \
-H 'Connection: keep-alive' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Sec-Fetch-Mode: cors' \
-H 'Sec-Fetch-Site: same-site' \
-H 'Pragma: no-cache' \
-H 'Cache-Control: no-cache' \
-H 'TE: trailers' | jq > /tmp/transactions.json

# Process the JSON data to select certain fields and remove others.
# The jq command is used to filter the JSON data.
# The filter selects entries where the 'type' field is not 'expense'.
# If the 'organizationId' field of the 'organization' object is empty, the 'organization' object is removed.
# The 'merchantName', 'amountInCents', 'feesMerchantInCents', 'feesPlatformInCents', 'creditInCents', 'runningBalanceInCents', 'deltaInCents', 'submitterName', and 'description' fields are removed.
jq '[.entries[] | select(.type != "expense") | if .organization.organizationId == "" then del(.organization) else . end | del(.merchantName, .amountInCents, .feesMerchantInCents, .feesPlatformInCents, .creditInCents, .runningBalanceInCents, .deltaInCents, .submitterName, .description)]' /tmp/transactions.json
