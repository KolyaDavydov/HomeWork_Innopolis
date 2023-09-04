SELECT
	t.passenger_name,
	count(*),
	round(avg(tf.amount)) AS average_amount,
	sum(tf.amount),
	min(tf.amount),
	max(tf.amount)
FROM bookings.tickets t
JOIN bookings.ticket_flights tf ON t.ticket_no = tf.ticket_no
GROUP BY t.passenger_name
ORDER BY count DESC;