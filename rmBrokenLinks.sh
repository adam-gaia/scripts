#!/usr/bin/env bash

if [[ "$#" -eq '0' ]]; then
    inputDir='.'
else
    inputDir="$1"
fi


for brokenLink in $(find "${inputDir}" -maxdepth 1 -xtype l); do
    pointedTo="$(readlink -f "$brokenLink")"
    echo "Broken link '${brokenLink}' pointed to '${pointedTo}'. Removing"
    rm "${brokenLink}"
done
