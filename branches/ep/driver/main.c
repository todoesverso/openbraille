#include <stdio.h>
#include "funciones.h"

//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


int main()
{
int inicializo,j=0,j1=0,i;
byte a = 1;
//char *brailleOut, brailleIn[64], car ;
char buff[]={0xbc,0x01,0x02,0x03,0x04,0x05,0x06, 0x07},rec, rec2,car;
rec = 0x00;
rec2 = 0x00;
//Codigos de inicializacion
inicializo = iniciar_usb();

printf("Presionar -i- para imprimir\n");
car = getchar();	
if (car ==  'i' ){
printf("WRITE %02x READ %02x\n",WRITE2, READ2);
     j=  escribir_usb(udev,WRITE2  ,&buff[3],1,500);      
        j1=  leer_usb(udev, READ2     , &rec2, 1, 500);
 //j = escribir_usb(udev, WRITE, &buff[1], 1, 500);
//	for( i=0; i<100000; i++){}
//        leer_usb(udev, READ2, &rec2,1,500); 

      //  j1 =  leer_usb(udev, READ2, &rec, 1, 500);
} 
	printf("Se escribieron %d\n",j);
	printf("Se recibieron %d \n",j1);
        printf("Se recibio en 2 = %02x \n",rec);
        printf("Se recibio en 1 = %02x \n",rec2);
       if (a ==  0x01 ) printf ("SI!\n");

       // printf("Se recibio en 2 = %02x\n", rec2);

        //	while(rec[0] != sizeof(braille))
//		leer_usb(udev,READ,rec,j,500);
		
//	for( i=0; i<j; i++)
//		printf("A  finalizado la impresion  --CODIGO %x \n",rec[i]);

//Codigo de finalizacion
if(inicializo)finalizar_usb();
//fclose(ascii);
//fclose(braille);
//system("rm /tmp/braille");
return 0;
}

