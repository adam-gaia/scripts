#!/usr/bin/env bash

function lintHelper()
{
    LINTER="${1}"
    LINTER_ARGS="${2}"
    FILENAME="${3}"

    echo "================================================="
    echo "Linting '${FILENAME}' with '${LINTER} ${LINTER_ARGS}'."
    echo ''

    # Run linter. Print error message and exit if file doesn't pass
    "${LINTER}" "${ARGS}" "${FILENAME}" || { echo "'${FILENAME}' did not pass linter."; exit 1; }
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
    # Skip if file doesn't exist
    if [[ -f "${FILENAME}" ]]; then
        continue
    fi

    LINTER_ARGS='' # Reset to no extra args

    case "${FILENAME}" in

        *'.cpp' | *'.c' | *'.h')
            LINTER='python3 -m cpplint'
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
            echo "No linter set for file '${FILENAME}'"
            continue
            ;;

    esac

    lintHelper "${LINTER}" "${ARGS}" "${fileName}"

done
