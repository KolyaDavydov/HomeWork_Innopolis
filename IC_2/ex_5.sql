CREATE OR REPLACE VIEW bookings.amounts
AS SELECT tf.ticket_no,
    tf.flight_id,
    tf.fare_conditions,
    tf.amount
   FROM bookings.ticket_flights tf
  WHERE tf.fare_conditions::text = 'Business'::text
  ORDER BY tf.ticket_no
 LIMIT 20;