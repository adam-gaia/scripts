#!/usr/bin/env bash

case "${OSTYPE}" in
    'linux-gnu'*)
        # Gnu Sed is the default sed
        sed -i -e 's/\s*$//' "$1"
        ;;

    *)
        # Any other operating system, try 'gsed'
        gsed -i -e 's/\s*$//' "$1"
        ;;
esac
