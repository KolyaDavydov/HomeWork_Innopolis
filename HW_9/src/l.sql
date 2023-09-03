WITH tmp AS (
	SELECT student.name, student.city 
	FROM student
)
SELECT s1.name AS student_1, s2.name AS student_2, s1.city
FROM tmp AS s1
JOIN tmp AS s2 ON s2.city=s1.city
WHERE NOT s1.name=s2.name AND s1.name > s2.name