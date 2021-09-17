CREATE DATABASE [CarRental]

CREATE TABLE [Categories](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR(30) NOT NULL,
	[DailyRate] DECIMAL NOT NULL,
	[WeeklyRate] DECIMAL NOT NULL,
	[MonthlyRate] DECIMAL NOT NULL,
	[WeekendRate] DECIMAL NOT NULL
)
CREATE TABLE [Cars](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[PlateNumber] INT NOT NULL,
	[Manufacturer] NVARCHAR(30) NOT NULL,
	[Model] NVARCHAR(30) NOT NULL,
	[CarYear] DATETIME NOT NULL,
	[CategoryId] INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	[Doors] INT NOT NULL,
	[Picture] VARBINARY(MAX),
	[Condition] NVARCHAR(40),
	[Available] NVARCHAR(10)
)

CREATE TABLE [Employees](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[FirstName] NVARCHAR(20) NOT NULL,
	[LastName] NVARCHAR(20) NOT NULL,
	[Title] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(40) NOT NULL,
)
CREATE TABLE [Customers](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[DriverLicenceNumber] NVARCHAR(20) NOT NULL,
	[FullName] NVARCHAR(40) NOT NULL,
	[Address] NVARCHAR(30) NOT NULL,
	[City] NVARCHAR(30) NOT NULL,
	[ZIPCode] INT NOT NULL,
	[Notes] NVARCHAR(40) NOT NULL,
)
CREATE TABLE [RentalOrders](
	[Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[EmployeeId] INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	[CostumerId] INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
	[CarId] INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	[TankLevel] INT,
	[KilometrageStart] DECIMAL NOT NULL,
	[KilometrageEnd] DECIMAL NOT NULL,
	[TotalKilometrage] DECIMAL NOT NULL,
	[StartDate] DATETIME NOT NULL,
	[EndDate] DATETIME NOT NULL,
	[TotalDays] INT NOT NULL,
	[RateApplied] DECIMAL,
	[TaxRate] DECIMAL,
	[OrderStatus] NVARCHAR(30) NOT NULL,
	[Notes] NVARCHAR(40)
)

INSERT INTO Categories([CategoryName],[DailyRate],[WeeklyRate], [MonthlyRate], [WeekendRate])
VALUES ('mANGAL', 3.4, 2.3, 2.4, 2.6),
	('mANAAGAL', 3.4, 3.7, 2.4, 23.1),
	('AAA', 3.7, 2.3, 2.4, 3.7);

INSERT INTO Cars([PlateNumber], [Manufacturer], [Model],[CarYear],[CategoryId],[Doors],[Condition],[Available])
VALUES (123123, 'TOYOTA', 'JARVIS', '2021/12/23', 3, 4, 'WELL', 'yES')
	,(123233, 'TOYOTA', 'AA', '2021/04/22', 1, 4, 'BAD', 'NO')
	,(343123, 'TOYOTA', 'MM', '2021/12/03', 2, 4, 'WELL', 'yES');

INSERT INTO [Employees]([FirstName], [LastName], [Title],[Notes])
VALUES ('MISHIO', 'GOGOOG', 'PEDASS', 'NOPE')
	,('A', 'A', 'FF', 'NOPE')
	,('SDS', 'D', 'FGF', 'NOPE');

INSERT INTO [Customers]([DriverLicenceNumber] ,[FullName],[Address],[City],[ZIPCode],[Notes])
VALUES ('AAPK23', 'PASD AAA', 'UL.PAAA', 'SOFIQ', 2300, 'NEEEE')
	,('1231231', 'PASD AAA', 'UL.1323', 'SOFIQ', 1111, 'NEEEE')
	,('AD111', 'AAAA AAA', 'UL.111', 'PERNIK', 12323, 'DAATATA');

INSERT INTO [RentalOrders]([EmployeeId] ,[CostumerId] ,[CarId] ,[TankLevel] ,[KilometrageStart], [KilometrageEnd] ,[TotalKilometrage],[StartDate],[EndDate],[TotalDays],[RateApplied],[TaxRate] ,[OrderStatus] ,[Notes])
VALUES (2, 2, 1, 23, 23.4, 34.2, 12.3, '2021/04/03', '2021/06/03', 54, 23.2, 3.4, 'DONE', 'NO')
	,(2, 3, 1, 23, 123.4, 34.2, 12.3, '2021/04/05', '2021/06/19', 54, 25.2, 3.4, 'DONE', 'NO')
	,(1, 2, 3, 23, 232.4, 343.2, 121.3, '2019/04/03', '2021/06/03', 54, 23.2, 3.4, 'DONE', 'NO');