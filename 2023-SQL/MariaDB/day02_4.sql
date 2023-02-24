use employees;

use sqldb;

select * from stdtbl;
select * from clubtbl;

select stdname, addr from stdtbl
union
select clubname, roomno from clubtbl;

insert into clubtbl(clubname, roomno)
values('김범수','경남');

select stdname, addr from stdtbl
union all
select clubname, roomno from clubtbl;

select * from buytbl;

select sum(amount), sum(distinct amount), sum(all amount)
from buytbl;

select count(*),
from buytbl

select count(*), count(amount)
from buytbl

select count(*), count(amount), count(distinct amount)
from buytbl

select count(*), count(amount), count(distinct amount), count(all amount)
from buytbl

select max(amount), min(amount)
from buytbl

select avg(amount)
from buytbl
where groupname = '서적';

select avg(amount), avg(distinct amount)
from buytbl
where groupname = '서적';

select sum(amount), userid
from buytbl
group by userid;

select sum(amount)
from buytbl
group by uerid;


select userid, avg(amount)
from buytbl
group by userid
order by userid

select userid, sum(price*amount) as totalamt
from buytbl
group by userid
having totalamt > 1000
order by totalamt

select userid, sum(price*amount) as totalamt
from buytbl
group by userid
having sum(price*amount) > 1000
order by totalamt

select groupname, num, sum(price*amount) as '비용'
from buytbl
group by groupname, num
with rollup






