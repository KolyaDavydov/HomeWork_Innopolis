SELECT name, concat('университет') AS object_type
FROM college
UNION
SELECT name, concat('курс') AS object_type
FROM course
ORDER BY 2 desc, 1