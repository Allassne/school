@ECHO off

ECHO Entrez le Prenom  
SET /p FName=Le Prenom est :


IF EXIST Resultat.log del Resultat.log
SET mylog=Resultat.log
sqlcmd -S DESKTOP-1TD8NB7 -U ALLassane -P 123456 -d AdventureWorks2012 -i MaRequete_3.sql -v input=%FName% > %mylog%

:end