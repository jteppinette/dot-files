#!/bin/sh

usage() {
	echo "Usage: $0 [-l <logfile>] <inputfile>" 1>&2;
	exit 0;
}

LOGFILE=/dev/null

while getopts ":l:h" o; do
	case "${o}" in
        h)
		usage
	;;
        l)
		LOGFILE="$OPTARG"
		;;
	esac
done
shift $((OPTIND-1))

PATH=$1
if [ ! -f "$PATH" ]; then
	echo "[ERROR] input file does not exist"
	exit 1
fi

DIRNAME=$(/usr/bin/dirname "$PATH")
NAME=$(/usr/bin/basename "$PATH" .ogg)
OUTPUT="$DIRNAME/$NAME.m4a"

/usr/bin/ffmpeg -i "$PATH" -c:a aac "$OUTPUT" 2> $LOGFILE
if [ $? -ne 0 ]; then
	echo "[ERROR] processing failed: $PATH"
	exit 1
fi

/usr/bin/rm "$PATH"

echo "[SUCCESS] processed: $NAME"
