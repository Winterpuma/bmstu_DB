create function a1() returns int as
'
	select person
	from diet
	order by amount
' language sql;

select a1();