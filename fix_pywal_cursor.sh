#!/usr/bin/env bash
# Brew's pywal version is out of date. There is a cursor bug. Fix by grabbing a file from the latest
# See this: https://github.com/dylanaraps/pywal/issues/382

if [["$#" -ne 1]]; then
    echo "Error, please enter python version (3.x)"
    exit 1
fi

pythonVersion="$1"

URL='https://raw.githubusercontent.com/dylanaraps/pywal/master/pywal/sequences.py'
fixThisFile="/usr/local/lib/${pythonVersion}/site-packages/pywal"

# Run
curl "${URL}" > "${fixThisFile}"
