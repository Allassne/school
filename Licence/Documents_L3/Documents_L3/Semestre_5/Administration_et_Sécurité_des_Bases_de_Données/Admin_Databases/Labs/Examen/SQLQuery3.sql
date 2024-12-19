
USE master;
GO
CREATE DATABASE EXAMENFINAL
ON
( NAME = EXAMENFINAL_data,
FILENAME = 'C:\Examen\Data\EXAMENFINAL_data.mdf',
SIZE = 50MB,
MAXSIZE = 100MB,
FILEGROWTH = 10MB )
LOG ON
( NAME = EXAMENFINAL_log,
FILENAME = 'C:\Examen\Log\EXAMENFINAL_log.ldf',
SIZE = 25MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB )
GO

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

Select * from Produits
Select * from Clients
Select * from Vendeurs
Select * from Commandes
Select * from audit

CREATE TABLE audit (Id INT IDENTITY, actions text);

IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_tr_antivol')
DROP TRIGGER tr_antivol;

CREATE TRIGGER tr_tr_antivol 
ON  Commandes
FOR DELETE
AS 
BEGIN
  Declare @Id Int
  SELECT @Id = cmdID from deleted
  INSERT INTO audit
  VALUES ('Nouvelle vente de : Vente Id = ' + CAST(@Id AS VARCHAR(10)) + ' est ajoutée le : ' + CAST(Getdate() AS VARCHAR(22)))

END


Drop from comm



IF OBJECT_ID ('spVenteTotal', 'P') IS NOT NULL     
    DROP PROCEDURE spVenteTotal;
GO
CREATE PROCEDURE spVenteTotal
    @Pro_Nom nvarchar(50)   
AS   
	BEGIN
		SET NOCOUNT ON; 

		select p.Pro_Nom, (p.Pro_PrixUnite * c.Quantity) as VenteTotal
		from Produits p
		join Commandes as c ON c.Pro_ID = p.Pro_ID
		where p.Pro_Nom = @Pro_Nom
	END
go

EXECUTE spVenteTotal N'IPhone 13 ';





