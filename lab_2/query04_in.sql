select person, name, kcal*amount as total_kcal
from diet join food on diet.item = food.food_code
where person in
	(
		select id
		from people
		where sex = 'f' and age between 14 and 18
	)
