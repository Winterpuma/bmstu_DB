create function getpeople(int) returns people as
$$
	select *
	from people
	where age = $1;
$$ language sql;

select *, upper(name)
from getpeople(18); 