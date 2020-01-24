-- БД РК3 Оберган Татьяна ИУ7-55Б
-- Вариант 1


drop function avgagelate();
drop table record;
drop table employee;

create table if not exists employee (
	id serial not null primary key,
	name varchar(50) not null,
	birthdate date,
	department varchar(15)
);

insert into employee(name, birthdate, department)
values ('Иванов Иван Иванович', '25-09-1990', 'ИТ');

insert into employee(name, birthdate, department)
values ('Иванов Второй', '25-09-1970', 'ИТ');

insert into employee(name, birthdate, department)
values ('Петров Петр Петрович', '12-11-1987', 'Бухгалтерия');


create table if not exists record (
	id_employee int references employee(id) not null,
	rdate date,
	weekday varchar(15),
	rtime time,
	rtype int
);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(1, '21-12-2019', 'Суббота', '9:01', 1);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(1, '14-12-2018', 'Суббота', '9:20', 2);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(2, '21-12-2019', 'Суббота', '10:00', 1);

insert into record(id_employee, rdate, weekday, rtime, rtype)
values(2, '14-12-2018', 'Суббота', '9:05', 1);


-- Возвращает возраст человека по дате рождения на сегодня 
create or replace function getage(bd_ date) returns double precision as
$$
	select extract (year from current_date) - extract (year from bd_) 
$$ language sql;

-- Возвращает id опоздавших сегодня сотрудников из IT
create or replace function lateIT() returns table
(
	id int
)
as
$$
	select distinct id
	from employee join record on employee.id = record.id_employee
	where department = 'ИТ' and record.rdate = current_date
	group by id
	having min(record.rtime) > '9:00'; 
$$ language sql;

-- Возваращает средний возраст опоздавших сегодня сотрудников из IT
create or replace function avgagelate() returns double precision as
$$
	select avg(getage(birthdate))
	from lateIT() as l join employee on l.id = employee.id;
$$ language sql;

select avgagelate();
