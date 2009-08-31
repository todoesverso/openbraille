/*   errorsdrv.c - The error message deliver.
 *
 *  Copyright (C) 2008  Rosales Victor and German Sanguinetti.
 *  (todoesverso@gmail.com , german.sanguinetti@gmail.com)
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

#include "options.h"

int errors(int number)
{
	FILE *filePtr;
	char file_name[512];
	char line[1024];
	char lang[10];
	int line_number = 0, defa = 0;
	char command[1280] = "espeak -s 120 -p 35 -v ";

	getOpt("errors-msg", file_name);
	defa = getOpt("errors-lang", lang);

	if (defa == 1)
		strncpy(lang, "es", 2);	// If no language defined use spanish
	// as default.


	filePtr = fopen(file_name, "rt");

	if (filePtr == NULL) {
		printf("Error al abrir el archivo \n");
		return 1;
	}

	for (line_number = 0; line_number < number; line_number++)
		fgets(line, sizeof(line), filePtr);

	fclose(filePtr);

	char *nlptr = strchr(line, '\n');	// Make sure to remove the newline char
	if (nlptr)
		*nlptr = '\0';	// and add the NULL end of the string
	// othewise a segfault will occur.

	strncat(command, lang, (strlen(lang) + 1));
	strncat(command, " '", 2);
	strncat(command, line, strlen(line));
	strncat(command, "'", 1);

	printf("Error: %s\n", line);
	system(command);
	return 0;
}
