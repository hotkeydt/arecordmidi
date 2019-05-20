#!/bin/bash
regex='notes=([0-9]+),seconds=([0-9]+)'
basedir="/home/pi/midi"
scriptPath=$(dirname "$0")

rm -f .rec

while true
do
	tmpfile=$(mktemp -u --tmpdir midirec_XXXXX.mid)
	echo "[$(date -Iseconds)] Starting arecordmidi"
	recordout="$($scriptPath/arecordmidi -p 20 -T 10000 $tmpfile)"
	info=""
	if [[ $recordout =~ $regex ]]; then
	        notes=${BASH_REMATCH[1]}
	        seconds=${BASH_REMATCH[2]}
	        info=" ($notes notes, $seconds seconds)"
	fi

	if [ -f $tmpfile ]
	then
		outdir="$basedir/$(date +%Y/%m)"
		date=$(date +%Y-%m-%d\ %H%M%S)
		outfile="$date$info.mid"
		mkdir -p "$outdir"
		mv "$tmpfile" "$outdir/$outfile"
		echo "[$(date -Iseconds)] Saved To $outdir/$outfile"
	else
		rm -f $tmpfile
		rm -f .rec
		sleep 5
	fi
done

