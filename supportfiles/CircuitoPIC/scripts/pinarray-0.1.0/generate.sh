#!/bin/bash
paNxN=./paNxN.pl
DEST=samples


if [ "$1" = "clean" ] ; then
   echo "Cleaning $DEST..."
   cd $DEST
   rm -f PA_1x1.{mod,lib,dcm}
   rm -f PA_10x1.{mod,lib,dcm}
   rm -f PINARRAY_2x10.{mod,lib,dcm}
   rm -f MYPINS_10x2.{mod,lib,dcm}
   rm -f PA_10x10.{mod,lib,dcm}
   rm -f PA_5x5.{mod,lib,dcm}
   rm -f STRANGE_2x3.{mod,lib,dcm}
   exit 0
fi

if [ ! -e $paNxN ] ; then
   echo "$paNxN not found.\n"
   exit 0
fi

if [ ! -e $DEST ] ; then
   mkdir -p $DEST
fi

echo "Using $paNxN. Samples created in $DEST:"

#Only mandatory options. Defaults.
$paNxN --col=1 --row=1 --outdir=samples

#"col" is the only option starting with "c". Same for row
#Also using "-" instead "--".
#And adding some keywords to doclib and module. Extra verbose output.
$paNxN -c 10 -r 1   -ak "SAMPLE TEST HELLO" --outdir=samples -v -v

#Changing prefix (filenames, symbol and module names).
#Not using pin 1 marker in footprint. No 3d info in footprint.

$paNxN -c 2 -r 10 --outdir=samples -v --prefix=PINARRAY_ -nomark --no3d

#Changing default module and symbol names. File, module and symbol names are different.
$paNxN -c 10 -r 2 --outdir=samples -v --prefix=MYPINS_ -mname PinFooT -sname pinsymbol

#Changing Descriptions, sizes and pad types.
#Pin 1 shape C circular will be changed to O oblongue to allow different X and Y parammeters.
#Different descriptions for module and symbol.
#Symbol pin normal instead of default I Inverted.
$paNxN -c=10 -r=10 --outdir=samples \
       --dmod="Bigger connectors" --ddcm "Simple symbol Connector" -v\
       -padx 900 -pady 1100 -step 1500 -drill 750 \
       -pin1shape C -pinshape R -sytype "" -no3d

#Changing 3d shapes (only for example purposes !).
#Adding link to pdf in EEschema DOC-LIB
$paNxN -c 5 -r 5 --outdir=samples -wrl3d "discret/verti_resistor.wrl" \
       -1wrl3d "pin_array/pin_array_1x1_RED.wrl" \
       --dcmlink="philips/pca9516.pdf" -v
       
# Using a lot of arguments!
$paNxN -c 2 -r 3 --outdir=samples -pref "STRANGE_" -mname "mystrange_mod_2_3" \
      -mvalue="Conn strange 2x3" -step 500 -drill 100 -padx 350 -pady 250 \
      -pin1 O -pinsh R -nomark -kmod "CONNECTOR SPECIAL STRANGE" -akmod "KEYADDED"\
      -dmod="Superspecial footprint pin connector" --no3d \
      -sname "MYCONN" --syt " "  -dcmlink "strange/strange.pdf" \
      -ddcm="My special conector symbol" -akdc "ANOTHER SPECIAL KEYWORD" \
      -v -v

