@echo off
IF NOT EXIST migrate.config.bat (
echo ����������������������� USAGE GUIDE �����������������������ͻ
echo � Create migrate.config.bat in currnt folder and descripbe  �
echo � ant location and database credintals:                     �
echo �                                                           �
echo ������������������� migrate.config.bat ��������������������Ķ
echo �   set ant_path=\usr\bin\ant                               �
echo �   set db_port=3389                                        �
echo �   set db_host=192.168.137.10                              �
echo �   set db_user=root                                        �
echo �   set db_password=dtpltghjqltv                            �
echo �   set db_schema=crm                                       �
echo �����������������������������������������������������������Ķ
echo �                                                           �
echo � Execute migrate.bat [task] to migrate database.           �
echo � Ie: `migrate.bat migrate.crm` or `migrate.bat migrate.phc`�
echo �                                                           �
echo � Of cource you could create you own migrations call script,�
echo � but never commit host-specified scripts.                  �
echo �                                                           �
echo �����������������������������������������������������������ͼ
exit
)

call migrate.config.bat
%ant_path% %1 -Derpico.db_host="%db_host%" -Derpico.db_user="%db_user%" -Derpico.db_password="%db_password%" -Derpico.db_port="%db_port%" -Derpico.db_schema="%db_schema%"


