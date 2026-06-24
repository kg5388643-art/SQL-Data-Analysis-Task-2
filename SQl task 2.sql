USE StudentManagement;
CREATE TABLE courses (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO courses VALUES
(101, 'Mathematics'),
(102, 'Science'),
(103, 'English');
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    grade INT,

    FOREIGN KEY (student_id) REFERENCES students(StudentID),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
INSERT INTO enrollments VALUES
(1, 101, 85),
(1, 102, 78),
(2, 101, 92),
(2, 103, 88),
(3, 102, 35),
(3, 103, 45),
(4, 101, 95),
(4, 102, 90),
(5, 103, 38);
-- List of all student enrolled in each courses
SELECT c.name AS Course,
       s.name AS Student,
       e.grade
FROM enrollments e
JOIN students s ON e.student_id = s.StudentID
JOIN courses c ON e.course_id = c.id;
-- Average grade per course
SELECT c.name AS Course,
AVG(e.grade) AS Average_Grade
FROM enrollments e
JOIN courses c
ON e.course_id = c.id
GROUP BY c.name;
-- Top Performer
SELECT s.name,
       AVG(e.grade) AS Average_Grade
FROM students s
JOIN enrollments e
ON s.StudentID = e.student_id
GROUP BY s.StudentID, s.name
ORDER BY Average_Grade DESC
LIMIT 3;
-- Count who failed and grade<40
SELECT COUNT(DISTINCT student_id) AS Failed_Students
FROM enrollments
WHERE grade < 40;