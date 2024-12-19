USE AdventureWorks2012;

SELECT FirstName, LastName, Department, EndDate 
FROM HumanResources.vEmployeeDepartmentHistory
WHERE EndDate IS NOT NULL
ORDER BY FirstName, LastName