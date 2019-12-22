-- БД РК2 Оберган Татьяна ИУ7-55Б
-- Вариант 1, задание 3

-- Получаем информацию о всех функциях
select proname, pronargs, prorettype, proargtypes
from pg_proc
where pronargs > 0; -- кол-во принимаемых аргументов

-- Хранимая процедура доступа к метаданным
-- Вывести имя функции и типы принимаемых значений
create or replace procedure show_functions() as
$$
declare 
	cur cursor
	for select proname, proargtypes
	from (
		select proname, pronargs, prorettype, proargtypes
		from pg_proc
		where pronargs > 0
	) AS tmp;
	row record;
begin
	open cur;
	loop
		fetch cur into row;
		exit when not found;
		raise notice '{func_name : %} {args : %}', row.proname, row.proargtypes;
	end loop;
	close cur;
end
$$ language plpgsql;

call show_functions();


