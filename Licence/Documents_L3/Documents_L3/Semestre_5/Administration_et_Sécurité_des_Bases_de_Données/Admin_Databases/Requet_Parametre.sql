USE AdventureWorks2012
IF OBJECT_ID ('TheBestEmployees', 'P') IS NOT NULL
DROP PROCEDURE TheBestEmployees;
GO

CREATE PROCEDURE TheBestEmployees
@LastName NVARCHAR(50),
@FirstName NVARCHAR(50)
AS
BEGIN
SET NOCOUNT ON;
SELECT p.FirstName, p.LastName, e.Bonus
FROM Sales.SalesPerson AS e JOIN Person.Person AS p
ON e.BusinessEntityID = p.BusinessEntityID
WHERE FirstName = @FirstName AND LastName = @LastName;
END
GO


EXECUTE TheBestEmployees N'Ito', N'Shu';