-- Создаем две таблицы
CREATE TABLE students (
	id serial PRIMARY KEY,
	name TEXT,
	total_score integer
);

CREATE TABLE activity_scores (
	student_id integer,
	activity_type TEXT,
	score integer,
	
	FOREIGN KEY (student_id) REFERENCES students (id)
);

-- заполняем таблицы данными
INSERT INTO students (id, name) VALUES
		(1, 'Василий'),
		(2, 'Иван'),
		(3, 'Константин'),
		(4, 'Егор');
	
INSERT INTO activity_scores (student_id, activity_type, score) VALUES
		(1, 'Homework', 100),
		(1, 'Exam', 69),
		(2, 'Homework', 90),
		(2, 'Exam', 92),
		(3, 'Homework', 80),
		(3, 'Exam', 72),
		(4, 'Homework', 60),
		(4, 'Exam', 80);

-- создаем таблицу 'stipendia' и заполняем пока '0'
CREATE TABLE stipendia (
	student_id integer PRIMARY KEY REFERENCES students (id),
	stipuxa integer
);
INSERT INTO stipendia (SELECT id, 0 FROM students);

--	вспомогательная функция для подсчета общего бала студентов
CREATE OR REPLACE FUNCTION fn_total (id_student integer)
RETURNS SETOF NUMERIC
AS $$
	SELECT avg(score) FROM activity_scores
	WHERE student_id = id_student
	GROUP BY student_id
$$ LANGUAGE SQL;

-- Заполняем значение столбца 'total_score' в таблице students
UPDATE students SET total_score = (SELECT fn_total(id));

-- вспомогательная функция для расчета стипендии
CREATE OR REPLACE FUNCTION fn_stippendia (id_student integer)
RETURNS SETOF NUMERIC
AS $$
	SELECT (CASE
			WHEN total_score >= 90 THEN 1000
			WHEN total_score >= 80 AND total_score  < 90 THEN 500
			ELSE 0
			END) FROM students
	WHERE id = id_student
	GROUP BY id
$$ LANGUAGE SQL;
-- добавляем значение стипендии в таблицу 'stipendia'
UPDATE stipendia SET stipuxa = (SELECT fn_stippendia(student_id));


-- тригеррная функции которая обновляет значение общего балла и стиппендии после добавления  значений в тбалицу 'activity_scores'
CREATE OR REPLACE FUNCTION calculate_scholarship ()
RETURNS TRIGGER 
AS $update_scholarship_trigger$
	BEGIN
		UPDATE students SET total_score = (SELECT fn_total(id));	
		UPDATE stipendia SET stipuxa = (SELECT fn_stippendia(student_id));
		RETURN NULL;
	END;
$update_scholarship_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER update_scholarship_trigger
AFTER INSERT ON activity_scores
FOR EACH ROW EXECUTE FUNCTION calculate_scholarship();

-- для проверки:
-- select * from stipendia;

-- INSERT INTO activity_scores (student_id, activity_type, score) VALUES
--     (1, 'Exam', 100);
 
-- SELECT * FROM stipendia;



