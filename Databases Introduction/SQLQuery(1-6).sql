CREATE DATABASE [Minions]
CREATE TABLE [Towns](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(30)
)
CREATE TABLE [Minions](
	[Id] INT PRIMARY KEY NOT NULL,
	[Name] VARCHAR(20),
	[Age] INT,
	[TownId] INT FOREIGN KEY REFERENCES Towns(Id)
)
INSERT INTO Towns([Id], [Name])
VALUES (1,'Sofia'), (2,'Plovdiv'),(3,'Varna');

INSERT INTO [Minions]([Id], [Name], [Age],[TownId])
VALUES (1,'Kevin', 22, 1), (2,'Bob', 15, 3),(3,'Steward', NULL, 2);

TRUNCATE TABLE [Minions]

DROP TABLE [Minions];
DROP TABLE [Towns];