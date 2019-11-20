--B3) Хранимая процедура с курсором
-- Обновить вес людей определенного возрастного диапазона

drop table people_copy;

select *
into temp people_copy
from people;

create or replace procedure update_weight(koef real, target_l real, target_h real) as
$$
declare cur cursor
	for select * 
	from people
	where age between target_l and target_h;
	row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		update people_copy
		set weight = weight * koef
		where people_copy.id = row.id;
	end loop;
	close cur;		
end
$$ language plpgsql;

call update_weight(0.75, 18, 30);

select people.id, people.name, people.age, people.weight as old_weight, people_copy.weight as new_weight
from people_copy join people on people_copy.id = people.id
order by age;
