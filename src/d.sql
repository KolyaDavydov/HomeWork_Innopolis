SELECT name AS "университет", SIZE AS "количество студентов"
FROM college
WHERE college.id NOT IN (10, 30, 50)
ORDER BY 2, 1