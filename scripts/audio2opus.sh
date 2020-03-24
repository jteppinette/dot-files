#!/bin/sh

PATH=$1

DIRNAME=$(/usr/bin/dirname "$PATH")
NAME=$(/usr/bin/basename "$PATH" .ogg)
OUTPUT="$DIRNAME/$NAME.ogg"

/usr/bin/ffmpeg -i "$PATH" -c:a libopus "$OUTPUT" 2> convert.log
if [ $? -ne 0 ]; then
	echo "[ERROR] processing failed: $PATH"
	exit 1
fi

/usr/bin/rm "$PATH"

echo "[SUCCESS] processed: $NAME"
