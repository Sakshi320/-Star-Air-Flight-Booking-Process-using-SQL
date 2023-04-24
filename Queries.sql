
--1. Display pagination to get first five reservation ticket details by booking date with the use of window 
--function Row_number() and partition.

SELECT * FROM (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY booking_date) row_num, 
        reservation_id, 
        booking_date, 
        fare,
        reservation_status,
        passenger_id,
        seat_no,
        flight_no,
        flight_schedule_no       
    FROM
        flight_reservation_ticket
   )  a   
WHERE
    row_num > 0  AND row_num <=5;
    
-- 2. For a particular date total ticket revenue generated for the airline

select sum(fare) as "Total Revenue", booking_date
from flight_reservation_ticket
where reservation_status='Confirmed'
group by booking_date
order by booking_date desc;

-- 3. Generate total air traffic on different routes

SELECT f.from_location,f.to_location, count(*) as "total reservation"
FROM flight f JOIN flight_reservation_ticket fr
on f.flight_no=fr.flight_no
group by f.from_location, f.to_location;


--4. Display notification if there is any updation in the ticket fare. 
--The message should indicate both new and old fares along with the flight_no, departure_date, boarding, and departure destination.

update flight_reservation_ticket set fare=1500 where fare=2000;

select * from flight_reservation_ticket;

    UPDATE ON flight_reservation_ticket
    FOR EACH ROW
    WHEN ( new.fare <> old.fare )
DECLARE
    v_flight_no   flight.flight_no%TYPE;
    v_departure_date     flight.departure_date%TYPE;
    v_from_location     flight.from_location%TYPE;
    v_to_location     flight.to_location%TYPE;
BEGIN
    SELECT
        flight_no,
        departure_date,
        from_location,
        to_location
    INTO
        v_flight_no,v_departure_date,v_from_location,v_to_location
    FROM
        flight
    WHERE
        flight_no =:new.flight_no;

    dbms_output.put_line('The flight number '
    ||:new.flight_no
    || v_flight_no
    || v_departure_date
    || v_from_location
    || v_to_location
    || ' has changed to  '
    ||:new.fare
    || ' From '
    ||:old.fare);

END;

--5 This report generates passenger booking details for the year 2020 who had confirmed booking status

Select pg.passenger_id, pg.first_name, pg.last_name, pg.phone_number, fr.booking_date, s.seat_type, s.booking_status, p.payment_method
From seat s join flight_reservation_ticket fr
on s.seat_no= fr.seat_no
join passenger pg
on pg.passenger_id=fr.passenger_id
JOIN notifications n
on fr.reservation_id=n.reservation_id
join payment p
on n.payment_id=p.payment_id
where s.booking_status='Confirmed'
and to_char(fr.booking_date,'YYYY')=2020;
