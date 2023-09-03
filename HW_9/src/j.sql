(SELECT id FROM course
EXCEPT ALL 
SELECT id FROM student_on_course)
UNION 
(SELECT id FROM student_on_course
EXCEPT
SELECT id FROM course)
ORDER BY 1
		