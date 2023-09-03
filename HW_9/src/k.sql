SELECT student.name AS student_name,
		course.name AS course_name,
		college.name AS student_college,
		student_on_course.student_rating
FROM student_on_course
JOIN course ON course.id =student_on_course.course_id
JOIN college ON college.id=course.college_id
JOIN student ON student_on_course.student_id=student.id
WHERE student_on_course.student_rating>50 AND college.size>5000
ORDER BY 1, 2