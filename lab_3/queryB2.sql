-- B2) Рекурсивная хранимая процедура или хранимая процедура с рекурсивным ОТВ
--Обновляем возраст у всех людей с заданным id.

--drop table people_copy;

select *
into temp people_copy
from people;

create or replace procedure update_age (new_age int, id_l int, id_h int) as
$$
begin
	if (id_l <= id_h)
then
	update people_copy
	set age = new_age
	where id = id_l;
	call update_age(new_age, id_l + 1, id_h);
end if; 
end;
	
$$ language plpgsql;

call update_age(12, 2, 5);

select people.id, people.name, people.age as old_age, people_copy.age as new_age
from people_copy join people on people_copy.id = people.id
order by people.id;
