#!/usr/bin/perl
# paNxN.pl
# Instituto Nacional de Tecnología Industrial. http://www.inti.gov.ar
# Centro de Electrónica e Informática
# Unidad Técnica Instrumentación y Control.    http://utic.inti.gov.ar
#
# Copyright (c) 2006 Instituto Nacional de Tecnología Industrial.
# Copyright (c) 2006 Juan Pablo D. Borgna
# Copyright (c) 2006 Diego J. Brengi  <brengi at inti gov ar>
#
# Licencia: GPL v2
# Comments:
# Tool to generate pin arrays symbols and modules for Kicad.
#
#
use POSIX qw(strftime);
use Getopt::Long;

#####Default options

#####PCB Module configuration##############

$X=0; $Y=0;
$prefix="PA_";
#Recomended for IDC connectors: 100 mils between pins. Drill size 39 or 40 mils.
$step=1000;
$drill=400;
$radX=600;
$radY=600;
#Default pad type in footprint
# R=rectangular C=circle O=Oblong
$first_shape="R";     #First pin shape
$standard_shape="C";
#Draws first pin marker (triangle arrow) in .mod.
$use_marker="1";
####3D Shape #################
#Add 3D shape info to modules
$add_3d_shape="1";
#We use 1 pin 3d shape from kicad distribution.
$base_3d_shape="pin_array/pin_array_1x1.wrl";
$base_3d_shape1=$base_3d_shape; #Also for pin 1
$modkeywords="CONN ARRAY PIN HEADER PINHEAD";

#### SCH Symbol configuration##############
#You can choose different pin drawings:
# Empty for normal pin.
# I = Inverted (line and a circle) ; C = Clock type ; IC = Inverted clock
# L = Low in ; CL = low Clock ; V = low out
$pin_draw="I";

##### DOC-LIB configuration##############
$dcmkeywords=$modkeywords;
$dcmlink=""; #link in doc-lib

$version="0.1.0";
$RRevision='$Revision: 1.9 $'; #Revision from CVS.
$RRevision=~/.*: (\d+\.\d+).*/;
$RRevision=$1;

$verbose="0";

$result = GetOptions ("col=i" => \$X,
                      "row=i" => \$Y,
                      "step=i" => \$step,
                      "drill=i" => \$drill,
                      "padx=i" => \$radX,
                      "pady=i" => \$radY,
                      "prefix=s"   => \$prefix,
                      "verbose+"  => \$verbose,
                      "pin1shape=s" => \$first_shape,
                      "pinshape=s" => \$standard_shape,
                      "mark!" => \$use_marker,
                      "3d!" => \$add_3d_shape,
                      "wrl3d=s" => \$base_3d_shape,
                      "1wrl3d=s" => \$base_3d_shape1,
                      "sytype=s" => \$pin_draw,
                      "help" => \$help,
                      "outdir=s"  => \$outputdir,
                      "dcmlink=s" => \$dcmlink,
                      "akdcm=s"   => \$addkeydcm,
                      "akmod=s"   => \$addkeymod,
                      "ak=s"      => \$addkey,
                      "kdcm=s"      => \$dcmkeywords,
                      "kmod=s"      => \$modkeywords,
                      "ddcm=s"      =>  \$new_description_dcm,
                      "dmod=s"      =>  \$new_description_mod,
                      "desc=s"      =>  \$new_description,
                      "mvalue=s"    =>  \$modvalue,
                      "mname=s"     =>  \$modulename,
                      "sname=s"     =>  \$symbolname);

if ($help) { help_text(); }

$dcmkeywords= uc $dcmkeywords . " " . uc $addkeydcm . " " . uc $addkey ;
$modkeywords= uc $modkeywords . " " . uc $addkeymod . " " . uc $addkey ;

#If radX and radY differ, I assume you want Obloungue or rectangular pin.
if ( ($radX != $radY) and $standard_shape eq "C" ) { $standard_shape="O";}
if ( ($radX != $radY) and $first_shape eq "C" ) { $first_shape="O";}

$output= $prefix ."$X"."x"."$Y";
$module= $output;                #Module name same as base filename
$symbol= $output;                #Symbol name same as base filename

 if (defined $modulename)
  { $module=$modulename;}
 if (defined $symbolname)
  { $symbol=$symbolname;}

$moddescription="Pin header $X x $Y pins - Generated with paNxN" ;
$dcmdescription=$moddescription;

 if (defined $new_description)
  { $moddescription=$dcmdescription=$new_description;}
 else
 {
   if ( defined $new_description_dcm)
   { $dcmdescription=$new_description_dcm;}
  if ( defined $new_description_mod)
   { $moddescription=$new_description_mod;}
 }

 if (! defined $modvalue)
 { $modvalue="CONN_" . "$X" . "x" . "$Y";}
 
#Output files
$outputmod=$output . ".mod";
$outputlib=$output . ".lib";
$outputdcm=$output . ".dcm";

$fecha    =  strftime "%e/%m/%Y-%H:%M:%S", localtime;
$timestamp=sprintf "%8.8lX", time;

if ($verbose >0)
{
 copyright();
print "Parameters used:\n";
print  "  Output dir: $outputdir \tDate: $fecha\n";
print "PCB MODULE ($outputmod)\tModule name: $module\n";
print "  Columns        : $X pins \tRows  : $Y pins \tStep: $step DMILS\n";
print "  Drill          : $drill DMILS \tSize X: $radX DMILS \tSize Y: $radY DMILS\n";
print "  First pin shape:$first_shape \t Standard pin shape: $standard_shape\t Use marker: $use_marker\n";
print "  Module description: $moddescription\n";
print "  Module keywords   : $modkeywords\n";
print "  Module value      : $modvalue \tUse 3d shape: $add_3d_shape \n";
print "  wrl file          : $base_3d_shape\n";
print "  Pin 1 wrl file    : $base_3d_shape1\n";
print "SCH SYMBOL ($outputlib)\tSymbol name: $symbol\n";
print "  Symbol pin drawing: \"$pin_draw\"\n";
print "DOC-LIB    ($outputdcm)\tSymbol name: $symbol\n";
print "  Doclib Description: $dcmdescription\n";
print "  Doclib keywords   : $dcmkeywords\n";
print "  Doclib link       : $dcmlink\n";
}

die "Wrong arguments: col and row arguments needed.\n" if ($X==0 or $Y==0) ;
if (defined $outputdir )
 {
  die "Output directory does not exist!\n" unless (-d $outputdir);
  die "Cannot write to output directory!\n" unless (-w $outputdir);
  chdir ($outputdir) || die "cannot enter directory $outputdir ($!)" ;
 }
 
##########################################################################
# module .mod #

open(out,">$outputmod") || die "ERROR: Unable to open $outputmod\n";
print "Writing module info to $outputmod\n" if $verbose >1;

print out "PCBNEW-LibModule-V1  $fecha\n";
#print out "#File generated with paNxN.pl $version\n";
print out "\$INDEX\n$module\n\$EndINDEX\n";
print out "\$MODULE $module\n";
print out "Po 0 0 0 15 $timestamp $timestamp ~~\n";
print out "Li $module\n";
print out "Cd $moddescription\n";
print out "Kw $modkeywords\n";
print out "Sc $timestamp\n";
print out "Op 0 0 0\n";

print out "T0 4000 -500 500 500 0 80 N V 21 \"$module\"\n";
print out "T1 1000 -1500 500 500 0 80 N V 21 \"$modvalue\"\n";

print out "DS 0 0 ",$step*($X+1)," 0 120 21\n";
print out "DS ",$step*($X+1)," 0 ",$step*($X+1)," ",$step*($Y+1)," 120 21\n";
print out "DS ",$step*($X+1)," ",$step*($Y+1)," 0 ",$step*($Y+1)," 120 21\n";
print out "DS 0 ",$step*($Y+1)," 0 0 120 21\n";

#draws pin1 marking
if ($use_marker eq "1")
    {
    print "+ Printing first pin marker (triangle)\n" if $verbose > 1;
    $point1x=-($step/2);  $point1y=$step/2;
    $point2x=0;           $point2y=$step;
    $point3x=-($step/2);  $point3y=$step+$step/2;

#    print out "#Pin1 marking\n";
    print out "DS $point1x $point1y $point2x $point2y 120 21\n";
    print out "DS $point2x $point2y $point3x $point3y 120 21\n";
    print out "DS $point3x $point3y $point1x $point1y 120 21\n";
    }
else { print "- Not using first pin marker (triangle) \n" if $verbose > 1;}

for ($contY=1;$contY<=$Y;$contY++)
   {
    for ($contX=1;$contX<=$X;$contX++)
      {
       print out "\$PAD\n";
       print out "Sh \"";
       print out ($X*($contY-1))+$contX;
        #Pin1 can be different shape
        if( $contY==1 and $contX==1)
           {$padshape=$first_shape;}
         else {$padshape=$standard_shape;}
       print out "\" $padshape $radX $radY 0 0 0\n";
       print out "Dr $drill 0 0\n";
       print out "At STD N 00E0FFFF\n";
       print out "Ne 0 \"\"\n";
       print out "Po ",$contX*$step," ",$contY*$step,"\n";
       print out "\$EndPAD\n";
      }
   }

#Add 3d shape info
if ($add_3d_shape eq "1")
 {
  print "+ Adding 3D info to $outputmod.\n" if $verbose > 1;

  for ($contY=1;$contY<=$Y;$contY++)
   {
    for ($contX=1;$contX<=$X;$contX++)
      {
         $offX=$contX*($step/10000.00);
         $offY=$contY*($step/10000.00);
         print out "\$SHAPE3D\n";
          if ($contX==1 and $contY==1) {print out "Na \"$base_3d_shape1\"\n";}
             else {print out "Na \"$base_3d_shape\"\n";}
         print out "Sc 1.000000 1.000000 1.000000\n";
         print out "Of $offX -$offY 0.000000\n";
         print out "Ro 0.000000 0.000000 0.000000\n";
         print out "\$EndSHAPE3D\n";
      }
   }
 }
 else {   print "- No 3D info to $outputmod.\n" if $verbose > 1; }


print out "\$EndMODULE $module\n";
close out;
print "Module created ($outputmod).\n" if $verbose > 1;

##########################################################################
# symbol .lib #

open(out,">$outputlib") || die "ERROR: Unable to open $outputlib\n";
print "Writing simbol info to $outputlib\n" if $verbose > 1;

print out "EESchema-LIBRARY Version 2.3  Date: $fecha\n";
#print out "#File generated with paNxN.pl $version\n";
print out "# $symbol\n#\n";
print out "DEF $symbol P 0 40 Y N 1 0 N\n";

if ($X==1 && $Y==1) #1 signle pin
  {
   print out "F0 \"P\" 0 100 50 H V C C\n";
   print out "F1 \"$symbol\" 0 50 40 H V C C\n";
   print out "DRAW\n";
   print out "S 0 0 ",($X+1)*100 ," -",($Y+1)*100 ," 0 1 0 N\n";
   print out "X 1 1 -200 -100 300 R 60 60 1 1 P $pin_draw\n";
  }
  elsif ($Y==1) # single horizontal line
  {
   print out "F0 \"P\" 0 100 50 H V C C\n";
   print out "F1 \"$symbol\" 0 50 40 H V C C\n";
   print out "DRAW\n";
   print out "S 0 0 ",($X+1)*100 ," -",($Y+1)*100 ," 0 1 0 N\n";
   for ($contX=1;$contX<=$X;$contX++)
      {
       print out "X $contX $contX ", $contX*100 ," -400 200 U 50 50 1 1 P $pin_draw\n";
      }
  }
  elsif ($X==1) # single vertical line
  {
   print out "F0 \"P\" 0 100 50 H V C C\n";
   print out "F1 \"$symbol\" 0 50 40 H V C C\n";
   print out "DRAW\n";
   print out "S 0 0 ",($X+1)*100 ," -",($Y+1)*100 ," 0 1 0 N\n";
   for ($contY=1;$contY<=$Y;$contY++)
      {
       print out "X $contY $contY -200 -", $contY*100 ," 200 R 50 50 1 1 P $pin_draw\n";
      }
  }

  elsif ($X==2) #double vertical line
  {

   print out "F0 \"P\" 0 100 50 H V C C\n";
   print out "F1 \"$symbol\" 0 50 40 H V C C\n";
   print out "DRAW\n";
   print out "S 0 0 ",($X)*100 ," -",($Y+1)*100 ," 0 1 0 N\n";
   for ($pinum=1, $contY=1;$contY<=$Y;$contY++)
      {
       print out "X $pinum $pinum -200 -", $contY*100 ," 200 R 40 40 1 1 P $pin_draw\n";
       $pinum++;
       print out "X ", $pinum, " ", $pinum, " 400 -", $contY*100 ," 200 L 40 40 1 1 P $pin_draw\n";
       $pinum++;
      }
  }

  else #several lines
  {
   $p_name=1;
   
   print out "F0 \"P\" -100 100 50 H V C C\n";
   
   print out "F1 \"$symbol\" ";
   print out $X*50;
   print out " -";
   print out ($Y*50)-50;
   print out " 40 ";
   if ($X < $Y) {print out "V"} else {print out "H"};
   print out " H V C C\n";
   
   print out "DRAW\n";
   
   print out "S 0 0 ",($X+1)*100 ," -",($Y-1)*100 ," 0 1 0 N\n";
   
   for ($contY=1;$contY<=$Y;$contY++)
       {
        for ($contX=1;$contX<=$X;$contX++)
           {
            if ($contY==1)
              {
               print out "X $p_name ";
               print out ($X*($contY-1))+$contX;
               print out " ";
               print out $contX*100;
               print out " 200 200 D 50 50 1 1 P $pin_draw\n";
              }
            elsif ($contY==$Y)
              {
               print out "X $p_name ";
               print out ($X*($contY-1))+$contX;
               print out " ";
               print out $contX*100;
               print out " -";
               print out 300+(($Y-2)*100);
               print out " 200 U 50 50 1 1 P $pin_draw\n";
              }
            else
              {
               print out "X $p_name ";
               print out ($X*($contY-1))+$contX;
               print out " -200 -";
               print out ($contY-1)*100;
               print out " 200 R 50 50 1 1 P $pin_draw\n";
               
               $contX=$X;
               $p_name++;
               
               print out "X $p_name ";
               print out ($X*($contY-1))+$contX;
               print out " ";
               print out ($X+1)*100+200;
               print out " -";
               print out ($contY-1)*100;
               print out " 200 L 50 50 1 1 P $pin_draw\n";
              }
             $p_name++;
           }
       }
  }

print out "ENDDRAW\nENDDEF\n#\n#End Library\n";
close out;
print "Library simbol ($outputlib) created.\n" if $verbose > 1;

####################################################################################
# EESCHEMA Doc-Lib .dcm   #

open(out,">$outputdcm") || die "ERROR: Unable to open $outputdcm\n";
print "Writing EESchema-DOCLIB info to $outputdcm\n" if $verbose > 1;

print out "EESchema-DOCLIB  Version 2.0 Date: $fecha\n";
print out "#\n";
print out "\$CMP $symbol\n";
print out "D $dcmdescription\n";
print out "K $dcmkeywords\n";
print out "F $dcmlink\n";
print out "\$ENDCMP\n";
print out "#\n";
print out "#End Doc Library";

close out;
print "Library doc ($outputdcm) created.\n" if $verbose > 1;

print "Done!\n" if $verbose > 1;
exit 1;

##########################################################

sub copyright
{
print "paNxN Version:$version Revision:$RRevision\n";
print "Tool to generate pin arrays symbols and modules for Kicad.\n\n";
print "Copyright (c) 2006 Instituto Nacional de Tecnología Industrial.\n";
print "Copyright (c) 2006 Juan Pablo D. Borgna\n";
print "Copyright (c) 2006 Diego J. Brengi \n\n";
}

##########################################################

sub help_text
{
 copyright();
 print "Usage: paNxN.pl --col NCOL --row NROW [options]\n";
 print "\nGeneral options:\n";
 print "--col=NCOL           Number of array columns. Mandatory.\n";
 print "--row=NROW           Number of array rows. Mandatory.\n";
 print "--prefix=TEXT        Prefix for files and components names. Def=$prefix\n";
 print "--outdir=DIR         Output directory.Def=Current \n";
 print "--ak=KEYWORDS        Add keywords to doclib and footprint.\n";
 print "--desc=DESCRIPTION   Override default description in all files.\n";
 print "--verbose            Be verbose. Level1:Values. Level2:Actions.\n";
 print "--help               Prints this text.\n";

 print "Footprint options:\n";
 print "--mname=NAME         Sets module name. Def:Same as base filename\n";
 print "--mvalue=VALUE       Override default module value. Def:CONN_RxC \n";
 print "--step=DMILS         Spacing between pins in footprint. Def=$step\n";
 print "--drill=DMILS        Drill size. Def=$drill\n";
 print "--padx=DMILS         X Size of pin pads in footprint. Def=$radX\n";
 print "--pady=DMILS         Y Size of pin pads in footprint. Def=$radY\n";
 print "--pin1shape=SHAPE    Pad shape used for pin1 in footprint. Def=$first_shape\n";
 print "--pinshape=SHAPE     Pad shape used for pins in footprint. Def=$standard_shape\n";
 print "--mark               Draws arrow marker for pin1 in footprint. Default on.\n";
 print "--nomark             Don't draw arrow marker in footprint.\n";
 print "--akmod=KEYWORDS     Add keywords to module file.\n";
 print "--kmod=KEYWORDS      Override default keywords in module file.\n";
 print "--dmod=DESCRIPTION   Override default description in module file.\n";

 print "3D model options:\n";
 print "--3d                 Puts 3d info in footprint. Default on\n";
 print "--no3d               Don't put 3d info in footprint.\n";
 print "--wrl3d=FILE         wrl file used for normal pin 3d shape. Def=$base_3d_shape\n";
 print "--1wrl3d=FILE        wrl file used for pin1 3d shape. Def=$base_3d_shape1\n";

 print "Symbol options:\n";
 print "--sname=NAME         Sets symbol name. Def:Same as base filename\n";
 print "--sytype=SHAPE   Symbol type used for pins in schematics. Def=$pin_draw\n";

 print "EESchema-DOCLIB options:\n";
 print "--dcmlink=TEXT       Add link to documentation in doclib file.\n";
 print "--akdcm=KEYWORDS     Add keywords to doclib file.\n";
 print "--kdcm=KEYWORDS      Override default keywords in doclib file.\n";
 print "--ddcm=DESCRIPTION   Override default description in doclib file.\n";
 print "\n  Note1: DMILS is 0.1 mil (1 = 0.0001 inch = 0.1 mil)\n";
 print "  Note2: Valid pin shapes are: R for rectangular, C for circle, O for Oblong\n";
 print "  Note3: Different X and Y pad sizes are valid only for R and O shapes.\n";
 print "  Note4: Valid pin symbol types are I(inverted), C(clock), IC(inverted clock), \
          L(low in), CL(low clock), V(low out) and empty \"\"(normal pin)\n\n";
 exit 1;
}

