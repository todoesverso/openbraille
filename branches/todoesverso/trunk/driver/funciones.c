/*   function.c - The main functions used by the driver.
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
#include <usb.h> 
#include <errno.h> 
#include <time.h>
#include <ctype.h>

//Cantidad de bytes en la pagina de salida
#define ANCHO 7

// La cantidad de caracteres que contien la pagina de entrada (1 byte por ASCII )
#define LONG 4*ANCHO
#define SIZE 840

//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO

//Especificacion del dispositivo
#define LIBRE 0x04d8
#define USBPRINTER 0x7531

typedef unsigned char byte;

//Variables globales de USB
struct usb_bus *bus; 
struct usb_device *dev;
usb_dev_handle *udev;
unsigned int WRITE,READ, WRITE2,READ2;

//Archivos de texto
FILE *ascii, *braille;

//Variables globales genericas
int cnt = 0;
//-----------------------------------------------------------------------------------------

byte brAsciiTabla[] = 
{			//b7 b6 b5 b4 b3 b2 b1 b0  "Simbolo"		//b7 b6 b5 b4 b3 b2 b1 b0   "Simbolo"
			//----------------------------------		-------------------------------------
0x00,0x1b,		//(Espacio)	 			        //0  0  0  1  1  0  1  1       ! 
0x04,0x17,		//0  0  0  0  0  1  0  0      "			//0  0  0  1  0  1  1  1       #
0x49,0x41,		//0  0  1  1  1  0  0  1      $                 //0  0  1  1  0  0  0  1       %	
0x4b,0x02,		//0  0  1  1  1  0  1  1      &			//0  0  0  0  0  0  1  0       '
0x2f,0x1f,		//0  0  1  0  1  1  1  1      ( 		//0  0  0  1  1  1  1  1       )  
0x21,0x00,		//0  0  1  0  0  0  0  1      *			//0  0  0  1  0  0  1  1       +
0x01,0x00,		//0  0  0  0  0  0  0  1      ,			//0  0  0  0  0  0  1  1       -
0x11,0x12,		//0  0  0  1  0  0  0  1      .  		//0  0  0  1  0  0  1  0       /
0x07,0x08,		//0  0  0  0  0  1  1  1      0			//0  0  0  0  1  0  0  0       1
0x0a,0x0c,		//0  0  0  0  1  0  1  0      2			//0  0  0  0  1  1  0  0       3
0x0d,0x09,		//0  0  0  0  1  1  0  1      4			//0  0  0  0  1  0  0  1       5  	
0x0e,0x0f,		//0  0  0  0  1  1  1  0      6			//0  0  0  0  1  1  1  1       7
0x0b,0x06,		//0  0  0  0  1  0  1  1      8			//0  0  0  0  0  1  1  0       9	  
0x25,0x05,		//0  0  1  0  0  1  0  1      :			//0  0  0  0  0  1  0  1       ; 	
0x29,0x4f,		//0  0  1  0  1  0  0  1      <			//0  0  1  1  1  1  1  1       =	 
0x16,0x45,		//0  0  0  1  0  1  1  0      >			//0  0  1  1  0  1  0  1       ? 	
0x10,0x20,		//0  0  0  1  0  0  0  0      @			//0  0  1  0  0  0  0  0       A
0x28,0x30,		//0  0  1  0  1  0  0  0      B			//0  0  1  1  0  0  0  0       C	
0x34,0x24,		//0  0  1  1  0  1  0  0      D			//0  0  1  0  0  1  0  0       E
0x38,0x3c,		//0  0  1  1  1  0  0  0      F			//0  0  1  1  1  1  0  0       G	
0x2c,0x18,		//0  0  1  0  1  1  0  0      H			//0  0  0  1  1  0  0  0       I
0x1c,0x22,		//0  0  0  1  1  1  0  0      J			//0  0  1  0  0  0  1  0       K 	
0x2a,0x32,		//0  0  1  0  1  0  1  0      L			//0  0  1  1  0  0  1  0       M  
0x36,0x26,		//0  0  1  1  0  1  1  0      N			//0  0  1  0  0  1  1  0       O
0x3a,0x3e,		//0  0  1  1  1  0  1  0      P			//0  0  1  1  1  1  1  0       Q
0x2e,0x1a,		//0  0  1  0  1  1  1  0      R			//0  0  0  1  1  0  1  0       S 
0x1e,0x23,		//0  0  0  1  1  1  1  0      T			//0  0  1  0  0  0  1  1       U	
0x2b,0x1d,		//0  0  1  0  1  0  1  1      V			//0  0  0  1  1  1  0  1       W 	
0x33,0x37,		//0  0  1  1  0  0  1  1      X			//0  0  1  1  0  1  1  1       Y
0x27,0x19,		//0  0  1  0  0  1  1  1      Z			//0  0  0  1  1  0  0  1       [
0x2d,0x3d,		//0  0  1  0  1  1  0  1      \			//0  0  1  1  1  1  0  1       ]
0x14,0x15		//0  0  0  1  0  1  0  0      ^		 	//0  0  0  1  0  1  0  1       _
};


//-----------------------------------------------------------------------------------------


void bprint(byte x) {
 int n;
 for(n=0; n<8; n++) {
        if((x & 0x80) !=0){
	        printf("1");
		}
	else {
		printf("0");
	     }
	        if (n==3) {
			printf(" "); /* Un espacio cada 4 bits */
		}
		x = x<<1;
	}
 printf("  ");
}

byte llenarbyte(byte *ptr, byte mask) {
 byte pkt = 0;
   switch(mask)	{
	case 0x30:
		pkt = ((*ptr & mask) << 2)|(*(ptr+1) & mask)|((*(ptr+2) & mask) >> 2)|((*(ptr+3) & mask) >> 4);
		break;
	case 0x0c:
		pkt = ((*ptr & mask) << 4)|((*(ptr+1) & mask) << 2)|(*(ptr+2) & mask)|((*(ptr+3) & mask) >> 2);
		break;
	case 0x03:
		pkt = ((*ptr & mask) << 6)|((*(ptr+1) & mask) << 4)|((*(ptr+2) & mask) << 2)|(*(ptr+3) & mask);
		break;
	default: printf("Error de mascara");
	}
//ptr +=4;
 return pkt;
}

void llenarrenglon(byte *ptrOut, byte *ptrIn, int ancho) {
 int i,j;
 byte *ptrInA, *ptrOutA;
 ptrInA = ptrIn;
 ptrOutA = ptrOut + 21*cnt;
 byte mascara[3] = {0x30, 0x0c, 0x03};

 for(i=0; i<3; i++) {
	ptrInA = ptrIn;
	// LLena la linea hasta el ancho correspondiente de pagina
	for(j = 0; j < ancho; j++){
		*ptrOutA = llenarbyte (ptrInA, mascara[i]);
		ptrOutA ++;
		ptrInA +=4;
	}
 }
}


		
int iniciar_usb(void){

int n,m,ret,sizein,sizeout,pts,valor,sizein2,sizeout2; 
char string[256];
	
usb_init();	
	
n = usb_find_busses(); 
m = usb_find_devices();


for (bus = usb_busses; bus; bus = bus->next){ 
	for (dev = bus->devices; dev; dev = dev->next) {
		if (dev->descriptor.idVendor==LIBRE){ 
			if (dev->descriptor.idProduct==USBPRINTER){
			udev = usb_open(dev);
					
			if (udev){ 
			printf("PIC encontrado dev-%s en el bus-%s\n",dev->filename,bus->dirname); 
			usb_detach_kernel_driver_np(udev, 0); 
			usb_set_configuration(udev, 1);
			
				if (dev->descriptor.iManufacturer){ 
				usb_get_string_simple(udev, dev->descriptor.iManufacturer, string, sizeof(string));
					if (ret > 0)
					printf("- Fabricante : %s\n", string);
					else 
					printf("- No se pudo leer el fabricante\n"); 
				}

				if (dev->descriptor.iProduct){ 
				ret = usb_get_string_simple(udev, dev->descriptor.iProduct, string, sizeof(string));
					if (ret > 0)
					printf("- Producto : %s\n", string);
					else
					printf("- No se pudo leer el producto\n");
				}
				if (dev->descriptor.iSerialNumber) 
				{ 
				ret = usb_get_string_simple(udev, dev->descriptor.iSerialNumber, string, sizeof(string));
					if (ret > 0) 
					printf("- Numero de serie: %s\n", string);
					else
					printf("- No se pudo leer el numero de serie\n");
				}
				ret = usb_claim_interface(udev,0); 
					if 
					(ret>=0) printf("La interfaz respondio!\n"); 
					else 
					printf("Error al abrir la interfaz (?))\n");
						
						
WRITE = dev->config[0].interface[0].altsetting[0].endpoint[1].bEndpointAddress;
READ = dev->config[0].interface[0].altsetting[0].endpoint[0].bEndpointAddress;
 
WRITE2 = dev->config[0].interface[0].altsetting[0].endpoint[3].bEndpointAddress;
READ2 = dev->config[0].interface[0].altsetting[0].endpoint[2].bEndpointAddress;
 
sizein = dev->config[0].interface[0].altsetting[0].endpoint[1].wMaxPacketSize;
sizeout = dev->config[0].interface[0].altsetting[0].endpoint[1].wMaxPacketSize;
pts = dev->config[0].interface[0].altsetting[0].endpoint[0].bInterval;

sizein2 = dev->config[0].interface[0].altsetting[0].endpoint[2].wMaxPacketSize;
sizeout2 = dev->config[0].interface[0].altsetting[0].endpoint[2].wMaxPacketSize;
printf("EP1 - WRITE TO %02xh READ FROM %02xh  SIZEIN %d SIZEOUT %d E_PTS %d\n\
EP2 - WRITE TO %02xh READ FROM %02xh SIZEIN %d SIZEOUT %d\n",WRITE,READ,sizein,sizeout,pts,WRITE2,READ2,sizein2,sizeout2);
					}
				}
			}
			else 
 			continue;
		}
	}
	
if (udev){
printf("Se ha inicializado correctamente el dispositivo!\n");
valor = 1;
}
else{
printf("No se ha podido inicializar el dispositivo!\n");
valor = 0;
}
return valor;
}

void finalizar_usb(void){
	usb_release_interface(udev,0);
	usb_close (udev);
}


byte reempchar(byte caract){
	byte charCod,retorna;
	
	charCod = caract - 0x20;
	retorna =  brAsciiTabla[charCod];

	return retorna;
}


void codificar(FILE *ascii, FILE *braille){
byte caract;	
	while(!feof(ascii))
	{
		caract = getc(ascii);

		if(!feof(ascii))
			putc(reempchar(caract), braille);
	}
}

void llenarbuffer(FILE *braille, char *brailleIn){
char caract;
int i=0;	
	while(!feof(braille))
	{
		caract = getc(braille);

		if(!feof(braille))
			 brailleIn[i] = caract;
		i++;
	}
}




