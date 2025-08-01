
---Display Last Occurrence of given char in a string
---Ex : 'Keerthi' char 'e' exists 2 times last time at position 3 

SELECT 
    LEN('Keerthi') - CHARINDEX('e', REVERSE('Keerthi')) + 1 AS LastOccurrence,
    LEN('Keerthi') - LEN(REPLACE('Keerthi', 'e', '')) AS TotalOccurrences;



---Take FullName as 'Venkata Narayana' and split them into firstName and LastName

SELECT 
    LEFT('Venkata Narayana', CHARINDEX(' ', 'Venkata Narayana') - 1) AS FirstName,
    RIGHT('Venkata Narayana', LEN('Venkata Narayana') - CHARINDEX(' ', 'Venkata Narayana')) AS LastName;



---In Word 'misissipi' count no.of 'i' 


SELECT 
    LEN('misissipi') - LEN(REPLACE('misissipi', 'i', '')) AS CountOfI;


---Display the last day of next month

SELECT EOMONTH(DATEADD(MONTH, 1, GETDATE())) AS LastDayOfNextMonth;


---Display First Day of Previous Month

SELECT 
    CAST(
        FORMAT(DATEADD(MONTH, -1, GETDATE()), 'yyyy-MM-01') AS DATE
    ) AS FirstDayOfPreviousMonth;




SELECT DATEFROMPARTS(
    YEAR(DATEADD(MONTH, -1, GETDATE())),
    MONTH(DATEADD(MONTH, -1, GETDATE())),
    1
) AS FirstDayOfPreviousMonth;




---Display all Fridays of current month







-- Set DATEFIRST to ensure correct weekday numbering (optional)
SET DATEFIRST 7; -- Sunday = 1, Friday = 6

-- Get all Fridays of the current month
SELECT DATEADD(DAY, number, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)) AS Friday
FROM master.dbo.spt_values
WHERE type = 'P'
  AND number BETWEEN 0 AND DAY(EOMONTH(GETDATE())) - 1
  AND DATEPART(WEEKDAY, DATEADD(DAY, number, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1))) = 6;
