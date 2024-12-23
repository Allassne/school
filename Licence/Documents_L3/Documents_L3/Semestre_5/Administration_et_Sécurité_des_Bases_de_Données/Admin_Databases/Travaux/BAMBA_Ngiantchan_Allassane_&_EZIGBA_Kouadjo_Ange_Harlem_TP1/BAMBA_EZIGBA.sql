﻿											--- Creation de la base de donnée
CREATE DATABASE [N_GIANTCHAN_&_ANGE]; 
							
											--- Creation des tables Client, Produit et Vente
USE [N_GIANTCHAN_&_ANGE]
CREATE TABLE  Client (clientID INT PRIMARY KEY, nom_client VARCHAR(50), tel_client INT, dom_client VARCHAR(25));
CREATE TABLE Produit (produitID INT PRIMARY KEY, desc_produit VARCHAR(100), cout_produit INT);
CREATE TABLE Vente(venteID INT PRIMARY KEY, clientID INT, produitID INT, quantite INT, carte_credit VARCHAR(50));
							
											--- Insertion des valeurs dans les differentes table
USE [N_GIANTCHAN_&_ANGE]
INSERT INTO Client VALUES
(1,'Steffan', 0505782503, 'Marcory'),
(2,'Amelie', 0788253455, 'Cocody'),
(3,'Antonio', 0707629577, 'Riviera'),
(4,'Marco', 0102452500, 'Marcory'),
(5,'Eliana', 0550253501, 'Treichville');
INSERT INTO Produit VALUES
(10,'Mangue sucrée', 50.00),
(20,'Orange Marocain', 75.00),
(30,'Pomme Rouge', 100.00);
INSERT INTO Vente VALUES
(101,1,20,500,'1256804852152300'),
(102,2,10,100,'1256804852152302'),
(103,5,30,200,'5256804852152305'),
(104,3,30,1000,'3256804852152303'),
(105,3,20,500,'3256804852152303'),
(106,4,10,100,'4256804852152304'),
(107,2,30,700,'2256804852152302'),
(108,1,30,200,'1256804852152300'),
(109,2,10,1000,'2256804852152302'),
(110,5,10,100,'5256804852152305');
							
											--- Creation de la table vente_audit

USE [N_GIANTCHAN_&_ANGE]
CREATE TABLE  vente_audit (Id INT IDENTITY, actions text);
							
											--- Verifier s'il existe un triggers nommée tr_insertVente
											--- Et le supprimer s'il existe
USE [N_GIANTCHAN_&_ANGE]
IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_insertVente')
DROP TRIGGER tr_insertVente;

							
										--- Creation de TRIGGER nommé tr_insertVente sur la table vente qui va se déclencher chaque
										--- fois qu’il y a insertion d’une nouvelle vente. John vous demande de faire l’audit de cette table
										--- vente qui doit montrer les dates d’insertion et l’Identité de celui qui a inséré la vente (venteID).

CREATE TRIGGER tr_insertVente 
ON  Vente 
FOR INSERT
AS 
BEGIN
  Declare @Id Int
  SELECT @Id = venteID from inserted
  INSERT INTO vente_audit
  VALUES ('Nouvelle vente de : Vente Id = ' + CAST(@Id AS VARCHAR(10)) + ' est ajoutée le : ' + CAST(Getdate() AS VARCHAR(22)))

END

									--- test en insérant au moins 2 nouvelles ventes
USE [N_GIANTCHAN_&_ANGE]
INSERT INTO vente VALUES (111,3,20,1000,'3256804852152303') 
INSERT INTO vente VALUES (112,1,10,2000,'1256804852152300')

									---Verifier la table Vente et vente_audit
select * from Vente;
select * from vente_audit ;


									--- créer une procédure stockée nommée sp_ventequartier.
-- Cette procédure doit donc calculer la vente total de produit par client puis le grouper par dom_client en joignant les 3 tables.
-- Astuces : Utilisez les alias et inner join on ou bien join as on pour joindre les tables par leurs clés primaires. Utilisez aussi la fonction d’aggrégation SUM pour calculer les ventes totales de produits et les grouper par dom_client.



USE [N_GIANTCHAN_&_ANGE]
IF OBJECT_ID ('sp_ventequartier', 'P') IS NOT NULL
DROP PROCEDURE sp_ventequartier;
GO

CREATE PROCEDURE sp_ventequartier
@dom_client NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON;
SELECT c.dom_client, SUM(p.cout_produit * v.quantite) AS vente_Total
FROM Client AS c
JOIN Vente AS v ON (c.clientID = v.clientID)
JOIN Produit AS p ON (p.produitID = v.produitID)
WHERE dom_client = @dom_client
GROUP BY c.dom_client

END
GO

							-- Exécutez la procedure pour le quartier de Cocody

EXECUTE dbo.sp_ventequartier N'Cocody';
