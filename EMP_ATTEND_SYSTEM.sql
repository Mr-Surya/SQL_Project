-- Step 1: Create Database and Use it
CREATE DATABASE EmployeeAttendanceSystem1;
USE EmployeeAttendanceSystem1;

-- Step 2: Create Tables
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    HireDate DATE NOT NULL,
    Status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Attendance (
    AttendanceID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    AttendanceDate DATE NOT NULL,
    CheckInTime TIME,
    CheckOutTime TIME,
    Status ENUM('Present', 'Absent', 'Leave') NOT NULL DEFAULT 'Absent',
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    UNIQUE (EmployeeID, AttendanceDate)
);

-- Step 3: Insert Data
INSERT INTO Departments (DepartmentName)
VALUES ('HR'), ('IT'), ('Finance'), ('Marketing');

INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate)
VALUES 
('John', 'Doe', 1, '2020-01-10'),
('Jane', 'Smith', 2, '2021-03-15'),
('Alice', 'Johnson', 3, '2019-08-20'),
('Bob', 'Brown', 4, '2020-05-23'),
('Mary', 'Davis', 1, '2022-07-01'),
('Chris', 'Miller', 2, '2021-09-12'),
('Linda', 'Wilson', 3, '2019-12-30'),
('James', 'Moore', 4, '2020-02-10'),
('Sophia', 'Taylor', 1, '2021-10-15'),
('Michael', 'Anderson', 2, '2020-11-20'),
('David', 'Thomas', 3, '2019-04-14'),
('Emma', 'Jackson', 4, '2021-06-23'),
('Oliver', 'White', 1, '2022-01-10'),
('Lucas', 'Harris', 2, '2022-05-14'),
('Mia', 'Clark', 3, '2021-07-03'),
('Ethan', 'Lewis', 4, '2020-08-27'),
('Ava', 'Young', 1, '2021-12-07'),
('Amelia', 'Walker', 2, '2022-02-25'),
('Benjamin', 'Allen', 3, '2020-09-01'),
('Charlotte', 'King', 4, '2022-04-09'),
('Harper', 'Scott', 1, '2019-06-18'),
('Liam', 'Adams', 2, '2021-08-05'),
('Ella', 'Baker', 3, '2021-10-02'),
('Jack', 'Gonzalez', 4, '2020-04-22'),
('Archer', 'Nelson', 1, '2022-03-11'),
('Grace', 'Carter', 2, '2020-12-19'),
('Sebastian', 'Mitchell', 3, '2019-02-13'),
('Zoe', 'Perez', 4, '2022-01-28'),
('Harvey', 'Roberts', 1, '2021-11-15'),
('Chloe', 'Evans', 2, '2021-01-22');

-- Step 4: Insert Attendance Data
INSERT INTO Attendance (EmployeeID, AttendanceDate, CheckInTime, CheckOutTime, Status)
VALUES 
(1, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(2, '2025-01-01', NULL, NULL, 'Absent'),
(3, '2025-01-01', '09:15:00', '17:30:00', 'Present'),
(4, '2025-01-01', '09:05:00', '17:10:00', 'Present'),
(5, '2025-01-01', '09:30:00', '17:30:00', 'Present'),
(6, '2025-01-01', NULL, NULL, 'Absent'),
(7, '2025-01-01', '09:10:00', '17:20:00', 'Present'),
(8, '2025-01-01', NULL, NULL, 'Absent'),
(9, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(10, '2025-01-01', '09:05:00', '17:00:00', 'Present'),
(11, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(12, '2025-01-01', '09:00:00', '17:05:00', 'Present'),
(13, '2025-01-01', '09:15:00', '17:15:00', 'Present'),
(14, '2025-01-01', '09:10:00', '17:20:00', 'Present'),
(15, '2025-01-01', NULL, NULL, 'Absent'),
(16, '2025-01-01', '09:00:00', '17:30:00', 'Present'),
(17, '2025-01-01', NULL, NULL, 'Absent'),
(18, '2025-01-01', '09:10:00', '17:30:00', 'Present'),
(19, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(20, '2025-01-01', '09:30:00', '17:30:00', 'Present'),
(21, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(22, '2025-01-01', NULL, NULL, 'Absent'),
(23, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(24, '2025-01-01', '09:15:00', '17:10:00', 'Present'),
(25, '2025-01-01', '09:05:00', '17:05:00', 'Present'),
(26, '2025-01-01', '09:10:00', '17:20:00', 'Present'),
(27, '2025-01-01', '09:00:00', '17:30:00', 'Present'),
(28, '2025-01-01', '09:00:00', '17:00:00', 'Present'),
(29, '2025-01-01', '09:05:00', '17:00:00', 'Present'),
(30, '2025-01-01', '09:10:00', '17:00:00', 'Present');

-- Step 5: Additional Scenario Queries

-- 1. Retrieve Employees Who Are Currently Active
SELECT * 
FROM Employees 
WHERE Status = 'Active';

-- 2. Find Employees Who Have Taken Leave on a Specific Date
SELECT 
    E.FirstName,
    E.LastName,
    A.AttendanceDate,
    A.Status
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
WHERE A.Status = 'Leave' AND A.AttendanceDate = '2025-01-04';

-- 3. Check Which Employees Have Never Been Absent
SELECT 
    E.FirstName,
    E.LastName
FROM Employees E
LEFT JOIN Attendance A ON E.EmployeeID = A.EmployeeID
GROUP BY E.EmployeeID
HAVING COUNT(CASE WHEN A.Status = 'Absent' THEN 1 END) = 0;

-- 4. Get Department-Wise Attendance Summary for a Specific Month
SELECT 
    D.DepartmentName,
    COUNT(CASE WHEN A.Status = 'Present' THEN 1 END) AS TotalPresent,
    COUNT(CASE WHEN A.Status = 'Absent' THEN 1 END) AS TotalAbsent,
    COUNT(CASE WHEN A.Status = 'Leave' THEN 1 END) AS TotalLeave
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
JOIN Departments D ON E.DepartmentID = D.DepartmentID
WHERE MONTH(A.AttendanceDate) = 1 AND YEAR(A.AttendanceDate) = 2025
GROUP BY D.DepartmentName;

-- 5. Find Employees with Late Check-In Times (e.g., After 9:00 AM)
SELECT 
    E.FirstName,
    E.LastName,
    A.AttendanceDate,
    A.CheckInTime
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
WHERE A.CheckInTime > '09:00:00';

-- 6. Get the Average Attendance Time of All Employees
SELECT 
    AVG(TIMESTAMPDIFF(HOUR, A.CheckInTime, A.CheckOutTime)) AS AverageHoursWorked
FROM Attendance A
WHERE MONTH(A.AttendanceDate) = 1 AND YEAR(A.AttendanceDate) = 2025;

-- 7. Retrieve Employees with Missing Check-Out Time
SELECT 
    E.FirstName,
    E.LastName,
    A.AttendanceDate
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
WHERE A.CheckOutTime IS NULL;

-- 8. Identify Employees Who Have Worked Overtime (More Than 8 Hours in a Day)
SELECT 
    E.FirstName,
    E.LastName,
    A.AttendanceDate,
    TIMESTAMPDIFF(HOUR, A.CheckInTime, A.CheckOutTime) AS HoursWorked
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
WHERE TIMESTAMPDIFF(HOUR, A.CheckInTime, A.CheckOutTime) > 8;

-- 9. Retrieve Attendance for Employees Who Have Worked All Days in a Month
SELECT 
    E.FirstName,
    E.LastName
FROM Employees E
JOIN Attendance A ON E.EmployeeID = A.EmployeeID
WHERE MONTH(A.AttendanceDate) = 1 AND YEAR(A.AttendanceDate) = 2025
GROUP BY E.EmployeeID
HAVING COUNT(CASE WHEN A.Status = 'Present' THEN 1 END) = DAY(LAST_DAY('2025-01-01'));

-- 10. Find the Employee with the Most Absences in a Month
SELECT 
    E.FirstName,
    E.LastName,
    COUNT(*) AS TotalAbsences
FROM Attendance A
JOIN Employees E ON A.EmployeeID = E.EmployeeID
WHERE A.Status = 'Absent' AND MONTH(A.AttendanceDate) = 1 AND YEAR(A.AttendanceDate) = 2025
GROUP BY E.EmployeeID
ORDER BY TotalAbsences DESC
LIMIT 1;
