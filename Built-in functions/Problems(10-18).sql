--Problem 10
SELECT 
[EmployeeID], [FirstName], [LastName], [Salary], DENSE_RANK() OVER(PARTITION BY Salary ORDER BY [EmployeeID]) AS [Rank] 
FROM [Employees]
WHERE [Salary] >= 10000 AND [Salary] <= 50000
ORDER BY [Salary]DESC
--Problem 11
SELECT *
FROM (
       SELECT EmployeeID,
              FirstName,
              LastName,
              Salary,
              DENSE_RANK() over (partition by Salary ORDER BY EmployeeID) AS Rank
       FROM Employees
       WHERE Salary BETWEEN 10000 AND 50000) AS MyTable
WHERE Rank = 2
ORDER BY Salary DESC
--Problem 12
SELECT [CountryName], [IsoCode] as [ISO Code] FROM [Countries]
WHERE [CountryName] LIKE '%a%a%a%'
ORDER BY [ISO Code]
--Problem 13
SELECT Peaks.PeakName, Rivers.RiverName, 
LOWER((Peaks.PeakName) + SUBSTRING(Rivers.RiverName,2,LEN(Rivers.Rivername))) AS 'Mix' 
FROM Peaks
JOIN Rivers
ON RIGHT(Peaks.PeakName,1) = LEFT(Rivers.RiverName,1)
ORDER BY Mix
--Problem 14
SELECT TOP(50) [Name] [Game],
convert(char(10), start,126) [Start]
from Games
where Start >= '20110101' and Start < '20130101'
order by start,name
--Problem 15
SELECT 
	[Username],
	SUBSTRING(Email,CHARINDEX('@',Email,1)+1,LEN(Email)) AS [Email Provider]
FROM Users
ORDER BY [Email Provider],[Username]
--Problem 16
SELECT 
	[Username],
	[IpAddress]
FROM [Users]
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY [Username]
--Problem 17
SELECT [Name]
     , CASE
            WHEN DATEPART(hour,[Start]) >= 0 AND DATEPART(hour,[Start]) < 12 THEN 'Morning'
            WHEN DATEPART(hour, [Start]) >= 12 AND DATEPART(hour,[Start]) < 18 THEN 'Afternoon'
            WHEN DATEPART(hour, [Start]) >= 18 AND DATEPART(hour,[Start]) < 24 THEN 'Evening'
       END AS 'Part of the Day'
     , Case
            WHEN [Duration] <= 3 THEN 'Extra Short'
            WHEN [Duration] >= 4 AND [Duration] <= 6 THEN 'Short'
            WHEN [Duration] > 6 THEN 'Long'
            ELSE 'Extra Long'        
       END AS 'Duration'
     
  FROM Games
ORDER BY [Name],
 
         (Case
             WHEN [Duration] <= 3 THEN 1
             WHEN [Duration] >= 4 AND [Duration] <= 6 THEN 2
             WHEN [Duration] > 6 THEN 3
             ELSE 4      
          END),
          (CASE
             WHEN DATEPART(hour,[Start]) >= 0 AND DATEPART(hour,[Start]) < 12 THEN 1
             WHEN DATEPART(hour, [Start]) >= 12 AND DATEPART(hour,[Start]) < 18 THEN 2
             WHEN DATEPART(hour, [Start]) >= 18 AND DATEPART(hour,[Start]) < 24 THEN 3
           END)
--Problem 18
SELECT ProductName, OrderDate, DATEADD(day, 3, OrderDate) AS [Pay Due],DATEADD(month, 1, OrderDate) AS [Deliver Due] 
FROM [Orders]




