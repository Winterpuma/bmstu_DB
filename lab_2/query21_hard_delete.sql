delete from diet
where item in
(
	select food_code
	from food
	where category = '2006'
)