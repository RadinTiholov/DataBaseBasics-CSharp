CREATE TABLE [Sizes](
	[Id] INT PRIMARY KEY IDENTITY,
	[Length] INT NOT NULL,
	[RingRange] DECIMAL(10,2) NOT NULL,
	CHECK([Length] BETWEEN 10 AND 25),
	CHECK([RingRange] BETWEEN 1.5 AND 7.5)
)

CREATE TABLE [Tastes](
	[Id] INT PRIMARY KEY IDENTITY,
	[TasteType] VARCHAR(20) NOT NULL,
	[TasteStrength] VARCHAR(15) NOT NULL,
	[ImageURL] NVARCHAR(100) NOT NULL,
)

CREATE TABLE [Brands](
	[Id] INT PRIMARY KEY IDENTITY,
	[BrandName] VARCHAR(30) UNIQUE NOT NULL,
	[BrandDescription] VARCHAR(MAX)
)

CREATE TABLE [Cigars](
	[Id] INT PRIMARY KEY IDENTITY,
	[CigarName] VARCHAR(80) NOT NULL,
	[BrandId] INT FOREIGN KEY REFERENCES Brands(Id),
	[TastId] INT FOREIGN KEY REFERENCES Tastes(Id),
	[SizeId] INT FOREIGN KEY REFERENCES Sizes(Id),
	[PriceForSingleCigar] MONEY NOT NULL,
	[ImageURL] NVARCHAR(100) NOT NULL
)

CREATE TABLE [Addresses](
	[Id] INT PRIMARY KEY IDENTITY,
	[Town] VARCHAR(30) NOT NULL,
	[Country] NVARCHAR(30) NOT NULL,
	[Streat] NVARCHAR(100) NOT NULL,
	[ZIP] VARCHAR(20) NOT NULL,
)

CREATE TABLE [Clients](
	[Id] INT PRIMARY KEY IDENTITY,
	[FirstName] NVARCHAR(30) NOT NULL,
	[LastName] NVARCHAR(30) NOT NULL,
	[Email] NVARCHAR(50) NOT NULL,
	[AddressId] INT FOREIGN KEY REFERENCES [Addresses](Id) NOT NULL
)

CREATE TABLE [ClientsCigars](
	[ClientId] INT FOREIGN KEY REFERENCES [Clients](Id),
	[CigarId] INT FOREIGN KEY REFERENCES [Cigars](Id),
	PRIMARY KEY([ClientId], [CigarId])
)
--PROBLEM 2
INSERT INTO [Cigars](CigarName,	BrandId,TastId,	SizeId,	PriceForSingleCigar,ImageURL)
VALUES ('COHIBA ROBUSTO',9,	1,	5,	15.50,	'cohiba-robusto-stick_18.jpg'),
	('COHIBA SIGLO I',	9	,1,	10	,410.00	,'cohiba-siglo-i-stick_12.jpg'),
	('HOYO DE MONTERREY LE HOYO DU MAIRE',14,	5	,11	,7.50,	'hoyo-du-maire-stick_17.jpg'),
	('HOYO DE MONTERREY LE HOYO DE SAN JUAN',	14	,4	,15	,32.00,	'hoyo-de-san-juan-stick_20.jpg'),
	('TRINIDAD COLONIALES',	2	,3	,8	,85.21	,'trinidad-coloniales-stick_30.jpg')

INSERT INTO [Addresses](Town,Country,Streat,ZIP)
VALUES ('Sofia',	'Bulgaria'	,'18 Bul. Vasil levski'	,'1000'),
	('Athens',	'Greece',	'4342 McDonald Avenue',	'10435'),
	('Zagreb',	'Croatia',	'4333 Lauren Drive',	'10000')

--PROBLEM 3
UPDATE Cigars
	SET [PriceForSingleCigar] = [PriceForSingleCigar] * 1.20
	WHERE TastId = 1

UPDATE Brands
	SET BrandDescription = 'New description'
	WHERE BrandDescription IS NULL

--PROBLEM 4
DELETE FROM Clients
	WHERE AddressId IN (7,8,10,23)

DELETE FROM Addresses
	WHERE Country LIKE('C%')

--PROBLEM 5
SELECT CigarName, PriceForSingleCigar, ImageURL FROM Cigars
	ORDER BY PriceForSingleCigar, CigarName DESC

--PROBLEM 6
SELECT c.Id, CigarName, PriceForSingleCigar, t.TasteType, t.TasteStrength FROM Cigars AS c
LEFT JOIN Tastes AS t
ON t.Id = c.TastId
WHERE t.TasteType IN ('Earthy' , 'Woody')
	ORDER BY PriceForSingleCigar DESC

--PROBLEM 7
SELECT Id, CONCAT(FirstName, ' ',LastName) AS [ClientName], Email FROM Clients
	WHERE Id NOT IN (
		SELECT ClientId FROM ClientsCigars
		GROUP BY ClientId)
ORDER BY CONCAT(FirstName, ' ',LastName)

--PROBLEM 8

SELECT TOP(5) c.CigarName, c.PriceForSingleCigar, c.ImageURL FROM Cigars AS c
	LEFT JOIN Sizes AS s
	ON c.SizeId = s.Id
	WHERE  s.[Length] >= 12 AND (c.CigarName LIKE('%ci%') OR c.PriceForSingleCigar > 50) AND s.RingRange > 2.55
ORDER BY c.CigarName, c.PriceForSingleCigar DESC

--PROBLEM 9

SELECT CONCAT(c.FirstName, ' ', c.LastName) AS FullName, a.Country,	a.ZIP AS CigarPrice FROM Clients AS c
	LEFT JOIN Addresses AS a
	ON c.AddressId = a.Id
	LEFT JOIN ClientsCigars AS cc
	ON cc.CigarId = c.Id
	LEFT JOIN Cigars AS cig
	ON cig.Id = cc.CigarId
	WHERE a.ZIP NOT LIKE '%[^0-9]%'

SELECT FullName, Country, ZIP, CONCAT('$',PriceForSingleCigar) AS [CigarPrice] FROM
    ( SELECT CONCAT(cli.FirstName, ' ', cli.LastName) AS FullName, a.Country, a.ZIP, cs.PriceForSingleCigar,
             DENSE_RANK()
				OVER(PARTITION BY cli.Id ORDER BY cs.PriceForSingleCigar DESC)
			 AS [Rank]
        FROM Clients AS cli
        LEFT JOIN Addresses AS a
        ON cli.AddressId = a.Id
        JOIN ClientsCigars AS cc
        ON cli.Id = cc.ClientId
        JOIN Cigars AS cs
        ON cc.CigarId = cs.Id
        WHERE a.ZIP NOT LIKE '%[^0-9]%'
    ) AS Ranked
WHERE [Rank] = 1
ORDER BY FullName

--PROBLEM 10

SELECT c.LastName, AVG(s.[Length]) AS [CiagrLength], CEILING(AVG(s.RingRange)) AS [CiagrRingRange] FROM ClientsCigars as cc
LEFT JOIN Clients as c
ON c.Id = cc.ClientId
LEFT JOIN Cigars as cig
ON cig.Id = cc.CigarId
LEFT JOIN Sizes as s
ON s.Id = cig.SizeId
GROUP BY c.LastName
ORDER BY AVG(s.[Length]) DESC


----PROBLEM 11
GO

CREATE FUNCTION udf_ClientWithCigars(@name NVARCHAR(30))
RETURNS INT
AS
BEGIN
	IF(@name NOT IN (SELECT FirstName FROM ClientsCigars as cc
	LEFT JOIN Clients as c
	ON c.Id = cc.ClientId
	LEFT JOIN Cigars as cig
	ON cig.Id = cc.CigarId
	GROUP BY FirstName))
	BEGIN
		RETURN 0
	END
	RETURN (SELECT TOP(1) COUNT(CigarId) FROM ClientsCigars as cc
	LEFT JOIN Clients as c
	ON c.Id = cc.ClientId
	LEFT JOIN Cigars as cig
	ON cig.Id = cc.CigarId
	WHERE FirstName = @name
	GROUP BY FirstName)
END

----PROBLEM 12
Go

CREATE PROC usp_SearchByTaste @taste VARCHAR(20)
AS
BEGIN
	SELECT c.CigarName, CONCAT('$',c.PriceForSingleCigar) AS [Price], t.TasteType,	BrandName,	CONCAT(s.[Length],' cm') AS [CigarLength], CONCAT(s.RingRange,' cm') AS [CigarRingRange] FROM Tastes as t
	LEFT JOIN Cigars as c
	On c.TastId = t.Id
	LEFT JOIN Sizes as s
	On s.Id = c.SizeId
	LEFT JOIN Brands as b
	On c.BrandId = b.Id
	WHERE t.TasteType = @taste
	ORDER BY s.[Length], s.RingRange DESC
END