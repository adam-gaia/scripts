#!/usr/bin/env bash

case "${OSTYPE}" in
    'linux-gnu'*)
        # Gnu Sed is the default sed
        /bin/cat "$1" | sed -e "s/\s*$//"
        ;;

    *)
        # Any other operating system, try 'gsed'
        /bin/cat "$1" | gsed -e "s/\s*$//"
        ;;
esac

