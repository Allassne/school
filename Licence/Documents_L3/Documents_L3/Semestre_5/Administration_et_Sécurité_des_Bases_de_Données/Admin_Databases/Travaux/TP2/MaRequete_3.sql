USE AdventureWorks2012;

-- Exemple pour la gestion du INPUT.
declare @prenom varchar(30) = '$(input)'; /* Pour permettre l'accès au INPUT du bat dans la commande SQLCMD avec l'option -v */
SELECT FirstName, LastName, Department, EndDate  
FROM HumanResources.vEmployeeDepartmentHistory
WHERE FirstName = @prenom;