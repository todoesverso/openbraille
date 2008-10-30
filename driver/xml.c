#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>

char
*getOpt(char *option){
	xmlDocPtr doc;
	xmlNodePtr cur;
	xmlChar *key;
        char *value;
	doc = xmlParseFile("config.cfg");
	
	if (doc == NULL ) {
		fprintf(stderr,"Document not parsed successfully. \n");
		return;
	}
	
	cur = xmlDocGetRootElement(doc);
	
	if (cur == NULL) {
		fprintf(stderr,"empty document\n");
		xmlFreeDoc(doc);
		return;
	}
	
	if (xmlStrcmp(cur->name, (const xmlChar *) "config")) {
		fprintf(stderr,"document of the wrong type, root node != config");
		xmlFreeDoc(doc);
		return;
	}
	
	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
		if ((!xmlStrcmp(cur->name, (const xmlChar *) option))){
		    key = xmlNodeListGetString(doc, cur->xmlChildrenNode, 1);
		    printf("keyword: %s\n", key);
		    strcpy(value, key);
                    xmlFree(key);
                    return value;
		}
	cur = cur->next;
	}
	
	xmlFreeDoc(doc);
	return;
}



main(int argc, char **argv) {

        getOpt("uno");
        getOpt("dos");
        printf("Salida %d\n",atoll(getOpt("tres")));
        
	return (1);


//gcc -Wall `xml2-config --cflag` -lxml2 -o parser
}


