insert into diet(person, item, amount) 
select people.id, 11000000, 1
from people
where people.age < 10

