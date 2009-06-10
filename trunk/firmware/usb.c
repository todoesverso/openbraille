/*   usb.c - The main functions for usb handle.
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
#include <string.h>
#include <stdio.h>
#include "usb.h"


/**
 * Device and configuration descriptors.  These are used as the
 * host enumerates the device and discovers what class of device
 * it is and what interfaces it supports.
**/

/**
 * Size in bytes of descriptors
 **/
#define DEVICE_DESCRIPTOR_SIZE 0x12
#define CONFIG_HEADER_SIZE  0x09
#define CONFIG_DESCRIPTOR_SIZE 0x25
/**
 * The total size of the configuration descriptor
 * 0x09	 +  0x09  +  0x07  +  0x07  =  0x20 
 **/

#define CFSZ CONFIG_HEADER_SIZE+CONFIG_DESCRIPTOR_SIZE

/** 
 * Struct of Configuration Descriptor
 * @configHeader:
 * @Descriptor:
 * 
 **/
typedef struct _configStruct {
    byte configHeader[CONFIG_HEADER_SIZE];
    byte Descriptor[CONFIG_DESCRIPTOR_SIZE]; 
} ConfigStruct;

/**
 * Global Variables
 **/

/**
 * Visible States (USB 2.0 Spec, chap 9.1.1)
 **/
byte deviceState;  
byte remoteWakeup;
byte deviceAddress;
byte selfPowered;
byte currentConfiguration;


/* Control Transfer Stages - see USB spec chapter 5                          */
/* Start of a control transfer (followed by 0 or more data stages)           */
#define SETUP_STAGE    0 
#define DATA_OUT_STAGE 1 /* Data from host to device                         */
#define DATA_IN_STAGE  2 /* Data from device to host                         */
#define STATUS_STAGE   3 /* Unused - if data I/O went ok, then back to setup */

byte ctrlTransferStage; /* Holds the current stage in a control transfer     */
byte requestHandled;    /* Set to 1 if request was understood and processed. */

byte *outPtr;           /* Data to send to the host                          */
byte *inPtr;            /* Data from the host                                */
word wCount;            /* Number of bytes of data                           */
byte RxLen;             /* # de bytes colocados dentro del buffer            */

/**
 * Device Descriptor
 **/
code byte deviceDescriptor[] = {
    DEVICE_DESCRIPTOR_SIZE, 0x01, /* bLength, bDescriptorType                */
    0x00, 0x02,                   /* bcdUSB (LB), bcdUSB (HB)                */
    0x00, 0x00,                   /* bDeviceClass, bDeviceSubClass           */
    0x00, E0SZ,                   /* bDeviceProtocl, bMaxPacketSize          */
    0xD8, 0x04,                   /* idVendor (LB), idVendor (HB)            */
    0x31, 0x75,                   /* idProduct (LB), idProduct (HB)          */
    0x01, 0x00,                   /* bcdDevice (LB), bcdDevice (HB)          */
    0x01, 0x02,                   /* iManufacturer, iProduct                 */
    0x00, 0x01                    /* iSerialNumber (none), bNumConfigurations*/
};

#define ISZ 7                /* wMaxPacketSize (low) of endopoint1IN         */
#define OSZ 7                /* wMaxPacketSize (low) of endopoint1OUT        */
#define OSZ2 1               /* wMaxPacketSize (low) of endopoint2OUT        */

/**
 * Configuration Descriptor
 **/
code ConfigStruct configDescriptor = {
    {
    /* Descriptor de configuracin, contiene el descriptor de la clase        */
    CONFIG_HEADER_SIZE, 0x02, /* bLength, bDescriptorType (Configuration)    */
    CFSZ, 0x00,               /* wTotalLength (low), wTotalLength (high)     */
    0x01, 0x01,               /* bNumInterfaces, bConfigurationValue         */
    0x00, 0xA0,               /* iConfiguration, bmAttributes ()             */
    0x32,                     /* bMaxPower (100 mA)                          */
    },
    {
    // Interfaz del descriptor
    0x09, 0x04,               /* bLength, bDescriptorType (Interface)        */
    0x00, 0x00,               /* bInterfaceNumber, bAlternateSetting         */
    0x04, 0x07,               /* bNumEndpoints, bInterfaceClass (Printer)    */
    0x01, 0x00,               /* bInterfaceSubclass, bInterfaceProtocol      */
    0x00,                     /* iInterface                                  */
    // Impresora Endpoint 1 In
    0x07, 0x05,               /* bLength, bDescriptorType (Endpoint)         */
    0x81, 0x02,               /* bEndpointAddress, bmAttributes (Bulk)       */
    ISZ, 0x00,                /* wMaxPacketSize (L), wMaxPacketSize (H)      */
    0x01,                     /* bInterval (1 millisecond)                   */
    // Impresora Endpoint 1 Out
    0x07, 0x05,               /* bLength, bDescriptorType (Endpoint)         */
    0x01, 0x02,               /* bEndpointAddress, bmAttributes (Bulk)       */
    OSZ, 0x00,                /* wMaxPacketSize (L), wMaxPacketSize (H)      */
    0x01,                     /* bInterval (1 millisecond)                   */
    // Impresora Endpoint 2 In
    0x07, 0x05,               /* bLength, bDescriptorType (Endpoint)         */
    0x82, 0x02,               /* bEndpointAddress, bmAttributes (Bulk)       */
    ISZ, 0x00,                /* wMaxPacketSize (L), wMaxPacketSize (H)      */
    0x01,                     /* bInterval (1 millisecond)                   */
    // Impresora Endpoint 2 Out
    0x07, 0x05,               /* bLength, bDescriptorType (Endpoint)         */
    0x02, 0x02,               /* bEndpointAddress, bmAttributes (Bulk)       */
    OSZ2, 0x00,               /* wMaxPacketSize (L), wMaxPacketSize (H)      */
    0x01,                     /* bInterval (1 millisecond)                   */
    } 
};

//
// Descriptores String (cadenas de caracteres)
//

/**
 * According to USB spec, the 0 index has the lenguage code 
 **/
code byte stringDescriptor0[] = {
    0x04, STRING_DESCRIPTOR,    /* bLength, bDscType                         */
    0x09, 0x04,		        /* Stablish wLANGID with 0x0409 (English,USA)*/
};

code byte stringDescriptor1[] = {
    0x1A, STRING_DESCRIPTOR,                    /* bLength, bDscType */
    'E', 0x00, 'm', 0x00, 'b', 0x00, 'o', 0x00,
    's', 0x00, 's', 0x00, 'e', 0x00, 'r', 0x00,
    ' ', 0x00, ' ', 0x00,
    ' ', 0x00, ' ', 0x00,
};

code byte stringDescriptor2[] = {
    0x20, STRING_DESCRIPTOR,                    /* bLength, bDscType */
    'U', 0x00, 'S', 0x00, 'B', 0x00, ' ', 0x00,
    'B', 0x00, 'r', 0x00, 'a', 0x00, 'i', 0x00,
    'l', 0x00, 'l', 0x00, 'e', 0x00, ' ', 0x00,
    '0', 0x00, '.', 0x00, '1', 0x00,
};

volatile BDT at 0x0400 ep0Bo; /* Endpoint #0 BD OUT     */
volatile BDT at 0x0404 ep0Bi; /* Endpoint #0 BD IN      */
volatile BDT at 0x0408 ep1Bo; /* Endpoint #1 BD OUT     */
volatile BDT at 0x040C ep1Bi; /* Endpoint #1 BD IN      */
volatile BDT at 0x0410 ep2Bo; /* Endpoint #2 BD OUT     */
volatile BDT at 0x0414 ep2Bi; /* Endpoint #2 BD IN      */

/*
 * Put endpoint 0 buffers into dual port RAM
 **/
#pragma udata usbram5 SetupPacket controlTransferBuffer
volatile setupPacketStruct SetupPacket;
volatile byte controlTransferBuffer[E0SZ];

/**
 * Put I/O buffersinto dual port USB RAM
 **/
#pragma udata usbram5 RxBuffer TxBuffer 
#pragma udata usbram6 RxBuffer2 TxBuffer2

/** 
 * Specific Buffers
 **/
volatile byte RxBuffer[OSZ];
volatile byte TxBuffer[ISZ];
volatile byte RxBuffer2;
volatile byte TxBuffer2[ISZ];

/** 
 * Enpoints Initialization
 **/
void InitEndpoint(void)
{
    	/* Turn on both IN and OUT for this endpoints (EP1 & EP2)       */
        UEP1 = 0x1E;  /* See PIC datasheet, page 169 (USB E1 Control)   */
        UEP2 = 0x1E;  /* Same as above for EP2                          */

	/** 
         * Load EP1's BDT
         **/
        ep1Bo.Cnt = sizeof(RxBuffer);
	ep1Bo.ADDR = PTR16(&RxBuffer);
	ep1Bo.Stat = UOWN | DTSEN;
	ep1Bi.ADDR = PTR16(&TxBuffer);
	ep1Bi.Stat = DTS;

	/** 
         * Load de EP2's BDT
         **/
        ep2Bo.Cnt = RxBuffer2;
	ep2Bo.ADDR = PTR16(&RxBuffer2);
	ep2Bo.Stat = UOWN | DTSEN;
	ep2Bi.ADDR = PTR16(&TxBuffer2);
	ep2Bi.Stat = DTS;
}

/**
 * BulkIn() - Makes an IN and returns the amount of bytes transfered
 * @ep_num:   Number of the endpoint to be used (only EP1 & EP2)
 * @buffer:   Buffer of the data to be transfered
 * @len:      Lenght of the bytes transfered
 *
 * The function checks if the BD is owned by the CPU retunrning 0 if so.
 * (PIC 18F4550 datasheet page 171 section 17.4.1.1 - Buffer Ownership)
 *
 * Send up to len bytes to the host.  The actual number of bytes sent is returned
 * to the caller.  If the send failed (usually because a send was attempted while
 * the SIE was busy processing the last request), then 0 is returned.
 **/ 
byte BulkIn(byte ep_num, byte *buffer, byte len){
	byte i;
/**
 * If slelected EP1
 **/
if (ep_num == 1){        
        /** 
         * If SIE owns the BD do not try to send anything and return 0. 
         **/
	if (ep1Bi.Stat & UOWN)
		return 0;
	/**
         * Truncate requests that are too large 
         **/
	if(len > ISZ)       
		len = ISZ;
        /**
        * Copy data from user's buffer to dual-port ram buffer
        **/
	for (i = 0; i < len; i++)
		TxBuffer[i] = buffer[i];
        /**
         * Toggle the data bit and give control to the SIE
         **/
	ep1Bi.Cnt = len;
	if(ep1Bi.Stat & DTS)
		ep1Bi.Stat = UOWN | DTSEN;
	else
		ep1Bi.Stat = UOWN | DTS | DTSEN;

	return len;
}
/**
 * If selected EP2 (same as above)
 **/
else if (ep_num == 2){
	if (ep2Bi.Stat & UOWN)
		return 0;
	
	if(len > ISZ)
		len = ISZ;
	
	for (i = 0; i < len; i++)
		TxBuffer2[i] = buffer[i];
	
	ep2Bi.Cnt = len;
	if(ep2Bi.Stat & DTS)
		ep2Bi.Stat = UOWN | DTSEN;
	else
		ep2Bi.Stat = UOWN | DTS | DTSEN;

	return len;
}
/**
 * In case of error (ep_num != 1|2) return 0
 **/
return 0;
}

/**
 * BulkOut() - Reads 'len' bytes from the dual-port buffer
 * @ep_num:    Number of the endpoint to be read
 * @buffer:    Buffer to collect the data
 * @len:       Lenght of the data recived
 *
 * Actual number of bytes put into buffer is returned.  
 * If there are fewer than len bytes, then only the available
 * bytes will be returned.  Any bytes in the buffer beyond len 
 * will be discarded.
 **/
byte BulkOut(byte ep_num, byte *buffer, byte len) {
RxLen = 0;
/**
 * If selected EP1
 **/
if (ep_num == 1) {
        /**
        * If the SIE doesn't own the output buffer descriptor, 
        * then it is safe to pull data from it
        **/
	if(!(ep1Bo.Stat & UOWN)) {
        /**
         * See if the host sent fewer bytes that we asked for.
         **/
		if(len > ep1Bo.Cnt)
			len = ep1Bo.Cnt;
        /**
         * Copy data from dual-ram buffer to user's buffer
         **/
		for (RxLen = 0; RxLen < len; RxLen++)
			buffer[RxLen] = RxBuffer[RxLen];
        /**
         * Resets the OUT buffer descriptor so the host can send more data
         **/
		ep1Bo.Cnt = sizeof(RxBuffer);
		if (ep1Bo.Stat & DTS)
			ep1Bo.Stat = UOWN | DTSEN;
		else
			ep1Bo.Stat = UOWN | DTS | DTSEN;
        } 
}
/**
 * The same that above but for EP2. In this case the 'len'
 * is hardcoded to '1' because only 1 byte is needed for
 * instructions for the printer.
 **/
else if (ep_num == 2) {
	if (!(ep2Bo.Stat & UOWN)) {
		if (len > ep2Bo.Cnt)
			len = ep2Bo.Cnt;

		buffer[0] = RxBuffer2;
                RxLen = 1;

		ep2Bo.Cnt = 1;
		if (ep2Bo.Stat & DTS)
			ep2Bo.Stat = UOWN | DTSEN;
		else
			ep2Bo.Stat = UOWN | DTS | DTSEN;
	}
}
/**
 * Retunrs the lenght of the data recived
 **/
return RxLen;
}

/**
 * Start of code to process standard requests (USB spec chapter 9)
 **/

// Solicitud GET_DESCRIPTOR (X) (los datos parecen estar contenidos el el paquete Setup)
// (X) sera Device, Configuration o String segun se identifique al tipo de solicitud

/**
 * GetDescriptor(void) - Process Descriptors requests
 *
 * 
 *
 **/
static void GetDescriptor(void)
{
        /**
         * If direction is device --> host
         **/
        if (SetupPacket.bmRequestType == 0x80) {
                /**
                 * MSB has descriptor type
                 * LSB has descriptor Index
                 **/
                byte descriptorType  = SetupPacket.wValue1;
                byte descriptorIndex = SetupPacket.wValue0; 
                /**
                * If request for device
                **/
                if (descriptorType == DEVICE_DESCRIPTOR) {
                        requestHandled = 1;		
                        /**
                         * Points to device descriptor's address 
                         **/
                        outPtr = (byte *) &deviceDescriptor;
                        wCount = DEVICE_DESCRIPTOR_SIZE; 
                }
                /**
                 * If requested for descriptor's configuration
                 **/
	        else if (descriptorType == CONFIGURATION_DESCRIPTOR) {
                        requestHandled = 1;
                        outPtr = (byte *) &configDescriptor;
                        wCount = configDescriptor.configHeader[2]; 
                        /*** Note: SDCC may generate bad code with this ***/
                }
                /**
                 * If requested for descriptor's string
                 **/
	        else if (descriptorType == STRING_DESCRIPTOR) {
                        requestHandled = 1;
                        if (descriptorIndex == 0)
                                /* Language encoding */
                                outPtr = (byte *) &stringDescriptor0;
                        else if (descriptorIndex == 1)  
                                /* Author name */
                                outPtr = (byte *) &stringDescriptor1;
                        else
                                /* Device name */
                                outPtr = (byte *) &stringDescriptor2;
                        wCount = *outPtr;	
                } else {
                /**
                 * A blinking LED may be used if error occur
                 **/
                }
    }
}

// Solicitud GET_STATUS (los datos parecen estar contenidos en el paquete Setup) 
/**
 * GetStatus(void) - 
 *
 **/
static void GetStatus(void)
{
	/** 
         * Mask Off the Recipient bits 
         *
         * From USB spec chapter 9.4.5
         * ---------------------------
         *  bmRequestType
         * 10000000 -> Device
         * 10000001 -> Interface
         * 10000010 -> Endpoint
         **/
        byte recipient = SetupPacket.bmRequestType & 0x1F;
        controlTransferBuffer[0] = 0;
        controlTransferBuffer[1] = 0;

        /**
         * Requested for Device
         **/
        if (recipient == 0x00) {
                requestHandled = 1;
	        if (selfPowered)
                        /* Set SelfPowered bit */
		        controlTransferBuffer[0] |= 0x01;
                if (remoteWakeup)
                        /* Set RemoteWakeUp bit */
		        controlTransferBuffer[0] |= 0x02; 
        }
        /**
         * Requested for Interface
         **/
        else if (recipient == 0x01) 
                requestHandled = 1;
        /**
         * Requested for Endpoint
         **/
        else if (recipient == 0x02) { 
                byte endpointNum = SetupPacket.wIndex0 & 0x0F;
                byte endpointDir = SetupPacket.wIndex0 & 0x80;
                requestHandled = 1;
        /**
         * Endpoint descriptors are 8 bytes long, with each in and out taking 4 bytes
         * within the endpoint (See PIC18F4550 'Buffer Descriptors and the
         * Buffer Descriptor Table' chapter 17.4)
         **/
                inPtr = (byte *)&ep0Bo + (endpointNum * 8); 

                if (endpointDir) 
                        inPtr += 4;

                if (*inPtr & BSTALL) // El valor al que apunta el puntero y el estado del bit D0
                        controlTransferBuffer[0] = 0x01;
        }
        /**
         * If a request was handled (reuestHandled) move OUT pointer to the
         * controlTransferBuffer adress.
         **/
	if (requestHandled) {
		outPtr = (byte *)&controlTransferBuffer;
		wCount = 2;
	}
}

/**
 * SetFeature(void) -
 *
 **/
static void SetFeature(void)
{
        byte recipient = SetupPacket.bmRequestType & 0x1F;
        byte feature = SetupPacket.wValue0;

        /**
         * Requested for Device
         **/
        if (recipient == 0x00) {
                if (feature == DEVICE_REMOTE_WAKEUP) {
                        requestHandled = 1;

                if (SetupPacket.bRequest == SET_FEATURE)
                        remoteWakeup = 1;
                else
                        remoteWakeup = 0;
                }
        }
        /**
         * Requested for Endpoint
         **/
        else if (recipient == 0x02) {
                byte endpointNum = SetupPacket.wIndex0 & 0x0F;
                byte endpointDir = SetupPacket.wIndex0 & 0x80;

                if ((feature == ENDPOINT_HALT) && (endpointNum != 0)) {
                        requestHandled = 1;
                        inPtr = (byte *) &ep0Bo + (endpointNum * 8); 

                        if (endpointDir)
                                inPtr += 4;

                        if (SetupPacket.bRequest == SET_FEATURE)
                                *inPtr = 0x84;
                        else {
                                if (endpointDir == 1)
                                        *inPtr = 0x00;
                                else
                                        *inPtr = 0x88;
                        }
                }
        }
}

/**
 * ProcessStandarRequest(void) -
 *
 **/
void ProcessStandardRequest(void)
{
        /**
         * See USB 2.0 spec chapter 9.3
         **/
        byte request = SetupPacket.bRequest; 

        /**
         * Only attend Standar requests D6..5 == 00b
         **/
        if ((SetupPacket.bmRequestType & 0x60) != 0x00)
	        return;

        if (request == SET_ADDRESS) {
        // Establece la direccion del dispositivo.  Todas las solicitudes futuras
        // vendran a esa direccion. En realidad, no se se puede establecer UADDR
        // a la nueva direcciom aun porque el resto de la transaccion SET_ADDRESS
        // utiliza la direccion 0.
                requestHandled = 1;
                deviceState = ADDRESS;
                deviceAddress = SetupPacket.wValue0;
        }

        else if (request == GET_DESCRIPTOR) {
                GetDescriptor();
        }
  // SetConfiguration(Device)
        else if (request == SET_CONFIGURATION) {
                requestHandled = 1;
                currentConfiguration = SetupPacket.wValue0;
            // TBD: ensure the new configuration value is one that
            // exists in the descriptor.
                if (currentConfiguration == 0)
                // Si el valor de la configuracion es cero, el dispositivo se coloca
		// en el estado direccionado (USB 2.0 - 9.4.7)
                        deviceState = ADDRESS;
                else {
                        deviceState = CONFIGURED;
   		        InitEndpoint();
                // TBD: Add initialization code here for any additional
                // interfaces beyond the one used for the HID
                }
        }
  // GetConfiguration(Device)
        else if (request == GET_CONFIGURATION) {
                requestHandled = 1;
                outPtr = (byte*)&currentConfiguration;
                wCount = 1;
        }

        else if (request == GET_STATUS) {
                GetStatus();
        }

        else if ((request == CLEAR_FEATURE) || (request == SET_FEATURE)) {
                SetFeature();
        }

        else if (request == GET_INTERFACE) {
            // No se soporta interfaces alternadas. Se envia
            // cero de regreso al host.
                requestHandled = 1;
                controlTransferBuffer[0] = 0;
                outPtr = (byte *) &controlTransferBuffer;
                wCount = 1;
        }
        
        else if (request == SET_INTERFACE) {
	    // No se soporta interfaces alternadas - solo se ignora
                requestHandled = 1;
        }
    //else if (request == SET_DESCRIPTOR)
    //else if (request == SYNCH_FRAME)
    //else
}

// Etapa de datos de la transferencia de control que envia datos al host
void InDataStage(void)
{
        byte i;
        word bufferSize;

    // Determina cuantos bytes se envian al host, en caso de que la cantidad de datos supere
    // el tamano del EP0, lo que va a llevar a multiples transacciones para completarse.
        if (wCount < E0SZ)
                bufferSize = wCount;
        else
                bufferSize = E0SZ;

    // Carga los dos bits altos del contador de bits en BC8:BC9
        ep0Bi.Stat &= ~(BC8 | BC9); // Borra BC8 y BC9
        ep0Bi.Stat |= (byte) ((bufferSize & 0x0300) >> 8);
        ep0Bi.Cnt = (byte) (bufferSize & 0xFF);
        ep0Bi.ADDR = PTR16(&controlTransferBuffer);

    // Actualiza la cantidad de bytes que todavia necesitan ser enviados. Tomando
    // todo el dato de regreso al host puede llevar multiples transacciones, asi
    // se calcula el nuevo valor que quedan todavia para una futura entrega
        wCount = wCount - bufferSize;

    // Mueve el dato al buffer de salida USB donde queda asentado
        inPtr = (byte *)&controlTransferBuffer;

        for (i=0;i<bufferSize;i++)
                *inPtr++ = *outPtr++; //Copia los contenidos de los buffer bit a bit
}

// Etapa de datos de la transferencia de control que lee datos provenientes del host
void OutDataStage(void)
{
        word i, bufferSize;

        bufferSize = ((0x03 & ep0Bo.Stat) << 8) | ep0Bo.Cnt;

    // Total acumulado de la cantidad de bytes leidos
        wCount = wCount + bufferSize;

        outPtr = (byte*)&controlTransferBuffer;

        for (i=0;i<bufferSize;i++)
                *inPtr++ = *outPtr++; //Copia los contenidos de los buffer bit a bit
}

// Proceso del la etapa de setup en una transferencia de control. Este codigo inicializa
// las banderas que le permiten al firmware saber que hacer durante los estados subsecuentes 
// de la transferencia

void SetupStage(void)
{
    // Nota: Microchip establece desactivar el bit UOWN bit en la direccion IN tan pronto
    // como sea posible después de detectar que el paquete SETUP ha sido recibido
        ep0Bi.Stat &= ~UOWN;
        ep0Bo.Stat &= ~UOWN;

    // Inicializa el proceso de transferncia
        ctrlTransferStage = SETUP_STAGE;
        requestHandled = 0; // La solicitud no ha sido manejada todavia
        wCount = 0;         // No hay bits transferidos todavia

    // Se fija si la solicitud corresponde a una de tipo estandar (Segun lo definido en Cap 9 de USB)
        ProcessStandardRequest();
    // TBD: Add handlers for any other classes/interfaces in the device

        if (!requestHandled) {
        // Si el servicio no fue manejado luego de procesar las solicitudes estadar
	// entonces se detienen los EP0 (endpoints 0 = stalled)
                ep0Bo.Cnt = E0SZ;
                ep0Bo.ADDR = PTR16(&SetupPacket);
                ep0Bo.Stat = UOWN | BSTALL;
                ep0Bi.Stat = UOWN | BSTALL;
        }
// Se identifica la direccion del flujo de datos para comenzar con el paquete
        else if (SetupPacket.bmRequestType & 0x80) {
        // Dispositivo a host
                if(SetupPacket.wLength < wCount)
                        wCount = SetupPacket.wLength;

                InDataStage();
                ctrlTransferStage = DATA_IN_STAGE;
	
        // Resetea el descriptor del buffer para el endpoint 0
                ep0Bo.Cnt = E0SZ;
                ep0Bo.ADDR = PTR16(&SetupPacket);
                ep0Bo.Stat = UOWN;

        // Establece el descriptor del buffer del endpoint 0 para enviar el dato

                ep0Bi.ADDR = PTR16(&controlTransferBuffer);
                ep0Bi.Stat = UOWN | DTS | DTSEN; 
        } else {
        // Host a dispositivo
                ctrlTransferStage = DATA_OUT_STAGE;

        // Borra el descriptor del buffer de entrada
                ep0Bi.Cnt = 0;
                ep0Bi.Stat = UOWN | DTS | DTSEN;

        // Establece el descritptor del buffer en el endpoint 0 para recibir datos
	// con la direccion y el estado correspondiente
                ep0Bo.Cnt = E0SZ;
                ep0Bo.ADDR = PTR16(&controlTransferBuffer);
                ep0Bo.Stat = UOWN | DTS | DTSEN;
        }
    // Habilita el proceso de muestra y paquete del SIE
    UCONbits.PKTDIS = 0;
}

// Configura el descriptor del buffer para el endpoint 0 asi queda esperando para
// la etapa de estado de una transferencia de control
void WaitForSetupStage(void)
{
        ctrlTransferStage = SETUP_STAGE;
        ep0Bo.Cnt = E0SZ;
        ep0Bo.ADDR = PTR16(&SetupPacket);
        ep0Bo.Stat = UOWN | DTSEN; // Le al SIE, habilita el chequeo de toggle del dato
        ep0Bi.Stat = 0x00;         // Da el control al CPU
}

// Este es el punto inicial del proceso de la transferencia de control. El codigo directamente
// sigue la secuencia de transacciones descriptas en el cap 5 del USB2.0. 
// El unico flujo de control en este firmware es el Flujo de Control por defecto (endpoint 0).
// Los mensajes de control que tiene diferente destino son descartados
void ProcessControlTransfer(void)
{
        if (USTAT == 0) {
        // Endpoint 0: salida
                byte PID = (ep0Bo.Stat & 0x3C) >> 2; // Extrae el PID del medio de BD0STAT
 // Se identifica la idenificacion del paquete para iniciar el la transaccion correspondiente
	        if (PID == 0x0D)
            // SETUP PID - comienzo de una transaccion
                        SetupStage();
                else if (ctrlTransferStage == DATA_OUT_STAGE) {
            // Completa la etapa de datos asi todas la informacion ha
            // pasado del host al dispositivo antes de atenderlo
                        OutDataStage();

            // Devuelve el control sobre el SIE y cambia el bit de dato
                if(ep0Bo.Stat & DTS)
                        ep0Bo.Stat = UOWN | DTSEN;
                else
                        ep0Bo.Stat = UOWN | DTS | DTSEN;
                } else {
            // Se prepara para la etapa de setup de una trasnferencia de control
                        WaitForSetupStage();
                }
        } 

        else if (USTAT == 0x04) {
        // Endpoint 0: entrada
                if ((UADDR == 0) && (deviceState == ADDRESS)) {
            // TBD: ensure that the new address matches the value of
            // "deviceAddress" (which came in through a SET_ADDRESS).
                        UADDR = SetupPacket.wValue0;

                        if(UADDR == 0)
                // Si recibimos un reset despues de un SET_ADDRESS, entonces necesitamos
                // regresar al estado Default
                                deviceState = DEFAULT;
                }

        if (ctrlTransferStage == DATA_IN_STAGE) {
            // Comienzo (o continuacion) de la transmision de dato
            InDataStage();

            // Devuelve el control sobre el SIE y cambia el bit de dato
            if(ep0Bi.Stat & DTS)
                ep0Bi.Stat = UOWN | DTSEN;
            else
                ep0Bi.Stat = UOWN | DTS | DTSEN;
        } else {
            // Prepara para la etapa de setup de una transferencia de control
            WaitForSetupStage();
        }
    }
    //else

}

// Habilitacion del modulo USB

void EnableUSBModule(void)
{
    // TBD: Check for voltage coming from the USB cable and use that
    // as an indication we are attached.

        if (UCONbits.USBEN == 0) {
                UCON = 0;
                UIE = 0;
                UCONbits.USBEN = 1;
                deviceState = ATTACHED;
        }

    // Si fue enchufado y no se detecto un single-ended zero, entonces 
    // nos movemos al estado Powered
        if ((deviceState == ATTACHED) && !UCONbits.SE0) {
                UIR = 0;
                UIE = 0;
                UIEbits.URSTIE = 1;
                UIEbits.IDLEIE = 1;
                deviceState = POWERED;
        }
}

// Desuspender el dispositivo
void UnSuspend(void)
{
        UCONbits.SUSPND = 0;
        UIEbits.ACTVIE = 0;
        UIRbits.ACTVIF = 0;
}

// Los dispositivos Full speed toman un paquete Start Of Frame (SOF) cada 1 milisegundo
// Con esta interrupcion, simplemente se enmascara y no se hace nada mas
void StartOfFrame(void)
{
    // TBD: Add a callback routine to do something
        UIRbits.SOFIF = 0;
}

// Esta rutina es una llamada en respuesta al codigo deteniendo un endpoint.
void Stall(void)
{
        if (UEP0bits.EPSTALL == 1) {
        // Se prepara para la etapa de Setup de una trasferencia de control
                WaitForSetupStage();
                UEP0bits.EPSTALL = 0;
        }
        UIRbits.STALLIF = 0;
}

void BusReset()
{
        UEIR  = 0x00;
        UIR   = 0x00;
        UEIE  = 0x9f;
        UIE   = 0x7b;
        UADDR = 0x00;

    // Establece el endpoint 0 como un flujo de control
        UEP0 = 0x16;

    // Hace fluir alguna transaccion pendiente
        while (UIRbits.TRNIF == 1)
                UIRbits.TRNIF = 0;

    // Habilita el proceso del paquete
        UCONbits.PKTDIS = 0;

    // Prepara para la etapa de Setup de una transferencia de control
        WaitForSetupStage();
        remoteWakeup = 0;         // Remote wakeup esta apagado por defecto
        selfPowered = 0;          // Self powered esta apagado por defecto
        currentConfiguration = 0; // Borra la configuracion activa
        deviceState = DEFAULT;
}

// Punto de entrada principal para las tareas de USB. Chequea interrupciones, luego chequea para
// transacciones

void ProcessUSBTransactions(void)
{
    // Ve si el dispositivo esta conectado todavia
        if (deviceState == DETACHED)
                return;

    // Si el USB activo entonces despierta de suspendido
        if (UIRbits.ACTVIF && UIEbits.ACTVIE)
                UnSuspend();

    // Se supone que esta suspendido, entonces no se trata de realizar ningun proceso
        if (UCONbits.SUSPND == 1)
                return;

     // Procesa un reset del bus
        if (UIRbits.URSTIF && UIEbits.URSTIE)
                BusReset();

        if (UIRbits.IDLEIF && UIEbits.IDLEIE)
        // No hay actividad en el bus por un momento

        if (UIRbits.SOFIF && UIEbits.SOFIE)
                StartOfFrame();

        if (UIRbits.STALLIF && UIEbits.STALLIE)
                Stall();

        if (UIRbits.UERRIF && UIEbits.UERRIE)
	// Significa que hubo errores
        // TBD: See where the error came from.
        // Borra los errores
                UIRbits.UERRIF = 0;

    // Si no ha sido reseteado por el host, no hay necesidad de mantener procesando
        if (deviceState < DEFAULT)
                return;

    // Una transaccion ha terminado. Intenta procesar por defecto en el endpoint 0.
        if (UIRbits.TRNIF && UIEbits.TRNIE) {
                ProcessControlTransfer();
        // Apaga las banderas de interrupcion
                UIRbits.TRNIF = 0;
        }
}


#if 0
// Test - put something into EEPROM
code at 0xF00000 word dataEEPROM[] =
{
    0, 1, 2, 3, 4, 5, 6, 7,
    '0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'
};
#endif
