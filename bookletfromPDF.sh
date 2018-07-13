#!/usr/bin/env bash
# Takes a PDF and sorts the pages so they can easily be printed as a booklet
IFS=$'\n\t'
set -euo pipefail

# directory of program
PROG_DIR=$(cd "$(dirname "$(readlink "${0}")")"; pwd)

QPDF=$(which qpdf)
[ -x "${QPDF}" ] && echo $QPDF
[ -x "${QPDF}" ] || (echo "qpdf was not found in the path" && exit 1)
[ -r "${1}" ] || (echo "given file '${1}' can not be read" && exit 1)
OUTPUT="${1%.*}.booklet.pdf"

PAGES=$("${QPDF}" --show-npages "${1}" | tr -d '\n ')
let "m = $PAGES % 4"
[ ! "$m" -eq 0 ] && (echo "number of pages '$PAGES' has to be a multiple of 4"; exit 1)

PAGEORDER=$("${PROG_DIR}/page-order.sh" "${PAGES}")
echo "pages '$PAGES'"
echo "$PAGEORDER"
"${QPDF}" --empty --pages "${1}" $PAGEORDER -- "${OUTPUT}"
echo "written to '$OUTPUT'"

