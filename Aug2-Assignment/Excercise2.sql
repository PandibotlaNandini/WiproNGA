---1. Total Present Basic > 30000 for each department
SELECT DepartmentCode, SUM(PresentBasic) AS TotalBasic
FROM dbo.tblEmployees
GROUP BY DepartmentCode
HAVING SUM(PresentBasic) > 30000
ORDER BY DepartmentCode
Go


----2. Max, Min, Avg Age (Years & Months) by Service Type, Status, Centre
SELECT CentreCode,ServiceType, ServiceStatus,
       MAX(DATEDIFF(MONTH, DOB, GETDATE())) / 12 AS MaxAgeYears,
       MIN(DATEDIFF(MONTH, DOB, GETDATE())) / 12 AS MinAgeYears,
       AVG(DATEDIFF(MONTH, DOB, GETDATE())) / 12.0 AS AvgAgeYears
FROM dbo.tblEmployees
GROUP BY CentreCode, ServiceType, ServiceStatus
Go

---3.Max, Min, Avg Service by Service Type, Status, Centre (Years & Months)
SELECT CentreCode, ServiceType, ServiceStatus,
       MAX(DATEDIFF(MONTH, DOJ, GETDATE())) / 12 AS MaxServiceYears,
       MIN(DATEDIFF(MONTH, DOJ, GETDATE())) / 12 AS MinServiceYears,
       AVG(DATEDIFF(MONTH, DOJ, GETDATE())) / 12.0 AS AvgServiceYears
FROM dbo.tblEmployees
GROUP BY CentreCode, ServiceType, ServiceStatus
Go

----4.Departments where Total Salary > 3 × Average Salary
SELECT DepartmentCode
FROM (
   SELECT DepartmentCode,
          SUM(PresentBasic) AS TotalBasic,
          AVG(PresentBasic) AS AvgBasic
   FROM tblEmployees
   GROUP BY DepartmentCode
) t
WHERE t.TotalBasic > 3 * t.AvgBasic;

---5. Departments where Total Salary > 2×Avg Salary and Max Basic ≥ 3×Min Basic

SELECT DepartmentCode
FROM (
   SELECT DepartmentCode,
          SUM(PresentBasic) AS TotalBasic,
          AVG(PresentBasic) AS AvgBasic,
          MAX(PresentBasic) AS MaxBasic,
          MIN(PresentBasic) AS MinBasic
   FROM tblEmployees
   GROUP BY DepartmentCode
) t
WHERE t.TotalBasic > 2 * t.AvgBasic
  AND t.MaxBasic >= 3 * t.MinBasic;



---6. Centers where max name length = 2×min name length
SELECT CM.CentreName
FROM  dbo.tblEmployees E
JOIN dbo.tblCentreMaster CM ON E.CentreCode = CM.CentreCode
GROUP BY CM.CentreName
HAVING MAX(LEN(E.Name)) >= 2 * MIN(LEN(E.Name))
Go
--- 7.Service by Type, Status, Centre in milliseconds
SELECT 
    CM.CentreName,
    E.ServiceType,
    E.ServiceStatus,
    MAX(DATEDIFF(MILLISECOND, E.DOJ, GETDATE())) AS MaxService,
    MIN(DATEDIFF(MILLISECOND, E.DOJ, GETDATE())) AS MinService,
    AVG(1.0 * DATEDIFF(MILLISECOND, E.DOJ, GETDATE())) AS AvgService
FROM dbo.tblEmployees E
JOIN dbo.tblCentreMaster CM ON E.CentreCode = CM.CentreCode
GROUP BY CM.CentreName, E.ServiceType, E.ServiceStatus;

---8. Employees with leading/trailing spaces in names
SELECT *
FROM dbo.tblEmployees
WHERE LEFT(Name, 1) = ' ' OR RIGHT(Name, 1) = ' ';

---9. Employees with multiple spaces between name parts

SELECT *
FROM dbo.tblEmployees
WHERE Name LIKE '%  %'; -- Two or more spaces

---10. Clean name: remove leading/trailing spaces and reduce multiple spaces


-- Step 1: Tally table (1 to 200)
WITH Tally(n) AS (
    SELECT TOP 200 ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM sys.all_objects
),
CleanedNames AS (
    SELECT 
        E.EmployeeNumber,
        (
            SELECT 
                CASE 
                    WHEN T.n = 1 AND SUBSTRING(E.Name, T.n, 1) = ' ' THEN ''  -- Skip leading space
                    WHEN SUBSTRING(E.Name, T.n, 1) = '.' THEN ''              -- Remove periods
                    WHEN SUBSTRING(E.Name, T.n, 1) = ' ' 
                         AND (SUBSTRING(E.Name, T.n - 1, 1) = ' ' OR T.n = 1) THEN ''  -- Skip repeated or leading spaces
                    WHEN T.n = LEN(E.Name) AND SUBSTRING(E.Name, T.n, 1) = ' ' THEN '' -- Skip trailing space
                    ELSE SUBSTRING(E.Name, T.n, 1)
                END
            FROM Tally T
            WHERE T.n <= LEN(E.Name)
            FOR XML PATH(''), TYPE
        ).value('.', 'NVARCHAR(MAX)') AS CleanedName
    FROM dbo.tblEmployees E
)
SELECT EmployeeNumber, CleanedName
FROM CleanedNames;

---11.Max number of words in employee names


WITH Tally(n) AS (
    SELECT TOP 100 ROW_NUMBER() OVER (ORDER BY (SELECT NULL))
    FROM sys.all_objects
),
WordCount AS (
    SELECT 
        E.EmployeeNumber,
        E.Name,
        COUNT(*) + CASE WHEN SUBSTRING(E.Name, 1, 1) != ' ' THEN 1 ELSE 0 END AS WordCount
    FROM dbo.tblEmployees E
    JOIN Tally T ON T.n <= LEN(E.Name) - 1
    WHERE SUBSTRING(E.Name, T.n, 1) = ' ' AND SUBSTRING(E.Name, T.n + 1, 1) != ' '
    GROUP BY E.EmployeeNumber, E.Name
)
SELECT MAX(WordCount) AS MaxWordsInAnyEmployeeName
FROM WordCount;


---12. Name starts and ends with same character

SELECT *
FROM dbo.tblEmployees
WHERE LEFT(Name, 1) = RIGHT(Name, 1);

---13. First and second name start with same character
SELECT *
FROM dbo.tblEmployees
WHERE 
    LEN(Name) - LEN(REPLACE(Name, ' ', '')) >= 1 AND
    SUBSTRING(Name, 1, 1) = 
    SUBSTRING(Name, CHARINDEX(' ', Name) + 1, 1);

---14. All words start with same character

SELECT name, compatibility_level  
FROM sys.databases  
WHERE name = 'EmpSample_#OK';

ALTER DATABASE EmpSample_#OK
SET COMPATIBILITY_LEVEL = 130;

SELECT *
FROM dbo.tblEmployees
WHERE NOT EXISTS (
    SELECT *
    FROM STRING_SPLIT(Name, ' ')
    GROUP BY LEFT(value, 1)
    HAVING COUNT(*) > 1
);

---15. Any word (not initials) starts and ends with same character

SELECT *
FROM dbo.tblEmployees
WHERE EXISTS (
    SELECT value
    FROM STRING_SPLIT(Name, ' ')
    WHERE LEN(value) > 1 AND LEFT(value, 1) = RIGHT(value, 1)
);


---16. Present basic perfectly rounded to 100
--Using ROUND:
SELECT * FROM dbo.tblEmployees
WHERE ROUND(PresentBasic, -2) = PresentBasic;

---Using FLOOR:
SELECT * FROM dbo.tblEmployees
WHERE FLOOR(PresentBasic / 100.0) * 100 = PresentBasic;

--Using MOD:

SELECT * FROM dbo.tblEmployees
WHERE PresentBasic % 100 = 0;

--Using CEILING:

SELECT * FROM dbo.tblEmployees
WHERE CEILING(PresentBasic / 100.0) * 100 = PresentBasic;

--17. Departments where all employees have Present Basic rounded to 100

SELECT DepartmentCode
FROM dbo.tblEmployees
GROUP BY DepartmentCode
HAVING COUNT(*) = SUM(CASE WHEN PresentBasic % 100 = 0 THEN 1 ELSE 0 END);


--18. Departments where no employee has Present Basic rounded to 100
SELECT DepartmentCode
FROM dbo.tblEmployees
GROUP BY DepartmentCode
HAVING SUM(CASE WHEN PresentBasic % 100 = 0 THEN 1 ELSE 0 END) = 0;


---19. Eligibility for bonus (after 1 year 3 months 15 days); age on payment date
SELECT 
    E.Name,
    DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ)) AS EligibilityDate,
    
    DATEDIFF(YEAR, E.DOB, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) AS AgeYears,
    
    DATEDIFF(MONTH, E.DOB, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) % 12 AS AgeMonths,
    
    DATEDIFF(DAY,
        DATEADD(YEAR,
            DATEDIFF(YEAR, E.DOB, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))),
            DATEADD(MONTH,
                DATEDIFF(MONTH, E.DOB, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) % 12,
                E.DOB
            )
        ),
        DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))
    ) AS AgeDays,

    DATENAME(WEEKDAY, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) AS Weekday,
    DATEPART(WEEK, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) AS WeekOfYear,
    DATEPART(DAYOFYEAR, DATEADD(MONTH, 15, DATEADD(DAY, 15, E.DOJ))) AS DayOfYear
FROM tblEmployees AS E;



---20. Bonus eligibility based on rules

SELECT Name, ServiceType, EmployeeType, DOJ, DOB
FROM tblEmployees
WHERE (
    ServiceType = 1 AND EmployeeType = 1 AND
      DATEDIFF(YEAR, DOJ, GETDATE()) >= 10 AND
      DATEDIFF(YEAR, GETDATE(), DATEADD(YEAR, 60, DOB)) >= 15
)
OR (
    ServiceType = 1 AND EmployeeType = 2 AND
      DATEDIFF(YEAR, DOJ, GETDATE()) >= 12 AND
      DATEDIFF(YEAR, GETDATE(), DATEADD(YEAR, 55, DOB)) >= 14
)
OR (
    ServiceType = 1 AND EmployeeType = 3 AND
      DATEDIFF(YEAR, DOJ, GETDATE()) >= 12 AND
      DATEDIFF(YEAR, GETDATE(), DATEADD(YEAR, 55, DOB)) >= 12
)
OR (
    ServiceType IN (2,3,4) AND
      DATEDIFF(YEAR, DOJ, GETDATE()) >= 15 AND
      DATEDIFF(YEAR, GETDATE(), DATEADD(YEAR, 65, DOB)) >= 20
);



---21. Display current date in all formats using CONVERT()

SELECT 
    CONVERT(VARCHAR, GETDATE(), 100) AS Format100,
    CONVERT(VARCHAR, GETDATE(), 101) AS Format101,
    CONVERT(VARCHAR, GETDATE(), 102) AS Format102,
    CONVERT(VARCHAR, GETDATE(), 103) AS Format103,
    CONVERT(VARCHAR, GETDATE(), 104) AS Format104,
    CONVERT(VARCHAR, GETDATE(), 105) AS Format105,
    CONVERT(VARCHAR, GETDATE(), 106) AS Format106,
    CONVERT(VARCHAR, GETDATE(), 107) AS Format107,
    CONVERT(VARCHAR, GETDATE(), 108) AS Format108,
    CONVERT(VARCHAR, GETDATE(), 109) AS Format109;


---22.22. Employees whose net payment < actual basic (from PayEmployeeParamDetails)

WITH SalarySummary AS (
    SELECT 
        p.EmployeeNumber,
        e.Name,
        p.NoteNumber,
        SUM(CASE WHEN p.ParamCode = 'BASIC' THEN p.Amount ELSE 0 END) AS BasicPay,
        SUM(p.Amount) AS NetPay
    FROM tblPayEmployeeparamDetails p
    JOIN tblEmployees e ON e.EmployeeNumber = p.EmployeeNumber
    GROUP BY p.EmployeeNumber, e.Name, p.NoteNumber
)
SELECT *
FROM SalarySummary
WHERE NetPay < BasicPay;

WITH SalaryBreakdown AS (
    SELECT 
        p.EmployeeNumber,
        e.Name,
        SUM(CASE WHEN p.ParamCode = 'BASIC' THEN p.Amount ELSE 0 END) AS BasicAmount,
        SUM(CASE WHEN p.ParamCode <> 'BASIC' THEN p.Amount ELSE 0 END) AS OtherComponents
    FROM tblPayEmployeeparamDetails p
    JOIN tblEmployees e ON e.EmployeeNumber = p.EmployeeNumber
    GROUP BY p.EmployeeNumber, e.Name
)
SELECT *
FROM SalaryBreakdown
WHERE OtherComponents < BasicAmount;
