-- dbaUtilities database
-- Increase the maxsize for data and log files as needed
USE master;
GO
CREATE DATABASE dba
ON
( NAME = dba_data,
FILENAME = 'C:\Dba\Data\dba_data.mdf',
SIZE = 50MB,
MAXSIZE = 100MB,
FILEGROWTH = 10MB )
LOG ON
( NAME = dba_log,
FILENAME = 'C:\Dba\Log\dba_log.ldf',
SIZE = 25MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB )
GO



-- Exécutez le Script suivant pour exécuter les backups Full et Tlog de la BD dbaUtilities.
-- Run a Full backup of dbaUtilities
EXECUTE dba.dbo.DatabaseBackup
@Databases = 'dba',
@Directory = 'C:\Dba\Backup',
@BackupType = 'FULL',
@Compress = 'Y'
GO
-- Wait 5 Seconds
WAITFOR DELAY '00:00:05'
-- Run a Tlog backup of dbaUtilities
EXECUTE dba.dbo.DatabaseBackup
@Databases = 'dba',
@Directory = 'C:\Dba\Backup',
@BackupType = 'LOG',
@Compress = 'Y'
GO


CREATE TABLE Clients ( idClient CHAR(6) PRIMARY KEY , nom VARCHAR(30) NOT NULL, adresse VARCHAR(30) , numéroTelephone INTEGER
);
CREATE TABLE Produit ( idProduit CHAR(6) PRIMARY KEY , nom VARCHAR(30) NOT NULL, marque VARCHAR(30) NOT NULL , prix DECIMAL(6,2) ,
-- contrainte de table
CHECK (marque IN ( 'BMW', 'TOYOTA', 'PEUGEOT') )
);
CREATE TABLE Vente ( idVente CHAR(6) PRIMARY KEY , referenceProduit CHAR(6) , idClient CHAR(6) ,
date DATE NOT NULL ,
-- contrainte de table
FOREIGN KEY (referenceProduit) REFERENCES Produit(idProduit) ON DELETE
CASCADE,
FOREIGN KEY (idClient) REFERENCES Clients (idClient) ON DELETE CASCADE, );

SELECT * FROM Vente
