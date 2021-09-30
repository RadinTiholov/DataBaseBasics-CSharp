--Problem 1
SELECT TOP (5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText 
FROM Employees as e
LEFT JOIN Addresses as a
ON e.AddressID = a.AddressID
ORDER BY e.AddressID ASC

--Problem 2
SELECT TOP (50) e.FirstName, e.LastName, t.[Name] AS [Town],a.AddressText FROM 
Employees AS e
LEFT JOIN Addresses AS a
ON e.AddressID = a.AddressID
LEFT JOIN Towns AS t
ON a.TownID = t.TownID
ORDER BY FirstName,LastName

--Problem 3
SELECT e.EmployeeID, e.FirstName, e.LastName, d.[Name] AS [DepartmentName] FROM Employees AS e
INNER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID AND e.DepartmentID = 3
ORDER BY e.EmployeeID ASC

--Problem 4
SELECT TOP (5) e.EmployeeID, e.FirstName, e.Salary, d.[Name] AS [DepartmentName] FROM Employees AS e
INNER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID 
AND  e.Salary > 15000
ORDER BY e.DepartmentID ASC

--Problem 5
SELECT TOP (3) e.EmployeeID,e.FirstName FROM Employees AS e
FULL JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
WHERE  ep.EmployeeID IS NULL
ORDER BY e.EmployeeID ASC

--Problem 6
SELECT e.FirstName, e.LastName,e.HireDate, d.[Name] AS [DeptName] FROM Employees AS e
INNER JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1/1/1999' AND e.DepartmentID = 3 OR e.DepartmentID = 10
ORDER BY e.HireDate ASC

--Problem 7
SELECT TOP (5) e.EmployeeID,e.FirstName,p.[Name] AS [ProjectName] FROM Employees AS e
JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID
LEFt JOIN Projects AS p
ON ep.ProjectID = p.ProjectID
WHERE  p.StartDate > '08/13/2002' AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

--Problem 8
SELECT TOP (5) e.EmployeeID,e.FirstName,
CASE 
	WHEN P.StartDate > '01/01/2005' 
	THEN NULL
	ELSE p.[Name] 
END AS [ProjectName]
FROM Employees AS e
INNER JOIN EmployeesProjects AS ep
ON e.EmployeeID = ep.EmployeeID AND e.EmployeeID = 24
INNER JOIN Projects AS p
ON ep.ProjectID = p.ProjectID

--Problem 9
SELECT e.EmployeeID,e.FirstName,e.ManagerID,d.FirstName AS [ManagerName] FROM Employees as e
LEFT JOIN Employees as d
ON d.EmployeeID = e.ManagerID
WHERE e.ManagerID = 3 OR e.ManagerID = 7
ORDER BY e.EmployeeID ASC

--Problem 10
SELECT TOP (50) e.EmployeeID,
	e.FirstName + ' ' + e.LastName AS [EmployeeName],
	d.FirstName + ' ' + d.LastName AS [ManagerName],
	dep.[Name] AS [DepartmentName] FROM Employees as e
LEFT JOIN Employees as d
ON d.EmployeeID = e.ManagerID
LEFT JOIN Departments as dep
ON e.DepartmentID = dep.DepartmentID
ORDER BY e.EmployeeID ASC

--Problem 11
SELECT TOP(1) (SELECT AVG(Salary)) AS avgSAl FROM Employees
GROUP BY DepartmentID
ORDER BY avgSAl

--Problem 12
USE [Geography]

SELECT mc.CountryCode, m.MountainRange,p.PeakName,p.Elevation FROM Mountains AS m
LEFT JOIN Peaks AS p
ON m.Id = p.MountainId
LEFT JOIN MountainsCountries mc
ON m.Id = mc.MountainId
WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC 

--Problem 13
USE [Geography]

SELECT mc.CountryCode, COUNT(mc.CountryCode) AS [MountainRanges] FROM Mountains AS m
INNER JOIN MountainsCountries mc
ON m.Id = mc.MountainId AND (mc.CountryCode = 'BG' OR mc.CountryCode = 'Us' OR  mc.CountryCode = 'RU')
GROUP BY mc.CountryCode

--Problem 14
USE [Geography]

SELECT TOP (5) c.CountryName, r.RiverName FROM Countries AS c
LEFT JOIN CountriesRivers AS cr
ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers AS r
ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName ASC

--Problem 15
USE [Geography]

SELECT CountryCode, CurrencyCode, COUNT(CurrencyCode) AS [CurrencyUsage]  FROM Countries AS c
--WHERE COUNT(CurrencyCode) = 1
GROUP BY CurrencyCode
ORDER BY ContinentCode
--Problem 16
USE [Geography] 

SELECT COUNT(c.CountryCode) AS [Count] FROM Countries AS c
LEFT JOIN MountainsCountries AS mc
ON c.CountryCode = mc.CountryCode
WHERE mc.MountainId IS NULL

--Problem 17
USE [Geography]

SELECT TOP(5) c.CountryName, MAX(p.Elevation) AS [HighestPeakElevation], MAX(r.Length) AS [LongestRiverLength]
FROM Countries AS c
LEFT OUTER JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
LEFT OUTER JOIN Peaks AS p ON p.MountainId = mc.MountainId
LEFT OUTER JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
LEFT OUTER JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY c.CountryName
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.CountryName

