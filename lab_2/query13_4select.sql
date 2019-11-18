--Выводим людей, которые едят что-либо из категории "Cheese"
select *
from people
where id in
(
	select distinct person
	from diet join food on diet.item = food.food_code
	where item in
	(
		select distinct food_code
		from food  join food_category on food.category = food_category.code
		where code = 
		(
				select code
				from food_category
				where name = 'Cheese'
		)
	)
)