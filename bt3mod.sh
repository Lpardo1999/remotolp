#!/bin/sh
########################################################################
# Script Name	: bt3.sh
# Description	: Set GoV Buttons for assistance UP=IN DOWN=OUT
# Version		: V0.2  
# Date			: 28 dec 2023
# Usage			: 
# Log			:
#
########################################################################
s_name=bt3mod.sh	# Script Name
########################################################################
base=/mnt/mtdblock/data
if [ -f /mnt/mtdblock/data/sqlite3_arm ]; then
	echo "#####   ARM   ################################"
	binSQL=sqlite3_arm
	sqlite=$base/$binSQL
	elif [ -f /mnt/mtdblock/data/sqlite3_mips ]; then
	echo "#####   MIPS  ################################"
	binSQL=sqlite3_mips
	sqlite=$base/$binSQL
	elif [ -f /mnt/mtdblock/service/sqlite3 ]; then
	echo "#####   sqlite SpeedFace #####################"
	binSQL=sqlite3
	sqlite=/mnt/mtdblock/service/$binSQL
else
	echo "##############################################"
	echo "#####   FAIL SQLITE #####################"
	rm /mnt/mtdblock/$s_name
	exit 0
fi
########################################################################
db1=ZKDB.db
dst=$(date +"%d%m%YI%H%M%S")
db1tmp=tmp_$db1
db1bkp=$dst.bkp_$db1
cp $base/$db1 $base/$db1tmp
cp $base/$db1 $base/$db1bkp
########################################################################

#################################
#  Botones de asistencia
#################################

$sqlite -column -header $base/$db1tmp "
-- P1
DELETE FROM TIME_ZONE WHERE ID>0;
UPDATE sqlite_sequence SET seq='0' WHERE name='TIME_ZONE';
INSERT INTO TIME_ZONE (ID,Timezone_Name,Mon_Time,Tue_Time,Wed_Time,Thu_Time,Fri_Time,Sat_Time,Sun_Time) VALUES (1,'time1',0,0,0,0,0,0,0);
INSERT INTO TIME_ZONE (ID,Timezone_Name,Mon_Time,Tue_Time,Wed_Time,Thu_Time,Fri_Time,Sat_Time,Sun_Time) VALUES (2,'time2',0,0,0,0,0,0,0);
INSERT INTO TIME_ZONE (ID,Timezone_Name,Mon_Time,Tue_Time,Wed_Time,Thu_Time,Fri_Time,Sat_Time,Sun_Time) VALUES (3,'time3',0,0,0,0,0,0,0);
INSERT INTO TIME_ZONE (ID,Timezone_Name,Mon_Time,Tue_Time,Wed_Time,Thu_Time,Fri_Time,Sat_Time,Sun_Time) VALUES (4,'time4',0,0,0,0,0,0,0);
INSERT INTO TIME_ZONE (ID,Timezone_Name,Mon_Time,Tue_Time,Wed_Time,Thu_Time,Fri_Time,Sat_Time,Sun_Time) VALUES (5,'time5',0,0,0,0,0,0,0);
-- P2
DELETE FROM SHORT_STATE WHERE ID>0;
UPDATE sqlite_sequence SET seq='0' WHERE name='SHORT_STATE';
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (1,0,'state0','Entrada',273,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (2,1,'state1','',274,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (3,2,'state2','',275,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (4,3,'state3','',276,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (5,4,'state4','Salida',277,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
INSERT INTO SHORT_STATE (ID,State_No,State_Name,Description,Res_ID,Auto_Change,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES (6,5,'state5','',278,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
-- P3
DELETE FROM KEY_FUNC WHERE ID>0;
UPDATE sqlite_sequence SET seq='0' WHERE name='KEY_FUNC';
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('up','state1','100');
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('down','state2','100');
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('left','state0','0');
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('right','state4','0');
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('esc','state3','100');
INSERT INTO KEY_FUNC(Key_Name, Func_Name, Flag) VALUES('ok','state5','100');
"
########################################################################
cp $base/$db1tmp $base/$db1
rm $base/$db1tmp
sync
sync
########################################################################
date_end=$(date +"%x %r %Z")
echo "###############################################"
echo "## End $s_name at $date_end"
echo "## FILE $s_name SELF DESTRUCT.... BYE BYE!!!."
echo "###############################################"
rm /mnt/mtdblock/$s_name
exit 0