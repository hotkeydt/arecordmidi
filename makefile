LIBS=-lasound

arecordmidi: arecordmidi.c
	gcc -o arecordmidi arecordmidi.c $(LIBS)

.PHONY: clean
	
clean:	
	rm -f *.o *~ core arecordmidi
	
