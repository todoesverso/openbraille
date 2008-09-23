#
# Makefile
#
FUENTES.c=main.c funciones.c
INCLUDES=funciones.h
CFLAGS=
SLIBS=
PROG=gcc
OPT=-Wall -W -L/usr/lib/ -lusb

# Destino (target) especial (inicia con .)


all: main.c funciones.h funciones.o
	$(PROG) $(OPT) main.c -o imprimir 

funciones.o: funciones.h 
	$(PROG) -c funciones.c



