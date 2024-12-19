@ECHO off

pause
TITLE Demonstration: comment executer une requet
color a 

IF EXIST Resultat.log del Resultat.log
SET mylog=Resultat.log

ECHO.
sqlcmd -S DESKTOP-1TD8NB7 -U kalf -P 123456 -d dba -i backup.sql > %mylog%
ECHO.
:end