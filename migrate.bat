@echo off
IF NOT EXIST migrate.config.bat (
echo ษออออออออออออออออออออออ USAGE GUIDE ออออออออออออออออออออออออป
echo บ Create migrate.config.bat in currnt folder and descripbe  บ
echo บ ant location and database credintals:                     บ
echo บ                                                           บ
echo วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ migrate.config.bat ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
echo บ   set ant_path=\usr\bin\ant                               บ
echo บ   set db_port=3389                                        บ
echo บ   set db_host=192.168.137.10                              บ
echo บ   set db_user=root                                        บ
echo บ   set db_password=dtpltghjqltv                            บ
echo บ   set db_schema=crm                                       บ
echo วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
echo บ                                                           บ
echo บ Execute migrate.bat [task] to migrate database.           บ
echo บ Ie: `migrate.bat migrate.crm` or `migrate.bat migrate.phc`บ
echo บ                                                           บ
echo บ Of cource you could create you own migrations call script,บ
echo บ but never commit host-specified scripts.                  บ
echo บ                                                           บ
echo ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
exit
)

call migrate.config.bat
%ant_path% %1 -Derpico.db_host="%db_host%" -Derpico.db_user="%db_user%" -Derpico.db_password="%db_password%" -Derpico.db_port="%db_port%" -Derpico.db_schema="%db_schema%"


