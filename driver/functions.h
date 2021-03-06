/*   functions.h - The header for functions.c.
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

#include "functions.c"

// Variables globales estaticas


// Cabecera de las funciones 

//De uso general
void bprint(byte x);
void fill_buffer(FILE *braille, char *brailleIn);

//De codificacion
byte fill_byte(byte *ptr, byte mask);
void fill_line(byte *ptrOut, byte *ptrIn, int ancho);
byte rep_char(byte caract);
void code(FILE *ascii, FILE *braille);

//De manejo de USB
int start_usb(void);
void stop_usb(void);

int usb_discover(void);
void _usb_get_string_simple_Manuf(void);
void _usb_get_string_simple_Product(void);
void _usb_get_string_simple_SN(void);
void _usb_claim_interface(void);


