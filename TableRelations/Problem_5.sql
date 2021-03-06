
CREATE TABLE [Cities](
	[CityID] INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE [Customers](
	[CustomersID] INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	[Birthday] DATE,
	[CityID] INT FOREIGN KEY REFERENCES Cities(CityID)
)

CREATE TABLE [Orders](
	[OrderID] INT PRIMARY KEY,
	[CustomerID] INT FOREIGN KEY REFERENCES Customers([CustomersID])
)
CREATE TABLE [ItemTypes](
	[ItemTypeID] INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL
)
CREATE TABLE [Items](
	[ItemID] INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	[ItemTypeID] INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeID)
)
CREATE TABLE [OrdersItems](
	[OrderID] INT,
	[ItemID] INT,
	CONSTRAINT PK_OrderId_ItemId PRIMARY KEY([OrderID], [ItemID]),
	CONSTRAINT FK_OrderId FOREIGN KEY([OrderID]) REFERENCES Orders([OrderID]),
	CONSTRAINT FK_ItemId FOREIGN KEY([ItemID]) REFERENCES Items([ItemID])
)
