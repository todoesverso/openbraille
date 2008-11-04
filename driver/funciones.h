/*   functions.h - The header for functions.c.
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