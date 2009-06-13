/*   options.c - The xml parser for options.
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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

int
getOpt (char *option, char *value) {
	xmlDocPtr doc;
	xmlNodePtr cur;
	xmlChar *key;
	doc = xmlParseFile("config.cfg");
	int ret_val = 0;

	if (doc == NULL ) {
		fprintf(stderr,"Document not parsed successfully. \n");
		return 1;
	}
	
	cur = xmlDocGetRootElement(doc);
	
	if (cur == NULL) {
		fprintf(stderr,"Empty document\n");
		xmlFreeDoc(doc);
		return 1;
	}
	
	if (xmlStrcmp(cur->name, (const xmlChar *) "config")) {
		fprintf(stderr,"Document of the wrong type, root node != config");
		xmlFreeDoc(doc);
		return 1;
	}
	
        /* If we arrived here it means that everything is OK
         * so we will look for the tag 'option' and give its value
         * to 'value'. If the value is NULL, the parameter value
         * will be 1 char long with '\0', and the return value will
         * be 1, that means an error ocurred, else return 0 (succeded)
         * so the programers can make a choice of the default 
         * value that option should have.
         */ 

	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
		if ((!xmlStrcmp(cur->name, (const xmlChar *) option))){
		    key = xmlNodeListGetString(doc, cur->xmlChildrenNode, 1);

                    if (key == NULL) {
                     value[0] = '\0';
                     ret_val = 1;
                    }
                    else
                     strcpy(value,(const char * ) key);

                    xmlFree(key);
	            xmlFreeDoc(doc);
                    return ret_val;
		}
	cur = cur->next;
	}

        return 1;
}

