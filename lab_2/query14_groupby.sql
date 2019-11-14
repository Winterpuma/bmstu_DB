select name, 
	case
		when kcal < 30 then 'Low'
		when kcal < 100 then 'Normal'
		when kcal < 200 then 'High'
		else 'Very high'
	end as kcal_check
from food