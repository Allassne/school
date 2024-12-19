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
CREATE TRIGGER  tr_insertVente
   ON Vente
   FOR INSERT
AS 
BEGIN
	Declare @Id Int
	SELECT @Id = venteID from inserted
	INSERT INTO vente_audit
	VALUES ('Nouvelle vente de : Vente Id = ' + CAST(@Id AS VARCHAR(10)) + ' est ajoutée le : ' + CAST(Getdate() AS VARCHAR(22)))

END
GO
