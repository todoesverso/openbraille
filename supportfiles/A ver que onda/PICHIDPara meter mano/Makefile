
#
#

CHIP=4550

DIRS=

LOBJS=

LIBS= pic18f$(CHIP).lib libio18f$(CHIP).lib libc18f.lib libsdcc.lib crt0.o

SRCS= main usb

CFILES=main.c usb.c

OFILES=main.o usb.o 

AFILES=main.asm usb.asm

HEXFILE=USBHID2.hex

ASMONLY= -S

CC=sdcc

SDCC_HOME= /usr/share/sdcc

OPTS= --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-frame-pointer
#OPTS= --vc --no-peep
#OPTS= --denable-peeps --optimize-goto --optimize-cmp





$(CC) $(OPTS) -mpic16 -p18f$(CHIP) -I $(SDCC_HOME)/include/pic16/ -c usb.c

$(CC) $(OPTS) -mpic16 -p18f$(CHIP) -I $(SDCC_HOME)/include/pic16/ -L /usr/share/sdcc/lib/pic16/ -Wl,"-w -s 18f$(CHIP).lkr" main.c usb.o    


