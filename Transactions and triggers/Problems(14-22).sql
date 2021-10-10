--Problem 14
CREATE TABLE [Logs](
	[LogId] INT PRIMARY KEY IDENTITY NOT NULL,
	[AccountId] INT FOREIGN KEY REFERENCES Accounts(Id),
	[OldSum] MONEY NOT NULL,
	[NewSum] MONEY NOT NULL
)
GO

CREATE TRIGGER tr_UpdateMoneyInLog
ON Accounts AFTER UPDATE
AS
	INSERT INTO Logs
	VALUES (
    (SELECT Id
     FROM inserted),
    (SELECT Balance
     FROM deleted),
    (SELECT Balance
     FROM inserted)
  )
GO
--Problem 15
CREATE TABLE NotificationEmails (
  [Id] INT PRIMARY KEY IDENTITY,
  [Recipient] INT,
  [Subject] NVARCHAR(MAX),
  [Body] NVARCHAR(MAX)
)
GO

CREATE TRIGGER tr_UpdateEmailWhenLogs
ON Logs AFTER INSERT
AS
	INSERT INTO NotificationEmails
	VALUES (
    (SELECT AccountId FROM inserted),
    (SELECT ('Balance change for account: ' +  [AccountId]) FROM inserted),
    (CONCAT('On ',(SELECT GETDATE() FROM inserted), ' your balance was changed from ', (SELECT OldSum FROM inserted), 'to',(SELECT NewSum FROM inserted),'.'))
  )


GO
--Problem 16

CREATE PROC usp_DepositMoney @AccountId INT, @MoneyAmount MONEY
AS
	BEGIN TRANSACTION
	UPDATE Accounts
		SET Balance += @MoneyAmount
	WHERE @AccountId = Id
	COMMIT

GO

--Problem 17

CREATE PROC usp_WithdrawMoney @AccountId INT, @MoneyAmount MONEY
AS
	BEGIN TRANSACTION
	UPDATE Accounts
		SET Balance -= @MoneyAmount
	WHERE @AccountId = Id
	COMMIT

GO

--Problem 18

CREATE PROC usp_TransferMoney @SenderId INT, @ReceiverId INT, @Amount MONEY
AS
BEGIN
	BEGIN TRANSACTION
	EXEC dbo.usp_WithdrawMoney @SenderId, @Amount
	EXEC dbo.usp_DepositMoney @ReceiverId, @Amount
	IF((SELECT Balance FROM Accounts
		WHERE Accounts.Id = @SenderId) < 0)
	BEGIN
		ROLLBACK
	END
	ELSE
	BEGIN
		COMMIT
	END
END
GO

--Problem 21
CREATE PROC usp_AssignProject @emloyeeId INT, @projectID INT  
AS
BEGIN
  BEGIN TRAN
	INSERT INTO EmployeesProjects
	VALUES (@emloyeeId, @projectID)
	IF((SELECT COUNT(EmployeeID) FROM EmployeesProjects WHERE EmployeeID = @emloyeeId) > 3)
	BEGIN
		RAISERROR ('The employee has too many projects!', 16, 1)
		ROLLBACK
		RETURN
	END
    COMMIT
END

Go
--Problem 22
CREATE TABLE Deleted_Employees
(
  EmployeeId INT PRIMARY KEY IDENTITY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  MiddleName VARCHAR(50),
  JobTitle VARCHAR(50),
  DepartmentId INT,
  Salary DECIMAL(15, 2)
)

GO
CREATE TRIGGER tr_UpdateDeletedEmployees
ON Employees AFTER DELETE 
AS
	BEGIN
		INSERT INTO Deleted_Employees
		SELECT
			FirstName,
			LastName,
			MiddleName,
			JobTitle,
			DepartmentID,
			Salary
      FROM deleted
END

