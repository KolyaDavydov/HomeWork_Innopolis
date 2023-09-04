-- объединение таблиц с использованием 'JOIN'
SELECT
	a.aircraft_code,
	a.model,
	a."range",
	s.seat_no,
	s.fare_conditions 
FROM bookings.aircrafts a
JOIN bookings.seats s 
ON a.aircraft_code = s.aircraft_code
ORDER BY 1;

-- объединение таблиц с использованием 'UNION'
SELECT
	a.aircraft_code,
	a.model AS object
FROM bookings.aircrafts a
UNION
SELECT
	s.aircraft_code,
	s.fare_conditions AS object
FROM bookings.seats s 
ORDER BY 1;