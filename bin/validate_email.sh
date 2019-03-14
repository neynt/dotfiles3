#!/bin/bash
# Checks if an email is real by constructing the beginning of a SMTP message.
if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 EMAIL"
  exit 1
fi
EMAIL="$1"
IFS="@" read -r -a parts <<< "$EMAIL"
HOST="${parts[1]}"
LINE="$(nslookup -q=mx $HOST | grep 'mail exchanger' | head -n1)"
SERVER="${LINE##* }"
SERVER="${SERVER%?}"
echo "Mail server at $SERVER"
(echo 'helo hi'; echo "mail from: <whomstdvexxx3717492@gmail.com>"; echo "rcpt to: <$EMAIL>"; echo "quit") | nc $SERVER 25 | grep .
