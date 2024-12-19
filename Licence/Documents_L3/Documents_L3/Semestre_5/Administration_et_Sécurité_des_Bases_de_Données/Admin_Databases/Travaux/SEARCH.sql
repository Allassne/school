-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
USE TravailDirige;

IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_InsertEmployees')
DROP TRIGGER tr_InsertEmployees;

CREATE TRIGGER tr_InsertEmployees
ON  Employees 
AFTER INSERT
AS 
BEGIN
Declare @Id Int
  SELECT @Id = Id from inserted
  INSERT INTO Employees_Audit
  VALUES ('New employee with Id = ' + CAST(@Id AS VARCHAR(10)) + ' is added at ' + CAST(Getdate() AS VARCHAR(22)))

END

select * from Employees
select * from Employees_Audit
select * from sys.triggers

GO
