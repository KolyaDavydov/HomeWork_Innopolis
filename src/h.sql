SELECT name, amount_of_students
FROM course
WHERE amount_of_students = 300
UNION ALL 
(SELECT name, amount_of_students
FROM course
WHERE amount_of_students NOT IN (300)
ORDER BY amount_of_students)
LIMIT 3
