CREATE DATABASE Paul

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


drop table Commandes


Select * from Produits
Select * from Clients
Select * from Vendeurs
Select * from Commandes




-- b) Création de la Master Key dont le mot de passe est: Robert123_ 
CREATE MASTER KEY ENCRYPTION BY
PASSWORD = '123456';


-- Création du certificat nommé Certif_CC01 
CREATE CERTIFICATE Certif_CC01
WITH SUBJECT = 'Certificat de Protection de carte de crédit';
GO

-- c) Création de la clé Symétrique nommée SymKeyCC01 du certificat Certif_CC01 avec un algorithme de chiffrage AES_256
CREATE SYMMETRIC KEY SymKeyCC01
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Certif_CC01;
GO

-- d) Ajoutez une Colonne nommée cartecredit_encrypted de type varbinary(200) dans la table payment 
ALTER TABLE Commandes
ADD cartecredit_encrypted varbinary(200);
GO
-- ouvrons la clé Symétrique crée
OPEN SYMMETRIC KEY SymKeyCC01
DECRYPTION BY CERTIFICATE Certif_CC01;
GO

-- e) Chiffrez la valeur de la colonne cartecredit en utilisant la clé symétrique SymKeyCC01 
--    et sauvez le résultat dans la colonne cartecredit_encrypted de la même table payment avec hash SHA2_256 comme nous l’avons vu en classe.
UPDATE Commandes
SET cartecredit_encrypted = EncryptByKey(Key_GUID('SymKeyCC01')
, CreditCard, 2, HASHBYTES('SHA2_256', CONVERT( varbinary
, ID_Com)));
GO


-- f) Insertion de la ligne dans la table payment (1,10,152,'45095788805107324')
insert into Commandes
values (1,20,1,2,60,'1111-1111-1111', NULL);

select * from Commandes	

-- g) Création d'un TRIGGER qui va se déclencher et mettre à jour automatiquement la 
--    colonne cartecredit_encrypted à chaque fois qu’on insère un nouveau payment avec une nouvelle carte de crédit bien sûr.

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
delete from Commandes where ID_Com = 2
insert into Commandes
values (2,10,3,1,100,'2222-2222-2222', NULL),
(3,20,2,2,500,'3333-3333-3333', NULL),
(4,30,2,3,450,'4444-4444-4444', NULL),
(5,20,4,2,100,'5555-5555-5555', NULL),
(6,30,3,2,800,'6666-6666-6666', NULL),
(7,20,5,3,700,'7777-7777-7777', NULL);


SELECT CreditCard, cartecredit_encrypted
AS 'Encrypted card number', CONVERT(nvarchar,
DecryptByKey(cartecredit_encrypted, 7 ,
HASHBYTES('SHA2_256', CONVERT(varbinary, ID_Com))))
AS 'Decrypted card number' FROM Commandes;
GO

