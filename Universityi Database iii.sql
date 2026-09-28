create database universityi;
use universityi;

CREATE TABLE Fact_Academic_Performancei (
    Performance_ID INT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Semester_ID INT,
    Marks INT,
    Grade_Point DECIMAL(3,2),
    Result_Status VARCHAR(10),

    FOREIGN KEY (Student_ID) REFERENCES Dim_Student(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Dim_Course(Course_ID),
    FOREIGN KEY (Semester_ID) REFERENCES Dim_Semester(Semester_ID)
);

CREATE TABLE Dim_College (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(100),
    University_Name VARCHAR(100)
);

CREATE TABLE Dim_Department (
    Department_ID INT PRIMARY KEY,
    Department_Name VARCHAR(100),
    College_ID INT,
    FOREIGN KEY (College_ID) REFERENCES Dim_College(College_ID)
);

CREATE TABLE Dim_Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Gender VARCHAR(10),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Dim_Department(Department_ID)
);

CREATE TABLE Dim_Subject (
    Subject_ID INT PRIMARY KEY,
    Subject_Name VARCHAR(100),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES Dim_Department(Department_ID)
);

CREATE TABLE Dim_Course (
    Course_ID INT PRIMARY KEY,
    Course_Name VARCHAR(100),
    Subject_ID INT,
    FOREIGN KEY (Subject_ID) REFERENCES Dim_Subject(Subject_ID)
);

CREATE TABLE Dim_Semester (
    Semester_ID INT PRIMARY KEY,
    Semester_Name VARCHAR(50),
    Academic_Year VARCHAR(20)
);

INSERT INTO Dim_College
(College_ID, College_Name, University_Name)
VALUES
(301, 'College of Science', 'ABC University'),
(302, 'College of Commerce', 'ABC University'),
(303, 'College of Arts', 'ABC University'),
(304, 'College of Engineering', 'ABC University'),
(305, 'College of Management', 'ABC University');

INSERT INTO Dim_Department
(Department_ID, Department_Name, College_ID)
VALUES
(201, 'Computer Science', 301),
(202, 'Commerce', 302),
(203, 'Mathematics', 301),
(204, 'English', 303),
(205, 'Management Studies', 305);

INSERT INTO Dim_Student
(Student_ID, Student_Name, Gender, Department_ID)
VALUES
(101, 'Arun', 'Male', 201),
(102, 'Priya', 'Female', 202),
(103, 'Rahul', 'Male', 201),
(104, 'Divya', 'Female', 203),
(105, 'John', 'Male', 204);

INSERT INTO Dim_Subject
(Subject_ID, Subject_Name, Department_ID)
VALUES
(501, 'Programming', 201),
(502, 'Database Management', 201),
(503, 'Financial Accounting', 202),
(504, 'Statistics', 203),
(505, 'English Literature', 204);

INSERT INTO Dim_Course
(Course_ID, Course_Name, Subject_ID)
VALUES
(401, 'Python Programming', 501),
(402, 'SQL and Database', 502),
(403, 'Financial Accounting', 503),
(404, 'Business Statistics', 504),
(405, 'British Literature', 505);

INSERT INTO Dim_Semester
(Semester_ID, Semester_Name, Academic_Year)
VALUES
(601, 'Semester 1', '2025-26'),
(602, 'Semester 2', '2025-26'),
(603, 'Semester 3', '2026-27'),
(604, 'Semester 4', '2026-27'),
(605, 'Semester 5', '2027-28');

INSERT INTO Fact_Academic_Performancei
(Performance_ID, Student_ID, Course_ID, Semester_ID,
 Marks, Grade_Point, Result_Status)
VALUES
(1001, 101, 401, 601, 85, 9.00, 'Pass'),
(1002, 102, 403, 601, 78, 8.00, 'Pass'),
(1003, 103, 402, 602, 92, 10.00, 'Pass'),
(1004, 104, 404, 602, 68, 7.00, 'Pass'),
(1005, 105, 405, 603, 55, 6.00, 'Pass');

select * from dim_semester;
select * from dim_course;
select * from dim_department;
select * from dim_student;
select * from dim_subject;
select * from dim_college;

-- student marks 
SELECT
    s.Student_Name,
    c.Course_Name,
    f.Marks,
    f.Grade_Point,
    f.Result_Status
FROM Fact_Academic_Performancei f
JOIN Dim_Student s
    ON f.Student_ID = s.Student_ID
JOIN Dim_Course c
    ON f.Course_ID = c.Course_ID;
    
-- average marks of students in each department
SELECT
    d.Department_Name,
    AVG(f.Marks) AS Average_Marks
FROM Fact_Academic_Performance f
JOIN Dim_Student s
    ON f.Student_ID = s.Student_ID
JOIN Dim_Department d
    ON s.Department_ID = d.Department_ID
GROUP BY d.Department_Name;