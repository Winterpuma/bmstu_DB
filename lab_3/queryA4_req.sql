create or replace function recursive_function (ct int, pr int)
returns table (counter int, product int)
language plpgsql
as $$
begin
    return query select ct, pr;
    if ct < 10 then
        return query select * from recursive_function(ct+ 1, pr * (ct+ 1));
    end if;
end $$;

select * from recursive_function (1, 1);