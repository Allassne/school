												-- Creation de base de donnee
USE master;
GO
CREATE DATABASE Tp1
ON
( NAME = Tp1_data,
FILENAME = 'C:\Tp1\Data\Tp1_data.mdf',
SIZE = 50MB,
MAXSIZE = 100MB,
FILEGROWTH = 10MB )
LOG ON
( NAME = Tp1_log,
FILENAME = 'C:\Tp1\Log\Tp1_log.ldf',
SIZE = 25MB,
MAXSIZE = 50MB,
FILEGROWTH = 5MB )
GO


CREATE TABLE  usager (usagerID INT PRIMARY KEY NOT NULL, nom_usager VARCHAR(50), tel_usager INT, dom_usager VARCHAR(25));
CREATE TABLE produits (produitID INT PRIMARY KEY NOT NULL, desc_produits VARCHAR(100), cout_produits INT);
CREATE TABLE commande(cmdID INT PRIMARY KEY NOT NULL, usagerID INT, produitsID INT, quantite INT, carte_credit VARCHAR(50));


INSERT INTO usager VALUES
(1,'Steffan', 0505782503, 'Marcory'),
(2,'Amelie', 0788253455, 'Cocody'),
(3,'Antonio', 0707629577, 'Riviera'),
(4,'Marco', 0102452500, 'Marcory'),
(5,'Eliana', 0550253501, 'Treichville')
INSERT INTO produits VALUES
(10,'Mangue sucrée', 50.00),
(20,'Orange Marocain', 75.00),
(30,'Pomme Rouge', 100.00)
INSERT INTO commande VALUES
(101,1,20,500,'1256804852152300'),
(102,2,10,100,'1256804852152302'),
(103,5,30,200,'5256804852152305'),
(104,3,30,1000,'3256804852152303'),
(105,3,20,500,'3256804852152303'),
(106,4,10,100,'4256804852152304'),
(107,2,30,700,'2256804852152302'),
(108,1,30,200,'1256804852152300'),
(109,2,10,1000,'2256804852152302'),
(110,5,10,100,'5256804852152305')



CREATE TABLE  commande_audit (Id INT IDENTITY, actions text);




CREATE TRIGGER tr_insertCommande 
ON  commande
FOR INSERT
AS 
BEGIN
  Declare @Id Int
  SELECT @Id = cmdID from inserted
  INSERT INTO commande_audit
  VALUES ('Nouvelle vente de : Vente Id = ' + CAST(@Id AS VARCHAR(10)) + ' est ajoutée le : ' + CAST(Getdate() AS VARCHAR(22)))

END



INSERT INTO commande VALUES (111,3,20,1000,'3256804852152303') 
INSERT INTO commande VALUES (112,1,10,2000,'1256804852152300')


SELECT * FROM commande_audit
SELECT * FROM commande




SELECT u.dom_usager, SUM(p.cout_produits * c.quantite) AS commande_total
FROM usager AS u
JOIN commande AS c ON (u.usagerID = c.usagerID)
JOIN produits AS p ON (p.produitID = c.produitsID)
GROUP BY u.dom_usager



select desc_produits, SUM(p.cout_produits * c.quantite) as Montant
		from produits as p
		join Commande as c ON c.produitsID = p.produitID
		GROUP BY desc_produits



CREATE LOGIN Bamba 
WITH PASSWORD = '123456'

CREATE USER Ado FOR LOGIN Bamba;

-- DROP USER Ado 
-- DROP LOGIN Bamba 