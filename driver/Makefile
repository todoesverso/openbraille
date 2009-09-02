#
# Makefile
#
FUENTES.c=main.c funciones.c
INCLUDES=funciones.h
CFLAGS=
SLIBS=
PROG=gcc
OPT=-Wall -O2 
OPTUSB= -L/usr/lib/ -lusb
LIBXML= `xml2-config --cflags` `xml2-config --libs` 	

# Destino (target) especial (inicia con .)

all: main.c functions.h functions.o errorsdrv.h errorsdrv.o options.h options.o 
	\time -f %e $(PROG) $(OPTUSB) $(LIBXML) main.c -o brailledriver 

functions.o: functions.h 
	$(PROG) -c functions.c

errorsdrv.o: errorsdrv.h
	$(PROG) $(OPT) $(LIBXML) -c errorsdrv.c 

options.o: options.h 
	$(PROG) $(OPT) $(LIBXML) -c options.c 

clean:
	rm *.o
	
delete: 
	rm brailledriver
	rm *.o

