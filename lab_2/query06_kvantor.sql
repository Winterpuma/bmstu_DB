--Вывести продукты, калорийность которых меньше, чем калорийность
--любого продукта из категории 2202
select *
from food
where kcal < all
(
	select kcal
	from food
	where category = '2202'
)
order by kcal
