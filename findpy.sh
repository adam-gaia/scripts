#!/usr/bin/env bash

for x in $(echo "$PATH" | gsed 's/:/\n/g'); do
    find $x -name "*python*"
done
