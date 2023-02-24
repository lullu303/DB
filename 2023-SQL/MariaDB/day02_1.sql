USE sqldb;

insert into saltbl(sal, comm)
values(500, null)

select * from saltbl

select sal *12+comm as annsal
from saltbl
-- select no, (sal*12) +comm as annsal, sal*12
-- from saltbl

select * from saltbl
order by sal desc, comm

