#!/usr/bin/env bash
set -o pipefail

echo "$*" | sed 's/  */, /g'
