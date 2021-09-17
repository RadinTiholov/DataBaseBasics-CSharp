-- Problem 16
CREATE TABLE Towns
(
             [Id] INT
             PRIMARY KEY IDENTITY NOT NULL,
             [Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE Addresses
(
             [Id]          INT
             PRIMARY KEY IDENTITY NOT NULL,
             [AddressText] NVARCHAR(100) NOT NULL,
             [TownId]      INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
);

CREATE TABLE Departments
(
             [Id]     INT
             PRIMARY KEY IDENTITY NOT NULL,
             [Name] NVARCHAR(50) NOT NULL
);

CREATE TABLE Employees
(
             [Id]           INT
             PRIMARY KEY IDENTITY NOT NULL,
             [FirstName]    NVARCHAR(50) NOT NULL,
             [MiddleName]   NVARCHAR(50),
             [LastName]     NVARCHAR(50),
             [JobTitle]     NVARCHAR(100) NOT NULL,
             [DepartmentId] INT FOREIGN KEY REFERENCES Departments(Id) NOT NULL,
             [HireDate]     DATE,
             [Salary]      DECIMAL(10, 2) NOT NULL,
             [AddressId]    INT FOREIGN KEY REFERENCES Addresses(Id)
);

--Problem 19

SELECT * FROM Towns

SELECT * FROM Departments 

SELECT * FROM Employees 

-- Problem 20

SELECT * FROM Towns ORDER BY [Name] ASC

SELECT * FROM Departments ORDER BY [Name] ASC

SELECT * FROM Employees ORDER BY [Salary] DESC

-- Problem 21
SELECT [Name] FROM Towns ORDER BY [Name] ASC

SELECT [Name] FROM Departments ORDER BY [Name] ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees ORDER BY [Salary] DESC

-- Problem 22
UPDATE Employees
  SET
      Salary *= 1.10;

SELECT [Salary] FROM Employees;
-- Problem 23
USE [Hotel]

UPDATE Payments
	SET 
		TaxRate /= 1.03;
SELECT [TaxRate] FROM Payments;
-- Problem 24
TRUNCATE TABLE Occupancies;