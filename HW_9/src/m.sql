SELECT
    CASE
        WHEN soc.student_rating < 30 THEN 'неудовлетворительно'
        WHEN soc.student_rating >= 30 AND soc.student_rating < 60 THEN 'удовлетворительно'
        WHEN soc.student_rating >= 60 AND soc.student_rating < 85 THEN 'хорошо'
        ELSE 'отлично'
    END AS "оценка",
    COUNT(*) AS "количество студентов"
FROM student_on_course AS soc
GROUP BY "оценка"
ORDER BY "оценка"
