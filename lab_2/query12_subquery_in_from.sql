select people.name, foodindiet.name
from people join 
(
	diet join food 
	on food.food_code = diet.item
) as foodindiet on foodindiet.person = people.id
order by people.name

