

USE AdventureWorks2012 ;
GO
CREATE VIEW HumanResources.EmployeeHireDate
AS
SELECT p.FirstName, p.LastName, e.HireDate
FROM HumanResources.Employee AS e JOIN Person.Person AS p
ON e.BusinessEntityID = p.BusinessEntityID ;
GO
-- Query the view
SELECT FirstName, LastName, HireDate
FROM HumanResources.EmployeeHireDate
ORDER BY LastName;
Pour vérifier la vue créée :
SELECT * FROM HumanResources.EmployeeHireDate
Pour voir toutes les vues de la base de données :
select * from AdventureWorks2012.sys.all_views;
Vérifiez que la vue créée s’y trouve.
Pour créer un Indexed Views (Vues indexées) (Notions avancées)
Exemple :
--Set the options to support indexed views.
SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
QUOTED_IDENTIFIER, ANSI_NULLS ON;
--Create view with SCHEMABINDING.
IF OBJECT_ID ('Sales.vOrders', 'view') IS NOT NULL
DROP VIEW Sales.vOrders ;
GO
CREATE VIEW Sales.vOrders
WITH SCHEMABINDING
AS
SELECT SUM(UnitPrice * OrderQty * (1.00 - UnitPriceDiscount)) AS Revenue,
OrderDate, ProductID, COUNT_BIG(*) AS COUNT
FROM Sales.SalesOrderDetail AS od, Sales.SalesOrderHeader AS o
WHERE od.SalesOrderID = o.SalesOrderID
GROUP BY OrderDate, ProductID;
GO
--Create an index on the view.
CREATE UNIQUE CLUSTERED INDEX IDX_V1
ON Sales.vOrders (OrderDate, ProductID);
GO
Comment utiliser les vues indexées : (Suivre les explications du prof.)
--This query can use the indexed view even though the view is not specified in the FROM clause.
SELECT SUM(UnitPrice * OrderQty * (1.00 - UnitPriceDiscount)) AS Rev,
OrderDate, ProductID
FROM Sales.SalesOrderDetail AS od
JOIN Sales.SalesOrderHeader AS o
ON od.SalesOrderID=o.SalesOrderID
AND o.OrderDate >= CONVERT(datetime, '05/01/2012', 101)
WHERE od.ProductID BETWEEN 700 and 800
GROUP BY OrderDate, ProductID
ORDER BY Rev DESC;
GO
--This query will also use the above indexed view.
SELECT OrderDate, SUM(UnitPrice * OrderQty * (1.00 - UnitPriceDiscount)) AS Rev
FROM Sales.SalesOrderDetail AS od
JOIN Sales.SalesOrderHeader AS o
ON od.SalesOrderID=o.SalesOrderID
AND o.OrderDate >= CONVERT(datetime,'03/01/2012', 101)
AND o.OrderDate < CONVERT(datetime,'04/01/2012', 101)
GROUP BY OrderDate
ORDER BY OrderDate ASC;
/*--Finally, this example shows querying directly from the indexed view.
On SQL Server Standard edition, you must use the NOEXPAND query hint to query the indexed view directly.
*/
--This query uses the indexed view directly, on Enterprise edition.
SELECT OrderDate, Revenue
FROM Sales.vOrders
WHERE OrderDate >= CONVERT(datetime,'03/01/2012', 101)
AND OrderDate < CONVERT(datetime,'04/01/2012', 101)
ORDER BY OrderDate ASC;
--This query uses the indexed view directly, with the NOEXPAND hint.
SELECT OrderDate, Revenue
FROM Sales.vOrders WITH (NOEXPAND)
WHERE OrderDate >= CONVERT(datetime,'03/01/2012', 101)
AND OrderDate < CONVERT(datetime,'04/01/2012', 101)
ORDER BY OrderDate ASC;