--											Exercice n°2

-- a)
USE AdventureWorks2016;
SELECT SP1.name AS ServerRoleName,
ISNULL(SP2.name, 'No members') AS LoginName
FROM sys.server_role_members AS SRM
RIGHT JOIN sys.server_principals AS SP1
ON SRM.role_principal_id = SP1.principal_id
LEFT JOIN sys.server_principals AS SP2
ON SRM.member_principal_id = SP2.principal_id
WHERE SP1.is_fixed_role = 1 -- Remove for SQL Server 2008
ORDER BY SP1.name;

--			 le Nom du Rôle Serveur fixe définit pour la connexion du service
--			 NT SERVICE\SQLWriter de la base de données AdventureWorks2016 est : sysadmin

-- b)
USE master;
SELECT pr.type_desc,
 pr.name,
 pe.state_desc,
 pe.permission_name,
 s.name + '.' + oj.name AS OBJECT,
 major_id 
FROM sys.database_principals AS pr 
INNER JOIN sys.database_permissions AS pe
 ON pr.principal_id = pe.grantee_principal_id 
INNER JOIN sys.objects AS oj
 ON oj.object_id = pe.major_id 
INNER JOIN sys.schemas AS s
 ON oj.schema_id = s.schema_id 
WHERE class_desc = 'OBJECT_OR_COLUMN';

-- le nom de la permission accordée aux objets dbo.spt_values et dbo.spt_monitor de la base de données MASTER est : SELECT

-- c) A l’aide de T-SQL créons les 2 comptes de connexions suivantes :
--		 Authentification Windows de l’usager MARC et le serveur MySERVER-01
CREATE LOGIN [MySERVER-01\MARC] FROM WINDOWS;
GO

--		 Authentification SQL Server de l’usager JAMES dont le mot de passe 
--		 est Jimy123 et que James doit changer son mot de passe qui expirera à la prochaine connexion.

CREATE LOGIN JAMES WITH PASSWORD = 'Jimy123'
MUST_CHANGE, CHECK_EXPIRATION = ON;
GO

-- d) Création de l'Usager SQL Server nommé SMITH et mot de passe John123 qui 
--    doit se connecter à l’aide de SQL Server et non Windows.

CREATE LOGIN SMITH 
	WITH PASSWORD = 'John123'
CREATE USER SMITH FOR LOGIN SMITH;

--											Exercice n°3

-- Création de la Base de Donnée nommée TP5Note
CREATE DATABASE TP5Note;

-- a) Création de la table nommée payment
USE TP5Note;
CREATE TABLE payment (
payment_ID int Primary Key,
userId int,
orderId int,
cartecredit varchar(20)
);

-- b) Création de la Master Key dont le mot de passe est: Robert123_ 
CREATE MASTER KEY ENCRYPTION BY
PASSWORD = 'Robert123_';

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
ALTER TABLE payment
ADD cartecredit_encrypted varbinary(200);
GO
-- ouvrons la clé Symétrique crée
OPEN SYMMETRIC KEY SymKeyCC01
DECRYPTION BY CERTIFICATE Certif_CC01;
GO

-- e) Chiffrez la valeur de la colonne cartecredit en utilisant la clé symétrique SymKeyCC01 
--    et sauvez le résultat dans la colonne cartecredit_encrypted de la même table payment avec hash SHA2_256 comme nous l’avons vu en classe.
UPDATE payment
SET cartecredit_encrypted = EncryptByKey(Key_GUID('SymKeyCC01')
, cartecredit, 1, HASHBYTES('SHA2_256', CONVERT( varbinary
, payment_Id)));
GO


-- f) Insertion de la ligne dans la table payment (1,10,152,'45095788805107324')
INSERT INTO payment VALUES (1, 10, 152, '45095788805107324', NULL);

select * from payment	

-- g) Création d'un TRIGGER qui va se déclencher et mettre à jour automatiquement la 
--    colonne cartecredit_encrypted à chaque fois qu’on insère un nouveau payment avec une nouvelle carte de crédit bien sûr.

IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_InsertEmployees')
DROP TRIGGER tr_All;

CREATE TRIGGER tr_All
ON  payment 
FOR INSERT
AS 
BEGIN
Declare @Id Int
  SELECT @Id = payment_Id from inserted
UPDATE payment
SET cartecredit_encrypted = EncryptByKey(Key_GUID('SymKeyCC01')
, cartecredit, @Id, HASHBYTES('SHA2_256', CONVERT( varbinary
, payment_Id)));

END

-- TEST
INSERT INTO payment VALUES (2,12, 300, '95095788805107320',NULL);

select * from payment