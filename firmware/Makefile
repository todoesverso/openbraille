# MakeFile para compilar el firmware v1.0

CHIP=4550

SDCC_HOME=/usr/share/sdcc/

#HEXFILE=USB.hex

CC=sdcc

OPTS1= -Wl --vc  --denable-peeps --optimize-goto --optimize-cmp --optimize-df\
--obanksel=2 --opt-code-size --fommit-frame-pointer -mpic16 -p18f4550 -I\
$(SDCC_HOME)\include/pic16/ -c

OPTS2= --vc --denable-peeps --optimize-goto --optimize-cmp --optimize-df\
--obanksel=2 --opt-code-size --fommit-frame-pointer -mpic16 -p18f4550\
-L $(SDCC_HOME)\lib/pic16/ -Wl,"-w -s 18f$(CHIP).lkr"


###########################################################################

all: main.c usb.h usb.o
	$(CC) $(OPTS2)  main.c usb.o
	
usb.o: usb.c usb.h 
	$(CC) $(OPTS1) usb.c

clean:
	rm *.asm
	rm *.lst
	rm *.o
	rm *.cod
delete:
	rm *.hex
