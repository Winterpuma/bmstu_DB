create table if not exists people (
	id serial not null primary key,
	name varchar(30) not null,
	sex char,
	age integer check (age>=0 and age <= 111),
	height integer check (height > 30 and height < 300) default 165,
	weight real check (weight > 0 and weight < 500),
	calories int default 2000
);
--copy people(name, sex, age, height, weight, calories) from 'D:\GitHub\bmstu_DB\lab_1\people.csv' delimiter ',' csv;

create table if not exists food_category(
	code varchar(4) not null unique,
	name varchar(50) not null
);
--copy food_category from 'D:\GitHub\bmstu_DB\lab_1\food_category.csv' delimiter ',' csv;

create table if not exists food(
	food_code int not null primary key,
	name varchar(170),
	category varchar(4) references food_category(code),
	kcal int check (kcal >= 0) default 0 not null,
	protein real check (protein >= 0),
	carbohydrate real check (carbohydrate >= 0),
	sugar real check (sugar >= 0),
	fiber real check (fiber >= 0),
	fat real check (fat >= 0)
);
--copy food from 'D:\GitHub\bmstu_DB\lab_1\food.csv' delimiter ':' csv;

create table if not exists diet(
	person int references people(id) not null,
	item int references food(food_code) not null,
	amount real check (amount > 0) default 1
);
--copy diet from 'D:\GitHub\bmstu_DB\lab_1\diet.csv' delimiter ',' csv;

--alter table food add constraint name check (not null);
--insert into people(name, sex, age) values('Winterpuma', 'f', 18);
select * from people where name = 'Winterpuma';

--select * from people;
--select * from food_category;
--select * from food;
--select * from diet;
--select name, kcal from food

--drop table food;
--drop table food_category;
