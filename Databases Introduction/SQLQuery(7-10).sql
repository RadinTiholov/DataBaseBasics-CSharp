CREATE TABLE [People](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	[Height] DECIMAL,
	[Weight] DECIMAL,
	[Gender] VARCHAR(10) NOT NULL CHECK ([Gender] IN('m', 'f')),
	[Birthdate] DATETIME NOT NULL,
	[Biography] NVARCHAR(MAX)
)

INSERT INTO [People]([Name], Height, [Weight], [Gender], [Birthdate], [Biography])
VALUES ('Gosho', 2.3, 45.6, 'm', '1992-03-02', 'Karam golf cql jivot'),
		('Pesho', 2.3, 45.6, 'm', '1999-03-12', 'Karam golf cql jivot'),
		('Misho', 2.2, 2.6, 'f', '1992-12-02', 'Karam bmv cql jivot'),
		('Mishoa', 1.5, 34.6, 'm', '1996-08-22', 'Karam fiesta cql jivot'),
		('Sasho', 1.8, 29.6, 'm', '2004-03-02', 'Karam nishto cql jivot');

CREATE TABLE [Users](
	[Id] BIGINT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Pasword] VARCHAR(26) NOT NULL,
	[ProfilePicture] VARBINARY(MAX),
	[LastLoginTime] DATETIME2,
	[IsDeleted] VARCHAR(10) NOT NULL CHECK ([IsDeleted] IN('true', 'false')),
)
INSERT INTO [Users]([Username], [Pasword], [LastLoginTime], [IsDeleted])
VALUES ('Goshoi', 'Kurcho33', '2016-10-23 12:45:37.1234567', 'false'),
('GADAD', '123123', '2016-10-31 12:45:37.1234567', 'false'),
('Pokkk', 'ada2', '2017-04-04 12:41:37.1234567', 'false'),
('Sokkk', 'asdddd2', '2004-11-23 12:45:37.1234567', 'true'),
('usko', 'adad', '2019-10-12 12:45:37.1234567', 'true');

ALTER TABLE [Users]
ADD CONSTRAINT PK_Id_And_Username PRIMARY KEY ([Id], [Username])

ALTER TABLE [Users]
DROP CONSTRAINT PK_Id_And_Username

ALTER TABLE [Users]
ADD CONSTRAINT [MinLengthPass] CHECK(DATALENGTH(Pasword)>=10)

DROP TABLE Users
