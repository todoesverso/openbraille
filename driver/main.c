#include <stdio.h>
#include "funciones.h"




//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


int main(int argc, char *argv[])
{
int inicializo,j=0,i;

char *brailleOut, brailleIn[64], car ;

			char buff[]={0xff,0x01,0x02,0x03,0x04,0x05,0x06, 0x07},rec[64];

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


/*
llenarbuffer(ascii, brailleIn);


for(j=0; j<30; j++)
	llenarrenglon(brailleOut,brailleIn, ANCHO);
*/
	car = getchar();
	
if (car == 'i'){
	j=escribir_usb(udev,WRITE,braille,sizeof(braille),500);

} 
	printf("Se escribieron %d \n",j);

	for( i=0; i<10000; i++){}

	leer_usb(udev,READ,rec,j,500);
	
	while(rec[0] != sizeof(braille))
		leer_usb(udev,READ,rec,j,500);
		
	for( i=0; i<j; i++)
		printf("A  finalizado la impresion  --CODIGO %x \n",rec[i]);

//Codigo de finalizacion
if(inicializo)finalizar_usb();
fclose(ascii);
fclose(braille);
//system("rm /tmp/braille");
return 0;
}

