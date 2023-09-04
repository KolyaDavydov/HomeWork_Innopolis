SELECT
	*
FROM bookings.ticket_flights tf 
WHERE tf.fare_conditions = 'Business' 
ORDER BY 1
LIMIT 20;