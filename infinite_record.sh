#!/bin/bash
regex='notes=([0-9]+),seconds=([0-9]+)'
basedir="/home/pi/midi"

while true
do
	tmpfile=$(mktemp -u midirec_XXXXX.mid)
	echo Starting arecordmidi
	recordout="$(./arecordmidi -p 20 -T 5000 $tmpfile)"
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
		echo "Saved To $outdir/$outfile"
	else
		rm -f $tmpfile
		sleep 5
	fi
done

