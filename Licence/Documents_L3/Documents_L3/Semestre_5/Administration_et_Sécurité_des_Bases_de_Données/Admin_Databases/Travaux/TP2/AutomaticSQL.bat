@ECHO off

pause
TITLE Demonstration: comment executer une requet
color a 

:: ECHO Entrer le Nom du serveur 
:: SET /p SName=SQL Server Name :
:: ECHO Entrer le Nom de la base de donnnee 
:: SET /p DName=Database Name :
:: ECHO Entrer le Nom de l'Utisateur 
:: SET /p UName=User Name :
:: ECHO Entrer le Mot de Passe de l'Utilisateur 
:: SET /p Pass=Password :
ECHO Entrez le Prenom  
SET /p FName=Le Prenom est :


IF EXIST Resultat.log del Resultat.log
SET mylog=Resultat.log
ECHO Execution de la requete SQLCOmmand...........
ECHO.
:: sqlcmd -S %SName% -U %UName% -P %Pass% -d %DName% -i MaRequete_3.sql -v input=%FName% > %mylog%
sqlcmd -S DESKTOP-1TD8NB7 -U ALLassane -P 123456 -d AdventureWorks2012 -i MaRequete_3.sql -v input=%FName% > %mylog%
ECHO.

Notepad %mylog%
:: runas /env /user:"N'giantchan Allassane BAMBA" "notepad \"%mylog%""
pause
:end