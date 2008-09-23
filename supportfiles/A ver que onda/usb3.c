#include <usb.h> 
#include <stdio.h>
//#include <iostream.h>
#include <errno.h> 
#include <time.h>
#include <ctype.h>


#define VENDOR_ARGOX 0x04d8
#define DEVICE_PT 0x7531

int main(void)
{
	struct usb_bus *bus; 
	struct usb_device *dev;
	int n,m,ret,sizein,sizeout,pts; 

	usb_init();
	char string[256],car;
	unsigned int WRITE,READ;
			char buff[]={0xff,0x00,0xff,0xff,0xff,0xff,0xff};
			char buffo[2]={0x00,0x00};

			//char bufferout[]={0x1b,0x02,0x00,0x00,0x00,0x04,0x01,0x00,0x00,0x00,0x02,0x1b,0x3f,0x00};
			char bufferin[256];
	
	n=usb_find_busses(); 
	m=usb_find_devices();
	usb_dev_handle *udev;


for (bus = usb_busses; bus; bus = bus->next) { 
   for (dev = bus->devices; dev; dev = dev->next) {
	if (dev->descriptor.idVendor==VENDOR_ARGOX){ 
		if (dev->descriptor.idProduct==DEVICE_PT){  
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

			  ret = usb_claim_interface(udev,0); 
				if 
				(ret>=0) printf("La interfaz respondio!\n"); 
				else 
				printf("Error al abrir %d %s\n", errno, strerror(errno));
						
						
WRITE=dev->config[0].interface[0].altsetting[0].endpoint[1].bEndpointAddress;
READ=dev->config[0].interface[0].altsetting[0].endpoint[0].bEndpointAddress;
sizein=dev->config[0].interface[0].altsetting[0].endpoint[1].wMaxPacketSize;
sizeout=dev->config[0].interface[0].altsetting[0].endpoint[0].wMaxPacketSize;
pts=dev->config[0].interface[0].altsetting[0].endpoint[0].bInterval;
printf("WRITE TO %02xh READ FROM %02xh\n SIZEIN %d SIZEOUT %d\n PTS %d\n",WRITE,READ,sizein,sizeout,pts);
}
}
}
else 
continue;
}
}
	
do{
	printf(" El byte 0 de buffo es: %x bytes \n",buffo[0]); 
	ret = usb_claim_interface(udev,0); 
	if 
	(ret>=0) printf("device claimed!\n"); 
	else 
	printf("open error %d %s\n", errno, strerror(errno));


	ret=usb_bulk_write(udev, WRITE, buff, 64, 500);
	printf(" transfered %i bytes \n",ret); 

	

	
	printf(" WRITE: %x bytes \n",WRITE);
	printf(" READ: %x bytes \n",READ);
	ret=usb_bulk_read(udev, READ, buffo, 2, 400);
	printf(" Se recibieron %i bytes \n",ret); 
	printf(" El byte 0 de buffo es: %x  \n",buffo[0]); 
	printf(" El byte 1 de buffo es: %x  \n",buffo[1]); 


if (buffo[0] == 0x12){
	printf(" Se ha recibido 0x12: \n");


}

	car = getchar();

} while (car != 'a');


	usb_release_interface(udev,0);
	usb_close (udev);



	return 0;
}
