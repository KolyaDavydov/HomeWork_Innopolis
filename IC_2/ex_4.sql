SELECT
	t.passenger_name,
	tf.fare_conditions,
	tf.amount,
	bp.seat_no
FROM bookings.tickets t
JOIN bookings.ticket_flights tf ON t.ticket_no =tf.ticket_no
JOIN bookings.boarding_passes bp ON tf.ticket_no = bp.ticket_no
WHERE tf.fare_conditions = 'Business'
ORDER BY 1;