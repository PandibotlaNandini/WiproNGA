CREATE TABLE Student1 (
    StudentNo INT PRIMARY KEY,
    StudentName VARCHAR(100),
    City VARCHAR(100),
    Gender VARCHAR(10)
);

CREATE TABLE Course (
    Ccode VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100),
    Duration VARCHAR(50),
    Fee DECIMAL(10,2)
);

CREATE TABLE Faculty (
    FacultyCode VARCHAR(10) PRIMARY KEY,
    FacultyName VARCHAR(100),
    Qualification VARCHAR(100)
);

CREATE TABLE Batch (
    BatchCode VARCHAR(10) PRIMARY KEY,
    BatchName VARCHAR(50),
    StartDate DATE,
    EndDate DATE,
    Timing VARCHAR(50)
);

CREATE TABLE CourseEnrollment (
    StudentNo INT,
    Ccode VARCHAR(10),
    BatchCode VARCHAR(10),
    FacultyCode VARCHAR(10),
    PRIMARY KEY(StudentNo, Ccode, BatchCode),
    FOREIGN KEY (StudentNo) REFERENCES Student1(StudentNo),
    FOREIGN KEY (Ccode) REFERENCES Course(Ccode),
    FOREIGN KEY (BatchCode) REFERENCES Batch(BatchCode),
    FOREIGN KEY (FacultyCode) REFERENCES Faculty(FacultyCode)
);

CREATE TABLE Payment (
    PaymentId INT PRIMARY KEY,
    PaymentDate DATE,
    StudentNo INT,
    Ccode VARCHAR(10),
    BatchCode VARCHAR(10),
    FOREIGN KEY (StudentNo, Ccode, BatchCode) REFERENCES CourseEnrollment(StudentNo, Ccode, BatchCode)
);


-- Student
INSERT INTO Student1 VALUES (1, 'Nandini', 'Anantapur', 'Female');
INSERT INTO Student1 VALUES (2, 'Uday', 'Bangalore', 'Male');

-- Course
INSERT INTO Course VALUES ('C101', 'Python Programming', '2 months', 5000);
INSERT INTO Course VALUES ('C102', 'Data Science', '3 months', 8000);

-- Faculty
INSERT INTO Faculty VALUES ('F01', 'Mr. Kumar', 'M.Tech');
INSERT INTO Faculty VALUES ('F02', 'Ms. Anjali', 'PhD');

-- Batch
INSERT INTO Batch VALUES ('B01', 'Batch A', '2025-08-01', '2025-10-01', 'Morning');
INSERT INTO Batch VALUES ('B02', 'Batch B', '2025-09-01', '2025-12-01', 'Evening');

-- Course Enrollment
INSERT INTO CourseEnrollment VALUES (1, 'C101', 'B01', 'F01');
INSERT INTO CourseEnrollment VALUES (2, 'C102', 'B02', 'F02');

-- Payment
INSERT INTO Payment VALUES (101, '2025-08-01', 1, 'C101', 'B01');
INSERT INTO Payment VALUES (102, '2025-09-01', 2, 'C102', 'B02');


SELECT S.StudentName, C.CourseName, F.FacultyName, B.BatchName
FROM Student1 S
JOIN CourseEnrollment CE ON S.StudentNo = CE.StudentNo
JOIN Course C ON CE.Ccode = C.Ccode
JOIN Faculty F ON CE.FacultyCode = F.FacultyCode
JOIN Batch B ON CE.BatchCode = B.BatchCode;


SELECT P.PaymentId, P.PaymentDate, S.StudentName, C.CourseName, B.BatchName
FROM Payment P
JOIN Student1 S ON P.StudentNo = S.StudentNo
JOIN Course C ON P.Ccode = C.Ccode
JOIN Batch B ON P.BatchCode = B.BatchCode;


SELECT S.StudentName
FROM Student1 S
JOIN CourseEnrollment CE ON S.StudentNo = CE.StudentNo
JOIN Course C ON CE.Ccode = C.Ccode
WHERE C.CourseName = 'Data Science';


SELECT C.CourseName, COUNT(P.PaymentId) AS NumPayments, C.Fee * COUNT(P.PaymentId) AS TotalCollected
FROM Course C
JOIN Payment P ON C.Ccode = P.Ccode
GROUP BY C.CourseName, C.Fee;


SELECT F.FacultyName, B.BatchName
FROM Faculty F
JOIN CourseEnrollment CE ON F.FacultyCode = CE.FacultyCode
JOIN Batch B ON CE.BatchCode = B.BatchCode
GROUP BY F.FacultyName, B.BatchName;
