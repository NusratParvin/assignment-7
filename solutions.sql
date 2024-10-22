-- Active: 1729093794512@@127.0.0.1@5432@university_db


--Create a "courses" table with the following fields:
 
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL
);
 
--Create a "students" table with the following fields:
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    email VARCHAR(100) NOT NULL,
    frontend_mark INT NOT NULL,
    backend_mark INT NOT NULL,
    status VARCHAR(50) 
);

-- drop table students,enrollments;
-- drop table courses;

--Create an "enrollment" table with the following fields:
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id) ON DELETE CASCADE,
    course_id INT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE
);


 --Data insertion
 

 INSERT INTO courses ( course_name, credits)
VALUES
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

select * from  courses;

INSERT INTO students ( student_name, age, email, frontend_mark, backend_mark, status)
VALUES
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

select * from students;
INSERT INTO enrollments ( student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 2);

select * from enrollments;


--Query 1
-- Insert a new student record 

INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Nusrat', 34, 'nusrat@mail.com', 77, 77, NULL);


select * from students



--Query 2
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.

SELECT student_name  FROM students s 
JOIN enrollments e ON s.student_id = e.student_id 
JOIN courses c ON e.course_id = c.course_id where course_name='Next.js';


--Query 3
--- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.

UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);


 -- Query 4
 --Delete all courses that have no students enrolled.

-- select c.course_id from courses c left join enrollments e ON c.course_id=e.course_id where e.course_id IS NULL;

DELETE FROM courses
WHERE course_id IN (
    SELECT c.course_id
    FROM courses c
    LEFT JOIN enrollments e ON c.course_id = e.course_id
    WHERE e.course_id IS NULL
);

select * from courses


-- Query 5 
--Retrieve the names of students using a limit of 2, starting from the 3rd student.

select student_name from students LIMIT 2 OFFSET 2;


--Query 6:
--Retrieve the course names and the number of students enrolled in each course.

select course_name, count(*) from students s 
JOIN enrollments e ON s.student_id= e.student_id
JOIN courses c ON e.course_id=c.course_id
 GROUP BY course_name

 

 -- Query 7
-- Calculate and display the average age of all students.

select ROUND( AVG(age),2) as avg_age from students 

 

 --Query 8
 -- Retrieve the names of students whose email addresses contain 'example.com'.

 select student_name from students where email LIKE '%@example.com'