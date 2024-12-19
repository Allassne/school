CREATE TABLE payment (
payment_Id INT PRIMARY KEY,
UserID int,
orderID INT,
cartecredit VARCHAR(20)
);



CREATE SYMMETRIC KEY Key11
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE Sales09;
GO


ALTER TABLE payment Add cartecredit_encrypted varbinary (200)

 

OPEN SYMMETRIC KEY Key11
DECRYPTION BY CERTIFICATE Sales09;


UPDATE payment
SET cartecredit_encrypted = EncryptByKey(Key_GUID('Key11')
, cartecredit, 1, HASHBYTES('SHA2_256', CONVERT( varbinary
, payment_Id)));
GO

INSERT INTO payment VALUES (2,12, 300, '95095788805107320',NULL);

INSERT INTO payment VALUES (4,155, 550,'95643546865446545',NULL);

select * from payment


IF EXISTS (SELECT * FROM sys.triggers where type='TR' and name='tr_InsertEmployees')
DROP TRIGGER tr_Roxane;

CREATE TRIGGER tr_Roxane
ON  payment 
FOR INSERT
AS 
BEGIN
Declare @Id Int
  SELECT @Id = payment_Id from inserted
UPDATE payment
SET cartecredit_encrypted = EncryptByKey(Key_GUID('Key11')
, cartecredit, payment_Id, HASHBYTES('SHA2_256', CONVERT( varbinary
, payment_Id)));

END


