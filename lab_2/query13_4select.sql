select *
from food
where category = 
(
	select distinct category
	from food
	where category = 
	(
		select distinct category
		from food
		where category = 
		(
				select distinct category
				from food
				where category = '1002'
		)
	)
)