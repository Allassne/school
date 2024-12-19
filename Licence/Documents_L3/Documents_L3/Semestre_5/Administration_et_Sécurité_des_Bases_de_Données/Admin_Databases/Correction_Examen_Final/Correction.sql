												--EXERCISE-01 : Triggers et Stored Procedure
				
				--a) Creation de la base de donnée nommée EXAMENFINAL
USE master;
GO
CREATE DATABASE EXAMENFINAL
ON
( NAME = EXAMENFINAL_data,
FILENAME = 'C:\Data\EXAMENFINAL_data.mdf',
SIZE = 50MB,
MAXSIZE = 100MB,
FILEGROWTH = 10MB )
LOG ON
( NAME = EXAMENFINAL_log,
FILENAME = 'C:\Log\EXAMENFINAL_log.ldf',
SIZE = 25MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB )
GO


                 -- Creation des tables et insertion des valeurs
create table Produits (
Pro_ID int Primary Key NOT NULL,
Pro_Nom Varchar (120),
Pro_PrixUnite Money);
insert into Produits
values (10,'Samsung 12S', 500),
(20,'IPhone 13 ', 1000),
(30,'Infinix 10 Play', 2000),
(40,'Huawei P30 ', 1500),
(50,'LG G7', 2000);

create table Clients (
ID_Client int Primary Key NOT NULL,
Nom_Client varchar(30),
Prenom_Client varchar(30),
Adresse_Client varchar (60));
insert into Clients
values (1,'James', 'Jimy', 'Bingerville'),
(2,'Paul', 'Hubert', 'Yopougon'),
(3,'Adrien', 'Alain', 'Treichville'),
(4,'YAO', 'Paul', 'Riviera'),
(5,'Jordan', 'Michael', 'Cocody');

create table Vendeurs (
ID_Vendeurs int Primary Key NOT NULL,
Nom_Vendeurs varchar(30),
Prenom_Vendeurs varchar(30));
insert into Vendeurs
values (1,'Kouadio', 'Alexia'),
(2,'Toto', 'Grace'),
(3,'Kouassi', 'Esther');

create table Commandes (
ID_Com int Primary Key NOT NULL,
Pro_ID int,
ID_Client int,
ID_Vendeurs int,
Quantity int,
CreditCard varchar(15));
insert into Commandes
values (1,20,1,2,60,'1111-1111-1111'),
(2,10,3,1,100,'2222-2222-2222'),
(3,20,2,2,500,'3333-3333-3333'),
(4,30,2,3,450,'4444-4444-4444'),
(5,20,4,2,100,'5555-5555-5555'),
(6,30,3,2,800,'6666-6666-6666'),
(7,20,5,3,700,'7777-7777-7777');

select * from Clients
select * from Produits
select * from Vendeurs
select * from Commandes

					-- b) Creation de la table audit

CREATE TABLE audit (Id INT IDENTITY, actions text);


					-- Verification de l'existance du trigger nommee tr_antivol
IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_antivol')
DROP TRIGGER tr_antivol;
						-- Creation de Trigger nommee tr_antivol
CREATE TRIGGER tr_antivol
ON Commandes
FOR DELETE
AS 
BEGIN
  Declare @Id Int, @id_c Int, @Name varchar(10)
  SELECT @id_c = ID_Com, @Id = ID_Vendeurs from deleted
  Select @Name = Nom_Vendeurs from Vendeurs where ID_Vendeurs = @Id
  INSERT INTO audit
  VALUES ('Le Vendeur : ' + CAST(@Name AS VARCHAR(10)) + ' a supprimé la commande  : ' + CAST(@id_c AS VARCHAR(10)) + ' en Date du : ' + CAST(Getdate() AS VARCHAR(22)))

END


				-- Exemple (Suppression de la ligne ayant pour Identifiant 7 de la table Commandes)

delete from Commandes where ID_Com = 7
				-- Verification de la table audit
select * from audit

-- insert into Commandes
-- values (7,20,5,3,700,'7777-7777-7777');


			--c) Verification de l'existance du store procedure nommee sp_VenteTotal

IF OBJECT_ID ('sp_VenteTotal', 'P') IS NOT NULL
DROP PROCEDURE sp_VenteTotal;
GO
			-- Creation de store procedure nommee sp_VenteTotal
CREATE PROCEDURE sp_VenteTotal
@Nom_Produit NVARCHAR(20)
AS
BEGIN
SET NOCOUNT ON;
SELECT p.Pro_Nom, (p.Pro_PrixUnite * c.Quantity) as ' ventes totales'
FROM Produits as p
join Commandes as c ON c.Pro_ID = p.Pro_ID
where p.Pro_Nom = @Nom_Produit

END

 --exemple (execution du stored procedure )

 EXECUTE sp_VenteTotal N'IPhone 13 '

 





					




					--EXERCISE-03 : Backup et Restore

-- 1) Voir MonCodeSQL.sql

-- 2) Creation d'une nouvelle base de donnée nommée MesOutils

USE master;
GO
CREATE DATABASE MesOutils
ON
( NAME = MesOutilsL_data,
FILENAME = 'C:\Data\MesOutils_data.mdf',
SIZE = 20MB,
MAXSIZE = 100MB,
FILEGROWTH = 5MB )
LOG ON
( NAME = MesOutils_log,
FILENAME = 'C:\Log\MesOutils_log.ldf',
SIZE = 10MB,
MAXSIZE = 50MB,
FILEGROWTH = 2MB )
GO
 
									--EXERCISE-04 : Automatisation

		-- Creation de login, password et d'utilisateur (Pour la connection automatique au Server SQL)
 CREATE LOGIN Bamba 
WITH PASSWORD = '123456'

CREATE USER Ado FOR LOGIN Bamba;


									--EXERCISE-05 : Sécurité des bases de données

 --  Création de la Master Key dont le mot de passe est: 123456 
CREATE MASTER KEY ENCRYPTION BY
PASSWORD = '123456';

-- Création du certificat nommé Certif_CC01 
CREATE CERTIFICATE Certif_CC01
WITH SUBJECT = 'Certificat de Protection de carte de crédit';
GO

-- Création de la clé Symétrique nommée SymKeyCC01 du certificat Certif_CC01 avec un algorithme de chiffrage AES_256
CREATE SYMMETRIC KEY SymKeyCC01
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Certif_CC01;
GO

-- Ajoutez une Colonne nommée cartecredit_encrypted de type varbinary(210) dans la table Commandes 
ALTER TABLE Commandes
ADD cartecredit_encrypted varbinary(200);
GO
-- ouvrons la clé Symétrique crée
OPEN SYMMETRIC KEY SymKeyCC01
DECRYPTION BY CERTIFICATE Certif_CC01;
GO

-- Chiffrons la valeur de la prémière colonne CreditCard en utilisant la clé symétrique SymKeyCC01 
-- et sauvez le résultat dans la colonne cartecredit_encrypted de la même table Commandes avec hash SHA2_256.
UPDATE Commandes
SET cartecredit_encrypted = EncryptByKey(Key_GUID('SymKeyCC01')
, CreditCard, 1, HASHBYTES('SHA2_256', CONVERT( varbinary
, ID_Com)));
GO

-- Supposons que la table est vide
-- Insertion d'une nouvelle ligne dans la table Commandes (1,20,1,2,60,'1111-1111-1111', NULL)
insert into Commandes
values (1,20,1,2,60,'1111-1111-1111', NULL);

select * from Commandes	

-- g) Création d'un TRIGGER qui va se déclencher et mettre à jour automatiquement la 
--    colonne cartecredit_encrypted à chaque fois qu’on insère une nouvelle commande dans la table.

IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_All')
DROP TRIGGER tr_All;

CREATE TRIGGER tr_All
ON  Commandes	
FOR INSERT
AS 
BEGIN
Declare @Id Int
  SELECT @Id = ID_Com from inserted
UPDATE Commandes
SET cartecredit_encrypted = EncryptByKey(Key_GUID('SymKeyCC01')
, CreditCard, @Id, HASHBYTES('SHA2_256', CONVERT( varbinary
, ID_Com)));

END

-- TEST
insert into Commandes
values (2,10,3,1,100,'2222-2222-2222', NULL),
(3,20,2,2,500,'3333-3333-3333', NULL),
(4,30,2,3,450,'4444-4444-4444', NULL),
(5,20,4,2,100,'5555-5555-5555', NULL),
(6,30,3,2,800,'6666-6666-6666', NULL),
(7,20,5,3,700,'7777-7777-7777', NULL);


-- Decryptage
SELECT CreditCard, cartecredit_encrypted
AS 'Encrypted card number', CONVERT(nvarchar,
DecryptByKey(cartecredit_encrypted, 7 ,
HASHBYTES('SHA2_256', CONVERT(varbinary, ID_Com))))
AS 'Decrypted card number' FROM Commandes;
GO








 IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_antivol')
DROP TRIGGER tr_antivol;

 CREATE TRIGGER tr_antivol
ON Commandes
FOR DELETE
AS 
BEGIN
  Declare @Id Int, @id_c Int, @Name varchar(10)
  SELECT @id_c = ID_Com from deleted
  SELECT @Id = ID_Vendeurs from deleted
  -- Select @Name = Nom_Vendeurs from Vendeurs where ID_Vendeurs = @Id
  select @Name = v.Nom_Vendeurs
		from Vendeurs as v
		join Commandes as c ON c.ID_Vendeurs = v.ID_Vendeurs
  INSERT INTO audit
  VALUES ('Le Vendeur : ' + CAST(@Name AS VARCHAR(10)) + ' a supprimé la commande  : ' + CAST(@id_c AS VARCHAR(10)) + ' en Date du : ' + CAST(Getdate() AS VARCHAR(22)))

END
