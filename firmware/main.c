/*   main.c - The main program of the firmware.
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

#include <pic18fregs.h>
#include <stdio.h>
#include "usb.h"

// Constantes definidas por el tamaño de la pagina Braille
//#define BYTESXLIN 3
#define NUMLINES 7
// Instruction codes from the host 
#define RESET           0x00
#define PRINT           0x01
#define MOV_SHORT       0x02
#define MOV_LONG        0x03
// Codigo para tipo de movimiento vertical
#define SHORT_OUT 1
#define LONG_OUT 2
// Separaciones verticales de los braille dots
#define SHORT_STEPS_OUT 4
#define LONG_STEPS_OUT 7


// Nombres de lo que esta conectado al puerto del PIC, mirar esquemático del circuito y el pinout
// En el puerto D están conectados dos entradas y la salida del percutor
#define SENS_PAPEL PORTDbits.RD3
#define SENS_CARRO PORTDbits.RD2
#define PERCUTOR PORTDbits.RD1

#define CARRO 1
#define RODILLO 0
// visto desde el frente de la impresora
#define IZQ 1
#define DER 0
// a como sale la hoja impresa
#define ARR 1
#define ABAJ 0
// Extensión máxima de pasosn que puede recorrer el carro
#define RECORR_CARRO 136

// NOTA: Hay problemas relacionados al tiempo asociados con GET_FEAUTURE
// cuando corre a menos de 48 MHz

// Corriente:
//   23 mA @ 16 MHz
//   26 mA @ 24 MHz
//   35 mA @ 48 MHz
//
// Definición de los registros de configuración de fusibles (fuses)
#if defined(pic18f2550) || defined(pic18f2455) || defined(pic18f4550) || defined(pic18f4455)
code char at 0x300000 CONFIG1L = 0x20; // CPU system clock 96MHz PLL div 2, Oscillator No div (4MHz input)
code char at 0x300001 CONFIG1H = 0x0e; // HS oscillator, PLL enabled, HS used by USB
code char at 0x300002 CONFIG2L = 0x20; // Brown out off, PWRT On 
code char at 0x300003 CONFIG2H = 0x00; // WDT off
code char at 0x300004 CONFIG3L = 0xff; // Unused configuration bits
code char at 0x300005 CONFIG3H = 0x81; // MCLR, PORTB digital, CCP2 - RC1
code char at 0x300006 CONFIG4L = 0x80; // ICD off, ext off, LVP off, stk ovr off
code char at 0x300007 CONFIG4H = 0xff; // Unused configuration bits
code char at 0x300008 CONFIG5L = 0xff; // No code read protection
code char at 0x300009 CONFIG5H = 0xff; // No data/boot read protection
code char at 0x30000A CONFIG6L = 0xff; // No code write protection
code char at 0x30000B CONFIG6H = 0xff; // No data/boot/table protection
code char at 0x30000C CONFIG7L = 0xff; // No table read protection
code char at 0x30000D CONFIG7H = 0xff; // No boot table protection
#endif

// Buffers usados para el Endpoint1 (convencionalmente adoptado como Bus de datos)
volatile byte txBuffer[INPUT_BYTES];
volatile byte rxBuffer[OUTPUT_BYTES];
volatile byte echoVector[INPUT_BYTES];
// Buffer usado para el Endpoint2 (convencionalmente adoptado como Bus de instrucciones de 1 byte)
volatile byte instruction;

// Punto de entrada de inicialización de usuario
void UserInit(void){
 ADCON0         = 0xFF;		// Establece RA4 como salida
 ADCON1         = 0x0F;		// Establecer todos los pines de I/O a digital
 TRISB          = 0x00;		// o_O' Mhmh, read the f*in datasheet!
 TRISD          = 0xc;
 INTCON         = 0;
 INTCON2        = 0;
 PORTB          = 0x00;	
 PERCUTOR       = 0;
}

// Rutina que genera un delay aproximado hecho sin presicion (para ver los LEDs encendidos)

void delay(byte ms){
 byte i;
   while(ms--)
     for(i = 0; i < 200; i++); // Estos números son ciclos sucifientes para generar retardo
}

// Funciones para el comando de las partes móviles de la impresora

void apagar_motores(void){
 PORTB = 0x00;
}

void mover(byte loops, byte direccion, byte motor){
byte pasosI[8] = {0x77, 0x33, 0xbb, 0x99, 0xdd, 0xcc, 0xee, 0x66};
byte pasosD[8] = {0x66, 0xee, 0xcc, 0xdd, 0x99, 0xbb, 0x33, 0x77}; // <--- CAMBIAR!!!!
byte valor,i;
byte loops_aux ;

if(direccion)
 for(loops_aux = 0; loops_aux < loops; loops_aux++){
  for(i = 0; i < 8; i++){		
   valor = pasosI[i];
   if(motor){
    PORTB = (PORTB & 0xf0) | (valor & 0x0f);
    delay(50);
    }
   else{
    PORTB = (PORTB & 0x0f) | (valor & 0xf0);
    delay(50);
    }       	
  }
 }
else
 for(loops_aux = 0; loops_aux < loops; loops_aux++){
  for(i = 0; i < 8; i++){		
   valor = pasosD[i];
   if(motor){
    PORTB = (PORTB & 0xf0) | (valor & 0x0f);
    delay(50);
    }
   else{
    PORTB = (PORTB & 0x0f) | (valor & 0xf0);
    delay(50);
    }
  }
 }
}

void mov_paper (byte steps) {
 mover(steps, ARR, RODILLO);
}

void reset_carro(void){
  while(SENS_CARRO)
    mover(1, IZQ, CARRO);
 mover(8, DER, CARRO); // Esto es una sangria

}

void golpear(void){
 delay(100);
 PERCUTOR = 1;
 delay(100);
 PERCUTOR = 0;
 delay(100);
}

byte check_bit(byte byte_in, byte pos){
// Recibe como parametro un byte y un indice para el byte.
// Devuelve 1 si el bit del indice esta en uno o 0 si esta en cero.
//  (byte, [0-7])
 byte mascara;
 mascara = 0x01; // Para la lectura del cada bit
 mascara = mascara << pos;
   if (byte_in & mascara)
     return 1;
 return 0;
}

void set_bit(byte *byte_in, byte pos){
 byte mask = 0x01, byte_aux = *byte_in;
 mask = mask << pos;
 *byte_in = byte_aux ^ mask; 
 /* This could be a simple | too, but ^ makes it better
  * because it would destroy the byte if something goes wrong. 
  * Let's say that byte_in = 0x07 (0000 0111), and for some 
  * reason we try to set the bit 2 the XOR would destroy the byte 
  * byte_in = 0000 0111 ^ 0000 0100 = 0000 0011 = 0x03. This should
  * never happen because pos will increment, but you never know ;)
  */                         
}

byte print_byte(byte *p){
 byte a, i, byte_in, byte_ctl = 0x00;
 byte_in = *p;
   for (i = 8; i > 0; i--) {
     if (check_bit(byte_in, i-1)){ 
       golpear();
       set_bit(&byte_ctl, i-1); // Recreate the byte for error control
     }
       a =(byte)i;
 // Movimiento del carro segun la posicion par-impar del braille dot
     if (!(a&1)) // Chequea la paridad (PAR = minima sep, IMPAR = Maxima sep)
       mover(2, DER, CARRO); // Separacion horizontal mínima del caracter braille
     else
       mover(4, DER, CARRO); // Separacion horizontal máxima del caracter braille
    }
   return byte_ctl;
}

void print_line(byte *p, byte *e){
 byte width_b;
 reset_carro();
 width_b = NUMLINES - 1;
   while (width_b) {
     *e = print_byte(p);
     p++;
     e++;
     width_b--;
   }
}

static void USB(void){
 byte rxCnt;
 /* The code should present a clear distiction between
  * data direction
  */
  // *** HOST --> DEVICE  ***
 /* 
  * Find out if an output request has arrived to EP2
  */
 rxCnt = BulkOut(2, &instruction, 1); 
   if (rxCnt == 0) return;
   //Now rxBuffer[0] is actually the instruction that follow
 
  // Interpret instructions recived from host
  if (instruction == MOV_SHORT) {
 	mov_paper (SHORT_STEPS_OUT); 
  }
  else if (instruction == MOV_LONG){
	mov_paper (LONG_STEPS_OUT);
  }

  else if (instruction == PRINT) {
   do{
  // *** HOST --> DEVICE  ***
      rxCnt = BulkOut(1, rxBuffer, INPUT_BYTES); // Shuld this be OUTP?
   } while (rxCnt == 0);
        print_line(rxBuffer, echoVector);

           while (ep1Bi.Stat & UOWN)
            ProcessUSBTransactions();
      /* We recived the order to PRINT, so we did it. 
       * Then we process usb transactions if any.
       * Now we are ready to send the data treated back
       * to the host so he can check if there where
       * any errors.
       */
       // *** DEVICE --> HOST ***
       do{ 
         rxCnt =  BulkIn(1, echoVector, INPUT_BYTES);
       } while(rxCnt == 0);

  }
   else if (instruction == RESET)
        reset_carro();
   
      while (ep1Bi.Stat & UOWN)
            ProcessUSBTransactions();

        apagar_motores();
}

void ProcessIO(void){	
// Tareas de aplicación de Usuario USB
  if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
    return;
  USB();
}

// Punto de entrada del Firmware
void main(void){
 // LLamada a la función de inicialización de usuario
 UserInit();
 // Inicializar USB
 UCFG = 0x14; // Habilita las resistencias de pullup; modo full speed

 // Condiciones iniciales del dispositivo
 deviceState = DETACHED;
 remoteWakeup = 0x00;
 currentConfiguration = 0x00;
 apagar_motores();
   while(1){
   // Asegurar que el modulo USB está disponible
     EnableUSBModule();
    // En cuanto sale del modo de prueba (UTEYE), procesa
    // las transactiones USB
       if(UCFGbits.UTEYE != 1)
         ProcessUSBTransactions();
        // Tareas de apliacación específica
      ProcessIO();
   }
}
