CREATE TABLE DOCTOR_MASTER (
    doctor_id VARCHAR(15) PRIMARY KEY,
    doctor_name VARCHAR(15) NOT NULL,
    dept VARCHAR(15) NOT NULL
)
Go


INSERT INTO DOCTOR_MASTER(doctor_id, doctor_name, dept) 
VALUES
('D0001', 'Ram', 'ENT'),
('D0002', 'Rajan', 'ENT'),
('D0003', 'Smita', 'Eye'),
('D0004', 'Bhavan', 'Surgery'),
('D0005', 'Sheela', 'Surgery'),
('D0006', 'Nethra', 'Surgery');
GO


CREATE TABLE ROOM_MASTER (
    room_no VARCHAR(15) PRIMARY KEY,
    room_type VARCHAR(15) NOT NULL,
    status VARCHAR(15) NOT NULL
)
Go


INSERT INTO ROOM_MASTER(room_no, room_type, status) 
VALUES
('R0001', 'AC', 'occupied'),
('R0002', 'Suite', 'vacant'),
('R0003', 'NonAC', 'vacant'),
('R0004', 'NonAC', 'occupied'),
('R0005', 'AC', 'vacant'),
('R0006', 'AC', 'occupied');
GO


CREATE TABLE PATIENT_MASTER (
    pid VARCHAR(15) PRIMARY KEY,
    name VARCHAR(15) NOT NULL,
    age  INT NOT NULL,
    weight INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phoneno VARCHAR(10) NOT NULL,
    disease VARCHAR(50) NOT NULL,
    doctor_id VARCHAR(15) NOT NULL,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES DOCTOR_MASTER(doctor_id)
)
Go

INSERT INTO PATIENT_MASTER(pid, name, age, weight, gender, address, phoneno, disease, doctor_id) 
VALUES
('P0001', 'Gita', 35, 65, 'F', 'Chennai', '9867145678', 'Eye Infection', 'D0003'),
('P0002', 'Ashish', 40, 70, 'M', 'Delhi', '9845675678', 'Asthma', 'D0003'),
('P0003', 'Radha', 25, 60, 'F', 'Chennai', '9867166678', 'Pain in heart', 'D0005'),
('P0004', 'Chandra', 28, 55, 'F', 'Bangalore', '9978675567', 'Asthma', 'D0001'),
('P0005', 'Goyal', 42, 65, 'M', 'Delhi', '8967533223', 'Pain in Stomach', 'D0004');
GO


CREATE TABLE ROOM_ALLOCATION (
    room_no VARCHAR(15),
    pid VARCHAR(15),
    admission_date DATE NOT NULL,
    release_date DATE,
    CONSTRAINT fk_room FOREIGN KEY (room_no) REFERENCES ROOM_MASTER(room_no),
    CONSTRAINT fk_patient FOREIGN KEY (pid) REFERENCES PATIENT_MASTER(pid)
)
Go


INSERT INTO ROOM_ALLOCATION(room_no, pid, admission_date, release_date) 
VALUES 
('R0001', 'P0001', '2016-10-15', '2016-10-26'),
('R0002', 'P0002', '2016-11-15', '2016-11-26'),
('R0002', 'P0003', '2016-12-01', '2016-12-30'),
('R0004', 'P0001', '2017-01-01', '2017-01-30');
GO


---QUERIES

----1

SELECT * 
FROM ROOM_ALLOCATION
WHERE DATENAME(MONTH, admission_date) = 'January';
Go


---2

SELECT * 
FROM PATIENT_MASTER
WHERE gender = 'F' AND LOWER(disease) != 'asthma'
Go


---3

SELECT gender, COUNT(*) AS count 
FROM PATIENT_MASTER
GROUP BY gender
Go
---4
SELECT 
    P.pid AS patient_id,
    P.name AS patient_name,
    D.doctor_id,
    D.doctor_name,
    R.room_no,
    RM.room_type,
    R.admission_date
FROM PATIENT_MASTER P
JOIN DOCTOR_MASTER D ON P.doctorid = D.doctor_id
JOIN ROOM_ALLOCATION R ON P.pid = R.pid
JOIN ROOM_MASTER RM ON R.room_no = RM.room_no;







---5

SELECT room_no 
FROM ROOM_MASTER
WHERE room_no NOT IN (SELECT DISTINCT room_no FROM ROOM_ALLOCATION);
Go


---6

SELECT 
    room_no,
    (SELECT room_type FROM ROOM_MASTER WHERE ROOM_MASTER.room_no = RA.room_no) AS room_type
FROM ROOM_ALLOCATION RA
GROUP BY room_no
HAVING COUNT(*) > 1
Go
