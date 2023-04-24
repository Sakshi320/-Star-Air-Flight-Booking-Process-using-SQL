create table flight 
(flight_no varchar(20) constraint flight_no_pk primary key,
flight_duration numeric(10),
arrival_date date,
departure_date date,
from_location varchar(50),
to_location varchar(50),
number_of_seats numeric(10));

Describe flight;


create table airport
(Airport_id varchar(20) constraint Airport_id_pk primary key,
airport_name varchar(40) not null,
airport_address varchar(50) not null);

describe airport;


create table airport_flight_details(
airport_flight_number  varchar(40) constraint airport_flight_number_pk primary key,
airport_id varchar(20), 
flight_no varchar(20));

alter table airport_flight_details add constraint airport_id_fk foreign key(airport_id) references airport(airport_id);
 
alter table airport_flight_details add constraint flight_no_fk foreign key(flight_no) references flight(flight_no);

describe airport_flight_details;



create table flight_schedule 
(flight_schedule_no varchar(40) constraint flight_schedule_no_pk primary key,
departure_time varchar2(10),
gate numeric(20),
flight_status varchar(50),
flight_no varchar(20)
);



alter table flight_schedule add constraint flight_schedule_fk foreign key(flight_no) references flight(flight_no);

describe flight_schedule;

CREATE TABLE passenger (
    passenger_id           char(5) constraint passenger_id_pk primary key,
    first_name          varchar2(20),
    last_name           varchar2(20),
    Date_of_Birth       date,
    city                varchar2(10),
    phone_number        numeric(20),
    email_id            varchar2(20),
    flight_schedule_no varchar(40),
    payment_id numeric(20)
    );
    
alter table passenger add constraint passenger_fk foreign key(flight_schedule_no) references flight_schedule(flight_schedule_no);

alter table passenger add constraint payment_id_fk foreign key(payment_id) references payment(payment_id);

describe passenger;

CREATE TABLE seat (
    seat_no          char(5)
    constraint seat_sid_pk primary key,
    seat_type        varchar2(10),
    booking_status   varchar2(10),
    passenger_id     char(5),
    flight_no varchar(20) 
   );



alter table seat add constraint passenger_id_fk foreign key(passenger_id) references passenger(passenger_id);

alter table seat add constraint flight_no_fk1 foreign key(flight_no) references flight(flight_no);

describe seat;

create table notifications(
notification_id numeric(20) constraint notification_id_pk primary key,
Date_created date,
message varchar(60),
reservation_id varchar(20),
payment_id numeric(20) not null);

alter table notifications add constraint reservation_id2_fk foreign key(reservation_id) references flight_reservation_ticket(reservation_id);

alter table notifications add constraint payment_id3_fk foreign key(payment_id) references payment(payment_id);

describe table notifications;

create table payment
( payment_id numeric(20) constraint payment_id_pk primary key,
payment_method varchar2(30) not null,
payment_status varchar2(30) not null);

describe table payment;

create table card
( card_id numeric(20) constraint card_id_pk primary key,
card_number numeric(30),
card_type varchar2(40),
expiration_date date,
payment_id numeric(20));

alter table card add constraint payment_id_fk2 foreign key(payment_id) references payment(payment_id);

describe table card;

create table wallets
(wallet_id numeric(20) constraint wallet_id_pk primary key,
upi_id varchar2(40),
mobile_number numeric(30),
wallet_type varchar2(40),
payment_id numeric(20));

alter table wallets add constraint payment_id_fk4 foreign key(payment_id) references payment(payment_id);

describe table wallets;

create table flight_reservation_ticket
(reservation_id varchar(20) constraint reservation_id_pk primary key,
booking_date date,
fare decimal,
reservation_status varchar(30),
passenger_id char(5),
seat_no     char(5),
flight_no varchar(20),
flight_schedule_no varchar(40));

describe flight_reservation_ticket;
alter table flight_reservation_ticket add constraint 
passenger_id_fk1 foreign key(passenger_id) references passenger(passenger_id);

alter table flight_reservation_ticket add constraint 
seat_no_fk1 foreign key(seat_no) references seat(seat_no);

alter table flight_reservation_ticket add constraint 
flight_no_fk2 foreign key(flight_no) references flight(flight_no);

alter table flight_reservation_ticket add constraint 
flight_schedule_no_fk2 foreign key(flight_schedule_no) references flight_schedule(flight_schedule_no);


create table reserved_seat_details
( seat_no char(5), 
passenger_id char(5));

alter table reserved_seat_details add constraint seat_no_passenger_id_pk3 primary key(seat_no,passenger_id);


alter table reserved_seat_details add constraint 
seat_no_fk2 foreign key(seat_no) references seat(seat_no);

alter table reserved_seat_details add constraint 
passenger_id_fk2 foreign key(passenger_id) references passenger(passenger_id);

describe table reserved_seat_details;
