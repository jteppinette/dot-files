#!/bin/sh

usage() {
	echo "Usage: $0 <series name> <series year>" 1>&2;
	exit 0;
}

while getopts ":h" o; do
	case "${o}" in
        h)
		usage
	;;
	esac
done
shift $((OPTIND-1))

SERIES_NAME="$1"
SERIES_YEAR="$2"

series_id() {
	echo -n $(echo "$1" | /usr/bin/grep --perl-regexp --only-matching 'S[0-9][0-9](E[0-9][0-9])*')
}

for FILE in *.mkv; do
	SERIES_ID=$(series_id "$FILE")

	/usr/bin/mkvpropedit "$FILE" \
		--delete-attachment name:cover_land.jpg \
		--delete-attachment name:small_cover.jpg \
		--delete-attachment name:small_cover_land.jpg \
		--delete-attachment name:cover.jpg 2>&1 > /dev/null

	/usr/bin/mkvpropedit "$FILE" \
		--edit info --set "title=${SERIES_NAME} (${SERIES_YEAR}) - ${SERIES_ID}" 2>&1 > /dev/null

	mv "$FILE" "${SERIES_NAME} - ${SERIES_ID}.mkv" 2> /dev/null
done

for FILE in *.srt; do
	SERIES_ID=$(series_id "$FILE")

	mv "$FILE" "${SERIES_NAME} - ${SERIES_ID}.en.srt" 2> /dev/null
done
