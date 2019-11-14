select category, name, kcal,  
	min(kcal) over (partition by category), max(kcal) over (partition by category),
	avg(kcal) over (partition by category)
from food