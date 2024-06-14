#!/bin/sh

# This script uses curl to send a GET request to the LFX Crowdfunding API.
# It retrieves transaction data for a specific project identified by its ID.
# The retrieved data is in JSON format.

# The curl command is used with several options:
# -H: This option is used multiple times to set various HTTP headers.
# 'User-Agent': Identifies the client software originating the request.
# 'Accept': Indicates the media types the client is willing to receive from the server.
# 'Accept-Language': Indicates the client's language preference.
# 'Accept-Encoding': Indicates the encoding schemes the client is able to understand.
# 'Origin': Indicates the origin of the request.
# 'Connection': Controls whether the network connection stays open after the current transaction finishes.
# 'Sec-Fetch-Dest': Indicates the request's target within the context of the fetch.
# 'Sec-Fetch-Mode': Indicates the request's mode within the context of the fetch.
# 'Sec-Fetch-Site': Indicates the request's site within the context of the fetch.
# 'Pragma' and 'Cache-Control': These headers are used to specify caching directives.
# 'TE': Indicates the transfer encodings the user agent is willing to accept.

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

jq '[.entries[] | select(.type != "expense") | if .organization.organizationId == "" then del(.organization) else . end | del(.merchantName, .amountInCents, .feesMerchantInCents, .feesPlatformInCents, .creditInCents, .runningBalanceInCents, .deltaInCents, .submitterName, .description)]' /tmp/transactions.json > content/_data/donators/donators.json
