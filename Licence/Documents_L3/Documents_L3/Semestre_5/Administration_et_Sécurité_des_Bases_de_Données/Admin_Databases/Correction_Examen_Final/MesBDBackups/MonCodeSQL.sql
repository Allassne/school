									--EXERCISE-03 : Backup et Restore
		
		-- 1) Creation d'un full backup de la base de donnée nommée EXAMENFINAL
BACKUP DATABASE EXAMENFINAL
TO DISK = 'C:\MesBDBackups\EXAMENFINAL.bak' 
WITH FORMAT, MEDIANAME = 'EXAMENFINALSQLServerBackups', 
NAME = 'Full Backup de la base de donnee EXAMENFINAL'; 
GO
									--EXERCISE-04 : Automatisation

-- Afficher la Vente Total pour chaque produit
SELECT p.Pro_Nom, SUM(p.Pro_PrixUnite * c.Quantity) AS VenteTotal
FROM Produits p
JOIN Commandes AS c ON c.Pro_ID = p.Pro_ID
GROUP BY p.Pro_Nom 