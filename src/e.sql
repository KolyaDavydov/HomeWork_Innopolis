SELECT course.name AS "Название онлайн курса",
	college.name AS "университет", course.amount_of_students AS "количество слушателей"
FROM course
JOIN college ON college.id=course.college_id
WHERE (course.amount_of_students  BETWEEN 27 AND 310) AND course.is_online IS TRUE
ORDER BY 1 DESC, 3 DESC
