@echo off
IF NOT EXIST migrate.config.bat (
echo 浜様様様様様様様様様様� USAGE GUIDE 様様様様様様様様様様様様�
echo � Create migrate.config.bat in currnt folder and descripbe  �
echo � ant location and database credintals:                     �
echo �                                                           �
echo 把陳陳陳陳陳陳陳陳� migrate.config.bat 陳陳陳陳陳陳陳陳陳陳超
echo �   set ant_path=\usr\bin\ant                               �
echo �   set db_port=3389                                        �
echo �   set db_host=192.168.137.10                              �
echo �   set db_user=root                                        �
echo �   set db_password=dtpltghjqltv                            �
echo �   set db_schema=crm                                       �
echo 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
echo �                                                           �
echo � Execute migrate.bat [task] to migrate database.           �
echo � Ie: `migrate.bat migrate.crm` or `migrate.bat migrate.phc`�
echo �                                                           �
echo � Of cource you could create you own migrations call script,�
echo � but never commit host-specified scripts.                  �
echo �                                                           �
echo 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様�
exit
)

call migrate.config.bat
%ant_path% %1 -Derpico.db_host="%db_host%" -Derpico.db_user="%db_user%" -Derpico.db_password="%db_password%" -Derpico.db_port="%db_port%" -Derpico.db_schema="%db_schema%"


