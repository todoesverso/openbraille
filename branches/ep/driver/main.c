#include <stdio.h>
#include "funciones.h"

//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


int main()
{
int inicializo,j=0,j1=0,j2=0;
byte a = 1;
//char *brailleOut, brailleIn[64], car ;
char buff[]={0xbc,0x01,0x02,0x03,0x04,0x05,0x06, 0x07},rec, rec2,car;
rec = 0x00;
rec2 = 0x00;
//Codigos de inicializacion
inicializo = iniciar_usb();

//printf("Presionar -i- para imprimir\n");
//car = getchar();	
//if (car ==  'i' ){
printf("---WRITE2 %02x READ2 %02x---\n",WRITE2, READ2);
printf("------------------------\n");
/////////////////////////////////////////////
//
/////////////////////////////////////////////

j=  escribir_usb(udev,WRITE2 ,&buff[1],1,500);      
//j2= usb_clear_halt(udev,WRITE2);
//do{
j= escribir_usb(udev,WRITE ,&buff[0],1,500);   
//} while (j<0); 
j2= usb_clear_halt(udev,WRITE);
j1= leer_usb(udev, READ2 , &rec2, 1, 500);
//} 

//////////////////////////////////////////////
//
//////////////////////////////////////////////
        printf("-^- Se escribieron %d\n",j);
	printf("-^- Se recibieron %d \n",j1);
        printf("-^- Se recibio en 2 = %02x \n",rec);
        printf("-^- Se recibio en 1 = %02x \n",rec2);
        printf("-^- Se reseteo = %02x\n",j2);
//////////////////////////////////////////////

//Codigo de finalizacion
if(inicializo)finalizar_usb();
//fclose(ascii);
//fclose(braille);
//system("rm /tmp/braille");
return 0;
}

