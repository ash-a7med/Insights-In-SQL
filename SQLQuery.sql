-- 1. Create the following tables:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    EnrollmentDate DATE,
    Email VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    Department VARCHAR(50)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    Grade CHAR(2),
    Semester VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- --------------------------------------------------

-- 2. Insert the following data into the Students table:
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth, EnrollmentDate, Email)
VALUES
(1, 'John', 'Doe', '2000-01-01', '2018-09-01', 'john.doe@example.com'),
(2, 'Jane', 'Smith', '1999-05-15', '2017-09-01', 'jane.smith@example.com'),
(3, 'Robert', 'Brown', '2001-11-21', '2019-09-01', 'robert.brown@example.com'),
(4, 'Emily', 'Jones', '2002-03-03', '2020-09-01', 'emily.jones@example.com'),
(5, 'Michael', 'Davis', '1998-07-22', '2016-09-01', 'michael.davis@example.com');

-- --------------------------------------------------

-- 3. Insert the following data into the Courses table:
INSERT INTO Courses (CourseID, CourseName, Credits, Department)
VALUES
(1, 'Introduction to SQL', 3, 'Computer Science'),
(2, 'Data Structures', 4, 'Computer Science'),
(3, 'Database Management Systems', 3, 'Information Technology');

-- --------------------------------------------------

-- 4. Insert the following data into the Enrollments table:
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, Grade, Semester)
VALUES
(1, 1, 2, 'A', 'Fall2020'),
(2, 2, 3, 'B+', 'Spring2021'),
(3, 3, 2, 'A-', 'Fall2021'),
(4, 4, 3, 'B', 'Spring2022'),
(5, 2, 2, 'A', 'Fall2020');

-- --------------------------------------------------

-- 5. Update the Email of the student with StudentID 1 to john.doe@newmail.com.
UPDATE Students
SET Email = 'john.doe@newmail.com'
WHERE StudentID = 1;

-- --------------------------------------------------

-- 6. Delete the student record with StudentID 5.
DELETE FROM Students
WHERE StudentID = 5;

-- --------------------------------------------------

-- 7. Select all records from the Students table.
SELECT * FROM Students;

-- --------------------------------------------------

-- 8. Select the FirstName and LastName of all students who enrolled after '2018-01-01'.
SELECT FirstName, LastName
FROM Students
WHERE EnrollmentDate > '2018-01-01';

-- --------------------------------------------------

-- 9. Count the number of students in the Students table.
SELECT COUNT(*) FROM Students;

-- --------------------------------------------------

-- 10. Select all records from the Courses table.
SELECT * FROM Courses;

-- --------------------------------------------------

-- 11. Select the CourseName and Credits for courses in the 'Computer Science' department.
SELECT CourseName, Credits
FROM Courses
WHERE Department = 'Computer Science';

-- --------------------------------------------------

-- 12. Find the total number of credits offered by the 'Information Technology' department.
SELECT SUM(Credits)
FROM Courses
WHERE Department = 'Information Technology';

-- --------------------------------------------------

-- 13. List each student’s FirstName, LastName, and the names of the courses they are enrolled in.
SELECT Students.FirstName, Students.LastName, Courses.CourseName
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- --------------------------------------------------

-- 14. Find the names of courses that have more than one student enrolled. List the CourseName and the number of students.
SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS StudentCount
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Courses.CourseName
HAVING COUNT(Enrollments.StudentID) > 1;

-- --------------------------------------------------

-- 15. Select all students and order them by their EnrollmentDate in descending order.
SELECT * FROM Students
ORDER BY EnrollmentDate DESC;

-- --------------------------------------------------

-- 16. List the FirstName and LastName of students who are not enrolled in any courses.
SELECT FirstName, LastName
FROM Students
WHERE StudentID NOT IN (SELECT StudentID FROM Enrollments);

-- --------------------------------------------------

-- 17. Find the average number of credits for each department. List the Department and the average credits.
SELECT Department, AVG(Credits) AS AvgCredits
FROM Courses
GROUP BY Department;

-- --------------------------------------------------

-- 18. List the FirstName, LastName, CourseName, and Grade of students enrolled in courses for the 'Fall2020' semester.
SELECT Students.FirstName, Students.LastName, Courses.CourseName, Enrollments.Grade
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Enrollments.Semester = 'Fall2020';

-- --------------------------------------------------

-- 19. List the CourseName and the number of students enrolled in each course.
SELECT Courses.CourseName, COUNT(Enrollments.StudentID) AS StudentCount
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Courses.CourseName;

-- --------------------------------------------------

-- 20. Find the FirstName, LastName, CourseName, and Grade of students who received a grade lower than 'B'.
SELECT Students.FirstName, Students.LastName, Courses.CourseName, Enrollments.Grade
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Enrollments.Grade < 'B';

-- --------------------------------------------------

-- 21. List each StudentID, FirstName, LastName, and the total number of enrollments.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 22. List the CourseName of courses that have no enrollments.
SELECT CourseName
FROM Courses
WHERE CourseID NOT IN (SELECT CourseID FROM Enrollments);

-- --------------------------------------------------

-- 23. List the top 3 students with the highest number of course enrollments. Include StudentID, FirstName, LastName, and TotalEnrollments.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName
ORDER BY TotalEnrollments DESC
LIMIT 3;

-- --------------------------------------------------

-- 24. List each student's FirstName, LastName, and their average grade points. Use CASE WHEN to convert grades to grade points.
SELECT Students.FirstName, Students.LastName,
AVG(
    CASE 
        WHEN Enrollments.Grade = 'A' THEN 4.0
        WHEN Enrollments.Grade = 'A-' THEN 3.7
        WHEN Enrollments.Grade = 'B+' THEN 3.3
        WHEN Enrollments.Grade = 'B' THEN 3.0
        WHEN Enrollments.Grade = 'B-' THEN 2.7
        WHEN Enrollments.Grade = 'C+' THEN 2.3
        WHEN Enrollments.Grade = 'C' THEN 2.0
        ELSE 0.0
    END
) AS AvgGradePoints
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 25. List the number of students born in each month. Include the month and the number of students.
SELECT MONTH(DateOfBirth) AS BirthMonth, COUNT(StudentID) AS NumberOfStudents
FROM Students
GROUP BY MONTH(DateOfBirth);

-- --------------------------------------------------

-- 26. List the CourseName and Department of courses that had enrollments in 'Spring2021'.
SELECT DISTINCT Courses.CourseName, Courses.Department
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Enrollments.Semester = 'Spring2021';

-- --------------------------------------------------

-- 27. For each student, list their StudentID, FirstName, LastName, and the date of their last enrollment.
SELECT Students.StudentID, Students.FirstName, Students.LastName, MAX(Enrollments.Semester) AS LastEnrollment
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 28. Find the names of students who have enrolled in 'Data Structures' (CourseID 2).
SELECT Students.FirstName, Students.LastName
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
WHERE Enrollments.CourseID = 2;

-- --------------------------------------------------

-- 29. List all students along with the total number of courses they are enrolled in.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.CourseID) AS TotalCourses
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 30. Find the average grade of students enrolled in 'Database Management Systems' (CourseID 3) for the 'Spring2021' semester using a CASE WHEN statement to convert grades to grade points.
SELECT AVG(
    CASE 
        WHEN Enrollments.Grade = 'A' THEN 4.0
        WHEN Enrollments.Grade = 'A-' THEN 3.7
        WHEN Enrollments.Grade = 'B+' THEN 3.3
        WHEN Enrollments.Grade = 'B' THEN 3.0
        WHEN Enrollments.Grade = 'B-' THEN 2.7
        WHEN Enrollments.Grade = 'C+' THEN 2.3
        WHEN Enrollments.Grade = 'C' THEN 2.0
        ELSE 0.0
    END
) AS AvgGradePoints
FROM Enrollments
WHERE CourseID = 3 AND Semester = 'Spring2021';

-- --------------------------------------------------

-- 31. List all students with their enrolled courses and grades. Include StudentID, FirstName, LastName, CourseName, and Grade.
SELECT Students.StudentID, Students.FirstName, Students.LastName, Courses.CourseName, Enrollments.Grade
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

-- --------------------------------------------------

-- 32. Find the total number of enrollments for each student. List the StudentID, FirstName, LastName, and TotalEnrollments.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.EnrollmentID) AS TotalEnrollments
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 33. Find the minimum, maximum, and average grade for each course. List the CourseID, CourseName, MinGrade, MaxGrade, and AvgGrade.
SELECT Enrollments.CourseID, Courses.CourseName, 
MIN(Enrollments.Grade) AS MinGrade, 
MAX(Enrollments.Grade) AS MaxGrade, 
AVG(
    CASE 
        WHEN Enrollments.Grade = 'A' THEN 4.0
        WHEN Enrollments.Grade = 'A-' THEN 3.7
        WHEN Enrollments.Grade = 'B+' THEN 3.3
        WHEN Enrollments.Grade = 'B' THEN 3.0
        WHEN Enrollments.Grade = 'B-' THEN 2.7
        WHEN Enrollments.Grade = 'C+' THEN 2.3
        WHEN Enrollments.Grade = 'C' THEN 2.0
        ELSE 0.0
    END
) AS AvgGradePoints
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Enrollments.CourseID, Courses.CourseName;

-- --------------------------------------------------

-- 34. Find the total number of credits each student is enrolled in. List the StudentID, FirstName, LastName, and TotalCredits.
SELECT Students.StudentID, Students.FirstName, Students.LastName, SUM(Courses.Credits) AS TotalCredits
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 35. Find the number of students enrolled in each course for the 'Spring2021' semester. List the CourseID, CourseName, and StudentCount.
SELECT Enrollments.CourseID, Courses.CourseName, COUNT(Enrollments.StudentID) AS StudentCount
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Enrollments.Semester = 'Spring2021'
GROUP BY Enrollments.CourseID, Courses.CourseName;

-- --------------------------------------------------

-- 36. Find the total grades for students in each department. List the Department, TotalGrades.
SELECT Courses.Department, SUM(
    CASE 
        WHEN Enrollments.Grade = 'A' THEN 4.0
        WHEN Enrollments.Grade = 'A-' THEN 3.7
        WHEN Enrollments.Grade = 'B+' THEN 3.3
        WHEN Enrollments.Grade = 'B' THEN 3.0
        WHEN Enrollments.Grade = 'B-' THEN 2.7
        WHEN Enrollments.Grade = 'C+' THEN 2.3
        WHEN Enrollments.Grade = 'C' THEN 2.0
        ELSE 0.0
    END
) AS TotalGrades
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Courses.Department;

-- --------------------------------------------------

-- 37. Find the highest and lowest grade received by students in each course. List the CourseID, CourseName, HighestGrade, LowestGrade.
SELECT Enrollments.CourseID, Courses.CourseName, 
MAX(Enrollments.Grade) AS HighestGrade, 
MIN(Enrollments.Grade) AS LowestGrade
FROM Enrollments
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Enrollments.CourseID, Courses.CourseName;

-- --------------------------------------------------

-- 38. Calculate the average age of students enrolled in each course. List the CourseID, CourseName, and AverageAge.
SELECT Enrollments.CourseID, Courses.CourseName, AVG(DATEDIFF(YEAR, Students.DateOfBirth, GETDATE())) AS AverageAge
FROM Enrollments
JOIN Students ON Enrollments.StudentID = Students.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
GROUP BY Enrollments.CourseID, Courses.CourseName;

-- --------------------------------------------------

-- 39. List the number of courses each student is enrolled in for the 'Fall2020' semester. Include StudentID, FirstName, LastName, and CourseCount.
SELECT Students.StudentID, Students.FirstName, Students.LastName, COUNT(Enrollments.CourseID) AS CourseCount
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
WHERE Enrollments.Semester = 'Fall2020'
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;

-- --------------------------------------------------

-- 40. Find the average credits per student enrolled in 'Information Technology' courses. List StudentID, FirstName, LastName, and AvgCredits.
SELECT Students.StudentID, Students.FirstName, Students.LastName, AVG(Courses.Credits) AS AvgCredits
FROM Students
JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID
WHERE Courses.Department = 'Information Technology'
GROUP BY Students.StudentID, Students.FirstName, Students.LastName;
