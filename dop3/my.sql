create temp table Worker
(
    id integer primary key,
    name text
);

create temp table TypeVacation
(
    id integer primary key,
    type text
);

create temp table Vacation
(
    id integer primary key,
    idWorker integer references Worker (id),
    date date,
    type integer references TypeVacation (id)
);

insert into Worker
values (1, 'Иванов Иван Иванович');
insert into Worker
values (2, 'Петров Петр Петрович');
insert into Worker
values (3, 'Андреев Андрей Андреевич');

insert into TypeVacation
values (1, 'За свой счет');
insert into TypeVacation
values (2, 'Ежедн. опл.');
insert into TypeVacation
values (3, 'Болезнь');

insert into Vacation
values (1, 1, '2020-01-20', 1);
insert into Vacation
values (2, 1, '2020-01-21', 1);
insert into Vacation
values (3, 1, '2020-01-22', 1);
insert into Vacation
values (4, 1, '2020-01-23', 1);
insert into Vacation
values (5, 1, '2020-01-24', 3);
insert into Vacation
values (6, 1, '2020-01-25', 3);
insert into Vacation
values (7, 2, '2020-01-22', 2);
insert into Vacation
values (8, 2, '2020-01-23', 2);
insert into Vacation
values (9, 2, '2020-01-24', 2);
insert into Vacation
values (10, 2, '2020-01-25', 2);
insert into Vacation
values (11, 2, '2020-01-26', 2);
insert into Vacation
values (12, 3, '2020-01-24', 3);

with tmp
as
(
    select *,
        lag(date)  over(partition by IdWorker, Type order by date) as PrevDate,
        lead(date) over(partition by IdWorker, Type order by date) as NextDate,
        count(*)   over(partition by IdWorker, Type order by date) as c
    from Vacation
)
select W.Name, T.Type, fromdate, todate
from
(
    select T1.IdWorker, T1.Type, T1.Date as "fromdate", T2.Date as "todate"
    from tmp T1 join tmp T2 on T1.IdWorker = T2.IdWorker and T1.Type = T2.Type
    where (T1.PrevDate is null or date_part('day', T1.Date) - date_part('day', T1.PrevDate) > 1) and
        (T2.NextDate is null or date_part('day', T2.NextDate) - date_part('day', T2.Date) > 1) and
        (date_part('day', T1.Date) <= date_part('day', T2.Date)) and
        (date_part('day', T2.Date) - date_part('day', T1.Date) <= T2.c)
) as TMP join Worker W on TMP.IdWorker = W.Id
join TypeVacation T on TMP.Type = T.Id;


select *
from Vacation;

