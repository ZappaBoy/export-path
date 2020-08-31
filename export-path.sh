#!/bin/bash

INPUT_ERROR=5
SUCCESS=5

function export-path(){
    BIN_PATH=${1:-""}
    SOURCE_FILE=${2:-"~/.bashrc"}
    if grep -q "${BIN_PATH}" "${SOURCE_FILE}"
    then
        echo "BIN_PATH EXISTS"
    else
	echo "Exporting PATH: ${BIN_PATH}"
        echo "export PATH=${BIN_PATH}:$PATH" >> ${SOURCE_FILE}
    fi
}

[[ $# -eq 0 ]] && echo "No params detected: see ${0} -h" && exit "${INPUT_ERROR}"

while getopts "s:p:" ARG; do
    case "${ARG}" in
	p)
	    [[ -z "${OPTARG}" ]] && echo "Please insert a PATH to export" && exit "${INPUT_ERROR}"
	    BIN_PATH="${OPTARG}"
	    ;;
	s)
      	    [[ -z "${BIN_PATH}" ]] && echo "Please insert a PATH to export, then the source file path" && exit "${INPUT_ERROR}"
	    SOURCE_FILE="${OPTARG}"
	    ;;
	*)
	    cat <<EOF
Usage: export-path -p BIN_PATH -s SOURCE_FILE

- BIN_PATH: is the PATH to export
- SOURCE_FILE: is the file path where export the BIN_PATH (Default: ~/.bashrc)
EOF
	    exit "${INPUT_ERROR}"
	    ;;
    esac
done

export-path "${BIN_PATH}" "${SOURCE_FILE}"
exit "${SUCCESS}"
