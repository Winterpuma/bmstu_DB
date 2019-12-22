-- БД РК2 Оберган Татьяна ИУ7-55Б
-- Вариант 3.1

drop table rel_work_cust;
drop table workshop;
drop table director;
drop table customer;

create table if not exists director (
	id serial not null primary key,
	name varchar(30) not null,
	birth_year int,
	experience int,
	phone varchar(15)
);

insert into director(name, birth_year, experience, phone)
values ('Pasha Cool', 1985, 20, '79798885543');

insert into director(name, birth_year, experience, phone)
values ('Masha Cook', 1969, 30, '79793335543');

insert into director(name, birth_year, experience, phone)
values ('Hmmm Hm', 1972, 5, '79798884421');

insert into director(name, birth_year, experience, phone)
values ('Dasha Cool', 1975, 23, '79796665543');

insert into director(name, birth_year, experience, phone)
values ('Pork Meat', 1993, 7, '79793335543');

insert into director(name, birth_year, experience, phone)
values ('Mama No', 1974, 3, '79798884400');

insert into director(name, birth_year, experience, phone)
values ('Olga No', 1952, 50, '79798884433');

insert into director(name, birth_year, experience, phone)
values ('Volk Polk', 1955, 23, '79796635543');

insert into director(name, birth_year, experience, phone)
values ('Solo Home', 1997, 4, '78883335543');

insert into director(name, birth_year, experience, phone)
values ('Ilya Tri', 1944, 60, '79796666400');


create table if not exists workshop(
	id serial not null primary key,
	id_director int references director(id) not null,
	name varchar(30),
	found_year int,
	description varchar(50)
);

insert into workshop(name, found_year, id_director, description)
values('Crafty', 1500, 1, 'Best of all time');

insert into workshop(name, found_year, id_director, description)
values('Mud and clay', 1000, 2, 'First one in Russia');

insert into workshop(name, found_year, id_director, description)
values('Olimp', 2000, 3, 'Best of all time');

insert into workshop(name, found_year, id_director, description)
values('BMSTU', 1830, 2, 'Bauman');

insert into workshop(name, found_year, id_director, description)
values('Wood', 2010, 2, 'Hvatit');

insert into workshop(name, found_year, id_director, description)
values('Steel', 2000, 6, 'Finger horror');

insert into workshop(name, found_year, id_director, description)
values('Eraser', 2006, 3, 'Goood');

insert into workshop(name, found_year, id_director, description)
values('MGU', 1111, 4, 'Gos');

insert into workshop(name, found_year, id_director, description)
values('HSE', 1210, 7, 'We have cookies');

insert into workshop(name, found_year, id_director, description)
values('Not last', 2019, 9, 'Second one in Russia');


create table if not exists customer(
	id serial not null primary key,
	name varchar(30) not null,
	birth_year int,
	adress varchar(50),
	email varchar(20)
);

insert into customer(name, birth_year, adress, email)
values ('Anna Ioann', 1456, 'Big Postal, 24', 'annaI@mail.ru');

insert into customer(name, birth_year, adress, email)
values ('Good man', 2000, 'Tolstoy, 4', 'Manofgod@ya.ru');

insert into customer(name, birth_year, adress, email)
values ('Kolya Omg', 1999, 'Small Postal, 14', 'Kolya@mail.ru');

insert into customer(name, birth_year, adress, email)
values ('Nasya Heh', 2003, 'Hmmmm, 4', 'Mango@ya.ru');

insert into customer(name, birth_year, adress, email)
values ('Som Ton', 1256, 'Big Postal, 135', 'somton@gmail.com');

insert into customer(name, birth_year, adress, email)
values ('Tom Con', 2001, 'Tolstoy, 3', 'Mangod@gmail.com');

insert into customer(name, birth_year, adress, email)
values ('Lon Gon', 1990, 'Small Postal, 20', 'longon@mail.ru');

insert into customer(name, birth_year, adress, email)
values ('Lon Don', 1980, 'Hmmmm, 6', 'Mango@ya.ru');

create table rel_work_cust(
	id_customer int references customer(id) not null,
	id_workshop int references workshop(id) not null
);

insert into rel_work_cust(id_customer, id_workshop)
values (1, 2);

insert into rel_work_cust(id_customer, id_workshop)
values (3, 1);

insert into rel_work_cust(id_customer, id_workshop)
values (4, 3);

insert into rel_work_cust(id_customer, id_workshop)
values (4, 4);

insert into rel_work_cust(id_customer, id_workshop)
values (2, 1);

insert into rel_work_cust(id_customer, id_workshop)
values (1, 5);

insert into rel_work_cust(id_customer, id_workshop)
values (3, 6);

insert into rel_work_cust(id_customer, id_workshop)
values (4, 7);

insert into rel_work_cust(id_customer, id_workshop)
values (4, 8);

insert into rel_work_cust(id_customer, id_workshop)
values (3, 8);

select *
from rel_work_cust;

