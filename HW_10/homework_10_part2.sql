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


-- тригеррная функции которая обновляет значение 'total_score' после добавления  значений в тбалицу 'activity_scores' посредством цикла
CREATE OR REPLACE FUNCTION update_total_score ()
RETURNS TRIGGER 
AS $update_scholarship_trigger$
DECLARE record RECORD;
	BEGIN
		FOR record IN SELECT * FROM activity_scores WHERE student_id = NEW.student_id LOOP 
			UPDATE students SET total_score = (SELECT fn_total(NEW.student_id)) WHERE students.id = NEW.student_id;	
			UPDATE stipendia SET stipuxa = (SELECT fn_stippendia(NEW.student_id)) WHERE stipendia.student_id = NEW.student_id;
		END LOOP;
	RETURN NULL;
	END;
$update_scholarship_trigger$ LANGUAGE plpgsql;

CREATE TRIGGER update_total_score_trigger
AFTER INSERT ON activity_scores
FOR EACH ROW EXECUTE FUNCTION update_total_score();

-- для проверки:
-- SELECT * FROM students;

-- INSERT INTO students (id, name) VALUES
-- 		(5, 'Игорь'),
-- 		(6, 'Рассул');
	
-- INSERT INTO activity_scores (student_id, activity_type, score) VALUES
-- 		(5, 'Homework', 100),
-- 		(5, 'Exam', 99),
-- 		(6, 'Homework', 85),
-- 		(6, 'Exam', 82);
 
-- SELECT * FROM students;