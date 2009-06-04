#############
#!/bin/bash #
#############

# Genera un tgz del directorio ../trunk (con export, osea que no es una 
# working copy)  y luego hace un commit a ../tags/trunk.tgz

svn export ../ complete             ;
tar cvzf ../tags/complete.tgz complete/     ;
rm -fr complete/ 			      ;
svn commit ../tags/complete.tgz -m "Commit generado por backup.sh (`date`)";

exit 0
