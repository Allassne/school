USE master;
GO
CREATE DATABASE MesOutils
ON
( NAME = MesOutils_data,
FILENAME = 'C:\Examen\Data\MesOutils_data.mdf',
SIZE = 20MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB )
LOG ON
( NAME = MesOutils_log,
FILENAME = 'C:\Examen\Log\MesOutils_log.ldf',
SIZE = 10MB,
MAXSIZE = 50MB,
FILEGROWTH = 2MB )
GO