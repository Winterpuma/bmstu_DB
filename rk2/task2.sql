-- БД РК2 Оберган Татьяна ИУ7-55Б
-- Вариант 1, задание 2

-- select with case
-- Для некоторых пользователей выводит тип почты
select name, email,
	case substring(email from '(?=@)..')
		when '@m' then 'Mail.ru'
		when '@y'then 'Yandex.ru'
		when '@g' then 'Google.com'
		else 'IDK'
	end as domain
from customer;

-- window func
-- Вывести кружок и наименьший+наибольший год основания кружка этого же директора
select name, id_director, found_year, 
	min(found_year) over (partition by id_director) as min_year_in_director,
	max(found_year) over (partition by id_director) as max_year_in_director
from workshop;

-- group by, having
-- вывести директоров, которые курируют более одного кружка
select director.id, director.name, count(*) as n_workshops
from workshop join director on workshop.id_director = director.id
group by director.id
having count(*) > 1;


