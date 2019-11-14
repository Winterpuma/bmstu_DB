-- Вывести имя человека, его рекомендуемое и реальное потребление
select people.name,
	total_kcal as actual_intake, 
	people.calories as calories_task
from(
	select person, sum(food.kcal*diet.amount) as total_kcal
	from diet join food on diet.item = food.food_code
	group by person
)as personalKcal 
	join people on personalKcal.person = people.id
-- или right join для учета тех, кто не кушает :(