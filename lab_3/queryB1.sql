--B1) Хранимая процедура без параметров или с параметрам
--Меняем в koef раз цель по калориям, если вес принимает заданный диапазон 
--drop table people_copy;

select *
into temp people_copy
from people;

create or replace procedure update_calories(koef real, target_l real, target_h real) as
$$
	update people_copy
	set calories = calories * koef
	where weight between target_l and target_h
$$ language sql;

call update_calories(0.5, 0, 35);

select people.id, people.name, people.weight, people.calories as old_kcal, people_copy.calories as new_kcal
from people_copy join people on people_copy.id = people.id
order by weight;
