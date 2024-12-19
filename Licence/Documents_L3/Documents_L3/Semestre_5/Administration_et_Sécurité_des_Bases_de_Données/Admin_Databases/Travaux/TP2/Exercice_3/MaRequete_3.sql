USE AdventureWorks2012;

SELECT FirstName, LastName, Department, EndDate  
FROM HumanResources.vEmployeeDepartmentHistory
WHERE FirstName = 'Andy';