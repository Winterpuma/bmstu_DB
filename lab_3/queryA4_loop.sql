create or replace function loop_function ()
returns table (counter int, product int)
language plpgsql
as $$
declare
    ct int;
    pr int = 1;
begin
    for ct in 1..10 loop
        pr = ct* pr;
        return query select ct, pr;
    end loop;
end $$;

select * from loop_function ();