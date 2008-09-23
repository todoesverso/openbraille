/*
 * Set LED - program to control a USB LED device
 * from user space using libusb
 *
 * Copyright (C) 2004
 *     Greg Kroah-Hartman (greg@kroah.com)
 *
 * This program is free software; you can
 * redistribute it and/or modify it under the terms
 * of the GNU General Public License as published by
 * the Free Software Foundation, version 2 of the
 * License.
 *
 */
#include <stdio.h>
#include <string.h>
#include <usb.h>



#define LED_VENDOR_ID   0x04d8
#define LED_PRODUCT_ID  0x4541



static struct usb_device *device_init(void)
{
    struct usb_bus *usb_bus;
    struct usb_device *dev;

    usb_init();
    usb_find_busses();
    usb_find_devices();

    for (usb_bus = usb_busses;
         usb_bus;
         usb_bus = usb_bus->next) {
        for (dev = usb_bus->devices;
             dev;
             dev = dev->next) {
            if ((dev->descriptor.idVendor
                  == LED_VENDOR_ID) &&
                (dev->descriptor.idProduct
                  == LED_PRODUCT_ID))
                return dev;
        }
    }
    return NULL;
}

int main()
{
    struct usb_device *usb_dev;
    struct usb_dev_handle *usb_handle;
    int retval = 1;
    char send_data=0xff;
    char recive_data;
    char string[1024];
    int i;


    usb_dev = device_init();
    if (usb_dev == NULL) {
        fprintf(stderr, "Dispositivo no encontrado\n");
        goto exit;
    }

	 usb_handle = usb_open(usb_dev);
	usb_dev=usb_claim_interface(usb_handle,0);
    if (usb_dev == NULL) {
        fprintf(stderr, "No anda la interfaz\n");
        goto exit;
    }

    usb_handle = usb_open(usb_dev);
    if (usb_handle == NULL) {
        fprintf(stderr,"algo\n");
        goto exit;
    }

    usb_handle = usb_open(usb_dev);
    if (usb_handle == NULL) {
        fprintf(stderr,
             "Not able to claim the USB device\n");
        goto exit;
    }
    

    usb_handle = usb_open(usb_dev);

fprintf(stderr, "uno: %i \n", usb_reset(usb_handle));

fprintf(stderr, "uno: %i \n",usb_interrupt_write(usb_handle,2,&send_data,32,500));

    usb_handle = usb_open(usb_dev);


 usb_clear_halt(usb_handle ,129);


fprintf(stderr, "dos: %i \n",usb_interrupt_read(usb_handle,4,&recive_data,32,500));

/*for(i=0; i<5; i++) 
{
    usb_handle = usb_open(usb_dev);       
fprintf(stderr,
             "GET driver: %i \n",usb_get_driver_np(usb_handle, 1, string, sizeof(string)));

    usb_handle = usb_open(usb_dev);

        fprintf(stderr,
             "STRing: %s \n", string);
}
        goto exit;*/

    retval = 0;

exit:
    usb_close(usb_handle);
    return retval;
}


//gcc -Wall -W -L/usr/lib/ -lusb usb.c -o usb  <----- Para compilar

