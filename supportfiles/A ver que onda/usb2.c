#include <usb.h> 
#include <stdio.h>
//#include <iostream.h>
#include <errno.h> 

#define VENDOR_ARGOX 0x04d8
#define DEVICE_PT 0x7531  

int main(void)
{
struct usb_bus *bus; 
struct usb_device *dev;
int n,m,ret; 

usb_init();
char string[256];

n=usb_find_busses(); 
m=usb_find_devices();
usb_dev_handle *udev;


for (bus = usb_busses; bus; bus = bus->next) 
	{ 
		for (dev = bus->devices; dev; dev = dev->next) 
		{
			if (dev->descriptor.idVendor==VENDOR_ARGOX)
			{ 
				if (dev->descriptor.idProduct==DEVICE_PT)
				{  
				udev = usb_open(dev);
					if (udev) 
					{ 
						printf("found argox_PT dev-%s on bus-%s\n",dev->filename,bus->dirname); 
						usb_detach_kernel_driver_np(udev, 0); 
						usb_set_configuration(udev, 1);
							if (dev->descriptor.iManufacturer) 
							{ 
								usb_get_string_simple(udev, dev->descriptor.iManufacturer, string, sizeof(string));
								if (ret > 0)
									printf("- Manufacturer : %s\n", string);
								else 
									printf("- Unable to fetch manufacturer string\n"); 
							}
							if (dev->descriptor.iProduct) 
							{ 
								ret = usb_get_string_simple(udev, dev->descriptor.iProduct, string, sizeof(string));
									if (ret > 0)
										printf("- Product : %s\n", string);
									else
										printf("- Unable to fetch product string\n");
							}
							if (dev->descriptor.iSerialNumber) 
							{ 
								ret = usb_get_string_simple(udev, dev->descriptor.iSerialNumber, string, sizeof(string));
								if (ret > 0) 
									printf("- Serial Number: %s\n", string);
								else
									printf("- Unable to fetch serial number string\n");
							}
						ret = usb_claim_interface(udev,0); 
						if 
							(ret>=0) printf("device claimed!\n"); 
						else 
							printf("open error %d %s\n", errno, strerror(errno));
						
						
unsigned int WRITE=dev->config[0].interface[0].altsetting[0].endpoint[1].bEndpointAddress;
unsigned int READ=dev->config[0].interface[0].altsetting[0].endpoint[0].bEndpointAddress;
char buff[]={0xff,0xff,0xff,0xff,0xff,0xff,0xff};
char buffo[7];
int sizein=dev->config[0].interface[0].altsetting[0].endpoint[1].wMaxPacketSize;
int sizeout=dev->config[0].interface[0].altsetting[0].endpoint[0].wMaxPacketSize;
int pts=dev->config[0].interface[0].altsetting[0].endpoint[0].bInterval;
int i; 
printf("WRITE TO %02xh READ FROM %02xh\n SIZEIN %d SIZEOUT %d\n PTS %d\n",WRITE,READ,sizein,sizeout,pts);



///////////////
ret=usb_bulk_write(udev, WRITE, buff, 7, 400);
	printf(" transfered %i bytes \n",ret); 
ret=usb_bulk_read(udev, READ, buffo, 7, 500);
	printf(" Recibidos %i bytes \n",ret); 

	
	printf(" Recibio esto:  %i %i %i %i %i %i %i \n",buffo[0],buffo[1],buffo[2],buffo[3],buffo[4],buffo[5],buffo[6],buffo[7]); 
	
	printf(" WRITE: %x bytes \n",WRITE);
	printf(" READ: %x bytes \n",READ);
	 
usb_release_interface(udev,0);
usb_close (udev);
					}
				}
			}
else 
		continue;
		}
	}
return 0;
}

// gcc -Wall -W -L/usr/lib/ -lusb usb2.c -o usb

