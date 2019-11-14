--создаем дубли и избавляемся от них
select *
from
(
	select hm.name, row_number() over (partition by hm.name) as counter
	from diet join
	(
		select *
		from people join diet on people.id = diet.person
	) as hm on diet.person = hm.person
) as percount
where counter = 1
