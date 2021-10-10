--Problem 1

CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
BEGIN
	SELECT [FirstName], [LastName] FROM Employees
	WHERE [Salary] > 35000
END
--Problem 2
GO

CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber @number DECIMAL(18,4)
AS
BEGIN
	SELECT [FirstName], [LastName] FROM Employees
	WHERE [Salary] >= @number
END

--Problem 3
GO

CREATE PROC usp_GetTownsStartingWith @startText NVARCHAR(20)
AS
BEGIN
	SELECT [Name] FROM Towns
	WHERE LEFT([Name], LEN(@startText)) = @startText
END

--Problem 4
GO

CREATE PROC usp_GetEmployeesFromTown @townName NVARCHAR(30)
AS
BEGIN 
	SELECT FirstName as [First Name],LastName as [Last Name] FROM Employees AS e
	LEFT JOIN [Addresses] AS a
	ON e.AddressID = a.AddressID
	LEFT JOIN [Towns] AS t
	ON a.TownID = t.TownID
	WHERE t.Name = @townName
END

--Problem 5
GO

CREATE FUNCTION dbo.ufn_GetSalaryLevel(@salary DECIMAL(18,4))
RETURNS VARCHAR(7)
AS 
BEGIN
	DECLARE @SalaryLevel VARCHAR(7)
	IF(@Salary < 30000)
	BEGIN 
	 SET @SalaryLevel = 'Low'
	END
	ELSE IF(@Salary >= 30000 AND @Salary <= 50000)
	BEGIN
	 SET @SalaryLevel = 'Average'
	END
	ELSE 
	BEGIN 
	 SET @SalaryLevel = 'High'
	END
	RETURN @SalaryLevel
END

--Problem 6
GO

CREATE PROCEDURE usp_EmployeesBySalaryLevel @level NVARCHAR(7)
AS
BEGIN
	SELECT FirstName as [First Name],LastName as [Last Name] FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary) = @level
END

--Problem 7
GO

CREATE FUNCTION dbo.ufn_IsWordComprised(@setOfLetters NVARCHAR(260), @word NVARCHAR(260))
RETURNS BIT
AS
BEGIN
	 DECLARE @index INT = 1
     DECLARE @length INT = LEN(@word)
     DECLARE @letter CHAR(1)

     WHILE (@index <= @length)
     BEGIN
          SET @letter = SUBSTRING(@word, @index, 1)
          IF (CHARINDEX(@letter, @setOfLetters) > 0)
             SET @index = @index + 1
          ELSE
             RETURN 0
     END
     RETURN 1
END

--Problem 8
GO

CREATE PROCEDURE usp_DeleteEmployeesFromDepartment @departmentId INT
AS
BEGIN
	DELETE FROM Employees
	WHERE DepartmentID = @departmentId
	DELETE FROM Departments
	WHERE DepartmentID = @departmentId
	SELECT COUNT([EmployeeId]) FROM Employees
	WHERE DepartmentID = @departmentId
END