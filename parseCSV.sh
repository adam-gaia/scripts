#!/bin/bash

fileName="$1"

cat "${fileName}" |grep -v "NaN" |awk -F',' '{print $1}'
