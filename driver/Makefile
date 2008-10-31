#
# Makefile
#
FUENTES.c=main.c funciones.c
INCLUDES=funciones.h
CFLAGS=
SLIBS=
PROG=gcc
OPT=-Wall 
OPTUSB= -L/usr/lib/ -lusb
LIBXML= `xml2-config --cflags` `xml2-config --libs` 	

# Destino (target) especial (inicia con .)

all: main.c funciones.h funciones.o options.o
	$(PROG) $(OPTUSB) $(LIBXML) main.c -o brailledriver 

funciones.o: funciones.h 
	$(PROG) -c funciones.c

options.o: options.h 
	$(PROG) $(OPT) $(LIBXML) -c options.c 

clean:
	rm *.o
	
delete: 
	rm brailledriver
	rm *.o

