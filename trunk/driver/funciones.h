#include "funciones.c"

// Variables globales estaticas


// Cabecera de las funciones 

//De uso general
void bprint(byte x);
void llenarbuffer(FILE *braille, char *brailleIn);

//De codificacion
byte llenarbyte(byte *ptr, byte mask);
void llenarrenglon (byte *ptrOut, byte *ptrIn, int ancho);
byte reempchar(byte caract);
void codificar(FILE *ascii, FILE *braille);


//De manejo de USB
int iniciar_usb(void);
void finalizar_usb(void);
int escribir_usb(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);
int leer_usb(usb_dev_handle *dev, int ep, char *bytes, int size, int timeout);

//
