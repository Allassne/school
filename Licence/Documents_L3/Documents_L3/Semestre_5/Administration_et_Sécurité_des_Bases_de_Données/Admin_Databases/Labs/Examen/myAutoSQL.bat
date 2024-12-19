@ECHO off

pause
TITLE Full Backup
color a 

:: ECHO Entrer le Nom du serveur 
:: SET /p SName=SQL Server Name :
:: ECHO Entrer le Nom de la base de donnnee 
:: SET /p DName=Database Name :
:: ECHO Entrer le Nom de l'Utisateur 
:: SET /p UName=User Name :
:: ECHO Entrer le Mot de Passe de l'Utilisateur 
:: SET /p Pass=Password :


IF EXIST Resultat.log del Resultat.log
SET Mylog=Resultat.log
ECHO Execution de la requete SQLCOmmand...........
ECHO.
:: sqlcmd -S %SName% -U %UName% -P %Pass% -d %DName% 
sqlcmd -S DESKTOP-1TD8NB7 -U Bamba -P 123456 -d EXAMENFINAL -i MonCodeSQL.sql > %mylog%
ECHO.

:: @bloc-notes %mylog%

:end