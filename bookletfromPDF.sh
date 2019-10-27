#!/usr/bin/env bash
# Takes a PDF and sorts the pages so they can easily be printed as a booklet
IFS=$'\n\t'
set -euo pipefail

# directory of program
PROG_DIR=$(cd "$(dirname "$(readlink "${0}")")"; pwd)

QPDF="$(command -v qpdf)"
[ -x "${QPDF}" ] && echo "$QPDF"
[ -x "${QPDF}" ] || (echo "qpdf was not found in the path" && exit 1)
[ -r "${1}" ] || (echo "given file '${1}' can not be read" && exit 1)
OUTPUT="${1%.*}.booklet.pdf"

PAGES="$("${QPDF}" --show-npages "${1}" | tr -d '\n ')"
m="$((PAGES % 4))"
[ ! "$m" -eq 0 ] && (echo "number of pages '$PAGES' has to be a multiple of 4"; exit 1)
echo "pages '$PAGES'"

if [ "$#" -gt 1 ] && [ "$2" == "--rotate-back-pages" ]; then
  echo "Rotating back pages..."
  PAGEORDER="$("${PROG_DIR}/page-order.sh" "${PAGES}" "$2")"
  ROTATE="--rotate=+180:$(for c in $(seq 1 4 "$PAGES"); do echo -n ",$((c+2)),$((c+3))"; done)"
else
  PAGEORDER="$("${PROG_DIR}/page-order.sh" "${PAGES}")"
  ROTATE=''
fi

"${QPDF}" "$ROTATE" --empty --pages "${1}" "$PAGEORDER" -- "${OUTPUT}"
echo "written to '$OUTPUT'"

