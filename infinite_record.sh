#!/bin/bash

while true
do
	tmpfile=$(tempfile --suffix=.mid)
	echo Starting arecordmidi
	./arecordmidi -p 20 -T 5000 $tmpfile

	if [ -f $tmpfile ]
	then
		outdir=$(date +%Y/%m)
		outfile=$(date +arecordmidi_%Y%m%d_%H%M%S.mid)
		mkdir -p ~/midi/$outdir
		mv $tmpfile ~/midi/$outdir/$outfile
		echo Saved To ~/midi/$outdir/$outfile
	else
		rm $tmpfile
		sleep 5
	fi
done

