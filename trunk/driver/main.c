/*   main.c - The main program.
 *
 *  Copyright (C) 2008  Rosales Victor and German Sanguinetti.
 *  (todoesverso@gmail.com , german.sanguinetti@gmail.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#include <stdio.h>
#include <stdlib.h>
#include "funciones.h"

//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


int main(int argc, char *argv[])
{
int inicializo,j=0,i,j1=0,j2=0;

char *brailleOut, brailleIn[64], car ;

char buff[]={0x00,0x01,0x02,0x03,0x04,0x05,0x06},rec, rec2;

rec = 0x00;
rec2 = 0x00;

//Codigos de inicializacion
inicializo = iniciar_usb();
if (!inicializo){
 system("voice_scipts/error.voice");
 printf("Error al inicializar la conexion USB\n");
 return 1;
}

//if (argc!=2){
//	printf("Error: No ha ingresado el archivo deseado\n");
//exit(1);
//}

//ascii = fopen(argv[1],"r");
//braille = fopen("/tmp/braille","w");

//Codigo de programa
//codificar(ascii,braille);

/*
llenarbuffer(ascii, brailleIn);


for(j=0; j<30; j++)
	llenarrenglon(brailleOut,brailleIn, ANCHO);
*/
        

j=  usb_bulk_write(udev,WRITE2 ,&buff[0],1,500);      
//j2= usb_clear_halt(udev,WRITE2);
//do{
//j= usb_bulk_write(udev,WRITE ,buff,1,500);   
//} while (j<0); 
//j2= usb_clear_halt(udev,WRITE);
//j1= usb_bulk_read(udev, READ  , &rec2, 1, 500);
//j=  usb_bulk_write(udev,WRITE2 ,&buff[1],1,500);      
//j= usb_bulk_write(udev,WRITE ,&buff[4],1,500);   
//j2= usb_clear_halt(udev,WRITE);
//j1= usb_bulk_read(udev, READ  , &rec2, 1, 500);


	printf("Se escribieron %d %d\n",j,j1);


        printf("Se recibio en 1 = %02x \n",rec);
        printf("Se recibio en 2 = %02x\n", rec2);
	printf("Se recibio %d \n",j);

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

