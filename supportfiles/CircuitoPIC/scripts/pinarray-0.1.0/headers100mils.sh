 #!/bin/bash
#Basic script to generate headers library
#This script needs kicadlib from http://fpgalibre.sf.net

paNxN=./paNxN.pl
DEST=headers100mils

if [ ! -e $paNxN ] ; then
   echo "$paNxN not found.\n"
   exit 0
fi

if [ ! -e $DEST ] ; then
   mkdir -p $DEST
fi


echo "Using $paNxN in $DEST:"

for column in 1 2
do
row=1
   while [ $row -le "50" ]
   do
   NAME=header_
   #_${column}x${row}
   $paNxN --outdir="$DEST" --col="$column" --row="$row" --prefix="$NAME" \
   --step="1000" --drill="400" --padx="600" --pady="600" --ak="IDC"
   ALLMOD="$ALLMOD -a ${NAME}${column}x${row}.mod"
   ALLSYM="$ALLSYM -a ${NAME}${column}x${row}.lib"
   row=`expr $row + 1`
   done
  
done

cd $DEST
#Creating librarys
kicadlib $ALLMOD -o headers100mils.mod -w
kicadlib $ALLSYM -o headers100mils.lib -w

#Deleting single components.
rm header_*



