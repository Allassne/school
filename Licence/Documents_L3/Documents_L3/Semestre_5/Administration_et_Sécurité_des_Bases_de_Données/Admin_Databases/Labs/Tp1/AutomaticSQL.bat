@ECHO off

TITLE Full Backup
color a 
pause

IF EXIST MonResultat.log  del MonResultat.log 
SET mylog = MonResultat.log 
ECHO Execution de la requete SQLCOmmand...........
ECHO.
:: sqlcmd -S %SName% -U %UName% -P %Pass% -d %DName% -i MaRequete_3.sql -v input=%FName% > %mylog%
sqlcmd -S DESKTOP-1TD8NB7 -U Bamba -P 123456 -d Tp1 -i MyQuery.sql  > MonResultat.log
ECHO.

pause


:end