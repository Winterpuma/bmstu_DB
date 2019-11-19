create view people_view as
select *
from people;

create or replace function upd_is_deleted_func()
returns trigger as
$$
begin
	update people
	set sex = 'd'
	where id = old.id ;
	return old;
end;
$$ language plpgsql;

create trigger person_deleted
	instead of delete on people_view
	for each row 
	execute procedure upd_is_deleted_func()
	