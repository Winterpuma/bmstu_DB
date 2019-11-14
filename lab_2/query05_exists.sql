--Люди, которые едят что-то из категории сендвичей и молока 
select person
from (diet join food on diet.item = food.food_code) as tmp
where category = '3720'
	and exists(
	select person 
	from (diet join food on diet.item = food.food_code)
	where category = '1204'
		and person = tmp.person)
		
--14640034 3720 sandwich
--11514330 1204 hot chocolate