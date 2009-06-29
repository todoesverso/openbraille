Copyright (c) 2006 Instituto Nacional de Tecnología Industrial.
Copyright (c) 2006 Juan Pablo D. Borgna
Copyright (c) 2006 Diego J. Brengi  <brengi at inti gov ar>

 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 2.
  
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
       
 You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 02111-1307, USA
	   
	  
              Instituto Nacional de Tecnología Industrial
                      Electrónica e Informática
               Unidad Técnica Instrumentación y Control

Description:
------------

The funcion of this simple script is to generate pad arrays, (symbol and
module), for Kicad.
These arrays can be used for pins connectors, for prototyping areas or  for any
other component which requires many pads uniformly distributed.

Synopsis:
---------

# Parameters:
# paNxN.pl --col width --row height [Options]

width  : number of pins columns.
height : number of pins rows.

All command line options can be abbreviated. The abbreviation must avoid
confusion with other option. In some cases first character is enough.

See "paNxN --help" for available options.

Notes: 
------
The script needs a Perl interpreter with POSIX and Getopt packages installed.

DMILS units are 0.1 mil (1 DMIL = 0.0001 inch = 0.1 mil)

If sizeX and sizeY are different, oblong pins are used instead of circular ones.

The option to make the fisrt pin rectangular is active by default 
(others are circular).

The option to draw the first pin arrow marker (triangle) is active by default.

Multi-row arrays are numbered by row, here are some examples:

2x3
1 2
3 4
5 6

3x2
1 2 3
4 5 6

Scripts:
--------
Two test and example scripts are provided:
generate.sh :  Testing and Examples.
headers100mils.sh : Creates headers (IDC compatible) from 1x1 to 2x50. It needs
kicadlib from http://fpgalibre.sf.net to work.


Contact:
--------

If you have doubts, bug reports, comments, suggestions, enhancements, etc.
please contact the FPGA libre project:

http://fpgalibre.sf.net/
http://sf.net/projects/fpgalibre
