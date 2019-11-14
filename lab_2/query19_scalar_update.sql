update people
set calories = 
(
	select avg(calories)
	from people
	where age < 5
)
where age < 5
