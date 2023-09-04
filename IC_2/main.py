import psycopg2

conn=psycopg2.connect(database="demo", user="postgres", password="2380", host="localhost", port="5432")

cur = conn.cursor()

cur.execute("select * from bookings.amounts")

result = cur.fetchall()

for i in result:
    print(i)
