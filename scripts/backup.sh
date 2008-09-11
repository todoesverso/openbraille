#############
#!/bin/bash #
#############

# Genera un tgz del directorio ../trunk (con export, osea que no es una 
# working copy)  y luego hace un commit a ../tags/trunk.tgz

svn export ../trunk trunk             ;
tar cvzf ../tags/trunk.tgz trunk/     ;
rm -fr trunk/ 			      ;
svn commit ../tags/trunk.tgz -m "Commit generado por backup.sh (`date`)";

exit 0




