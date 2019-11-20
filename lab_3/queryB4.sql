--B4) Хранимая процедура доступа к метаданным
-- Вывод названия таблицы и ее физического размера
create or replace procedure table_size() as
$$
declare 
	cur cursor
	for select table_name, size
	from (
		select table_name,
		pg_relation_size(cast(table_name as varchar)) as size 
		from information_schema.tables
		where table_schema not in ('information_schema','pg_catalog')
		order by size desc
	) AS tmp;
		 row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		raise notice '{table : %} {size : %}', row.table_name, row.size;
	end loop;
	close cur;
end
$$ language plpgsql;

call table_size();
