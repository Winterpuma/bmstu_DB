-- Оберган ИУ7-55
-- БД ЛР4

-- Получение имени человека по id
create or replace function get_name_by_id(id_ int) returns varchar
as $$
ppl = plpy.execute("select * from people")
for person in ppl:
	if person['id'] == id_:
		return person['name']
return 'None'
$$ language plpython3u;

select * from get_name_by_id(1003);
select * from get_name_by_id(1001);
select * from get_name_by_id(1);


-- Сколько человек ест определенный продукт
create or replace function get_n_food(id_p int, id_f int) returns float
as $$
d = plpy.execute("select * from diet")
summ = 0
for l in d:
	if l['person'] == id_p and l['item'] == id_f:
		summ += l['amount']
return summ
$$ language plpython3u;

select * from get_n_food(19, 26151130);
select * from get_n_food(1, 1);


-- Возвращает всех людей указанного возраста
create or replace function get_people_by_age (age int) 
returns table (	id int, name varchar, sex varchar, age int, height int, weight real, calories int)
as $$
ppl = plpy.execute("select * from people")
res = []
for p in ppl:
	if p['age'] == age:
		res.append(p)
return res
$$ language plpython3u;

select * from get_people_by_age(18);
select * from get_people_by_age(-1);
select * from get_people_by_age(25);


-- Добавляет нового человека в базу
create or replace procedure add_person(name varchar,  sex varchar,  age int) as
$$
plan = plpy.prepare("insert into people(name, sex, age) values($1, $2, $3);", ["varchar", "varchar", "int"])
plpy.execute(plan, [name,  sex,  age])
$$ language plpython3u;

call add_person('Test person', 'm', 33);

select * from people
order by id desc;


-- При удалении людей, данные копируются в таблицу people_back
create or replace function backup_deleted_people()
returns trigger 
as $$
plan = plpy.prepare("insert into people_back(name, sex, age, height, weight, calories) values($1, $2, $3, $4, $5, $6);", ["varchar", "varchar", "int", "int", "float", "int"])
pi = TD['old']
rv = plpy.execute(plan, [pi["name"], pi["sex"], pi["age"], pi["height"], pi["weight"], pi["calories"]])
return TD['new']
$$ language  plpython3u;

drop trigger backup_deleted_people on people; 

create trigger backup_deleted_people
before delete on people for each row
execute procedure backup_deleted_people();

delete from people
where name = 'Test person';

select * from people_back;


-- Тип параметров человека
create type stats as (
  age int,
  height int,
  weight real
);

drop function get_stats_by_id;
drop type player_cut;
-- Вывод параметров человека по id
create or replace function get_stats_by_id(id_ integer) returns stats 
as $$
plan = plpy.prepare("select age, height, weight from people where id = $1", ["int"])
cr = plpy.execute(plan, [id_])
return (cr[0]['age'], cr[0]['height'], cr[0]['weight'])
$$ language plpython3u;

select * from get_stats_by_id(1001);

select *
from people
where id = 1001
