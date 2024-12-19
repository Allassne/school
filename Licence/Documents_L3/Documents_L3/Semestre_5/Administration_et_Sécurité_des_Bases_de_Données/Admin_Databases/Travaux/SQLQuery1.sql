USE TravailDirige


IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_DeleteEmployees')
DROP TRIGGER tr_DeleteEmployees;

CREATE TRIGGER tr_DeleteEmployees
ON  Employees 
AFTER DELETE
AS 
BEGIN
Declare @Id Int
  SELECT @Id = Id from deleted
  INSERT INTO Employees_Audit
  VALUES ('New employee with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is deled at ' + CAST(Getdate() AS VARCHAR(22)))

END
