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
