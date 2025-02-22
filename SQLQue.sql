USE DML;
SELECT * FROM EMPPLOYEE;

DELETE FROM EMPPLOYEE WHERE EMP_ID=109;

ALTER TABLE EMPPLOYEE
DROP CONSTRAINT FK_D_ID
GO

ALTER TABLE EMPPLOYEE
ALTER COLUMN EMP_ID INT NOT NULL;

ALTER TABLE EMPPLOYEE
ADD CONSTRAINT PK_EMP_ID
PRIMARY KEY(EMP_ID)
GO

EXEC sp_columns EMPPLOYEE;


CREATE TABLE EMPLOYEE_LOG(
LOG_ID INT NOT NULL,
EMP_ID INT NOT NULL,
OPRATION VARCHAR(10) NOT NULL,
MODIFY_TIME DATETIME
);

ALTER TABLE EMPLOYEE_LOG
ADD CONSTRAINT PK_LOG_ID
PRIMARY KEY (LOG_ID)
GO

ALTER TABLE EMPLOYEE_LOG
ADD CONSTRAINT FK_EMP_ID
FOREIGN KEY (EMP_ID) REFERENCES EMPPLOYEE(EMP_ID)
GO

CREATE TRIGGER TRI_EMP_INSERT
ON EMPPLOYEE
FOR INSERT
AS
INSERT INTO EMPLOYEE_LOG(LOG_ID,EMP_ID,OPRATION,MODIFY_TIME)
SELECT 1, EMP_ID,'INSERT',GETDATE() FROM INSERTED
GO

DROP TRIGGER TRI_EMP_INSERT

SELECT * FROM EMPLOYEE_LOG;

SELECT * FROM EMPPLOYEE;

INSERT INTO EMPPLOYEE
VALUES
(110,'SUJAN',29098,2,'PS','2005-09-05')
GO

INSERT INTO EMPPLOYEE VALUES(116,'GANESH',10000,2,'KEERTHI','12-11-2002');

 
CREATE TRIGGER TRI_EMP_UPDATE
ON EMPPLOYEE
AFTER UPDATE 
AS
INSERT INTO EMPLOYEE_LOG(LOG_ID,EMP_ID,OPRATION,MODIFY_TIME)
SELECT 1,EMP_ID,'UPDATED',GETDATE() FROM INSERTED
GO

DROP TRIGGER TRI_EMP_UPDATE
GO
 
SELECT * FROM EMPLOYEE_LOG;

UPDATE EMPPLOYEE SET EMP_LASTNAME='yy';
 
UPDATE EMPPLOYEE SET EMP_LASTNAME='shettyDD' WHERE EMP_FIRSTNAME='riya';

SELECT * FROM EMPPLOYEE;
SELECT * FROM EMPLOYEE_LOG;

DELETE FROM EMPLOYEE_LOG;




-- drop trigger 
--drop index cix_emp_id
--on emp;
--alter table emp
-- drop constraint pk_emp_id



--SYNONYM---

CREATE SYNONYM SYN_EMPPLOYEE
FOR EMPPLOYEE
GO
--USING THE SYNONYM

SELECT * FROM SYN_EMPPLOYEE
GO

SELECT EMP_ID,EMP_FIRSTNAME
FROM SYN_EMPPLOYEE
WHERE EMP_SALARY<5000
GO

--USER 

