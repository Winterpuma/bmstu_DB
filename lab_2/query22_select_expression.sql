--Человек и сколько разной еды он употребляет
select person, count(*) as n_of_food
from diet
group by person