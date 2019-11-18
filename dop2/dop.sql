drop table t1;
drop table t2;

create table t1 
(
	id int,
	var1 char,
	dfrom date,
	dto date
);

create table t2 
(
	id int,
	var2 char,
	dfrom date,
	dto date
);

insert into t1 (id, var1, dfrom, dto) values (1, 'A', '20180901', '20180915');
insert into t1 (id, var1, dfrom, dto) values (1, 'B', '20180916', '59991231');

insert into t2 (id, var2, dfrom, dto) values (1, 'A', '20180901', '20180918');
insert into t2 (id, var2, dfrom, dto) values (1, 'B', '20180919', '59991231');

select t1.id, t1.var1, t2.var2, 
	case when t1.dfrom<t2.dfrom
		then t2.dfrom
		else t1.dfrom
	end as time1, 
	case when t1.dto>t2.dto
		then t2.dto
		else t1.dto 
	end as time2
from t1 join t2 on 
	t1.id = t2.id and 
	t1.dfrom<t2.dto and 
	t2.dfrom<t1.dto