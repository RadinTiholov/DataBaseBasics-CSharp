CREATE PROC usp_GetHoldersFullName
AS
BEGIN
	SELECT FirstName + ' '+LastName AS [Full Name] FROM AccountHolders
END
EXEC usp_GetHoldersFullName

Go 

CREATE PROC usp_GetHoldersWithBalanceHigherThan @money MONEY
AS
BEGIN
	SELECT FirstName, LastName FROM AccountHolders AS ah
	LEFT JOIN Accounts AS a
	ON a.AccountHolderId = ah.Id
	GROUP BY FirstName, LastName
	HAVING SUM(Balance) > @money
END

EXEC usp_GetHoldersWithBalanceHigherThan 200

Go

CREATE FUNCTION ufn_CalculateFutureValue (@Sum MONEY, @Rate FLOAT , @Years INT)
RETURNS MONEY AS
BEGIN
 RETURN @Sum * POWER(1+@Rate,@Years)
END

Go

CREATE PROCEDURE usp_CalculateFutureValueForAccount @AccountId INT, @Rate FLOAT 
AS
BEGIN
	SELECT a.Id AS [Account Id],
	   ah.FirstName AS [First Name],
	   ah.LastName AS [Last Name],
	   a.[Balance] AS [Current Balance],
	   dbo.ufn_CalculateFutureValue(Balance, @Rate, 5) AS [Balance in 5 years] FROM AccountHolders as ah
	LEFT JOIN Accounts as a
	ON ah.Id = a.AccountHolderId
	WHERE ah.[Id] = @AccountId
END

DROP PROC dbo.usp_CalculateFutureValueForAccount

