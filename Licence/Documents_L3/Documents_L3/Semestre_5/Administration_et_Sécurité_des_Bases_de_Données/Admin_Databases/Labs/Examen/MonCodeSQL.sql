BACKUP DATABASE EXAMENFINAL
TO DISK = 'C:\Examen\Backup\EXAMENFINAL.bak' 
WITH FORMAT, MEDIANAME = 'EXAMENFINALSQLServerBackups', 
NAME = 'Full Backup de la base de donnee EXAMENFINAL'; 
GO


select p.Pro_Nom, SUM(p.Pro_PrixUnite * c.Quantity) as VenteTotal
		from Produits p
		join Commandes as c ON c.Pro_ID = p.Pro_ID
		group by p.Pro_Nom 