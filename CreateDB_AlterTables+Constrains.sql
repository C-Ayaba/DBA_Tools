-- TO CREATE THE DATABASE
Use Master
Create Database WalmartDB

-- USE THE DATABASE YOU JUST CREATED TO CREATE A TABLE INSIDE
Use WalmartDB

CREATE TABLE Employee 
(
EmployeeID INT PRIMARY KEY NOT NULL, 
FirstName VARCHAR(255) NOT NULL, 
LastName VARCHAR(255) NOT NULL,
DOB DATE NOT NULL, 
SSN INT NOT NULL, 
Salary MONEY NOT NULL, 
Address VARCHAR(255), 
Role VARCHAR(100) NOT NULL, 
CreditCardNo BIGINT NOT NULL
);

-- INSERT THE 13 RECORDS BELOW
INSERT INTO Employee VALUES (100, 'Einstein', 'Jong',  '1950-08-15', '123456789', 1000, '16 Halloway Dr. Belfast', 'Porter', 3334445550091234)
INSERT INTO Employee VALUES (200, 'Nelvis', 'Puwa', '1973-08-15', '123456789', 2000, '16 Halloway Dr. Belfast', 'Cleaner', 3334445550091234)
INSERT INTO Employee VALUES (300, 'Konte',' Epson', '1980-08-15' ,'123456789', 3000,'16 Halloway Dr. Belfast', 'Driver', 3334445550091234)
INSERT INTO Employee VALUES (400, 'Celestine', 'Feldera', '1980-08-15', '123456789', 8000,'16 Halloway Dr. Belfast', 'Shop Attendant', 3334445550091234)
INSERT INTO Employee VALUES (500, 'Vivian', 'Benz', '1990-08-15', '123456789', 4000,'16 Halloway Dr. Belfast', 'Security', 3334445550091234)
INSERT INTO Employee VALUES (600, 'Julius', 'Lemwell', '1984-08-15','123456789', 8000,'16 Halloway Dr. Belfast', 'Shop Attendant', 3334445550091234)
INSERT INTO Employee VALUES (700, 'Farida', 'Lexwira', '1983-08-15', '123456789', 7000,'16 Halloway Dr. Belfast', 'ITReport', 3334445550091234)
INSERT INTO Employee VALUES (800, 'Paolo', 'Mutuku', '1988-08-15' ,'123456789', 8000,'16 Halloway Dr. Belfast', 'HR', 3334445550091234)
INSERT INTO Employee VALUES (900, 'Kirian', 'Hollobros', '1986-08-15', '123456789', 9000, '16 Halloway Dr. Belfast', 'Manager', 3334445550091234)
INSERT INTO Employee VALUES (1000, 'Banditatu', 'Yalo', '1987-08-15', '123456789', 2000, '16 Halloway Dr. Belfast', 'Cleaner', 3334445550091234)
INSERT INTO Employee VALUES (1100, 'Christelle', 'Effi', '1950-08-15' ,'123456789', 8500, '16 Halloway Dr. Belfast', 'DBA', 3334445550091234)
INSERT INTO Employee VALUES (1200, 'Alphonsus', 'Jerryprime', '1930-08-15', '123456789', 12000, '16 Halloway Dr. Belfast', 'ITDirector', 3334445550091234)
INSERT INTO Employee VALUES (1300, 'Silvanus', 'Parlos', '1999-08-15', '123456789', 130000, '16 Halloway Dr. Belfast', 'CTO', 3334445550091234);


--VIEW ALL RECORDS FROM THE TWO OR MORE TABLES AT ONCE
SELECT * FROM Employee

---------------------------ALTERING TABLES IN SQL SERVER--------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- ALTER EXISTING TABLE AND ADD NEW COLUMN INTO IT
ALTER TABLE Employee
ADD Genda VARCHAR(1); 

--NOTICE HOW CHARACTER LENGTH FOR GENDA IS ONLY 1 CHARACTER. TRY TO INSERT THE RECORD BELOW WITH GENDER HAVING MORE THAN 1 CHARACTER AND SEE.
INSERT INTO Employee VALUES (1400, 'Silvanus', 'Parlos', '1970-08-15', '123456789', 130000, '16 Halloway Dr. Belfast', 'CTO', 3334445550091234, 'M');

--ALTER EXISTING TABLE AND ADD MULTIPLE COLUMNS
ALTER TABLE Employee
ADD City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(40);

-- AFTER ADDING 3 MORE COLUMNS, ATTEMPT TO INSERT COLUMNS NOW
INSERT INTO Employee VALUES (1600, 'Silvanus', 'Parlos', '1970-08-15', '123456789', 130000, '16 Halloway Dr. Belfast', 'CTO', 3334445550091234, 'M', 'Austin', 'Texas', 'USA');

 --TO RENAME A TABLE
EXEC sp_rename 'Employee', 'Worker';

Exec sp_rename 'Worker', 'Employee';

-- RENAME A COLUMN
EXEC sp_rename 'Employee.Genda', 'Gender';

--ALTER CHARACTER LENGTH OF A COLUMN IN A TABLE
ALTER TABLE Employee
ALTER COLUMN Gender VARCHAR(2);

--TO MODIFY THE DATA TYPE OF AN EXISTING COLUMN
ALTER TABLE Employee ALTER COLUMN Gender CHAR(6);

--TO DELETE ALL ROWS FROM EXISTING TABLE
DELETE FROM Employee;

--DELETE A PARTICULAR ROW IN SQL SERVER TABLE
DELETE FROM Employee WHERE EmployeeID='900';

--TO DROP COLUMN IN AN EXISTING TABLE
  ALTER TABLE Employee
  DROP COLUMN Gender;

-- DROP AN ENTIRE TABLE
  DROP TABLE Employee


----------------------------------COMPUTED COLUMNS---------------------------------------------
------------------------ALTER TABLES ADDING COMPUTED COLUMNS-----------------------------------
-----------------------------------------------------------------------------------------------

-- In SQL Server, Computed Columns are the columns that allow you to derive their values from expressions involving another column or columns within the same table. There are two types of computed columns in SQL Server.
-- Non-Persisted (does not store its data physically on disk.)
-- And Persisted computed columns (stores its data physically on disk.)


--DEMO
-- 1) Non-Persisted Computed Columns (The syntax PERSISTED is not explicitly stated)
--Demo1
ALTER TABLE Employee
ADD FULLNAME AS (firstname + ' ' + lastname);

--VIEW ALL RECORDS FROM THE TWO OR MORE columns AT ONCE
SELECT * FROM Employee;

-- 2) PERSISTED Computed Columns (the syntax PERSISTED is explicitly stated)
--Demo2  - Join FirstName and LastName to get a computed colum of FullName
ALTER TABLE Employee
ADD FULLNAME_Persisted AS (firstname + ' ' + lastname) PERSISTED;

--Demo3 - Use Date of birth and today's date to get Age
ALTER TABLE Employee
ADD AGE AS (DATEDIFF(year, [DOB], GETDATE()))

--HOW TO KNOW WHICH COMPUTED COLUMNS ARE ACTUALLY PERSISTED AND WHICH ONES ARE NOT.
Select * from sys.computed_columns

--DROP A COMPUTED COLUMN SAME AS YOU DROP A REGULAR COLUMN IN A TABLE.


---------------UNDERSTANDING CONSTRAINTS IN SQL SERER------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--SQL constraints are used to specify rules for the data in a table. Constraints are used to limit the type of data that can go into a table. This ensures the accuracy and reliability of the data in the table. If there is any violation between the constraint and the data action, the action is aborted. Constraints can be applied at the column-level or at the column level.

--Constraints can be applied during CREATE TABLE operation and after table creation using ALTER TABLE operations

----TYPES OF CONSTRAINTS----
--NOT NULL - Ensures that a column cannot have a NULL value
--UNIQUE - Ensures that all values in a column are different. (A PRIMARY KEY constraint automatically has a UNIQUE       constraint. However, you can have many UNIQUE constraints per table, but only one PRIMARY KEY constraint per table.)
--PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
--FOREIGN KEY - is a field (or collection of fields) in one table, that refers to the PRIMARY KEY in another table. Prevents invalid data from being inserted into the foreign key column, because it has to be one of the values contained in the parent table.
--CHECK - Ensures that the values in a column satisfies a specific condition
--DEFAULT - Sets a default value for a column if no value is specified
--CREATE INDEX - Used to create and retrieve data from the database very quickly


--DEMO
Use WalmartDB

CREATE TABLE CustomerTable
(
CustomerID INT NOT NULL, 
FirstName VARCHAR(255) NULL, 
LastName VARCHAR(255) NOT NULL,
DOB DATE NOT NULL, 
Age INT NOT NULL, 
AccBalance MONEY NOT NULL, 
Address VARCHAR(255), 
Role VARCHAR(100) NOT NULL,
SSN INT NOT NULL,
BankAccountNo BIGINT NOT NULL,
DateofToday Datetime NOT NULL,
Country VARCHAR(50) NOT NULL
);

-- See all columns
SELECT * FROM CustomerTable
--NOT NULL CONSTRAINT
--ALTER AND APPLY A NOT NULL CONSTRAINT  (for better understanding, use GUI to check)
ALTER TABLE CustomerTable
ALTER COLUMN FirstName VARCHAR(255) NOT NULL;

--UNIQUE CONSTRAINT
--Adding a Unique Constraint after table has been created
ALTER TABLE CustomerTable
ADD CONSTRAINT UC_CustomerTable_SSN UNIQUE (SSN);

--TO DROP A UNIQUE CONSTRAINT
ALTER TABLE CustomerTable
DROP CONSTRAINT UC_CustomerTable_SSN 

--To SEE ALL CONSTRAINTS ON A TABLE
EXEC sp_help CustomerTable


--Alter existing table and add Primary Key
ALTER TABLE CustomerTable
ADD CONSTRAINT PK_CustomerTable_CustomerID PRIMARY KEY (CustomerID);


--PRIMARY KEY CONSTRAINT
ALTER TABLE CustomerTable
DROP CONSTRAINT [PK_CustomerTable_CustomerID]


--CHECK CONSTRAINT
ALTER TABLE CustomerTable
ADD CONSTRAINT CHK_CustomerTable_Age CHECK (Age>=18);

--Drop the Check Constraint
ALTER TABLE CustomerTable
DROP CONSTRAINT CHK_CustomerTable_Age;

--DEFAULT CONSTRAINT
ALTER TABLE CustomerTable
ADD CONSTRAINT DFC_CustomerTable_DateofToday
DEFAULT GETDATE() FOR DateofToday;

--Default Constraint using country - Assuming that everyone has to be from a particular country.
ALTER TABLE CustomerTable
ADD CONSTRAINT DFC_CustomerTable_Country
DEFAULT 'Germany' FOR Country;

--FOREIGN KEY DEMO


--Create Table 1  -- Students in a school
Use Master

Create Database SchoolDB

Use SchoolDB

CREATE TABLE Student (
    StudentMatriculeNo int identity (500, 500) NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int NOT NULL,
	Gender varchar(1),
	SSN int NOT NULL,
    Country varchar(255) NOT NULL DEFAULT 'Switzerland',
	CONSTRAINT PK_Student_StudentMatriculeNo PRIMARY KEY (StudentMatriculeNo),
	CONSTRAINT CHK_Student_Age CHECK (Age<=22),
	CONSTRAINT UC_Student_SSN UNIQUE (SSN)
);

-- Exam registration is ONLY by students who are actually enrolled in that school and have a StudentMatriculeNo

Use SchoolDB
CREATE TABLE ExamRegistration
(
    ExamRegNo int identity (10000, 10000) NOT NULL,
	StudentMatriculeNo int NOT NULL,
    SubjectsRegistered int NOT NULL,
	Level int,
	RegistrationDate datetime,
	CONSTRAINT PK_ExamRegistration_ExamRegNo PRIMARY KEY (ExamRegNo),
	CONSTRAINT FK_Student_ExamRegistration FOREIGN KEY (StudentMatriculeNo) REFERENCES Student(StudentMatriculeNo),
);

INSERT INTO Student values ('Harrison4', 'Federat', 22, 'M', 123897019, 'Cameroon')
INSERT INTO ExamRegistration values (5000, 3, 2, CURRENT_TIMESTAMP)

SELECT * FROM Student
SELECT * FROM ExamRegistration


--- Just create one more table below again to show relationship in and no relationship in Database Diagram
Use SchoolDB
CREATE TABLE TestTable3
(
    ExamRegNo int identity (1, 99) NOT NULL,
	StudentMatriculeNo int NOT NULL,
    SubjectsRegistered int NOT NULL,
	Level int,
	RegistrationDate datetime,
);