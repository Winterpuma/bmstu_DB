select name, 
	case category
		when '2402' then 'Fish'
		when '1602' then 'Cheese'
		when '2202' then 'Chicken'
		else 'Other'
	end as category_txt
from food