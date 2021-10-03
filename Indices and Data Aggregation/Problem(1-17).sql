--Problem 1
SELECT COUNT(*) AS [Count] FROM WizzardDeposits

--Problem 2
SELECT TOP (1) MAX(MagicWandSize) AS [LongestMagicWand] FROM WizzardDeposits

--Problem 3
SELECT [DepositGroup],MAX(MagicWandSize) AS [LongestMagicWand] FROM WizzardDeposits
GROUP BY [DepositGroup]

--Problem 4
SELECT TOP(2) [DepositGroup] FROM WizzardDeposits
GROUP BY [DepositGroup]
ORDER BY AVG(MagicWandSize) 

--Problem 5
SELECT [DepositGroup], SUM(DepositAmount) AS [TotalSum] FROM WizzardDeposits
GROUP BY [DepositGroup]

--Problem 6
SELECT [DepositGroup], SUM(DepositAmount) AS [TotalSum] FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY [DepositGroup]

--Problem 7
SELECT [DepositGroup], SUM(DepositAmount) AS [TotalSum] FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY [DepositGroup]
HAVING SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC

--Problem 8
SELECT DepositGroup, MagicWandCreator AS [MagicWandCreator], MIN(DepositCharge) AS MinDepositCharge FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--Problem 9
SELECT nested.[AgeGroup], COUNT(nested.[AgeGroup]) FROM
	(SELECT
		CASE
			WHEN Age BETWEEN 0 AND 10 
			THEN '[0-10]'
			WHEN Age BETWEEN 11 AND 20
			THEN '[11-20]'
			WHEN Age BETWEEN 21 AND 30
			THEN '[21-30]'
			WHEN Age BETWEEN 31 AND 40
			THEN '[31-40]'
			WHEN Age BETWEEN 41 AND 50
			THEN '[41-50]'
			WHEN Age BETWEEN 51 AND 60
			THEN '[51-60]'
			WHEN Age >= 61
			THEN '[61+]'
		END AS [AgeGroup] 
	FROM WizzardDeposits
	) AS nested
GROUP BY nested.[AgeGroup]

SELECT * FROm WizzardDeposits

--Problem 10
SELECT * FROM
(SELECT DISTINCT LEFT(FirstName,1) as [FirstLetter] FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest') AS nested
ORDER BY nested.[FirstLetter]

--Problem 11

SELECT [DepositGroup], [IsDepositExpired], AVG(DepositInterest) AS [AverageInterest] FROM WizzardDeposits
WHERE DepositStartDate > '01/01/1985'
GROUP BY [DepositGroup],[IsDepositExpired]
ORDER BY DepositGroup DESC,
	[IsDepositExpired] ASC

--Problem 13
SELECT DepartmentId, SUM(Salary) FROM Employees
GROUP BY DepartmentId
ORDER BY DepartmentId

--Problem 14
SELECT DepartmentId, MIN(Salary) AS [MinimumSalary]FROM Employees
WHERE HireDate > '01/01/2000'
GROUP BY DepartmentId
HAVING DepartmentId IN (2,5,7)

--Problem 15
SELECT * INTO NewTable FROM Employees
WHERE Salary > 30000

DELETE FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
	SET Salary += 5000
	WHERE DepartmentID = 1

SELECT [DepartmentID], AVG(Salary) FROM NewTable
GROUP BY [DepartmentID]

--Problem 16
SELECT [DepartmentID], MAX(Salary) FROM Employees
GROUP BY [DepartmentID]
HAVING MAX(Salary)NOT BETWEEN 30000 AND 70000

--Problem 17
SELECT COUNT(Salary) AS Count FROM Employees
WHERE ManagerID IS NULL

--Problem 18
SELECT TOP (1) DepartmentID, Salary
	FROM (
	SELECT  DISTINCT TOP 3 DepartmentID , Salary
	FROM Employees
	ORDER BY Salary DESC
	) AS RESULT
GROUP BY DepartmentID
ORDER BY Salary
