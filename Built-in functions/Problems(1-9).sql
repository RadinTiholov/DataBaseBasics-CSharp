--First problem
SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE [FirstName] LIKE 'SA%' 
--Second problem

SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE [LastName] LIKE '%ei%' 
--Third problem

SELECT [FirstName]
	FROM [Employees]
	WHERE [DepartmentID] = 3 OR [DepartmentID] = 10 AND [HireDate] >= 1995 Or [HireDate] <= 2005 
-- Fourth problem

SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE [JobTitle] NOT LIKE '%engineer%'

-- Fifth problem
SELECT [Name]
	FROM [Towns]
	WHERE LEN([Name]) IN (5,6)
	ORDER BY [Name]

-- Sixth problem

SELECT [TownID],[Name]
	FROM [Towns]
	WHERE LEFT([Name],1) IN ('M', 'K', 'B', 'E')
	ORDER BY [Name]

-- Seventh problem

SELECT [TownID],[Name]
	FROM [Towns]
	WHERE LEFT(Name, 1) NOT LIKE '[RBD]'
	ORDER BY [Name]

-- Eighth problem
CREATE VIEW [V_EmployeesHiredAfter2000] AS
	SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE DATEPART(YEAR, HireDate) > 2000;

--Ninth problem
SELECT [FirstName], [LastName] 
	FROM [Employees]
	WHERE LEN([LastName]) = 5