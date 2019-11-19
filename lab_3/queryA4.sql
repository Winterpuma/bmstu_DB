--Возвращает перемноженные числа от заданного до 1
create or replace function myProduct (ct int, pr int)
returns table (counter int, product int)
language plpgsql
as $$
begin
    return query select ct, pr;
    if ct > 1 then
        return query 
		select * 
		from myProduct(ct - 1, pr * (ct - 1));
    end if;
end $$;

select * from myProduct(10, 10);