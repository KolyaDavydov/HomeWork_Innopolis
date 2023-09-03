INSERT INTO course VALUES (
		60,
		'Machine Learning',
		FALSE,
		17,
		(SELECT college.id
			FROM college
			JOIN course ON course.college_id=college.id
			WHERE course.name='Data Mining')
		)
		
		