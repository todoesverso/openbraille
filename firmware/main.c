/// Código de demostración de Entrada/Salida de USB en PIC 18F4550
/// enciende/apada LED y se identifica como impresora (si todo anda bien!! :] )
///
/// Sin copyright, (C) 2008 todoesverso & rajazz
///
/// Esta biblioteca es software libre. Puede ser redistribuido y/o modificado
/// bajo los términos de la Licencia Pública General de GNU publicada por
/// Free Software Foundation, bien de la versión 2.1 de dicha Licencia o
/// (según su elección) de cualquier versión posterior.
///
/// Esta biblioteca se distribuye con la esperanza de que sea útil, pero 
/// SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin
/// garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR.
/// Ver la Licencia Pública General de GNU para más detalles.
/// Debería haber recibido una copia de la Licencia Pública General junto
/// con este programa. Si no ha sido así, escriba a la Free Software
/// Foundation, Inc., en 675 Mass Ave, Cambridge, MA 02139, EEUU.
///

#include <pic18fregs.h>
#include <stdio.h>
#include <usart.h>
#include "usb.h"

// Constantes definidas por el tamaño de la pagina Braille
//#define BYTESXLIN 3
#define NUMLINES 7
// Codigos para instrucciones del driver
#define PRINT 1
#define MOV 2
// Codigo para tipo de movimiento vertical
#define SHORT_OUT 1
#define LONG_OUT 2
// Separaciones verticales de los braille dots
#define SHORT_STEPS_OUT 40
#define LONG_STEPS_OUT 70


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

// Buffer usado para el Endpoint2 (convencionalmente adoptado como Bus de instrucciones de 1 byte)
volatile byte instruction;

// Punto de entrada de inicialización de usuario
void UserInit(void){
    ADCON0 = 0xFF;		// Establece RA4 como salida
    ADCON1 = 0x0F;		// Establecer todos los pines de I/O a digital
    TRISB = 0x00;		// o_O' Mhmh, read the f*in datasheet!
    TRISD = 0xc;
    INTCON = 0;
    INTCON2 = 0;

    PORTB=0x00;	
    PERCUTOR = 0;
}

// Rutina que genera un delay aproximado hecho sin presicion (para ver los LEDs encendidos)

void delay(int ms){
int i;
	while(ms--)
		for(i=0;i<50;i++); // Estos números son ciclos sucifientes para generar retardo
}
// Bucle central de proceso. En cuanto el firmware no esta ocupado atendiendo
// el USB, se toma control acá para hacer otro procesamiento.


// Funciones para el comando de las partes móviles de la impresora

// Función q se usa exlcusivamente para calibrar los motores


void apagar_motores(void){
	PORTB = 0x00;
}

void mover(byte loops, byte direccion, byte motor){
byte pasosI[8] = {0x77, 0x33, 0xbb, 0x99, 0xdd, 0xcc, 0xee, 0x66};
byte pasosD[8] = {0x66, 0xee, 0xcc, 0xdd, 0x99, 0xbb, 0x33, 0x77}; // <--- CAMBIAR!!!!
byte valor,i;
byte loops_aux ;

if(direccion)
 for(loops_aux=0; loops_aux < loops; loops_aux++){
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
 for(loops_aux=0; loops_aux < loops; loops_aux++){
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

byte mov_paper (byte steps) {
	mover(steps, ARR, RODILLO);
	return steps;
	}

void reset_carro(void){
 while(SENS_CARRO)
  mover(1, IZQ, CARRO);
}

void golpear(void){
 delay(100);
 PERCUTOR = 1;
 delay(100);
 PERCUTOR = 0;
 delay(100);
}

// Funciones para la realización de la impresión

void check_bit(byte *p, byte pos){ // posicion del bit del 0 al 7
byte mascara, aux;
	mascara = 0x01; // Para la lectura del cada bit
	mascara = mascara << pos;
	aux = *p & mascara;
	if (aux)
		golpear();
}

/* Funciones a implementar
*
* 
*
*
*
*
byte check_bit(byte byte_in, byte pos){ // posicion del bit del 0 al 7
// Recibe como parametro un byte y un indice para el byte.
// Devuelve 1 si el bit del indice esta en 1 o cero si esta en cero.
//  (byte, [0-7])
byte mascara;
   mascara = 0x01; // Para la lectura del cada bit
   mascara = mascara << pos;
    if (byte_in & mascara)
      return 1;
    return 0;
}
*
*
*
*
*
*/


void print_byte(byte *p){
byte a, i;
	for (i = 8; i > 0; i--){
		check_bit(p, i-1);
		a =(byte)i;
		if (!(a&1)) // Chequea la paridad (PAR = minima sep, IMPAR = Maxima sep)
			mover(3, DER, CARRO); // Separacion horizontal mínima del caracter braille
		else
			mover(6, DER, CARRO); // Separacion horizontal máxima del caracter braille
	}
}

void print_line(byte *p) {
byte width_b;
	apagar_motores();
	mover(12, DER, CARRO); // Esto es una sangria
	width_b = NUMLINES;
	while (width_b) {
		print_byte(p);
		p++;
		width_b--;
 		}
	apagar_motores();
}

static void USBEcho(void){
	byte rxCnt, mv_type, i;

        // Find out if an Output report has been received from the host
//	rxCnt = BulkOut(rxBuffer, OUTPUT_BYTES);

        // Find out if an Output report has been received from the host

	rxCnt = BulkOut(1, rxBuffer, NUMLINES); // Carga el EP1 con los 7 bytes a imprimir o el tipo de movimiento
// REVISAR la linea anterior, OUTPUT_BYTES seria = 7, para cortar al ancho de la pagina
// rxBuffer se utiliza para usar el EP1, REVISAR para dar una mejor referencia (antes lo cargabamos a toda la pagina)
	mv_type = rxBuffer[0]; // esta se usa para guardar el byte si la instruccion es de movimiento (EP2=MOV)
	
	BulkOut(2, &instruction, 1); // La instruccion es de 1 byte, que viene con el EP2
	if (rxCnt == 0) return;

// mini main():	
	if (instruction == PRINT)
		print_line (rxBuffer);

else if (instruction == MOV) {
	if (mv_type == SHORT_OUT)
		mov_paper (SHORT_STEPS_OUT); 
	if (mv_type == LONG_OUT)
		mov_paper (LONG_STEPS_OUT);	
	}
	apagar_motores();

// se mandan estos datos por el USB al finalizar el proceso de impresión
	//pagina[0] = rxCnt;

// Se manda endpoint1 haciendo un eco de los datos simplemente guardados en rxBuffer
// TBD: Hacer el manejo de errores, usar txBuffer para mandar estos datos al host
	for(i=0;i<OUTPUT_BYTES;i++)
		txBuffer[i] = rxBuffer[i];
	BulkIn(1,txBuffer, OUTPUT_BYTES);

// Se manda endpoint2 con el codigo de instruccion usado
	BulkIn(2, &instruction, OUTPUT_BYTES);
}

void ProcessIO(void){	
	// Tareas de aplicación de Usuario USB
    if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
		return;

	// Proceso USB: Agregar acá la función que realiza el dispositivo
	// ACA!!
	USBEcho();

// Las siguientes lineas hacen que el dispositivo haga un eco de lo que recibe por el bus USB
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
	reset_carro();
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
//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-/frame-pointer -mpic16 -p18f45100 -I /usr/share/sdcc/include/pic16/ -c usb.c

//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-frame-pointer -mpic16 -p18f45100 -I /home/rajazz/Final/PICHID\ -Para\ meter\ mano/ -L /usr/share/sdcc/lib/pic16/ -Wl,"-w -s 18f45100.lkr" main.c usb.o

