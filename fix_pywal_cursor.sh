#!/usr/bin/env bash
# Brew's pywal version is out of date. There is a cursor bug. Fix by grabbing a file from the latest
# See this: https://github.com/dylanaraps/pywal/issues/382

pythonVersion="$(python3 --version | cut -d' ' -f2)"
pythonVersion="${pythonVersion%.*}"

URL='https://raw.githubusercontent.com/dylanaraps/pywal/master/pywal/sequences.py'
fixThisFile="/usr/local/lib/python${pythonVersion}/site-packages/pywal/sequences.py"

# Run
curl "${URL}" > "${fixThisFile}"
