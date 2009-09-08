/*   main.c - The main program.
 *
 *  Copyright (C) 2008  Rosales Victor (todoesverso@gmail.com)
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

#include "functions.h"
#include "errorsdrv.h"
#include <assert.h>

#define TAM 3*WIDTH

#if 1
#define DBG(fmt, args...) do {                             \
     printf("%s:%d:%s(", __FILE__, __LINE__, __FUNCTION__); \
     printf(fmt, ##args); printf(")\n"); } while (0)
#else
#define DBG(fmt, args...)	/* empty */
#endif

int main(int argc, char *argv[])
{
	int init, j = 0, i, j1 = 0, j2 = 0;
	FILE *ascii;
	char *brailleOut, brailleIn[64], car;
	char file_name[512];
	char value;
	char buff[] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06 }, rec, rec2;

	rec = 0x00;
	rec2 = 0x00;

        /* Init USB */
        init = start_usb();

        if (!init) {
                 errors(1);
                 exit(EXIT_FAILURE);
        }

	if (argc != 2)
		if (getOpt("file-name", file_name)) {
			errors(2);
			exit(1);
		}

	if (argv[1] != NULL)
		ascii = fopen(argv[1], "r");
	else
		ascii = fopen(file_name, "r");

	braille = fopen("/tmp/braille", "w");


        /**
         * Main loop sending and receving data
         * by using
         * j = usb_bulk_write(udev, WRITE2, &buff[0], 1, 500);      
         * j1 = usb_bulk_read(udev, READ  , &rec2, 1, 500);
         *
         **/

        /* Stop USB only if it was initializaed */
        if (init)
                stop_usb();

	fclose(ascii);
	fclose(braille);
	system("rm /tmp/braille");

	return 0;
}
