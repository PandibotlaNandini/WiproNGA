use EmpSample_#OK
Go

---Write a query to Get a List of Employees who have a one part name

SELECT * 
FROM dbo.tblEmployees
WHERE LEN(Name) - LEN(REPLACE(Name, ' ', '')) = 0
Go

---Three part name

SELECT * 
FROM dbo.tblEmployees
WHERE LEN(Name) - LEN(REPLACE(Name, ' ', '')) = 2
Go

----Employees whose First, Middle, or Last name is 'Ram' and only 'Ram'

SELECT * 
FROM  dbo.tblEmployees
WHERE 
    (Name = 'Ram') OR
    (Name LIKE 'Ram %' AND LEN(Name) - LEN(REPLACE(Name, ' ', '')) = 1 AND RIGHT(Name, LEN(Name) - 4) NOT LIKE '% %') OR
    (Name LIKE '% Ram' AND LEN(Name) - LEN(REPLACE(Name, ' ', '')) = 1 AND LEFT(Name, LEN(Name) - 4) NOT LIKE '% %') OR
    (Name LIKE '% Ram %' AND LEN(Name) - LEN(REPLACE(Name, ' ', '')) = 2)
	Go

----Bitwise Operations

-- Bitwise OR
SELECT 65 | 11 AS Result1
Go

-- Bitwise XOR
SELECT 65 ^ 11 AS Result2
Go

-- Bitwise AND
SELECT 65 & 11 AS Result3
Go

-- (12 AND 4) OR (13 AND 1)
SELECT (12 & 4) | (13 & 1) AS Result4
Go

-- 127 OR 64
SELECT 127 | 64 AS Result5
Go

-- 127 XOR 64
SELECT 127 ^ 64 AS Result6
Go

-- 127 XOR 128
SELECT 127 ^ 128 AS Result7
Go

-- 127 AND 64
SELECT 127 & 64 AS Result8
Go

-- 127 AND 128
SELECT 127 & 128 AS Result9
Go

---Return all columns from dbo.tblCentreMaster

SELECT * 
FROM dbo.tblCentreMaster
Go

----Get distinct employee types

SELECT DISTINCT EmployeeType 
FROM dbo.tblEmployees
Go

---Employees' Name, FatherName, DOB with PresentBasic filter

---a. PresentBasic > 3000

SELECT Name, FatherName, DOB 
FROM dbo.tblEmployees
WHERE PresentBasic > 3000
Go

---b. PresentBasic < 3000

SELECT Name, FatherName, DOB 
FROM dbo.tblEmployees 
WHERE PresentBasic < 3000
Go

---c. PresentBasic between 3000 and 5000

SELECT Name, FatherName, DOB 
FROM dbo.tblEmployees  
WHERE PresentBasic BETWEEN 3000 AND 5000
Go

---Employees whose Name...
----a. Ends with 'KHAN'

SELECT * 
FROM dbo.tblEmployees   
WHERE Name LIKE '%KHAN'
Go

---Starts with 'CHANDRA'

SELECT * 
FROM dbo.tblEmployees    
WHERE Name LIKE 'CHANDRA%'
Go

---Is 'RAMESH' with initials between A–T

SELECT * 
FROM dbo.tblEmployees 
WHERE 
    Name LIKE '[A-Ta-t].RAMESH' OR
    Name LIKE '[A-Ta-t]. RAMESH'
Go


