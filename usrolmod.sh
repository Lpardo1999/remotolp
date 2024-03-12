#!/bin/sh
########################################################################
# Script Name	: usrolmod.sh
# Description	: Set Enroller user Privilege
# Version		: V1.0
# Date			: 16 ABRIL 2019
# Usage			: 1st create admin user, then add user with Pri=4
# Log			: 
#
########################################################################
s_name=usrolmod.sh	# Script Name
########################################################################
if [ -f /mnt/mtdblock/data/sqlite3_arm ]; then 
	echo "#####   ARM   ################################"
	binSQL=sqlite3_arm
else
	echo "#####   MIPS  ################################"
	binSQL=sqlite3_mips
fi
base=/mnt/mtdblock/data
sqlite=$base/$binSQL
########################################################################
db1=ZKDB.db
dst=$(date +"%d%m%YI%H%M%S")
db1tmp=tmp_$db1
db1bkp=$dst.bkp_$db1
cp $base/$db1 $base/$db1tmp
cp $base/$db1 $base/$db1bkp
########################################################################

$sqlite -column -header $base/$db1tmp "
-- Roll
UPDATE ROLE SET Description='enrolador', Using_Status='1' WHERE Role_Name='custom1';
-- Privilegios
DELETE FROM FUNC_PERMISSION WHERE Func_Name='adduser' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='netset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='serialset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='linkset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='mobilenet' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='admsset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='timeset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='attparam' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='fpparam' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='restoreset' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='timezone' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='userliststyle' AND Permission='4';
DELETE FROM FUNC_PERMISSION WHERE Func_Name='company' AND Permission='4';
DELETE FROM APP_PERMISSION WHERE App_Name='comset' AND Permission='4';
DELETE FROM APP_PERMISSION WHERE App_Name='sysset' AND Permission='4';
DELETE FROM APP_PERMISSION WHERE App_Name='access' AND Permission='4';
DELETE FROM APP_PERMISSION WHERE App_Name='printset' AND Permission='4';
"
########################################################################
cp $base/$db1tmp $base/$db1
rm $base/$db1tmp
sync
sync
echo 3 > /proc/sys/vm/drop_caches
########################################################################
date_end=$(date +"%x %r %Z")
echo "###############################################"
echo "## End $s_name at $date_end"
echo "## FILE $s_name SELF DESTRUCT.... BYE BYE!!!."
echo "desactiva la opcion de empresa en el menu enrolador<usuario"
echo "@archivo Modificado por Lenis Pardo SSTT <3"
echo "###############################################"
rm /mnt/mtdblock/$s_name
exit 0