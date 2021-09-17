CREATE DATABASE [Movies]

CREATE TABLE [Directors](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DirectorName] NVARCHAR(30),
	[Notes] NVARCHAR(30),
)
CREATE TABLE [Genres](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[GenreName] NVARCHAR(30),
	[Notes] NVARCHAR(30),
)
CREATE TABLE [Categories](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR(30),
	[Notes] NVARCHAR(30),
)
CREATE TABLE [Movies](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Title] NVARCHAR(30) NOT NULL,
	[DirectorId] INT FOREIGN KEY REFERENCES [Directors](Id) NOT NULL,
	[CopyrightYear] DATETIME NOT NULL,
	[Length] DECIMAL NOT NULL,
	[GenreId] INT FOREIGN KEY REFERENCES [Genres](Id) NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES [Categories](Id) NOT NULL,
	[Rating] DECIMAL,
	[Notes] NVARCHAR(30),
)

INSERT INTO [Directors]([DirectorName], [Notes])
VALUES ('adadosho', 'mammama'),('ssosho1', 'wewewe'),('Mososh23o', 'qeqeqe'),('asd', 'vvvv'),('sssss', 'aa');

INSERT INTO [Genres]([GenreName], [Notes])
VALUES ('adadosDDho', 'mammAama'),('ssssosho1', 'wewewe'),('Mososh23o', 'qeaqeqe'),('aAsd', 'vvvdv'),('sssss', 'aa');

INSERT INTO [Categories]([CategoryName], [Notes])
VALUES ('adadosDDho', 'mammAama'),('ssssosho1', 'wewewe'),('Mososh23o', 'qeaqeqe'),('aAsd', 'vvvdv'),('sssss', 'aa');

INSERT INTO [Movies]([Title], [DirectorId],[CopyrightYear],[Length],[GenreId],[CategoryId],[Rating],[Notes])
VALUES ('TITLE1', 1, '2021-04-12', 192.3, 2, 1, 4.5, 'Shofior')
	,('TITL2', 4, '2021-04-12', 333.3, 3, 5, 4.5, 'Shofior')
	,('TITLasd', 3, '2021-04-12', 231.3, 1, 1, 2.4, 'Shofior')
	,('TITL4', 3, '1999-04-12', 123.3, 1, 5, 3.4, 'Shofior')
	,('TITLe5', 2, '2021-04-12', 323.3, 5, 3, 4.5, 'Shofior');
