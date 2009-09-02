/*   function.c - The main functions used by the driver.
 *
 *  Copyright (C) 2008  Rosales Victor (todoesverso@gmail.com)
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

/**
 * Global definitions
 **/
#define WIDTH 7
#define LONG 4*WIDTH
#define SIZE 840
#define TAM 3*WIDTH

/**
 * USB specific
 **/
#define LIBRE   0x04d8  /* vendorId */
#define PRINTER 0x7531  /* deviceId */

/**
 * Specific USB global variables
 **/
struct usb_bus *bus; 
struct usb_device *dev;
usb_dev_handle *udev;
unsigned int WRITE, READ, WRITE2, READ2;

/**
 * Text (ASCII) files
 **/
FILE *ascii, *braille;

/**
 * Global varialbes
 **/
int cnt = 0;
typedef unsigned char byte;

/*---------------------------------------------------------------------------*/
byte brAsciiTabla[] = 
{  	  /*b7 b6 b5 b4 b3 b2 b1 b0  "Sim"	b7 b6 b5 b4 b3 b2 b1 b0 "Sim"*/
	  /*-------------------------------	-----------------------------*/
0x00,0x1b, /*(Espacio)	 		        0  0  0  1  1  0  1  1    !  */
0x04,0x17, /*0  0  0  0  0  1  0  0    "        0  0  0  1  0  1  1  1    #  */
0x49,0x41, /*0  0  1  1  1  0  0  1    $        0  0  1  1  0  0  0  1    %  */	
0x4b,0x02, /*0  0  1  1  1  0  1  1    &	0  0  0  0  0  0  1  0    '  */
0x2f,0x1f, /*0  0  1  0  1  1  1  1    ( 	0  0  0  1  1  1  1  1    )  */
0x21,0x00, /*0  0  1  0  0  0  0  1    * 	0  0  0  1  0  0  1  1    +  */
0x01,0x00, /*0  0  0  0  0  0  0  1    , 	0  0  0  0  0  0  1  1    -  */
0x11,0x12, /*0  0  0  1  0  0  0  1    .        0  0  0  1  0  0  1  0    /  */
0x07,0x08, /*0  0  0  0  0  1  1  1    0	0  0  0  0  1  0  0  0    1  */
0x0a,0x0c, /*0  0  0  0  1  0  1  0    2	0  0  0  0  1  1  0  0    3  */
0x0d,0x09, /*0  0  0  0  1  1  0  1    4	0  0  0  0  1  0  0  1    5  */	
0x0e,0x0f, /*0  0  0  0  1  1  1  0    6	0  0  0  0  1  1  1  1    7  */
0x0b,0x06, /*0  0  0  0  1  0  1  1    8	0  0  0  0  0  1  1  0    9  */	  
0x25,0x05, /*0  0  1  0  0  1  0  1    :	0  0  0  0  0  1  0  1    ;  */	
0x29,0x4f, /*0  0  1  0  1  0  0  1    <	0  0  1  1  1  1  1  1    =  */	 
0x16,0x45, /*0  0  0  1  0  1  1  0    >	0  0  1  1  0  1  0  1    ?  */	
0x10,0x20, /*0  0  0  1  0  0  0  0    @ 	0  0  1  0  0  0  0  0    A  */
0x28,0x30, /*0  0  1  0  1  0  0  0    B 	0  0  1  1  0  0  0  0    C  */	
0x34,0x24, /*0  0  1  1  0  1  0  0    D	0  0  1  0  0  1  0  0    E  */
0x38,0x3c, /*0  0  1  1  1  0  0  0    F	0  0  1  1  1  1  0  0    G  */	
0x2c,0x18, /*0  0  1  0  1  1  0  0    H	0  0  0  1  1  0  0  0    I  */
0x1c,0x22, /*0  0  0  1  1  1  0  0    J	0  0  1  0  0  0  1  0    K  */	
0x2a,0x32, /*0  0  1  0  1  0  1  0    L	0  0  1  1  0  0  1  0    M  */
0x36,0x26, /*0  0  1  1  0  1  1  0    N	0  0  1  0  0  1  1  0    O  */
0x3a,0x3e, /*0  0  1  1  1  0  1  0    P	0  0  1  1  1  1  1  0    Q  */
0x2e,0x1a, /*0  0  1  0  1  1  1  0    R	0  0  0  1  1  0  1  0    S  */
0x1e,0x23, /*0  0  0  1  1  1  1  0    T 	0  0  1  0  0  0  1  1    U  */	
0x2b,0x1d, /*0  0  1  0  1  0  1  1    V 	0  0  0  1  1  1  0  1    W  */	
0x33,0x37, /*0  0  1  1  0  0  1  1    X 	0  0  1  1  0  1  1  1    Y  */
0x27,0x19, /*0  0  1  0  0  1  1  1    Z 	0  0  0  1  1  0  0  1    [  */
0x2d,0x3d, /*0  0  1  0  1  1  0  1    \ 	0  0  1  1  1  1  0  1    ]  */
0x14,0x15  /*0  0  0  1  0  1  0  0    ^        0  0  0  1  0  1  0  1    _  */
};
/*----------------------------------------------------------------------------*/

/**
 * bprint() -   Prints a nice formatted byte
 * @x:          Input byte
 *
 * Prints each bit of a byte to the STDOUT like
 *   0xFF = 1111 1111 
 **/
void bprint(byte x)
{
        int n;

        for(n = 0; n < 8; n++) {
                if((x & 0x80) != 0) {
	                printf("1");
		} else {
		        printf("0");
	        }

	        if (n == 3) {
			printf(" ");
		}
		x = x<<1;
	}

        printf("  ");
}

byte fill_byte(byte *ptr, byte mask) 
{
        byte pkt = 0;
        switch(mask) {
	        case 0x30:
		        pkt = ((*ptr & mask) << 2) |
                                (*(ptr + 1) & mask) |
                                ((*(ptr + 2) & mask) >> 2) |
                                ((*(ptr + 3) & mask) >> 4);
		        break;
	        case 0x0c:
		        pkt = ((*ptr & mask) << 4) |
                                ((*(ptr + 1) & mask) << 2) |
                                (*(ptr + 2) & mask) |
                                ((*(ptr + 3) & mask) >> 2);
		        break;
	        case 0x03:
		        pkt = ((*ptr & mask) << 6) |
                                ((*(ptr + 1) & mask) << 4) |
                                ((*(ptr + 2) & mask) << 2) |
                                (*(ptr + 3) & mask);
		        break;
	        default: printf("Mask error");
	}
        /*ptr +=4;*/
        return pkt;
}

void fill_line(byte *ptrOut, byte *ptrIn, int width) 
{
        int i,j;
        byte *ptrInA, *ptrOutA;
        ptrInA = ptrIn;
        ptrOutA = ptrOut + 21*cnt;
        byte mask[3] = { 0x30, 0x0c, 0x03 };

        for (i = 0; i < 3; i++) {
	        ptrInA = ptrIn;
                /**
                 * Fill line until 'width'
                 **/
	        for (j = 0; j < width; j++) {
		        *ptrOutA = fill_byte(ptrInA, mask[i]);
		        ptrOutA ++;
		        ptrInA += 4;
	        }
        }
}


/**
 * Unit function used in usb_discover()
 **/
void _usb_get_string_simple_Manuf(void)
{
	int ret;
	char s[256];

	ret = usb_get_string_simple(udev, 
				dev->descriptor.iManufacturer, 
				s, 
				sizeof(s));

	if (ret > 0)
		printf("Manufacturer: %s\n", s);
	else 
		printf("Could not read manufacturer\n"); 
}

/**
 * Unit function used in usb_discover()
 **/
void _usb_get_string_simple_Product(void)
{
	int ret;
	char s[256];

	ret = usb_get_string_simple(udev, 
				dev->descriptor.iProduct, 
				s, 
				sizeof(s));

	if (ret > 0)
		printf("Product: %s\n", s);
	else
		printf("Could not read product\n");
}

/**
 * Unit function used in usb_discover()
 **/
void _usb_get_string_simple_SN(void)
{ 
	int ret;
	char s[256];

	ret = usb_get_string_simple(udev, 
				dev->descriptor.iSerialNumber,
				s, 
				sizeof(s));

	if (ret > 0) 
		printf("Serial Number: %s\n", s);
	else
		printf("Could not read Serial Number\n");
}

/**
 * Unit function used in usb_discover()
 **/
void _usb_claim_interface(void)
{
	int ret;

	ret = usb_claim_interface(udev,0); 
	if (ret >= 0) 
		printf("The interface responded.\n"); 
	else 
	       printf("Error opening interface.\n");
}

/**
 * Main usb discovery function
 **/
int usb_discover(void)
{
        int sizein, sizeout, pts, sizein2, sizeout2; 
        char string[256];

	printf("PIC found, dev-%s in the bus-%s\n",
		dev->filename,
		bus->dirname); 

	usb_detach_kernel_driver_np(udev, 0); 
	usb_set_configuration(udev, 1);
			
	if (dev->descriptor.iManufacturer) 
		_usb_get_string_simple_Manuf();

	if (dev->descriptor.iProduct)  
		_usb_get_string_simple_Product();

	if (dev->descriptor.iSerialNumber)  
		_usb_get_string_simple_SN();

	_usb_claim_interface(); 
						
						
        WRITE = dev->config[0].interface[0].
                altsetting[0].endpoint[1].
                bEndpointAddress;

        READ = dev->config[0].interface[0].
                altsetting[0].endpoint[0].
                bEndpointAddress;
 
        WRITE2 = dev->config[0].interface[0].
                altsetting[0].endpoint[3].
                bEndpointAddress;

        READ2 = dev->config[0].interface[0].
                altsetting[0].endpoint[2].
                bEndpointAddress;
 
        sizein = dev->config[0].interface[0].
                altsetting[0].endpoint[1].
                wMaxPacketSize;

        sizeout = dev->config[0].interface[0].
                altsetting[0].endpoint[1].
                wMaxPacketSize;

        pts = dev->config[0].interface[0].
                altsetting[0].endpoint[0].
                bInterval;

        sizein2 = dev->config[0].interface[0].
                altsetting[0].endpoint[2].
                wMaxPacketSize;

        sizeout2 = dev->config[0].interface[0].
                altsetting[0].endpoint[2].
                wMaxPacketSize;

        printf("EP1\n");
        printf("---\n");
        printf("\tWRITE:\t%02xh\n", WRITE);
        printf("\tREAD:\t%02xh\n", READ);
        printf("\tSIZEIN:\t%d\n", sizein);
        printf("\tSIZEOUT:\t%d\n", sizeout);
        printf("\tE_PTS:\t%d\n\n", pts);
					
        printf("EP2\n");
        printf("---\n");
        printf("\tWRITE:\t%02xh\n", WRITE2);
        printf("\tREAD:\t%02xh\n", READ2);
        printf("\tSIZEIN:\t%d\n", sizein2);
        printf("\tSIZEOUT:\t%d\n", sizeout2);
}

/**
 * Main function that starts the usb device.
 **/
int start_usb(void)
{
        int n, m, ret; 
	
	usb_init();	
	
	n = usb_find_busses(); 
	m = usb_find_devices();

	for (bus = usb_busses; bus; bus = bus->next) { 
		for (dev = bus->devices; dev; dev = dev->next) {
			if (dev->descriptor.idVendor == LIBRE) { 
				if (dev->descriptor.idProduct == PRINTER) {
					udev = usb_open(dev);					
					if (udev) 
						usb_discover(); 				
				} else {
 					continue;
				}
			}
		}
	}
	
        if (udev) {
                printf("Device Initialized\n");
                ret = 1;
        } else {
                printf("Device could not be initialized\n");
                ret = 0;
	}
	return ret;
}

/**
 * Function to stop usb device
 **/
void stop_usb(void)
{
        usb_release_interface(udev,0);
	usb_close(udev);
}

/**
 * rep_char() - Replace a caracter with the braille table
 * @caract:     byte to replace
 *
 * Accepts an ASCII byte character and returns a replaced
 * byte according to the brAsciiTabla.
 **/
byte rep_char(byte caract)
{
	byte charCod,retorna;
	
	charCod = caract - 0x20;
	retorna =  brAsciiTabla[charCod];

	return retorna;
}


void code(FILE *ascii, FILE *braille)
{
        byte caract;	

	while(!feof(ascii)) {
		caract = getc(ascii);

		if (!feof(ascii))
			putc(rep_char(caract), braille);
	}
}

void fill_buffer(FILE *braille, char *brailleIn)
{
        char caract;
        int i=0;

	while(!feof(braille)) {
		caract = getc(braille);

		if(!feof(braille))
			 brailleIn[i] = caract;
		i++;
	}
}
