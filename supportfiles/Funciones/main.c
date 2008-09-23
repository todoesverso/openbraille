#include <stdio.h>
#include "funciones.h"


//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


int main(int argc, char *argv[])
{
int inicializo,j;

byte *brailleOut, *brailleIn;

//Codigos de inicializacion
inicializo = iniciar_usb();

if (argc!=2){
	printf("Error: No ha ingresado el archivo deseado\n");
exit(1);
}

ascii = fopen(argv[1],"r");
braille = fopen("/tmp/braille","w");



//Codigo de programa
codificar(ascii,braille);

llenarbuffer(ascii, brailleIn);


for(j=0; j<30; j++)
	llenarrenglon(brailleOut,brailleIn, ANCHO);



//Codigo de finalizacion
if(inicializo)finalizar_usb();
fclose(ascii);
fclose(braille);
system("rm /tmp/braille");
return 0;
}

