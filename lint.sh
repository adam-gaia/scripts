#!/usr/bin/env bash

function lintHelper()
{
    LINTER="${1}"
    LINTER_ARGS="${2}"
    FILENAME="${3}"

    if [[ "${LINTER_ARGS}" == '' ]]; then
        command="${LINTER} ${FILENAME}"
    else
        command="${LINTER} ${LINTER_ARGS} ${FILENAME}"
    fi

    echo "Linting '${FILENAME}' with '${command}'"

    # Run linter. Print error message and exit if file doesn't pass
    ${command} || { echo "'${FILENAME}' did not pass linter."; exit 1; }
    
    echo 'Pass'
    echo ''
}

if [[ "$#" -eq '0' ]]; then
    echo 'This script lints files based on the file extension.'
    echo 'Usage:'
    echo '    lint.sh file1, file2, ... fileN'
    exit 0
fi

# Loop over input files
for FILENAME in "$@"
do

    echo "Checking file '${FILENAME}'..."

    # Skip if file doesn't exist
    if [[ ! -f "${FILENAME}" ]]; then
        echo "This file doesn't exist. Skipping."
        continue
    fi

    LINTER_ARGS='' # Reset to no extra args

    case "${FILENAME}" in

        *'.cpp' | *'.c' | *'.h')
            LINTER='python3 -m cpplint'
            ;;

        *'.json')
            LINTER='lintJson' # lintJson is one of my bash functions
            ;;

        *'.py')
            LINTER='python3 -m flake8'
            LINTER_ARGS='--max-line-length 120'
            ;;

        *'.sh')
            LINTER=shellcheck
            ;;

        *'.yml' | *'.ymal')
            LINTER=yamllint
            ;;

        *'.xml')
            LINTER=xmllint
            ;;

        *) # default
            echo "No linter set for this file. Skipping."
            continue
            ;;

    esac

    lintHelper "${LINTER}" "${LINTER_ARGS}" "${FILENAME}"

done
