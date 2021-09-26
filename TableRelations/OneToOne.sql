CREATE DATABASE [TableRelations]

CREATE TABLE [Passports](
	[PassportID] INT IDENTITY(101,1) PRIMARY KEY NOT NULL,
	[PassportNumber] VARCHAR(10)
)

INSERT INTO [Passports]([PassportNumber])
VALUES ('N34FG21B'),('K65LO4R7'),('ZE657QP2')

CREATE TABLE [Persons](
	[PersonID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[FirstName] VARCHAR(20) NOT NULL,
	[Salary] DECIMAL NOT NULL,
	[PassportID] INT FOREIGN KEY REFERENCES Passports([PassportID]) NOT NULL
)

INSERT INTO [Persons](FirstName	,Salary	,PassportID)
VALUES ('Roberto', 43300.00, 102),('Tom',56100.00,103),('Yana',60200.00,101)
